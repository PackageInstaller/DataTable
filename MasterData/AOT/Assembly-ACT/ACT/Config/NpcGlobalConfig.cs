using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using ACT.NPC;
using ACT.NPC.Actions;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Newtonsoft.Json;
using UnityEngine;
using YooAsset;

namespace ACT.Config;

[Serializable]
public class NpcGlobalConfig
{
	public const string RuntimeEntryAddressPrefix = "Configs/NpcGlobalEntry_";

	public const string RuntimeReceiveMissionAddress = "Configs/NpcReceiveMissionDatas";

	private const string RuntimeAssetTag = "NpcRuntimeConfig";

	private const int RuntimeLoadBatchSize = 16;

	[JsonIgnore]
	private List<NpcShowEntranceCollection> npcEntranceCollectionConfigs;

	[JsonIgnore]
	private List<NpcAreaDirectoryConfig> npcDirectoryConfigs;

	[JsonIgnore]
	public List<ReceiveMissionData> receiveMissionDatas;

	public List<NpcShowEntranceCollection> NpcEntranceCollectionConfigs => GetOrCreateNpcEntranceCollectionConfigs();

	public List<NpcAreaDirectoryConfig> NpcDirectoryConfigs => GetOrCreateNpcDirectoryConfigs();

	public List<NpcShowEntranceCollection> GetOrCreateNpcEntranceCollectionConfigs()
	{
		if (npcEntranceCollectionConfigs != null)
		{
			return npcEntranceCollectionConfigs;
		}
		npcEntranceCollectionConfigs = new List<NpcShowEntranceCollection>();
		return npcEntranceCollectionConfigs;
	}

	public List<NpcAreaDirectoryConfig> GetOrCreateNpcDirectoryConfigs()
	{
		if (npcDirectoryConfigs != null)
		{
			return npcDirectoryConfigs;
		}
		npcDirectoryConfigs = new List<NpcAreaDirectoryConfig>();
		return npcDirectoryConfigs;
	}

	public List<ReceiveMissionData> GetOrCreateReceiveMissionDatas()
	{
		if (receiveMissionDatas == null)
		{
			receiveMissionDatas = new List<ReceiveMissionData>();
		}
		return receiveMissionDatas;
	}

	public void OverwriteRuntimeNpcDataFrom(NpcGlobalConfig source)
	{
		if (source != null)
		{
			string json = SerializeList(source.GetOrCreateReceiveMissionDatas(), indented: false);
			npcEntranceCollectionConfigs = DeserializeList<NpcShowEntranceCollection>(SerializeList(source.GetOrCreateNpcEntranceCollectionConfigs(), indented: false)) ?? new List<NpcShowEntranceCollection>();
			receiveMissionDatas = DeserializeList<ReceiveMissionData>(json) ?? new List<ReceiveMissionData>();
		}
	}

	public void InvalidateJsonCaches()
	{
		npcEntranceCollectionConfigs = null;
		npcDirectoryConfigs = null;
		receiveMissionDatas = null;
	}

	public bool HasNpcDirectoryData()
	{
		foreach (NpcAreaDirectoryConfig orCreateNpcDirectoryConfig in GetOrCreateNpcDirectoryConfigs())
		{
			if (orCreateNpcDirectoryConfig != null && orCreateNpcDirectoryConfig.HasDirectoryData())
			{
				return true;
			}
		}
		return false;
	}

	public NpcAreaDirectoryConfig GetOrCreateAreaDirectoryConfig(int mapAreaID)
	{
		List<NpcAreaDirectoryConfig> orCreateNpcDirectoryConfigs = GetOrCreateNpcDirectoryConfigs();
		NpcAreaDirectoryConfig npcAreaDirectoryConfig = orCreateNpcDirectoryConfigs.Find((NpcAreaDirectoryConfig x) => x.MapAreaID == mapAreaID);
		if (npcAreaDirectoryConfig != null)
		{
			return npcAreaDirectoryConfig;
		}
		npcAreaDirectoryConfig = new NpcAreaDirectoryConfig
		{
			MapAreaID = mapAreaID,
			Directories = new List<NpcDirectoryNode>()
		};
		orCreateNpcDirectoryConfigs.Add(npcAreaDirectoryConfig);
		return npcAreaDirectoryConfig;
	}

