#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using FMODUnity;
using GameFramework;
using GameFramework.Resource;
using GameFramework.Runtime;
using Newtonsoft.Json;
using UnityEngine;

namespace Ase;

public static class Entry
{
	public static void Init()
	{
	}

	public static async UniTask Start()
	{
		Physics.autoSimulation = false;
		Physics.autoSyncTransforms = false;
		TDAHandler.Initialize();
		Game.AddSingleton<ObjectPool>();
		Game.AddSingleton<ServiceSystem>();
		Game.AddSingleton<GraphicsSetting>();
		Game.AddSingleton<NetworkSystem>();
		Game.AddSingleton<NetResponseHandler>();
		Game.AddSingleton<Story>();
		Game.AddSingleton<NetCodes>();
		Game.AddSingleton<GuidanceManager>();
		Game.AddSingleton<AudioSystem>();
		await GameEntry.UI.OpenWindow<StartupWindow>("Start/StartupWindow", new StartupViewModel());
	}

	public static async UniTask TryDownloadSubRes(ProgressBar progressBar)
	{
		await LoadMasterAudio(null);
		Game.AddSingleton<SubrequestResHelper>();
		await Singleton<SubrequestResHelper>.Instance.DownSubrequestRes(showTips: true, delegate(float progress, long cur, long toal)
		{
			progressBar.Progress = progress;
			progressBar.CurrentDownloadBytes = cur;
			progressBar.TotalDownloadBytes = toal;
		});
	}

	public static IProgressResult<float> StartLoadGameData()
	{
		Log.Error("Version New " + GameEntry.BuiltinData.GameVersion.code_version);
		ProgressResult<float> progressResult = new ProgressResult<float>();
		LoadGameData(progressResult);
		return progressResult;
	}

	private static async void LoadGameData(ProgressResult<float> progressResult)
	{
		if (GameEntry.BuiltinData.IsFirstResourceUpdate)
		{
			await LoadMasterAudio(progressResult);
		}
		await LoadViewConfig(progressResult);
		await LoadDataTables(progressResult);
		await LoadIconBundles(progressResult);
		await LoadConfig(progressResult);
		await LoadShaders(progressResult);
		await LoadAudio(progressResult);
		progressResult.UpdateProgress(0.95f);
		await Start();
		progressResult.UpdateProgress(1f);
	}

	public static async UniTask LoadViewConfig(ProgressResult<float> progressResult)
	{
		await ViewConfigSetting.Init();
		progressResult.UpdateProgress(progressResult.Progress + 0.1f);
	}

	public static async UniTask LoadMasterAudio(ProgressResult<float> progressResult)
	{
		BankGroupData masterBankGroup = new BankGroupData
		{
			Id = 9999,
			Banks = new List<string> { "Master", "Master.strings" },
			GroupType = 0
		};
		List<string> masterNameList = new List<string>();
		try
		{
			foreach (string bank in masterBankGroup.Banks)
			{
				string audioPath = AssetUtility.GetMusicAsset(bank);
				TextAsset textAsset = await GameEntry.Resource.LoadAssetAsync<TextAsset>(audioPath, "Audio");
				masterNameList.Add(textAsset.name);
				GameEntry.Audio.LoadMainBank(textAsset, textAsset.name, masterBankGroup.GroupType, loadSamples: true);
				GameEntry.Resource.UnloadAsset(audioPath, "Audio");
			}
		}
		catch
		{
		}
		int waitMasterTimer = 600;
		float allStepProg = 0.05f;
		float stepProg = 0f;
		for (int i = 0; i < masterNameList.Count; i++)
		{
			string audioPath = masterNameList[i];
			while (!RuntimeManager.HasBankLoaded(audioPath))
			{
				stepProg = Mathf.Min(stepProg + 0.01f, allStepProg);
				progressResult?.UpdateProgress(progressResult.Progress + stepProg);
				allStepProg = Mathf.Max(0f, allStepProg - stepProg);
				await UniTask.Yield();
				int num = waitMasterTimer - 1;
				waitMasterTimer = num;
				if (num < 0)
				{
					break;
				}
			}
		}
		progressResult?.UpdateProgress(progressResult.Progress + allStepProg);
		allStepProg = 0.05f;
		stepProg = 0f;
		progressResult?.UpdateProgress(progressResult.Progress + 0.1f);
		while (RuntimeManager.AnySampleDataLoading())
		{
			stepProg = Mathf.Min(stepProg + 0.005f, allStepProg);
			progressResult?.UpdateProgress(progressResult.Progress + stepProg);
			allStepProg = Mathf.Max(0f, allStepProg - stepProg);
			await UniTask.Yield();
			int num = waitMasterTimer - 1;
			waitMasterTimer = num;
			if (num < 0)
			{
				break;
			}
		}
		progressResult?.UpdateProgress(progressResult.Progress + allStepProg);
	}

