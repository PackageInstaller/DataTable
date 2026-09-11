using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Cache;
using System.Net.Http;
using System.Threading;
using UnityEngine;

namespace PCYsDownload;

public class PCDownLoadManagerHotfix : MonoBehaviour
{
	public delegate void AllTaskDelegate(int result, string msg);

	public delegate void SingleTaskDelegate(int result, string filePath, long size, string md5, string msg);

	public delegate void ProgressDelegate(long currentOffset, int totalCount, int completedCount, int failedCount, string speed);

	private static string ERROR_DISK_FULL = "diskfull";

	private static string ERROR_NET = "neterror";

	private static string ERROR_CANCEL = "cancel";

	private const int THREAD_COUNT = 8;

	private const int HTTP_TIMEOUT = 5000;

	private const int READ_TIMEOUT = 30000;

	private const int TRY_COUNT = 3;

	private const int SPEED_DELTA = 500;

	private const int BUFFER_SIZE = 65536;

	private ManualResetEventSlim _globalPauseEvent;

	private volatile bool _isGlobalPause;

	private ConcurrentQueue<DownLoadTask> _taskQueue;

	private Queue<DownLoadTask> _doneQueue;

	private List<DownLoadTask> _workList;

	private List<DownLoadTask> _failedList;

	private ConcurrentDictionary<string, Queue<string>> errors;

	private List<byte[]> _bufferList;

	private Thread _workThread;

	private volatile bool _needStop;

	private object _object = new object();

	private ManualResetEventSlim _workThreadEvent;

	private volatile bool _isPause;

	private volatile bool _isFailed;

	private volatile bool _isContinue;

	private ManualResetEvent _threadExitEvent = new ManualResetEvent(initialState: false);

	private volatile int _activeThreadCount;

	private long _speed;

	private float _speedTime;

	private long _lastSecondSize;

	private long _downDoneSize;

	private long _downLoadSize;

	private long _doingSize;

	private volatile int _waitDownloadCount;

	private volatile bool _isDownloading;

	private static PCDownLoadManagerHotfix s_instance = null;

	public AllTaskDelegate AllTaskEvent;

	public SingleTaskDelegate SingleTaskEvent;

	public ProgressDelegate ProgressEvent;

	public static PCDownLoadManagerHotfix GetInstance()
	{
		return s_instance;
	}

	public static PCDownLoadManagerHotfix Create()
	{
		if (s_instance != null)
		{
			s_instance.OnDestroyInterface();
		}
		GameObject obj = new GameObject();
		UnityEngine.Object.DontDestroyOnLoad(obj);
		s_instance = obj.AddComponent<PCDownLoadManagerHotfix>();
		return s_instance;
	}

	private void StartNewDownloadThread()
	{
		ServicePointManager.SecurityProtocol = SecurityProtocolType.Ssl3 | SecurityProtocolType.Tls | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12 | SecurityProtocolType.Tls13;
		Clear();
		if (errors == null)
		{
			errors = new ConcurrentDictionary<string, Queue<string>>();
			errors.TryAdd(ERROR_DISK_FULL, new Queue<string>());
			errors.TryAdd(ERROR_NET, new Queue<string>());
			errors.TryAdd(ERROR_CANCEL, new Queue<string>());
		}
		if (_taskQueue == null)
		{
			_taskQueue = new ConcurrentQueue<DownLoadTask>();
		}
		if (_doneQueue == null)
		{
			_doneQueue = new Queue<DownLoadTask>();
			_workList = new List<DownLoadTask>(8);
			_failedList = new List<DownLoadTask>(8);
			_bufferList = new List<byte[]>(8);
			for (int i = 0; i < 8; i++)
			{
				_workList.Add(null);
				_bufferList.Add(null);
			}
		}
		if (_workThread == null)
		{
			_workThreadEvent = new ManualResetEventSlim(initialState: false);
			_globalPauseEvent = new ManualResetEventSlim(initialState: true);
			_workThread = new Thread(WorkThreadFunc);
			_workThread.Start();
		}
	}

	private void OnDestroy()
	{
		StopThread(waitForEnd: false);
	}

