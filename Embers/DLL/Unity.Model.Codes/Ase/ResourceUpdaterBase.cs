using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using YooAsset;

namespace Ase;

public abstract class ResourceUpdaterBase
{
	protected string[] resourcePackages;

	protected string[] audioResourcePackages;

	protected bool appReview;

	protected List<string> packageNames;

	protected MultiPackageDownloader downloader;

	protected ProgressBar progressBar;

	public ResourceUpdaterBase(ProgressBar progressBar, string[] resourcePackages, string[] audioResourcePackages, bool appReview)
	{
		this.progressBar = progressBar;
		this.resourcePackages = resourcePackages;
		this.audioResourcePackages = audioResourcePackages;
		this.appReview = appReview;
		packageNames = new List<string>();
		packageNames.AddRange(this.resourcePackages);
		packageNames.AddRange(this.audioResourcePackages);
	}

	public abstract UniTask<int> UpdateResources();

	protected UniTask InitPackages()
	{
		List<UniTask> list = new List<UniTask>();
		foreach (string packageName in packageNames)
		{
			list.Add(InitPackage(packageName));
		}
		return UniTask.WhenAll(list);
	}

	protected UniTask CheckResourceUpdate()
	{
		List<UniTask> list = new List<UniTask>();
		foreach (string packageName in packageNames)
		{
			list.Add(CheckUpdate(packageName));
		}
		return UniTask.WhenAll(list);
	}

	protected abstract void CreateDownloader();

	protected async UniTask StartDownload()
	{
		if (await DownloadAlertDialog())
		{
			int totalDownloadCount = downloader.GetTotalDownloadCount();
			long totalDownloadBytes = downloader.GetTotalDownloadBytes();
			progressBar.EnableDownload = true;
			progressBar.Enable = true;
			progressBar.Tip = "正在下载资源.";
			progressBar.CurrentDownloadBytes = 0L;
			progressBar.CurrentDownloadCount = 0;
			progressBar.TotalDownloadBytes = totalDownloadBytes;
			progressBar.TotalDownloadCount = totalDownloadCount;
			downloader.DownloadErrorCallback = new DownloadError(OnDownloadErrorCallback);
			downloader.DownloadUpdateCallback = OnDownloadUpdateCallback;
			downloader.DownloadFinishCallback = new DownloaderFinish(OnDownloadFinishCallback);
			downloader.DownloadFileBeginCallback = new DownloadFileBegin(OnDownloadFileBeginCallback);
			await downloader.DownloadAll();
			if (!downloader.IsAllSucceed())
			{
				throw new Exception("下载资源发生异常！");
			}
			await ClearCacheResource();
		}
	}

	protected async UniTask ClearCacheResource()
	{
		List<UniTask> list = new List<UniTask>();
		foreach (string packageName in packageNames)
		{
			if (GameEntry.BuiltinData.ActiveResourceVersions.TryGetValue(packageName, out var value))
			{
				list.Add(GameEntry.Resource.ClearUnusedResource(packageName, value));
			}
			else
			{
				list.Add(GameEntry.Resource.ClearUnusedResource(packageName, null));
			}
		}
		await UniTask.WhenAll(list);
	}

	protected async UniTask<bool> DownloadAlertDialog()
	{
		if (downloader.GetTotalDownloadBytes() <= 0)
		{
			return false;
		}
		if (await AlertDialog.Show("资源下载提示", "是否下载完整游戏所需资源(大小:" + FileSizeUtility.ToMb(downloader.GetTotalDownloadBytes()) + "M)?.", "下载", appReview ? "跳过" : "取消") != -1)
		{
			if (appReview)
			{
				return false;
			}
			KiifInterface.Instance.ExitGame();
			return false;
		}
		return true;
	}

	protected async UniTask InitPackage(string package)
	{
		if ((int)((AsyncOperationBase)(await GameEntry.Resource.InitPackage(package))).Status != 2)
		{
			throw new Exception("资源初始化失败！");
		}
	}

	protected async UniTask CheckUpdate(string package)
	{
		RequestPackageVersionOperation versionOperation = GameEntry.Resource.UpdatePackageVersionAsync(appendTimeTicks: true, 30, package);
		await versionOperation;
		if ((int)((AsyncOperationBase)versionOperation).Status != 2)
		{
			throw new Exception("更新资源版本失败！");
		}
		await UniTask.Delay(TimeSpan.FromSeconds(0.5));
		UpdatePackageManifestOperation manifestOperation = GameEntry.Resource.UpdatePackageManifestAsync(versionOperation.PackageVersion, autoSaveVersion: true, 30, package);
		await manifestOperation;
		if ((int)((AsyncOperationBase)manifestOperation).Status != 2)
		{
			throw new Exception("更新Manifest失败！");
		}
	}

	protected ResourceDownloaderOperation CreateDownloader(string package, string[] assetsTags = null)
	{
		if (assetsTags == null)
		{
			return GameEntry.Resource.CreateResourceDownloader(package);
		}
		return GameEntry.Resource.CreateResourceDownloader(package, assetsTags);
	}

	protected void OnDownloadFileBeginCallback(DownloadFileData data)
	{
	}

	protected void OnDownloadFinishCallback(DownloaderFinishData data)
	{
	}

	protected void OnDownloadUpdateCallback(long currentDownloadBytes, long totalDownloadBytes, int currentDownloadCount, int totalDownloadCount, float progress)
	{
		progressBar.CurrentDownloadCount = currentDownloadCount;
		progressBar.TotalDownloadCount = totalDownloadCount;
		progressBar.CurrentDownloadBytes = currentDownloadBytes;
		progressBar.TotalDownloadBytes = totalDownloadBytes;
		progressBar.Progress = progress;
	}

	protected void OnDownloadErrorCallback(DownloadErrorData data)
	{
	}
}