	public static async UniTask LoadAudio(ProgressResult<float> progressResult)
	{
		int waitTimerLoading = 300;
		float allProg1 = 0.1f;
		float allProg2 = 0.05f;
		if (true)
		{
			UniTask task = AudioHelper.LoadBanksByType(0);
			while (task.Status == UniTaskStatus.Pending || !RuntimeManager.HaveAllBanksLoaded)
			{
				float num = Mathf.Min(0.00033f, allProg1);
				progressResult.UpdateProgress(progressResult.Progress + num);
				allProg1 = Mathf.Max(0f, allProg1 - num);
				await UniTask.Yield();
				int num2 = waitTimerLoading - 1;
				waitTimerLoading = num2;
				if (num2 < 0)
				{
					if (task.Status == UniTaskStatus.Pending)
					{
						Log.Error("[Audio] Common Audio Task is always Pending.");
					}
					else if (!RuntimeManager.HaveAllBanksLoaded)
					{
						Log.Error("[Audio] Common Audio load timeout.");
					}
					break;
				}
			}
			await UniTask.Yield();
			int waitTimerSample = 300;
			while (RuntimeManager.AnySampleDataLoading())
			{
				float num = Mathf.Min(0.000167f, allProg2);
				progressResult.UpdateProgress(progressResult.Progress + num);
				allProg2 = Mathf.Max(0f, allProg2 - num);
				await UniTask.Yield();
				int num2 = waitTimerSample - 1;
				waitTimerSample = num2;
				if (num2 < 0)
				{
					Log.Error("[Audio] Common Audio Sample timeout.");
					break;
				}
			}
		}
		progressResult.UpdateProgress(progressResult.Progress + allProg1 + allProg2);
	}

	private static async UniTask LoadDataTables(ProgressResult<float> progressResult)
	{
		string[] dataTableNames = Global.DataTableNames;
		foreach (string dataTableName in dataTableNames)
		{
			GameEntry.DataTable.LoadDataTable(dataTableName, LoadType.Bytes);
			progressResult.UpdateProgress(progressResult.Progress + 0.2f / (float)Global.DataTableNames.Length);
		}
	}

	private static async UniTask LoadIconBundles(ProgressResult<float> progressResult)
	{
		IConverterRegistry converterRegistry = Context.GetApplicationContext().GetContainer().Resolve<IConverterRegistry>();
		AssetData[] assetInfos = GameEntry.Resource.GetAssetInfos("iconbundles");
		if (assetInfos.Length == 0)
		{
			return;
		}
		PackageSpriteConverter packageSpriteConverter = new PackageSpriteConverter();
		foreach (Sprite item in await GameEntry.Resource.LoadAllAssetAsync<Sprite>(assetInfos[0].AssetPath))
		{
			packageSpriteConverter.Add(item);
		}
		converterRegistry.Register("ItemIcon", packageSpriteConverter);
		progressResult.UpdateProgress(progressResult.Progress + 0.1f);
	}

	private static async UniTask LoadConfig(ProgressResult<float> progressResult)
	{
		string path = AssetUtility.GetConfigAsset("GameConfig", LoadType.Text);
		TextAsset textAsset = await GameEntry.Resource.LoadAssetAsync<TextAsset>(path);
		GameEntry.Base.GameConfig = JsonConvert.DeserializeObject<GameConfig>(textAsset.text);
		GameEntry.Resource.UnloadAsset(path);
		progressResult.UpdateProgress(progressResult.Progress + 0.1f);
	}

	private static async UniTask LoadShaders(ProgressResult<float> progressResult)
	{
		AssetData[] assetInfos = GameEntry.Resource.GetAssetInfos("shadervariants");
		if (assetInfos.Length == 0)
		{
			return;
		}
		foreach (ShaderVariantCollection item in await GameEntry.Resource.LoadAllAssetAsync<ShaderVariantCollection>(assetInfos[0].AssetPath))
		{
			if (item != null)
			{
				item.WarmUp();
			}
			progressResult.UpdateProgress(progressResult.Progress + 0.1f / (float)assetInfos.Length);
		}
	}
}
