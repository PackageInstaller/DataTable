#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using Cysharp.Threading.Tasks;
using GameFramework;
using YooAsset;

namespace Ase;

public class FirstResourceUpdater : ResourceUpdaterBase
{
	public FirstResourceUpdater(ProgressBar progressBar, string[] resourcePackages, string[] audioResourcePackages, bool appReview)
		: base(progressBar, resourcePackages, audioResourcePackages, appReview)
	{
	}

	public override async UniTask<int> UpdateResources()
	{
		try
		{
			await InitPackages();
			await CheckResourceUpdate();
			CreateDownloader();
			await StartDownload();
			GameEntry.BuiltinData.SaveVersionInfo();
		}
		catch (Exception ex)
		{
			Log.Error("下载资源失败 : " + ex.Message);
			await GameEntry.Resource.RemoveAllPackage();
			if (await AlertDialog.Show("系统提示", ex.Message, "重试", "退出") == -1)
			{
				return 1;
			}
			KiifInterface.Instance.ExitGame();
			return 2;
		}
		return 0;
	}

	protected override void CreateDownloader()
	{
		downloader = new MultiPackageDownloader();
		string[] array = resourcePackages;
		foreach (string package in array)
		{
			ResourceDownloaderOperation val = CreateDownloader(package, new string[2] { "BuildinData", "NecessaryRes" });
			if (((DownloaderOperation)val).TotalDownloadBytes > 0)
			{
				downloader.AddDownloader((DownloaderOperation)(object)val);
			}
		}
		AudioLanguageEnum audioLanguageEnum = (AudioLanguageEnum)GameEntry.Setting.GetInt("语音语言", 0);
		array = audioResourcePackages;
		foreach (string package2 in array)
		{
			ResourceDownloaderOperation val2 = CreateDownloader(package2, new string[2]
			{
				"NecessaryRes",
				audioLanguageEnum.ToString()
			});
			if (((DownloaderOperation)val2).TotalDownloadBytes > 0)
			{
				downloader.AddDownloader((DownloaderOperation)(object)val2);
			}
		}
	}
}
