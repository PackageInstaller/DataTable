using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using ACT.Config;
using ACT.Core;
using Cysharp.Threading.Tasks;
using Newtonsoft.Json;
using UnityEngine;
using YooAsset;

namespace ACT.Initialize.Flow;

public class InitTables : RuntimeLoadFlow
{
	private const int RuntimeLoadBatchSize = 16;

	private FieldInfo[] m_ConfigFields;

	private HashSet<string> m_HasLoadSet;

	private StaticData m_Data;

	public static event Action OnTablesReady;

	private static void NotifyTablesReady()
	{
		Action onTablesReady = OnTablesReady;
		if (onTablesReady == null)
		{
			return;
		}
		Delegate[] invocationList = onTablesReady.GetInvocationList();
		for (int i = 0; i < invocationList.Length; i++)
		{
			try
			{
				((Action)invocationList[i])();
			}
			catch (Exception arg)
			{
				Debug.LogError($"[InitTables] 表数据就绪回调执行异常: {arg}");
			}
		}
	}

	public InitTables()
		: base("InitTables")
	{
	}

	protected override void OnStart()
	{
		base.OnStart();
		m_ConfigFields = typeof(StaticData).GetFields();
		m_Data = (RuntimeConfigs.data = new StaticData());
		m_HasLoadSet = new HashSet<string>(StringComparer.Ordinal);
		InitializeExternalDatabaseOverride();
		WaitInitializer.Start(m_ConfigFields.Length);
		OnFlowComplete += OnTablesFlowComplete;
		LoadTablesAsync().Forget();
	}

	private void OnTablesFlowComplete()
	{
		RuntimeConfigs.data.PatchAutoIndexes();
		NotifyTablesReady();
	}

	private void InitializeExternalDatabaseOverride()
	{
	}

	private static bool TryGetExternalTablePath(string externalDatabaseDirectory, string configName, out string tablePath)
	{
		tablePath = null;
		return false;
	}

	private async UniTask LoadTablesAsync()
	{
		try
		{
			ResourcePackage package = YooAssets.GetPackage("ClientStatic");
			for (int batchStart = 0; batchStart < m_ConfigFields.Length; batchStart += 16)
			{
				int batchCount = Math.Min(16, m_ConfigFields.Length - batchStart);
				UniTask[] array = new UniTask[batchCount];
				for (int i = 0; i < batchCount; i++)
				{
					FieldInfo fieldInfo = m_ConfigFields[batchStart + i];
					if (!m_HasLoadSet.Add(fieldInfo.Name))
					{
						WaitInitializer.CompleteOne();
						array[i] = UniTask.CompletedTask;
					}
					else
					{
						array[i] = LoadConfigAsync(package, fieldInfo);
					}
				}
				await UniTask.WhenAll(array);
				if (batchStart + batchCount < m_ConfigFields.Length)
				{
					await UniTask.NextFrame();
				}
			}
		}
		catch (Exception arg)
		{
			await UniTask.SwitchToMainThread();
			Debug.LogError($"InitTables批量加载异常: {arg}");
			CompleteRemainingSteps();
		}
	}

	private async UniTask LoadConfigAsync(ResourcePackage package, FieldInfo field)
	{
		string configName = field.Name;
		string externalTablePath = null;
		try
		{
			object value = await LoadTableValueAsync(package, field, externalTablePath);
			await UniTask.SwitchToMainThread();
			field.SetValue(m_Data, value);
		}
		catch (Exception message)
		{
			await UniTask.SwitchToMainThread();
			if (string.IsNullOrEmpty(externalTablePath))
			{
				Debug.LogError(configName + " table error");
			}
			else
			{
				Debug.LogError("[InitTables] 外置Database表加载失败，不回退包内数据: table=" + configName + ", path=" + externalTablePath);
			}
			Debug.LogError(message);
		}
		finally
		{
			await UniTask.SwitchToMainThread();
			WaitInitializer.CompleteOne();
		}
	}

	private static async UniTask<object> LoadTableValueAsync(ResourcePackage package, FieldInfo field, string externalTablePath)
	{
		if (!string.IsNullOrEmpty(externalTablePath))
		{
			Type fieldType = field.FieldType;
			object value = await UniTask.RunOnThreadPool(() => JsonConvert.DeserializeObject(File.ReadAllText(externalTablePath), fieldType));
			await UniTask.SwitchToMainThread();
			Debug.Log("[InitTables] 使用外置Database表: " + externalTablePath);
			return value;
		}
		string configName = field.Name;
		string path = "ClientStatic/" + configName;
		AssetHandle load = null;
		object result;
		try
		{
			await UniTask.SwitchToMainThread();
			load = package.LoadAssetAsync<TextAsset>(path);
			await load.Task;
			await UniTask.SwitchToMainThread();
			if (load.Status != EOperationStatus.Succeed || !(load.AssetObject is TextAsset textAsset))
			{
				throw new FileNotFoundException("table missing: " + configName, path);
			}
			string json = textAsset.text;
			result = await UniTask.RunOnThreadPool(() => JsonConvert.DeserializeObject(json, field.FieldType));
		}
		finally
		{
			await UniTask.SwitchToMainThread();
			if (load != null)
			{
				load.Release();
				package.TryUnloadUnusedAsset(path);
			}
		}
		return result;
	}

	private static string GetTableSource(string configName, string externalTablePath)
	{
		if (!string.IsNullOrEmpty(externalTablePath))
		{
			return externalTablePath;
		}
		return "YooAsset:ClientStatic/" + configName;
	}

	private void CompleteRemainingSteps()
	{
		long num = WaitInitializer.Total - WaitInitializer.Current;
		if (num > 0)
		{
			WaitInitializer.AddBatch(num);
		}
	}
}
