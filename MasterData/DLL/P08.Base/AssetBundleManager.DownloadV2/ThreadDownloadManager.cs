using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.IO;
using System.Threading;
using UnityEngine;

namespace AssetBundleManager.DownloadV2;

public class ThreadDownloadManager
{
	private const int repeatTimes = 3;

	private int threadCount = 4;

	private float lastCollectTime;

	private ConcurrentQueue<DownloadThread> freeQueue;

	private List<DownloadThread> threads;

	private ConcurrentQueue<DownloadTask> waitingTask;

	private ConcurrentQueue<string> errorList;

	private ConcurrentQueue<DownloadTask> doneTask;

	private ConcurrentQueue<DownloadTask> failedTask;

	private Thread downloadThread;

	public Action<DownloadTask> doneCallback;

	public Action<DownloadTask> failedCallback;

	public Action<float> processCallback;

	public void Init(int count = 4)
	{
		threadCount = count;
		threads = new List<DownloadThread>();
		freeQueue = new ConcurrentQueue<DownloadThread>();
		waitingTask = new ConcurrentQueue<DownloadTask>();
		failedTask = new ConcurrentQueue<DownloadTask>();
		errorList = new ConcurrentQueue<string>();
		doneTask = new ConcurrentQueue<DownloadTask>();
		lastCollectTime = 0f;
		for (int i = 0; i < threadCount; i++)
		{
			DownloadThread downloadThread = new DownloadThread();
			downloadThread.Init();
			threads.Add(downloadThread);
			downloadThread.OnDownloadDone = delegate(DownloadThread thread)
			{
				thread.task = null;
				freeQueue.Enqueue(thread);
			};
			downloadThread.OnDownloadSuccess = delegate(DownloadThread thread)
			{
				doneTask.Enqueue(thread.task);
			};
			downloadThread.OnDownloadFail = delegate(DownloadThread thread)
			{
				DownloadTask task = thread.task;
				if (task.repeatTimes < 3)
				{
					errorList.Enqueue(thread.GetError());
					task.repeatTimes++;
					waitingTask.Enqueue(task);
				}
				else
				{
					failedTask.Enqueue(task);
				}
			};
		}
		this.downloadThread = new Thread((ThreadStart)delegate
		{
			while (true)
			{
				Tick();
			}
		});
		this.downloadThread.IsBackground = true;
		this.downloadThread.Start();
	}

	public void AddTask(string url, string savedPath, bool force)
	{
		DownloadTask downloadTask = new DownloadTask();
		downloadTask.originUrl = url;
		downloadTask.savePath = savedPath;
		downloadTask.force = force;
		waitingTask.Enqueue(downloadTask);
	}

	public void Tick()
	{
		lock (freeQueue)
		{
			DownloadTask result;
			DownloadThread result2;
			while (waitingTask.Count > 0 && waitingTask.TryPeek(out result) && freeQueue.TryDequeue(out result2))
			{
				if (!result2.isFree)
				{
					errorList.Enqueue("错误，存在不是free的任务在队列中");
					break;
				}
				waitingTask.TryDequeue(out var result3);
				FileInfo fileInfo = new FileInfo(result3.savePath);
				if (!fileInfo.Directory.Exists)
				{
					fileInfo.Directory.Create();
				}
				result2.StartDownload(result3);
			}
		}
	}

	public void MonoTick()
	{
		lock (errorList)
		{
			string result;
			while (errorList.TryDequeue(out result))
			{
				Debug.LogError(result);
			}
			errorList.Clear();
		}
		lock (doneTask)
		{
			DownloadTask result2;
			while (doneTask.TryDequeue(out result2))
			{
				doneCallback?.Invoke(result2);
			}
		}
		lock (failedTask)
		{
			DownloadTask result3;
			while (failedTask.TryDequeue(out result3))
			{
				failedCallback?.Invoke(result3);
			}
		}
		float num = 0f;
		foreach (DownloadThread thread in threads)
		{
			num += thread.GetCacheBytes();
			float unscaledDeltaTime = Time.unscaledDeltaTime;
			processCallback(num / unscaledDeltaTime);
		}
	}

	public void Destroy()
	{
		if (downloadThread != null)
		{
			downloadThread.Abort();
			downloadThread = null;
		}
		foreach (DownloadThread thread in threads)
		{
			thread.Destroy();
		}
		threads = null;
		waitingTask = null;
		doneCallback = null;
		doneTask = null;
		errorList = null;
		failedTask = null;
	}
}