	public bool TryGetNpcDirectoryPath(int npcConfigUid, out int mapAreaID, out string groupPath)
	{
		foreach (NpcAreaDirectoryConfig orCreateNpcDirectoryConfig in GetOrCreateNpcDirectoryConfigs())
		{
			if (orCreateNpcDirectoryConfig != null && orCreateNpcDirectoryConfig.TryGetNpcDirectoryPath(npcConfigUid, out groupPath))
			{
				mapAreaID = orCreateNpcDirectoryConfig.MapAreaID;
				return true;
			}
		}
		mapAreaID = 0;
		groupPath = null;
		return false;
	}

	public NpcDirectoryNode GetOrCreateDirectory(int mapAreaID, string groupPath)
	{
		return GetOrCreateAreaDirectoryConfig(mapAreaID).GetOrCreateDirectory(groupPath);
	}

	private static List<T> DeserializeList<T>(string json)
	{
		if (!string.IsNullOrWhiteSpace(json))
		{
			return JsonConvert.DeserializeObject<List<T>>(json, NpcDataConfig.NpcDataConfigJsonParameters.JsonSettings);
		}
		return null;
	}

	private static string SerializeList<T>(List<T> value, bool indented)
	{
		return JsonConvert.SerializeObject(value ?? new List<T>(), indented ? Formatting.Indented : Formatting.None, NpcDataConfig.NpcDataConfigJsonParameters.JsonSettings);
	}

	private static T Deserialize<T>(string json)
	{
		if (!string.IsNullOrWhiteSpace(json))
		{
			return JsonConvert.DeserializeObject<T>(json, NpcDataConfig.NpcDataConfigJsonParameters.JsonSettings);
		}
		return default;
	}

	private static string Serialize<T>(T value, bool indented)
	{
		return JsonConvert.SerializeObject(value, indented ? Formatting.Indented : Formatting.None, NpcDataConfig.NpcDataConfigJsonParameters.JsonSettings);
	}

	public static async UniTask<NpcGlobalConfig> LoadRuntimeAsync(Action<int> onPlannedCount = null, System.Action onItemLoaded = null)
	{
		ResourcePackage package = YooAssets.TryGetPackage("Assets");
		if (package == null)
		{
			throw new InvalidOperationException("资源包[Assets]未初始化");
		}
		PrepareRuntimeJsonTypes();
		List<string> entryAddresses = await GetRuntimeEntryAddressesAsync(package);
		List<string> loadedAddresses = new List<string>(entryAddresses.Count + 1);
		try
		{
			ValidateRuntimeJsonAsset(package, "Configs/NpcReceiveMissionDatas");
			int plannedCount = entryAddresses.Count + 1;
			onPlannedCount?.Invoke(plannedCount);
			NpcGlobalConfig config = null;
			for (int batchStart = 0; batchStart < plannedCount; batchStart += 16)
			{
				int loadedAddressStart = loadedAddresses.Count;
				int batchCount = Math.Min(16, plannedCount - batchStart);
				UniTask<string>[] array = new UniTask<string>[batchCount];
				for (int i = 0; i < batchCount; i++)
				{
					int num = batchStart + i;
					string text = ((num == 0) ? "Configs/NpcReceiveMissionDatas" : entryAddresses[num - 1]);
					loadedAddresses.Add(text);
					array[i] = LoadRuntimeTextAsset(text);
				}
				string[] array2 = await UniTask.WhenAll(array);
				int num2 = Math.Max(0, 1 - batchStart);
				int firstEntryIndex = batchStart + num2 - 1;
				UniTask<NpcShowEntranceCollection>[] array3 = new UniTask<NpcShowEntranceCollection>[batchCount - num2];
				for (int j = 0; j < array3.Length; j++)
				{
					int num3 = num2 + j;
					string address = entryAddresses[firstEntryIndex + j];
					array3[j] = DeserializeRuntimeJsonAsync<NpcShowEntranceCollection>(array2[num3], address);
				}
				UniTask<List<ReceiveMissionData>> receiveMissionParseTask = default;
				if (batchStart == 0)
				{
					receiveMissionParseTask = DeserializeRuntimeJsonAsync<List<ReceiveMissionData>>(array2[0], "Configs/NpcReceiveMissionDatas");
				}
				NpcShowEntranceCollection[] parsedEntries = await UniTask.WhenAll(array3);
				if (batchStart == 0)
				{
					List<ReceiveMissionData> list = (await receiveMissionParseTask) ?? new List<ReceiveMissionData>();
					config = new NpcGlobalConfig
					{
						npcEntranceCollectionConfigs = new List<NpcShowEntranceCollection>(entryAddresses.Count),
						receiveMissionDatas = list
					};
				}
				for (int k = 0; k < parsedEntries.Length; k++)
				{
					NpcShowEntranceCollection npcShowEntranceCollection = parsedEntries[k];
					if (npcShowEntranceCollection == null)
					{
						string text2 = entryAddresses[firstEntryIndex + k];
						throw new InvalidOperationException("资源[" + text2 + "]加载结果为空或 JSON内容无效");
					}
					config.npcEntranceCollectionConfigs.Add(npcShowEntranceCollection);
				}
				for (int num4 = loadedAddresses.Count - 1; num4 >= loadedAddressStart; num4--)
				{
					ReleaseRuntimeJsonAsset(loadedAddresses[num4]);
				}
				loadedAddresses.RemoveRange(loadedAddressStart, loadedAddresses.Count - loadedAddressStart);
				for (int l = 0; l < batchCount; l++)
				{
					onItemLoaded?.Invoke();
				}
				if (batchStart + batchCount < plannedCount)
				{
					await UniTask.NextFrame();
				}
			}
			return config;
		}
		finally
		{
			for (int num5 = loadedAddresses.Count - 1; num5 >= 0; num5--)
			{
				ReleaseRuntimeJsonAsset(loadedAddresses[num5]);
			}
			Debug.Log("Npc Item Load Complete");
		}
	}

