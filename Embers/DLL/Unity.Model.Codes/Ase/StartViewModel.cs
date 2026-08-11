#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.IO;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.Networking;

namespace Ase;

public class StartViewModel : ViewModelBase
{
	private readonly InteractionRequest dismissRequest;

	private bool isLoading;

	private string versionInfo;

	private readonly ProgressBar progressBar = new ProgressBar();

	private Constant.LaunchType launchType;

	private SimpleCommand repairCmd;

	private ResourceUpdaterBase resourceUpdater;

	public SimpleCommand RepairCmd => repairCmd;

	public ProgressBar ProgressBar => progressBar;

	public bool IsLoading
	{
		get
		{
			return isLoading;
		}
		set
		{
			Set(ref isLoading, value, "IsLoading");
		}
	}

	public string VersionInfo
	{
		get
		{
			return versionInfo;
		}
		set
		{
			Set(ref versionInfo, value, "VersionInfo");
		}
	}

	public IInteractionRequest DismissRequest => dismissRequest;

	public StartViewModel(Constant.LaunchType launchType)
	{
		this.launchType = launchType;
		dismissRequest = new InteractionRequest(this);
		VersionInfo = GameEntry.BuiltinData.VersionInfo;
		repairCmd = new SimpleCommand(Repair);
	}

	public async UniTask Start()
	{
		int num = 1;
		while (true)
		{
			switch (num)
			{
			case 1:
				break;
			case 2:
				return;
			default:
				num = 1;
				while (true)
				{
					switch (num)
					{
					case 1:
						break;
					case 2:
						return;
					default:
						await LoadResources();
						return;
					}
					num = await resourceUpdater.UpdateResources();
				}
			}
			num = await CheckVersion();
		}
	}

	public async UniTask<int> CheckVersion()
	{
		ProgressBar.Enable = true;
		ProgressBar.EnableDownload = false;
		progressBar.Tip = "获取版本信息...";
		progressBar.Progress = 0f;
		GameVersion versionData = await GameEntry.BuiltinData.RequestVersion();
		if (versionData == null)
		{
			switch (await AlertDialog.Show("系统提示", "获取版本信息失败,请稍后重试.", "重试", "退出"))
			{
			case -1:
				return 1;
			case -2:
				Application.Quit();
				return 0;
			}
		}
		if (versionData.force_update && !versionData.game_version.Equals(GameEntry.BuiltinData.AppVersion))
		{
			if (await AlertDialog.Show("系统提示", "是否下载并安装新版本.", "确定", "退出") == -1)
			{
				if (versionData.app_isupdate)
				{
					await InstallApk(versionData.app_url);
				}
				else
				{
					Application.OpenURL(versionData.app_url);
				}
			}
			else
			{
				Application.Quit();
			}
			return 2;
		}
		GameEntry.Resource.AddResourceVersion("DefaultPackage", versionData.resource_version);
		GameEntry.Resource.AddResourceVersion("HotCode", versionData.code_version);
		GameEntry.Resource.AddResourceVersion("DataTables", versionData.dataTable_version);
		GameEntry.Resource.AddResourceVersion("Audio", versionData.audio_version);
		GameEntry.Resource.AddResourceVersion("Paradoxs", versionData.paradox_version);
		GameEntry.Resource.AddResourceVersion("Story", versionData.story_version);
		GameEntry.Resource.AddResourceVersion("Scenes", versionData.scenes_version);
		if (!GameEntry.BuiltinData.IsFirstResourceUpdate)
		{
			resourceUpdater = new FirstResourceUpdater(progressBar, ResourcesExtension.ResourcePackages, ResourcesExtension.AudioResourcePackages, versionData.app_review);
		}
		else
		{
			resourceUpdater = new ResourceUpdater(progressBar, ResourcesExtension.ResourcePackages, ResourcesExtension.AudioResourcePackages, versionData.app_review);
		}
		return 0;
	}

