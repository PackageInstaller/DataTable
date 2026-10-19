using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Config;
using ACT.Error;
using ACT.Net;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Initialize.Flow;

public class InitMetaRes : RuntimeLoadFlow
{
	private readonly struct AbilityInitializationData(ConfigAbility ability)
	{
		public readonly ConfigAbility Ability = ability;
	}

	public InitMetaRes()
		: base("InitMetaRes")
	{
	}

	protected override void OnStart()
	{
		base.OnStart();
		WaitInitializer.Start(1L);
		AssetStationManager.Root.LoadAsync<MetaRes>("Configs/metares", (AssetLoadHandle result) =>
		{
			MetaRes meta = (GameLoader.meta = result.As<MetaRes>());
			if (meta == null)
			{
				HandleInitializationFailure(null, new LuminErrorException(CodeType.CLIENT, CodeModule.INITIALIZE_RUNTIME_LOGIC, 1, null, "系统提示", "MetaRes加载异常"));
			}
			else
			{
				InitializeMetaResAsync(meta).Forget((Exception exception) =>
				{
					HandleInitializationFailure(meta, exception);
				});
			}
		});
	}

	private async UniTask InitializeMetaResAsync(MetaRes meta)
	{
		Dictionary<string, ConfigAbility> abilityDictionary = CollectAbilities(meta, out var abilities);
		await PrecomputeAbilityCachesAsync(abilities);
		await UniTask.SwitchToMainThread();
		EngineConfigs.ability = abilityDictionary;
		EngineConfigs.configProperty = meta.configProperty;
		await UniTask.NextFrame();
		await LoadNpcGlobalConfigAsync(meta);
	}

	private static Dictionary<string, ConfigAbility> CollectAbilities(MetaRes meta, out List<AbilityInitializationData> abilities)
	{
		Dictionary<string, ConfigAbility> dictionary = new Dictionary<string, ConfigAbility>();
		abilities = new List<AbilityInitializationData>();
		if (meta.abLists == null)
		{
			return dictionary;
		}
		for (int i = 0; i < meta.abLists.Count; i++)
		{
			ConfigAbilityList configAbilityList = meta.abLists[i];
			if (configAbilityList == null)
			{
				Debug.LogError("metaRes中含有空的abilitylist请检查");
			}
			else
			{
				if (configAbilityList.abilities == null)
				{
					continue;
				}
				string name = configAbilityList.name;
				for (int j = 0; j < configAbilityList.abilities.Length; j++)
				{
					ConfigAbility configAbility = configAbilityList.abilities[j];
					if (configAbility == null)
					{
						Debug.LogError($"{name} 里存在空技能，索引为{j}，请检查");
						continue;
					}
					if (string.IsNullOrEmpty(configAbility.name))
					{
						Debug.LogError($"{name} 里存在空命名的技能 索引为{j}，如无必要则删除。如有必要，请改名");
						continue;
					}
					if (dictionary.ContainsKey(configAbility.name))
					{
						Debug.LogError(name + " 里的 " + configAbility.name + " 重复了，如无必要，删除其中一个。如有必要，请改名");
						continue;
					}
					configAbility.id = (i << 24) | j;
					dictionary.Add(configAbility.name, configAbility);
					abilities.Add(new AbilityInitializationData(configAbility));
				}
			}
		}
		return dictionary;
	}

	private static async UniTask PrecomputeAbilityCachesAsync(List<AbilityInitializationData> abilities)
	{
		if (abilities.Count == 0)
		{
			return;
		}
		UniTask uniTask = UniTask.RunOnThreadPool(() =>
		{
			for (int i = 0; i < abilities.Count; i++)
			{
				abilities[i].Ability.GenerateActionList();
			}
		});
		UniTask uniTask2 = UniTask.RunOnThreadPool(() =>
		{
			for (int i = 0; i < abilities.Count; i++)
			{
				abilities[i].Ability.PrewarmCustomTagCache();
			}
		});
		await UniTask.WhenAll(uniTask, uniTask2);
		await UniTask.SwitchToMainThread();
	}

	private void HandleInitializationFailure(MetaRes meta, Exception exception)
	{
		Debug.LogError($"MetaRes初始化失败: {exception}");
		EngineConfigs.ability = new Dictionary<string, ConfigAbility>();
		if (meta != null)
		{
			EngineConfigs.configProperty = meta.configProperty;
			meta.npcGlobalConfig = new NpcGlobalConfig
			{
				receiveMissionDatas = new List<ReceiveMissionData>()
			};
		}
		long num = WaitInitializer.Total - WaitInitializer.Current;
		if (num > 0)
		{
			WaitInitializer.AddBatch(num);
		}
		LuminError.Handle((exception as LuminErrorException) ?? new LuminErrorException(CodeType.CLIENT, CodeModule.INITIALIZE_RUNTIME_LOGIC, 1, null, "系统提示", "MetaRes初始化异常", exception), new ErrorHandleOptions(ErrorPresentation.Configured, null, null, null, Application.Quit));
	}

	private async UniTask LoadNpcGlobalConfigAsync(MetaRes meta)
	{
		try
		{
			meta.npcGlobalConfig = await NpcGlobalConfig.LoadRuntimeAsync((int plannedCount) =>
			{
				if (plannedCount > 0)
				{
					WaitInitializer.Wait(plannedCount);
				}
				WaitInitializer.CompleteOne();
			}, () =>
			{
				WaitInitializer.CompleteOne();
			});
		}
		catch (Exception ex)
		{
			Debug.LogError($"NpcGlobalConfig JSON加载失败，已使用空配置继续初始化: {ex}");
			meta.npcGlobalConfig = new NpcGlobalConfig
			{
				receiveMissionDatas = new List<ReceiveMissionData>()
			};
			LuminError.Handle(new LuminErrorException(CodeType.CLIENT, CodeModule.INITIALIZE_RUNTIME_LOGIC, 1, null, "系统提示", "NPC全局配置加载异常", ex), new ErrorHandleOptions(ErrorPresentation.Configured, null, null, null, Application.Quit));
		}
		finally
		{
			long num = WaitInitializer.Total - WaitInitializer.Current;
			if (num > 0)
			{
				WaitInitializer.AddBatch(num);
			}
		}
	}
}