	private static async UniTask<List<string>> GetRuntimeEntryAddressesAsync(ResourcePackage package)
	{
		AssetInfo[] array = package.GetAssetInfos("NpcRuntimeConfig");
		if (array.Length == 0)
		{
			array = package.GetAllAssetInfos();
		}
		string[] allAddresses = new string[array.Length];
		for (int i = 0; i < array.Length; i++)
		{
			allAddresses[i] = array[i].Address;
		}
		List<string> result = await UniTask.RunOnThreadPool(() => FilterRuntimeEntryAddresses(allAddresses));
		await UniTask.SwitchToMainThread();
		return result;
	}

	private static void PrepareRuntimeJsonTypes()
	{
		RuntimeHelpers.RunClassConstructor(typeof(ActionOpenUI).TypeHandle);
	}

	private static List<string> FilterRuntimeEntryAddresses(string[] allAddresses)
	{
		HashSet<string> hashSet = new HashSet<string>(StringComparer.Ordinal);
		foreach (string text in allAddresses)
		{
			if (!string.IsNullOrEmpty(text) && text.StartsWith("Configs/NpcGlobalEntry_", StringComparison.Ordinal))
			{
				hashSet.Add(text);
			}
		}
		List<string> list = new List<string>(hashSet);
		list.Sort(StringComparer.Ordinal);
		return list;
	}

	private static async UniTask<T> DeserializeRuntimeJsonAsync<T>(string json, string address)
	{
		try
		{
			return await UniTask.RunOnThreadPool(() => Deserialize<T>(json));
		}
		catch (Exception innerException)
		{
			throw new InvalidOperationException("资源[" + address + "] JSON反序列化失败", innerException);
		}
	}

	private static UniTask<string> LoadRuntimeTextAsset(string address)
	{
		UniTaskCompletionSource<string> completion = new UniTaskCompletionSource<string>();
		try
		{
			AssetStationManager.Root.LoadAsync<TextAsset>(address, (AssetLoadHandle handle) =>
			{
				try
				{
					TextAsset textAsset = handle.As<TextAsset>();
					if (textAsset == null)
					{
						completion.TrySetException(new InvalidOperationException("资源[" + address + "]加载结果为空"));
					}
					else
					{
						completion.TrySetResult(textAsset.text);
					}
				}
				catch (Exception innerException2)
				{
					completion.TrySetException(new InvalidOperationException("资源[" + address + "]加载回调异常", innerException2));
				}
			});
		}
		catch (Exception innerException)
		{
			completion.TrySetException(new InvalidOperationException("资源[" + address + "]加载启动失败", innerException));
		}
		return completion.Task;
	}

	private static void ValidateRuntimeJsonAsset(ResourcePackage package, string address)
	{
		if (!package.CheckLocationValid(address))
		{
			throw new InvalidOperationException("资源[" + address + "]未打入资源包");
		}
	}

	private static void ReleaseRuntimeJsonAsset(string address)
	{
		try
		{
			AssetStationManager.Root.Release(address, showError: false);
		}
		catch (Exception arg)
		{
			Debug.LogWarning($"资源[{address}]句柄释放失败: {arg}");
		}
	}
}