	private void Update()
	{
		if (_isDownloading)
		{
			CalcSpeed();
			if (!ExceptionCheck() && _doneQueue.Count == _waitDownloadCount)
			{
				int result = ((_failedList.Count != 0) ? 1 : 0);
				StopAllDownload(waitForEnd: false);
				DownloadDone(result, "");
			}
		}
	}

	private bool ExceptionCheck()
	{
		if (errors[ERROR_DISK_FULL].Count > 0)
		{
			string msg = errors[ERROR_DISK_FULL].Peek();
			StopAllDownload(waitForEnd: false);
			DownloadDone(1, msg);
			return true;
		}
		if (errors[ERROR_NET].Count > 0)
		{
			string msg2 = errors[ERROR_NET].Peek();
			StopAllDownload(waitForEnd: false);
			DownloadDone(1, msg2);
			return true;
		}
		return false;
	}

	public void OnDestroyInterface()
	{
		StopThread(waitForEnd: false);
		s_instance = null;
		UnityEngine.Object.DestroyImmediate(base.gameObject);
	}

	public void CancelDonload()
	{
		if (_isDownloading)
		{
			_isDownloading = false;
			_needStop = true;
			_threadExitEvent.Reset();
			Resume();
			Continue();
			_threadExitEvent.WaitOne(5000);
			Clear();
			DownloadDone(1, ERROR_CANCEL);
		}
	}

	public void DownloadDone(int result, string msg)
	{
		_isDownloading = false;
		UnityEngine.Object.DestroyImmediate(base.gameObject);
		s_instance = null;
		AllTaskEvent?.Invoke(result, msg);
	}

	private void StopAllDownload(bool waitForEnd)
	{
		if (_workThread != null)
		{
			Clear();
			Resume();
		}
	}

	private void StopThread(bool waitForEnd)
	{
		if (_workThread != null)
		{
			_needStop = true;
			Clear();
			Resume();
			Continue();
			if (waitForEnd && _workThread.IsAlive)
			{
				_threadExitEvent.WaitOne(5000);
				_workThread = null;
			}
			_workThread = null;
		}
	}

	public void Clear()
	{
		lock (_object)
		{
			if (_workThread == null)
			{
				return;
			}
			_taskQueue.Clear();
			_failedList.Clear();
			for (int i = 0; i < _workList.Count; i++)
			{
				if (_workList[i] != null)
				{
					_workList[i].isCancel = true;
					_workList[i] = null;
				}
				_bufferList[i] = null;
			}
			foreach (KeyValuePair<string, Queue<string>> error in errors)
			{
				error.Value.Clear();
			}
			_doneQueue.Clear();
			_isFailed = false;
			_waitDownloadCount = 0;
			_speed = 0L;
			_speedTime = 0f;
			_lastSecondSize = 0L;
			_downDoneSize = 0L;
			_downLoadSize = 0L;
			_activeThreadCount = 0;
		}
	}

	public long GetSpeed()
	{
		return _speed;
	}

	public bool IsPause()
	{
		return _isPause;
	}

	public bool IsFaied()
	{
		return _isFailed;
	}

	public long GetDownLoadSize()
	{
		return _downDoneSize + _downLoadSize;
	}

	public void MContinue()
	{
		if (_isPause && _workThread != null)
		{
			_isPause = false;
			_isContinue = true;
			_workThreadEvent.Set();
		}
	}

	private void Resume()
	{
		if (_workThreadEvent == null)
		{
			return;
		}
		lock (_workThreadEvent)
		{
			if (_isPause)
			{
				_isPause = false;
				_isContinue = false;
			}
			if (!_workThreadEvent.IsSet)
			{
				_workThreadEvent.Set();
			}
		}
	}

	private void Pause(bool isFailed)
	{
		if (_workThreadEvent == null)
		{
			return;
		}
		lock (_workThreadEvent)
		{
			if (!_isPause)
			{
				_isPause = true;
				_isFailed = isFailed;
			}
			if (_workThreadEvent.IsSet)
			{
				_workThreadEvent.Reset();
			}
		}
	}

