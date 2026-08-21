using System.Collections.Generic;
using System.IO;
using AssetBundleManager.DownloadV2;

public class AssetPendDownLoadPCOption : AssetPendDownLoadOption
{
	private ThreadDownloadManager mgr;

	private Dictionary<string, string> m_processingRequest = new Dictionary<string, string>();

	private long currentDownloadSpeed;

	public AssetPendDownLoadPCOption(PendType pType, string key, AssetPendDownLoadManager manager)
		: base(pType, key, manager)
	{
		mgr = new ThreadDownloadManager();
		mgr.processCallback = OnProcessCallback;
		mgr.doneCallback = OnDoneCallback;
		mgr.failedCallback = OnFailedCallback;
		mgr.Init();
		m_processingRequest = new Dictionary<string, string>();
	}

	public override void Pause()
	{
		OnPause();
	}

	public override void Cancel()
	{
		OnFailed("Cancel");
	}

	private void OnProcessCallback(float value)
	{
		currentDownloadSpeed = (long)value;
	}

	private void OnDoneCallback(DownloadTask task)
	{
		if (m_processingRequest.ContainsKey(task.savePath))
		{
			m_processingRequest.Remove(task.savePath);
			if (m_processingRequest.Count == 0)
			{
				OnSuccessed();
				return;
			}
			m_currentSize += (ulong)new FileInfo(task.savePath).Length;
			OnProcess((float)m_currentSize / (float)base.m_totalSize);
		}
	}

	private void OnFailedCallback(DownloadTask task)
	{
		onFailed?.Invoke();
	}

	protected override void StartDownload()
	{
		m_processingRequest.Clear();
		foreach (KeyValuePair<string, AssetDownloadInfo> item in m_pendingDownloadDict)
		{
			AssetDownloadInfo value = item.Value;
			if (!m_processingRequest.ContainsKey(value.path))
			{
				mgr.AddTask(value.url, value.path, force: true);
				m_processingRequest[value.path] = value.url;
			}
		}
	}

	public override void OnUpdate()
	{
		mgr?.MonoTick();
	}

	public override void OnDestroy()
	{
		mgr?.Destroy();
	}

	public override string GetSpeed()
	{
		long num = currentDownloadSpeed;
		float num2 = ((num > 1048576) ? AssetPendDownLoadManager.ConvertSize(num, "MB") : AssetPendDownLoadManager.ConvertSize(num, "KB"));
		string arg = ((num > 1048576) ? "MB" : "KB");
		return $"{num2:F2}{arg}";
	}
}
