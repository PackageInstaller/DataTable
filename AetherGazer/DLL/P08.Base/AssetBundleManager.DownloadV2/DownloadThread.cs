using System;
using System.IO;
using System.Net;
using System.Security.Cryptography;
using System.Threading;
using UnityEngine;

namespace AssetBundleManager.DownloadV2;

public class DownloadThread
{
	public const int MSECOND_TIME_OUT = 300000;

	public DownloadTask task;

	public volatile bool isFree;

	private Thread thread;

	private AutoResetEvent threadEvent = new AutoResetEvent(initialState: false);

	public Action<DownloadThread> OnDownloadDone;

	public Action<DownloadThread> OnDownloadFail;

	public Action<DownloadThread> OnDownloadSuccess;

	private volatile float downloadBytes;

	private bool isRunning = true;

	private MD5 md5;

	private string IOError = string.Empty;

	private byte[] rbytes;

	private HttpWebRequest request;

	private HttpWebResponse response;

	public long completedSizeCount { get; }

	public float completeRate { get; }

	public void Init()
	{
		rbytes = new byte[65536];
		md5 = MD5.Create();
		downloadBytes = 0f;
		thread = new Thread((ThreadStart)delegate
		{
			while (isRunning)
			{
				isFree = true;
				IOError = string.Empty;
				if (string.IsNullOrEmpty(IOError) && task != null)
				{
					OnDownloadSuccess?.Invoke(this);
				}
				OnDownloadDone?.Invoke(this);
				threadEvent.WaitOne();
				DownloadTask();
			}
		});
		thread.IsBackground = true;
		thread.Start();
	}

	private void DownloadTask()
	{
		int num = 0;
		long num2 = 0L;
		long num3 = 0L;
		string savePath = task.savePath;
		try
		{
			if (File.Exists(savePath))
			{
				if (task.force)
				{
					File.Delete(savePath);
					num2 = 0L;
				}
				else
				{
					num2 = new FileInfo(savePath).Length;
				}
			}
			using FileStream fileStream = new FileStream(savePath, FileMode.OpenOrCreate, FileAccess.Write, FileShare.ReadWrite);
			if (num2 > 0)
			{
				fileStream.Seek(num2, SeekOrigin.Current);
			}
			request = WebRequest.CreateHttp(new Uri(task.originUrl));
			request.AddRange(num2);
			request.KeepAlive = false;
			request.Timeout = 300000;
			request.Method = "GET";
			using (response = (HttpWebResponse)request.GetResponse())
			{
				if ((response != null && response.StatusCode == HttpStatusCode.PartialContent) || response.StatusCode == HttpStatusCode.OK)
				{
					num3 = ReceiveContentLength(response, num2);
					using Stream stream = response.GetResponseStream();
					if (stream == null)
					{
						return;
					}
					do
					{
						if (!isRunning)
						{
							fileStream.Flush();
							OnDownloadFail?.Invoke(this);
							break;
						}
						num = stream.Read(rbytes, 0, rbytes.Length);
						if (num > 0)
						{
							fileStream.Write(rbytes, 0, num);
							fileStream.Flush();
							num2 += num;
							downloadBytes += num;
							continue;
						}
						break;
					}
					while (num2 < num3);
					return;
				}
				throw new Exception("网络错误: " + response.StatusCode.ToString() + " " + response.StatusDescription);
			}
		}
		catch (Exception ex)
		{
			IOError = ex.ToString();
			OnDownloadFail?.Invoke(this);
		}
		finally
		{
			request = null;
			response = null;
		}
	}

	protected long ReceiveContentLength(HttpWebResponse response, long localSize)
	{
		long num = 0L;
		string responseHeader = response.GetResponseHeader("Content-Length");
		if (!string.IsNullOrEmpty(responseHeader))
		{
			try
			{
				num = long.Parse(responseHeader);
			}
			catch (FormatException ex)
			{
				Debug.Log("获取文件长度失败,contentLengthStr:" + responseHeader + "," + ex.Message);
				num = response.ContentLength;
			}
			catch (Exception ex2)
			{
				Debug.Log("获取文件长度失败,contentLengthStr:" + responseHeader + "," + ex2.Message);
				num = response.ContentLength;
			}
		}
		else
		{
			num = response.ContentLength;
		}
		return num + localSize;
	}

	public void StartDownload(DownloadTask newTask)
	{
		task = newTask;
		isFree = false;
		threadEvent.Set();
	}

	public string GetError()
	{
		return IOError;
	}

	public float GetCacheBytes()
	{
		float result = downloadBytes;
		downloadBytes = 0f;
		return result;
	}

	public void Destroy()
	{
		md5.Dispose();
		OnDownloadDone = null;
		OnDownloadFail = null;
		OnDownloadSuccess = null;
		isRunning = false;
		response?.Close();
		request?.Abort();
	}
}