	public void Pause()
	{
		if (_globalPauseEvent == null)
		{
			return;
		}
		lock (_globalPauseEvent)
		{
			if (!_isGlobalPause)
			{
				_isGlobalPause = true;
			}
			if (_globalPauseEvent.IsSet)
			{
				_globalPauseEvent.Reset();
			}
		}
	}

	private void GlobalPause()
	{
		_globalPauseEvent.Wait();
	}

	public void Continue()
	{
		if (_globalPauseEvent == null)
		{
			return;
		}
		lock (_globalPauseEvent)
		{
			if (_isGlobalPause)
			{
				_isGlobalPause = false;
			}
			if (!_globalPauseEvent.IsSet)
			{
				_globalPauseEvent.Set();
			}
		}
	}

	private void CalcSpeed()
	{
		_speedTime += Time.unscaledDeltaTime;
		if (_speedTime > 1f)
		{
			_speed = GetDownLoadSize() - _lastSecondSize;
			_speedTime--;
			_lastSecondSize = GetDownLoadSize();
		}
	}

	private int GetWorkIndex()
	{
		for (int i = 0; i < _workList.Count; i++)
		{
			if (_workList[i] == null)
			{
				return i;
			}
		}
		return -1;
	}

	private bool DoWorkTaskInThreadPool(DownLoadTask task)
	{
		int workIndex = GetWorkIndex();
		if (workIndex != -1 && task != null)
		{
			task.isDone = false;
			_workList[workIndex] = task;
			ThreadPool.QueueUserWorkItem(ThreadPoolFunc, workIndex);
			return true;
		}
		return false;
	}

	private bool IsWorkWait()
	{
		return _taskQueue.Count > 0;
	}

	private bool IsWorkFailed()
	{
		return _failedList.Count > 0;
	}

	private bool IsWorkDoing()
	{
		long num = 0L;
		long num2 = 0L;
		bool result = false;
		for (int i = 0; i < _workList.Count; i++)
		{
			DownLoadTask downLoadTask = _workList[i];
			if (downLoadTask == null)
			{
				continue;
			}
			if (downLoadTask.isDone)
			{
				_workList[i] = null;
				if (downLoadTask.isSuccess)
				{
					num2 += downLoadTask.downLoadSize;
				}
				else
				{
					_failedList.Add(downLoadTask);
				}
				_doneQueue.Enqueue(downLoadTask);
			}
			else
			{
				num += downLoadTask.downLoadSize;
				result = true;
			}
		}
		_downLoadSize = num;
		_downDoneSize += num2;
		return result;
	}

	private void WorkThreadFunc()
	{
		Interlocked.Increment(ref _activeThreadCount);
		try
		{
			do
			{
				GlobalPause();
				if (_needStop)
				{
					break;
				}
				bool flag = false;
				bool isFailed = false;
				lock (_object)
				{
					long downDoneSize = _downDoneSize;
					bool flag2 = IsWorkDoing();
					bool flag3 = IsWorkFailed();
					bool flag4 = IsWorkWait();
					if (!flag4 && !flag2 && !flag3)
					{
						flag = true;
					}
					else
					{
						if (flag3 && _downDoneSize <= downDoneSize && !flag4 && !flag2)
						{
							flag = true;
							isFailed = true;
						}
						if (!flag & flag4)
						{
							_taskQueue.TryPeek(out var result);
							if (DoWorkTaskInThreadPool(result))
							{
								_taskQueue.TryDequeue(out var _);
							}
						}
					}
				}
				if (flag)
				{
					Pause(isFailed);
					continue;
				}
				Thread.Sleep(1);
				ProgressEvent?.Invoke(GetDownLoadSize(), _taskQueue.Count, _doneQueue.Count - _failedList.Count, _failedList.Count, _speed.ToString());
			}
			while (!_needStop);
		}
		finally
		{
			if (Interlocked.Decrement(ref _activeThreadCount) == 0)
			{
				_threadExitEvent.Set();
			}
		}
	}