	private async UniTask ClearCacheResource(string[] versionPackages, string[] audioVersionPackages)
	{
		List<UniTask> list = new List<UniTask>();
		string[] array = versionPackages;
		foreach (string text in array)
		{
			if (GameEntry.BuiltinData.ActiveResourceVersions.TryGetValue(text, out var value))
			{
				list.Add(GameEntry.Resource.ClearUnusedResource(text, value));
			}
			else
			{
				list.Add(GameEntry.Resource.ClearUnusedResource(text, null));
			}
		}
		array = audioVersionPackages;
		foreach (string text2 in array)
		{
			if (GameEntry.BuiltinData.ActiveResourceVersions.TryGetValue(text2, out var value2))
			{
				list.Add(GameEntry.Resource.ClearUnusedResource(text2, value2));
			}
			else
			{
				list.Add(GameEntry.Resource.ClearUnusedResource(text2, null));
			}
		}
		await UniTask.WhenAll(list);
	}

	public async UniTask LoadResources()
	{
		if (launchType == Constant.LaunchType.RepairRes)
		{
			await OnRepairFinish();
		}
		else
		{
			await LoadGameData();
		}
	}

	public async UniTask InstallApk(string downloadPath)
	{
		if (string.IsNullOrEmpty(downloadPath))
		{
			Debug.LogError("下载路径为空");
			return;
		}
		string savePath = System.IO.Path.Combine(Application.persistentDataPath, "test.apk");
		if (!Directory.Exists(Application.persistentDataPath))
		{
			Directory.CreateDirectory(Application.persistentDataPath);
		}
		try
		{
			progressBar.Tip = "正在下载安装包...";
			IProgressResult<float> progressResult = DownloadApkAsync(downloadPath, savePath);
			while (progressResult.Progress < 1f)
			{
				progressBar.Progress = progressResult.Progress;
				await UniTask.Delay(100);
			}
			progressBar.Progress = 1f;
			KiifInterface.Instance.InstallApk(savePath);
		}
		catch (Exception ex)
		{
			Debug.LogError("APK安装失败: " + ex.Message);
		}
	}

	private IProgressResult<float> DownloadApkAsync(string url, string savePath)
	{
		ProgressResult<float> progressResult = new ProgressResult<float>();
		DownloadApkAsync(url, savePath, progressResult);
		return progressResult;
	}

	private async void DownloadApkAsync(string url, string savePath, ProgressResult<float> progressResult)
	{
		UnityWebRequest uwr = UnityWebRequest.Get(url);
		try
		{
			uwr.downloadHandler = (DownloadHandler)new DownloadHandlerFile(savePath);
			UnityWebRequestAsyncOperation request = uwr.SendWebRequest();
			while (!((AsyncOperation)(object)request).isDone)
			{
				progressResult.UpdateProgress(uwr.downloadProgress);
				await UniTask.Delay(100);
			}
			if ((int)uwr.result != 1)
			{
				Log.Error("下载失败: " + uwr.error);
			}
			progressResult.UpdateProgress(1f);
		}
		finally
		{
			((IDisposable)uwr)?.Dispose();
		}
	}

	private async UniTask LoadGameData()
	{
		await GameEntry.Localization.UpdateGlobalSource();
		PreloadDataCtrl preloadDataCtrl = new PreloadDataCtrl();
		try
		{
			await preloadDataCtrl.LoadPreloadData(progressBar);
			progressBar.Progress = 1f;
		}
		finally
		{
			progressBar.Enable = false;
			progressBar.Tip = "";
		}
		dismissRequest.Raise();
	}

	private async UniTask OnRepairFinish()
	{
		KiifInterface.Instance.ExitGame();
	}

	private void Repair()
	{
		IAsyncResult<int> result = AlertDialog.Show("系统提示", "是否修复游戏", "确定", "取消");
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				GameEntry.Resource.RepairResources();
			}
		});
	}
}
