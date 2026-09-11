using UnityEngine;

namespace AssetBundleManager.DownloadV2;

public class ThreadDownloadMono : MonoBehaviour
{
	private ThreadDownloadManager mgr;

	public string targetPath;

	public bool pause;

	public void Initialize()
	{
		if (mgr == null)
		{
			mgr = new ThreadDownloadManager();
			mgr.processCallback = delegate(float value)
			{
				Debug.LogError("下载速度: " + value / 1048576f);
			};
			mgr.doneCallback = delegate(DownloadTask task)
			{
				Debug.LogError("下载成功: " + task.originUrl);
			};
			mgr.failedCallback = delegate(DownloadTask task)
			{
				Debug.LogError("下载失败: " + task.originUrl);
			};
			mgr.Init();
		}
	}

	public void AddTask(string url, string savePath, bool force)
	{
		mgr.AddTask(url, savePath, force);
	}

	public void Stop()
	{
		mgr?.Destroy();
		mgr = null;
	}

	private void Update()
	{
		if (!pause)
		{
			mgr.MonoTick();
		}
	}

	private void OnDestroy()
	{
		Stop();
	}
}
