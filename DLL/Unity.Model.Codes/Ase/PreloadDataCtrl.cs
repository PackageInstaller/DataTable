#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.IO;
using System.Reflection;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Resource;
using GameFramework.Runtime;
using HybridCLR;
using UnityEngine;

namespace Ase;

public class PreloadDataCtrl
{
	public void Close()
	{
		Resources.UnloadUnusedAssets();
		GC.Collect();
	}

	public async UniTask LoadPreloadData(ProgressBar progressBar)
	{
		Assembly model = await LoadGameAssembly();
		if (model == null)
		{
			Log.Error("没有找到程序集[Unity.Hotfix.Codes].");
			return;
		}
		progressBar.Enable = true;
		progressBar.Progress = 0f;
		if (!GameEntry.BuiltinData.IsFirstResourceUpdate)
		{
			progressBar.Tip = "正在下载后续资源..";
			progressBar.Progress = 0f;
			progressBar.EnableDownload = true;
			await new StaticMethod(model, "Ase.Entry", "TryDownloadSubRes").RunAsync(progressBar);
		}
		progressBar.Tip = "正在加载资源(此过程不消耗流量)...";
		progressBar.Progress = 0f;
		progressBar.EnableDownload = false;
		IStaticMethod staticMethod = new StaticMethod(model, "Ase.Entry", "StartLoadGameData");
		IProgressResult<float> progressResult = staticMethod.Run<IProgressResult<float>>();
		while (progressResult.Progress < 1f)
		{
			progressBar.Progress = progressResult.Progress;
			await UniTask.Yield();
		}
		Singleton<NetCodes>.Instance.Init(model);
		await UniTask.Yield();
		Close();
	}

	private async UniTask<Assembly> LoadGameAssembly()
	{
		await LoadMetadataForAOTAssemblies();
		return Assembly.Load(await LoadHotfixAssemblies());
	}

	public async UniTask<byte[]> LoadHotfixAssemblies()
	{
		byte[] result = default(byte[]);
		object obj;
		int num;
		try
		{
			TextAsset textAsset = await GameEntry.Resource.LoadAssetAsync<TextAsset>(AssetUtility.GetCodeAsset("Hotfix/Hotfix.dll"), "HotCode");
			if (textAsset == null)
			{
				result = await File.ReadAllBytesAsync(Application.streamingAssetsPath + "/Hotfix.dll.bytes");
				return result;
			}
			byte[] bytes = textAsset.bytes;
			GameEntry.Resource.UnloadAsset(AssetUtility.GetCodeAsset("Hotfix/Hotfix.dll"), "HotCode");
			result = bytes;
			return result;
		}
		catch (Exception ex)
		{
			obj = ex;
			num = 1;
		}
		if (num != 1)
		{
			return result;
		}
		_ = (Exception)obj;
		return await File.ReadAllBytesAsync(Application.streamingAssetsPath + "/Hotfix.dll.bytes");
	}

	private static async UniTask LoadMetadataForAOTAssemblies()
	{
		AssetData[] assetInfos = GameEntry.Resource.GetAssetInfos("hotfixAot", "HotCode");
		if (assetInfos.Length == 0)
		{
			return;
		}
		foreach (TextAsset item in await GameEntry.Resource.LoadAllAssetAsync<TextAsset>(assetInfos[0].AssetPath, "HotCode"))
		{
			RuntimeApi.LoadMetadataForAOTAssembly(item.bytes, (HomologousImageMode)1);
			await UniTask.Yield();
		}
		GameEntry.Resource.UnloadAsset(assetInfos[0].AssetPath, "HotCode");
	}
}
