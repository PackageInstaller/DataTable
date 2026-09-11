using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Networking;

public class DownloadRequest : IDisposable
{
	public int triedTimes;

	public int priority;

	private UnityWebRequest www;

	public string url = "";

	public int version;

	protected Dictionary<string, string> header;

	protected byte[] postData;

	public object userData;

	public UnityAction<DownloadRequest> callback;

	public bool isCache;

	protected FileStream fileStream;

	public string localFile = string.Empty;

	protected long localFileSize;

	public bool forceDownload;

	public const int SECOND_TIME_OUT = 300;

	public int retryUrlIndex;

	private ulong lastDownloadedBytes;

	private ulong lastLocalFileSize;

	public bool _isDone;

	private static Stack<byte[]> mBuffPool = new Stack<byte[]>();

	private byte[] buffer;

	public virtual long deltaDownloadBytes
	{
		get
		{
			if (www == null)
			{
				return 0L;
			}
			ulong downloadedBytes = www.downloadedBytes;
			long num = (long)(downloadedBytes - lastDownloadedBytes);
			if (num < 0)
			{
				num = 0L;
			}
			lastDownloadedBytes = downloadedBytes;
			return num;
		}
	}

	public virtual long deltaFileSize
	{
		get
		{
			if (www == null)
			{
				return 0L;
			}
			ulong num = GetLocalFileSize();
			long num2 = (long)(num - lastLocalFileSize);
			if (num2 < 0)
			{
				num2 = 0L;
			}
			lastLocalFileSize = num;
			return num2;
		}
	}

	public virtual bool isDone
	{
		get
		{
			if (www == null || !www.isDone)
			{
				return _isDone;
			}
			return true;
		}
	}

	public virtual ulong GetLocalFileSize()
	{
		if (www == null)
		{
			return 0uL;
		}
		return (www.downloadHandler as WWWDownloadHandler).LocalFileSize;
	}

	public DownloadRequest(object userData = null)
	{
		this.userData = userData;
	}

	public DownloadRequest(object userData, bool isCache)
	{
		this.isCache = isCache;
		this.userData = userData;
		if (isCache)
		{
			FileInfo fileInfo = new FileInfo((string)userData);
			if (!fileInfo.Directory.Exists)
			{
				fileInfo.Directory.Create();
			}
		}
	}

	public DownloadRequest(string url, byte[] postData, Dictionary<string, string> header, object userData = null)
	{
		this.url = url;
		this.header = header;
		this.postData = postData;
		this.userData = userData;
	}

	public virtual float GetProcess()
	{
		if (www == null)
		{
			return 0f;
		}
		return www.downloadProgress;
	}

	public static void ClearBuffer()
	{
		mBuffPool.Clear();
	}

	public byte[] GetBuff()
	{
		if (mBuffPool.Count <= 0)
		{
			return new byte[65536];
		}
		return mBuffPool.Pop();
	}

	public void Return(byte[] buff)
	{
		if (mBuffPool.Count > 0 && mBuffPool.Peek() == buff)
		{
			Debug.LogError("重复释放!");
		}
		mBuffPool.Push(buff);
	}

	public virtual void CreateWWW()
	{
		triedTimes++;
		Pure();
		www = UnityWebRequest.Get(url);
		www.timeout = 300;
		buffer = GetBuff();
		new WWWDownloadHandler(this, (string)userData, buffer);
	}

	public virtual void Pure()
	{
		if (www != null)
		{
			if (www.downloadHandler is WWWDownloadHandler wWWDownloadHandler)
			{
				wWWDownloadHandler.Clean();
			}
			www.disposeDownloadHandlerOnDispose = true;
			www.Dispose();
			www = null;
		}
		if (buffer != null)
		{
			Return(buffer);
			buffer = null;
		}
	}

	public virtual void Dispose()
	{
		DownloadManager.Instance.DisposeWWW(url);
		www = null;
	}

	public virtual UnityWebRequest GetWWW()
	{
		return www;
	}

	public virtual string GetError()
	{
		if (www != null)
		{
			if (www.downloadHandler is WWWDownloadHandler wWWDownloadHandler)
			{
				string iOError = wWWDownloadHandler.GetIOError();
				if (!string.IsNullOrEmpty(iOError))
				{
					return iOError;
				}
			}
			return www.error;
		}
		return string.Empty;
	}

	public virtual long GetResponeCode()
	{
		if (www != null)
		{
			return www.responseCode;
		}
		return 0L;
	}
}
