using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using YooAsset;

namespace Ase;

public class MultiPackageDownloader
{
	public delegate void DownloadUpdate(long currentDownloadBytes, long totalDownloadBytes, int currentDownloadCount, int totalDownloadCount, float progress);

	private List<DownloaderOperation> _downloaders = new List<DownloaderOperation>();

	private long _totalDownloadBytes;

	private int _totalDownloadCount;

	private long _currentDownloadBytes;

	private int _currentDownloadCount;

	public DownloaderFinish DownloadFinishCallback { get; set; }

	public DownloadUpdate DownloadUpdateCallback { get; set; }

	public DownloadError DownloadErrorCallback { get; set; }

	public DownloadFileBegin DownloadFileBeginCallback { get; set; }

	public void AddDownloader(DownloaderOperation downloader)
	{
		_totalDownloadBytes += downloader.TotalDownloadBytes;
		_totalDownloadCount += downloader.TotalDownloadCount;
		_downloaders.Add(downloader);
	}

	public void ResumeDownload()
	{
		if (_downloaders.Count == 0)
		{
			return;
		}
		foreach (DownloaderOperation downloader in _downloaders)
		{
			downloader.ResumeDownload();
		}
	}

	public void PauseDownload()
	{
		if (_downloaders.Count == 0)
		{
			return;
		}
		foreach (DownloaderOperation downloader in _downloaders)
		{
			downloader.PauseDownload();
		}
	}

	public void CancelDownload()
	{
		if (_downloaders.Count == 0)
		{
			return;
		}
		foreach (DownloaderOperation downloader in _downloaders)
		{
			downloader.CancelDownload();
		}
	}

	public async UniTask DownloadAll()
	{
		if (_downloaders.Count == 0)
		{
			return;
		}
		foreach (DownloaderOperation downloader in _downloaders)
		{
			downloader.DownloadErrorCallback = new DownloadError(OnDownloadErrorCallback);
			downloader.DownloadUpdateCallback = new DownloadUpdate(OnDownloadUpdateCallback);
			downloader.DownloadFinishCallback = new DownloaderFinish(OnDownloadFinishCallback);
			downloader.DownloadFileBeginCallback = new DownloadFileBegin(OnDownloadFileBeginCallback);
			downloader.BeginDownload();
		}
		while (!IsAllDone())
		{
			await UniTask.Yield();
		}
	}

	private void OnDownloadFileBeginCallback(DownloadFileData data)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		if (DownloadFileBeginCallback != null)
		{
			DownloadFileBeginCallback.Invoke(data);
		}
	}

	private void OnDownloadFinishCallback(DownloaderFinishData data)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		if (DownloadFinishCallback != null)
		{
			DownloadFinishCallback.Invoke(data);
		}
	}

	private void OnDownloadUpdateCallback(DownloadUpdateData data)
	{
		_currentDownloadBytes = GetCurrentDownloadBytes();
		_currentDownloadCount = GetCurrentDownloadCount();
		if (DownloadUpdateCallback != null)
		{
			DownloadUpdateCallback(_currentDownloadBytes, GetTotalDownloadBytes(), _currentDownloadCount, GetTotalDownloadCount(), (float)_currentDownloadBytes / (float)GetTotalDownloadBytes());
		}
	}

	private void OnDownloadErrorCallback(DownloadErrorData data)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		if (DownloadErrorCallback != null)
		{
			DownloadErrorCallback.Invoke(data);
		}
	}

	public long GetCurrentDownloadBytes()
	{
		long num = 0L;
		for (int i = 0; i < _downloaders.Count; i++)
		{
			num += _downloaders[i].CurrentDownloadBytes;
		}
		return num;
	}

	public int GetCurrentDownloadCount()
	{
		int num = 0;
		for (int i = 0; i < _downloaders.Count; i++)
		{
			num += _downloaders[i].CurrentDownloadCount;
		}
		return num;
	}

	public int GetTotalDownloadCount()
	{
		return _totalDownloadCount;
	}

	public long GetTotalDownloadBytes()
	{
		return _totalDownloadBytes;
	}

	public float GetProgress()
	{
		long totalDownloadBytes = GetTotalDownloadBytes();
		if (totalDownloadBytes == 0L)
		{
			return 0f;
		}
		return (float)GetCurrentDownloadBytes() / (float)totalDownloadBytes;
	}

	public bool IsAllSucceed()
	{
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Invalid comparison between Unknown and I4
		for (int i = 0; i < _downloaders.Count; i++)
		{
			if ((int)((AsyncOperationBase)_downloaders[i]).Status != 2)
			{
				return false;
			}
		}
		return true;
	}

	public bool IsProcessing()
	{
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Invalid comparison between Unknown and I4
		for (int i = 0; i < _downloaders.Count; i++)
		{
			if ((int)((AsyncOperationBase)_downloaders[i]).Status == 1)
			{
				return true;
			}
		}
		return false;
	}

	public bool IsAllDone()
	{
		for (int i = 0; i < _downloaders.Count; i++)
		{
			if (!((AsyncOperationBase)_downloaders[i]).IsDone)
			{
				return false;
			}
		}
		return true;
	}
}