	private void ThreadPoolFunc(object param)
	{
		Interlocked.Increment(ref _activeThreadCount);
		try
		{
			DownLoadTask downLoadTask = null;
			int index = (int)param;
			downLoadTask = _workList[index];
			if (downLoadTask != null)
			{
				downLoadTask.buffer = _bufferList[index];
				if (downLoadTask.buffer == null)
				{
					downLoadTask.buffer = new byte[65536];
					_bufferList[index] = downLoadTask.buffer;
				}
			}
			if (downLoadTask != null)
			{
				DoDownLoadTask(downLoadTask);
			}
		}
		finally
		{
			if (Interlocked.Decrement(ref _activeThreadCount) == 0)
			{
				_threadExitEvent.Set();
			}
		}
	}

	private bool DoDownLoadTask(DownLoadTask task)
	{
		if (task == null || task.isDone)
		{
			return false;
		}
		int num = 0;
		HttpWebRequest httpWebRequest = null;
		HttpWebResponse httpWebResponse = null;
		FileStream fileStream = null;
		Stream stream = null;
		byte[] buffer = task.buffer;
		bool flag = false;
		bool flag2 = false;
		string text = null;
		bool flag3 = false;
		do
		{
			GlobalPause();
			if (task.isCancel || _needStop)
			{
				break;
			}
			try
			{
				if (task.totalSize <= 0)
				{
					task.totalSize = GetFileLength(task.url);
				}
				if (task.totalSize > 0)
				{
					string directoryName = Path.GetDirectoryName(task.path);
					if (!Directory.Exists(directoryName))
					{
						Directory.CreateDirectory(directoryName);
					}
					httpWebRequest = CreateWebRequest(task.url);
					long num2 = 0L;
					using (fileStream = new FileStream(task.path, FileMode.OpenOrCreate))
					{
						if (fileStream.Length > 0 && task.totalSize > fileStream.Length && fileStream.Length < int.MaxValue)
						{
							num2 += (task.downLoadSize = fileStream.Seek(0L, SeekOrigin.End));
						}
						else
						{
							fileStream.Seek(0L, SeekOrigin.Begin);
							fileStream.SetLength(0L);
							task.downLoadSize = 0L;
						}
						httpWebRequest.AddRange((int)num2);
						using (httpWebResponse = httpWebRequest.GetResponse() as HttpWebResponse)
						{
							if (httpWebResponse.StatusCode == HttpStatusCode.OK || httpWebResponse.StatusCode == HttpStatusCode.PartialContent)
							{
								stream = httpWebResponse.GetResponseStream();
								stream.ReadTimeout = 30000;
								int num3 = 0;
								while (!task.IsDownLoadDone() && !task.isCancel && !_isGlobalPause && !_needStop)
								{
									num3 = stream.Read(buffer, 0, buffer.Length);
									if (num3 <= 0)
									{
										break;
									}
									fileStream.Write(buffer, 0, num3);
									task.downLoadSize += num3;
								}
								stream.Close();
								stream = null;
								httpWebResponse.Close();
								httpWebResponse = null;
								httpWebRequest.Abort();
								httpWebRequest = null;
								fileStream.Close();
								fileStream = null;
								if (task.IsDownLoadDone())
								{
									flag = true;
								}
							}
							else
							{
								Debug.LogErrorFormat("webResponse code:{0}", httpWebResponse.StatusCode.ToString());
							}
						}
					}
				}
			}
			catch (Exception ex)
			{
				flag2 = ((ex is WebException { Status: WebExceptionStatus.Timeout } ex2 && ex2.TargetSite.Name == "Read") ? true : false);
				Debug.LogError("DoDownLoadTask StackTrace: " + ex.StackTrace);
				Debug.LogError("DoDownLoadTask StackTrace: " + ex.Message);
				if (ex is IOException ex3 && ex3.Message.Contains("112"))
				{
					lock (_object)
					{
						text = ERROR_DISK_FULL + " " + ex3.Message;
						Pause();
						errors[ERROR_DISK_FULL].Enqueue(ERROR_DISK_FULL + " " + ex3.Message);
						flag3 = true;
					}
					break;
				}
				if (ex is WebException || ex is HttpRequestException)
				{
					text = ERROR_NET + " " + ex.Message;
				}
				if (stream != null)
				{
					stream.Close();
					stream = null;
				}
				if (httpWebResponse != null)
				{
					httpWebResponse.Close();
					httpWebResponse = null;
				}
				if (httpWebRequest != null)
				{
					httpWebRequest.Abort();
					httpWebRequest = null;
				}
				if (fileStream != null)
				{
					fileStream.Close();
					fileStream = null;
				}
			}
			finally
			{
				stream?.Close();
				httpWebResponse?.Close();
				httpWebRequest?.Abort();
				fileStream?.Close();
			}
			if (flag3 || flag)
			{
				break;
			}
			if (!flag2 && !_isGlobalPause)
			{
				num++;
			}
			Thread.Sleep(1);
		}
		while (num < 3);
		task.Done(flag);
		SingleTaskEvent?.Invoke((!flag) ? 1 : 0, task.path, task.downLoadSize, task.md5, flag ? "" : ("Error: " + text));
		return flag;
	}

