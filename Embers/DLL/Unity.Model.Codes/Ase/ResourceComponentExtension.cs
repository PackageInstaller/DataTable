#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Resource;
using GameFramework.Runtime;
using UnityEngine;
using YooAsset;

namespace Ase;

public static class ResourceComponentExtension
{
	private static Dictionary<string, List<(string, string)>> loadedSprites = new Dictionary<string, List<(string, string)>>();

	public static async void RepairResources(this ResourceComponent resourceComponent)
	{
		_ = 3;
		try
		{
			string[] resourcePackages = ResourcesExtension.ResourcePackages;
			foreach (string package in resourcePackages)
			{
				await resourceComponent.ClearCacheBundleFiles(package, (EFileClearMode)0);
				await resourceComponent.ClearCacheBundleFiles(package, (EFileClearMode)5);
			}
			resourcePackages = ResourcesExtension.AudioResourcePackages;
			foreach (string package in resourcePackages)
			{
				await resourceComponent.ClearCacheBundleFiles(package, (EFileClearMode)0);
				await resourceComponent.ClearCacheBundleFiles(package, (EFileClearMode)5);
			}
			GameEntry.BuiltinData.RecordFirstResourceUpdaterStatus(0);
		}
		catch (Exception ex)
		{
			Log.Error("Clear unused cache resource failure. " + ex.ToString());
		}
		finally
		{
			GameEntry.LaunchType = Constant.LaunchType.RepairRes;
			GameEntryRuntime.Shutdown(ShutdownType.Restart);
		}
	}

	public static async UniTask<bool> ClearUnusedResource(this ResourceComponent resourceComponent, string packageName, List<string> versions)
	{
		_ = 2;
		try
		{
			if (versions == null || versions.Count <= 0)
			{
				await resourceComponent.ClearCacheBundleFiles(packageName, (EFileClearMode)6);
			}
			else
			{
				await resourceComponent.ClearCacheBundleFiles(packageName, (EFileClearMode)2, versions);
			}
			await resourceComponent.ClearCacheBundleFiles(packageName, (EFileClearMode)1);
			return true;
		}
		catch (Exception ex)
		{
			Log.Error("Clear unused cache resource failure. " + ex.ToString());
			return false;
		}
	}

	public static void DownloadAudoResources(this ResourceComponent resourceComponent)
	{
		GameEntry.LaunchType = Constant.LaunchType.RepairRes;
		GameEntryRuntime.Shutdown(ShutdownType.Restart);
	}

	public static async UniTask<Sprite> LoadSpriteAsync(this ResourceComponent resourceComponent, string location, string spriteGroup, string packageName = "")
	{
		Sprite result = await resourceComponent.LoadAssetAsync<Sprite>(location, packageName);
		if (!loadedSprites.TryGetValue(spriteGroup, out var value))
		{
			value = new List<(string, string)>();
			loadedSprites.Add(spriteGroup, value);
		}
		value.Add((location, packageName));
		return result;
	}

	public static void UnLoadSpriteGroup(this ResourceComponent resourceComponent, string spriteGroup)
	{
		if (!loadedSprites.TryGetValue(spriteGroup, out var value))
		{
			return;
		}
		foreach (var item in value)
		{
			resourceComponent.UnloadAsset(item.Item1, item.Item2);
		}
		value.Clear();
	}

	public static UniTask<GameObject> InstantiateAsync(this ResourceComponent resourceComponent, string location, Transform parent, string packageName = "")
	{
		InstantiateData data = InstantiateData.Create(parent);
		return resourceComponent.InstantiateAsync(location, packageName, data);
	}
}