	private HttpWebRequest CreateWebRequest(string url)
	{
		HttpWebRequest httpWebRequest = WebRequest.Create(url) as HttpWebRequest;
		if (url.StartsWith("https", StringComparison.OrdinalIgnoreCase))
		{
			httpWebRequest.ProtocolVersion = HttpVersion.Version10;
		}
		httpWebRequest.AllowAutoRedirect = true;
		httpWebRequest.Timeout = 5000;
		httpWebRequest.Method = "GET";
		httpWebRequest.CachePolicy = new RequestCachePolicy(RequestCacheLevel.NoCacheNoStore);
		httpWebRequest.KeepAlive = true;
		httpWebRequest.CookieContainer = null;
		httpWebRequest.UseDefaultCredentials = true;
		httpWebRequest.ServicePoint.ConnectionLimit = 512;
		return httpWebRequest;
	}

	private long GetFileLength(string url)
	{
		long result = -1L;
		HttpWebResponse httpWebResponse = null;
		HttpWebRequest httpWebRequest = null;
		try
		{
			httpWebRequest = CreateWebRequest(url);
			using (httpWebResponse = httpWebRequest.GetResponse() as HttpWebResponse)
			{
				if (httpWebResponse != null)
				{
					result = httpWebResponse.ContentLength;
					httpWebResponse.Close();
					httpWebResponse = null;
				}
			}
			httpWebRequest.Abort();
			httpWebRequest = null;
		}
		catch (Exception ex)
		{
			Debug.LogError(ex.Message);
			if (httpWebResponse != null)
			{
				httpWebResponse.Close();
				httpWebResponse = null;
			}
			if (httpWebRequest != null)
			{
				httpWebRequest.Abort();
				httpWebRequest = null;
			}
		}
		return result;
	}

	public DownLoadTask DoTask(DownLoadTask downLoadTask, bool needAutoResume = true)
	{
		_taskQueue.Enqueue(downLoadTask);
		if (needAutoResume)
		{
			Resume();
		}
		return downLoadTask;
	}

	private DownLoadTask DownLoad(string url, string file, string filename, bool needAutoResume = true)
	{
		DownLoadTask downLoadTask = new DownLoadTask();
		downLoadTask.url = url;
		downLoadTask.path = file;
		downLoadTask.md5 = filename;
		DoTask(downLoadTask, needAutoResume);
		return downLoadTask;
	}

	public void Download(string baseUrl, string fileRootDir, string[] downloadList)
	{
		lock (_object)
		{
			if (_isDownloading)
			{
				Debug.LogError("正在下载，无需重复请求下载.");
				return;
			}
			_isDownloading = true;
			StartNewDownloadThread();
			_waitDownloadCount = downloadList.Length;
			for (int i = 0; i < downloadList.Length; i++)
			{
				string[] array = downloadList[i].Split(",");
				string path = array[0];
				_ = array[1];
				string text = array[2];
				DownLoad(baseUrl + text, Path.Combine(fileRootDir, path), text, needAutoResume: false);
			}
			Resume();
			Continue();
		}
	}
}
