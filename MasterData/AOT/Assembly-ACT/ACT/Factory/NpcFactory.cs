using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Battle.ECS.System.SystemNPC;
using ACT.Drama;
using ACT.Model;
using ACT.NPC;
using ACT.NPC.Actions;
using ACT.Utility;
using ACT.World.StateObject;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using RootMotion.FinalIK;
using Runtime.Battle.ECS.System.SystemInteract;
using UnityEngine;

namespace ACT.Factory;

public static class NpcFactory
{
	public const string InteractTriggerNodeName = "InteractTrigger";

	public static GameObject SetupNpcModelHierarchy(int npcConfigUid, Vector3 worldPosition, Vector3 worldRotationEuler, GameObject model = null, Transform parent = null, GameObject existingRoot = null)
	{
		GameObject gameObject = ((existingRoot != null) ? existingRoot : new GameObject($"Npc_{npcConfigUid}"));
		Transform transform = gameObject.transform;
		if (parent != null && transform.parent != parent)
		{
			transform.SetParent(parent, worldPositionStays: false);
		}
		AttachNpcModelToWrap(gameObject, model);
		transform.position = worldPosition;
		transform.rotation = Quaternion.Euler(worldRotationEuler);
		AlignNpcInteractTriggerToWorld(gameObject);
		return gameObject;
	}

	private static void AttachNpcModelToWrap(GameObject npcRoot, GameObject model)
	{
		if (!(npcRoot == null) && !(model == null))
		{
			Transform transform = model.transform;
			Transform transform2 = npcRoot.transform;
			if (transform.parent != transform2)
			{
				transform.SetParent(transform2, worldPositionStays: false);
			}
			transform.localRotation = Quaternion.identity;
		}
	}

	public static GameObject SetupNpcInteractTrigger(GameObject npcRoot, TriggerConfig triggerConfig)
	{
		GameObject gameObject = EnsureNpcInteractTriggerRoot(npcRoot);
		gameObject.GetOrAddComponent<MonoTriggerInteract>().AddTriggerByTriggerConfig(triggerConfig);
		return gameObject;
	}

	public static GameObject EnsureNpcInteractTriggerRoot(GameObject npcRoot)
	{
		if (npcRoot == null)
		{
			return null;
		}
		RemoveLegacyInteractTriggerOnNpcRoot(npcRoot);
		Transform transform = npcRoot.transform;
		Transform transform2 = transform.Find("InteractTrigger");
		GameObject gameObject;
		if (transform2 == null)
		{
			gameObject = new GameObject("InteractTrigger");
			gameObject.transform.SetParent(transform, worldPositionStays: false);
		}
		else
		{
			gameObject = transform2.gameObject;
		}
		AlignInteractTriggerTransform(gameObject.transform);
		return gameObject;
	}

	public static void AlignNpcInteractTriggerToWorld(GameObject npcRoot)
	{
		if (!(npcRoot == null))
		{
			Transform transform = npcRoot.transform.Find("InteractTrigger");
			if (!(transform == null))
			{
				AlignInteractTriggerTransform(transform);
			}
		}
	}

	private static void AlignInteractTriggerTransform(Transform triggerTrans)
	{
		triggerTrans.localPosition = Vector3.zero;
		triggerTrans.localScale = Vector3.one;
		triggerTrans.rotation = Quaternion.identity;
	}

	private static void RemoveLegacyInteractTriggerOnNpcRoot(GameObject npcRoot)
	{
		if (npcRoot.TryGetComponent<MonoTriggerInteract>(out var component))
		{
			if ((bool)component.Trigger && component.Trigger.gameObject != npcRoot)
			{
				component.Trigger = null;
			}
			DestroyOwned(component);
		}
		if (npcRoot.TryGetComponent<Collider>(out var component2))
		{
			DestroyOwned(component2);
		}
	}

	private static void DestroyOwned(UnityEngine.Object obj)
	{
		if ((bool)obj)
		{
			if (!Application.isPlaying)
			{
				UnityEngine.Object.DestroyImmediate(obj);
			}
			else
			{
				UnityEngine.Object.Destroy(obj);
			}
		}
	}

	public static bool ReleaseNpcModelResource(NpcShowEntranceCollection entranceCollection, Entity entity)
	{
		if (entranceCollection == null || !entity.IsValid)
		{
			return false;
		}
		CompBehave compBehave = entity.GetCompBehave();
		CompNpc compNpc = entity.GetCompNpc();
		if (compBehave?.Root == null || compNpc == null)
		{
			return false;
		}
		entranceCollection.InvalidateRuntimeLoads();
		compNpc.ReleaseModelReferences(preserveAnimatorSnap: true);
		if (entranceCollection.ActiveModelHandle.IsValid)
		{
			AssetStationManager.BattleStation.ReleaseInstance(entranceCollection.ActiveModelHandle);
			entranceCollection.ActiveModelHandle = default;
		}
		else if ((bool)compBehave.Model)
		{
			AssetStationManager.BattleStation.ReleaseInstance(compBehave.Model);
		}
		compBehave.SetupModel(null);
		entity.GetCompInteract()?.ReleaseInteractTip();
		MonoEntity monoEntity = compBehave.MonoEntity;
		if ((object)monoEntity != null)
		{
			monoEntity.renderers = Array.Empty<Renderer>();
		}
		return true;
	}

	public static async UniTaskVoid ReloadNpcModelResourceAsync(NpcShowEntranceCollection entranceCollection, Entity entity)
	{
		if (entranceCollection == null)
		{
			Debug.LogError("NPC模型资源重建失败。原因: NpcShowEntranceCollection为空。");
			return;
		}
		if (!entity.IsValid)
		{
			Debug.LogError($"NPC模型资源重建失败。NpcConfigUid: {entranceCollection.NpcConfigUid}，原因: Entity无效。");
			return;
		}
		CompBehave compBehave = entity.GetCompBehave();
		CompNpc compNpc = entity.GetCompNpc();
		Transform npcRoot = entity.GetRootTransform();
		NpcShowRule activeRule = entranceCollection.GetActiveRule();
		YooAssetReference modelPath = activeRule?.ModelPath;
		if (compBehave == null)
		{
			LogInvalidModelReason("CompBehave为空。");
			return;
		}
		if (compBehave.Root == null)
		{
			LogInvalidModelReason("CompBehave.Root为空。");
			return;
		}
		if (compNpc == null)
		{
			LogInvalidModelReason("CompNpc为空。");
			return;
		}
		NpcDataConfig npcDataConfig = compNpc.NpcDataConfig;
		if (npcDataConfig == null)
		{
			LogInvalidModelReason(((object)npcDataConfig == null) ? "CompNpc.NpcDataConfig真实为空。" : "CompNpc.NpcDataConfig对应的Unity资源已被卸载或销毁。");
		}
		else if (npcRoot == null)
		{
			LogInvalidModelReason("NPC根Transform为空。");
		}
		else if (activeRule == null)
		{
			LogInvalidModelReason("当前展示规则为空。");
		}
		else if ((object)modelPath != null)
		{
			YooAssetReference yooAssetReference = modelPath;
			if (!yooAssetReference.IsValid())
			{
				LogInvalidModelReason("当前展示规则配置的模型路径无效。");
				return;
			}
			int loadVersion = entranceCollection.BeginRuntimeLoad();
			AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(modelPath, npcRoot);
			entranceCollection.ActiveModelHandle = handle;
			try
			{
				await handle;
			}
			catch (Exception arg)
			{
				if (entranceCollection.IsCurrentRuntimeLoad(loadVersion))
				{
					string assetID = handle.AssetID;
					LoadState state = handle.State;
					AssetStationManager.BattleStation.ReleaseInstance(handle);
					entranceCollection.ActiveModelHandle = default;
					Debug.LogError($"NPC模型资源重建失败。NpcConfigUid: {entranceCollection.NpcConfigUid}，ModelPath: {modelPath}，" + $"AssetId: {assetID}，LoadState: {state}，原因: {arg}");
				}
				return;
			}
			GameObject gameObject = handle.As<GameObject>();
			if (!entranceCollection.IsCurrentRuntimeLoad(loadVersion) || !entity.IsValid || entity.GetRootTransform() != npcRoot)
			{
				AssetStationManager.BattleStation.ReleaseInstance(handle);
			}
			else if (gameObject == null)
			{
				string assetID2 = handle.AssetID;
				LoadState state2 = handle.State;
				AssetStationManager.BattleStation.ReleaseInstance(handle);
				entranceCollection.ActiveModelHandle = default;
				Debug.LogError($"NPC模型资源重建失败。NpcConfigUid: {entranceCollection.NpcConfigUid}，ModelPath: {modelPath}，" + $"AssetId: {assetID2}，LoadState: {state2}，原因: AssetStation未返回GameObject实例，请检查模型配置路径和资源包。");
			}
			else
			{
				SetupNpcModel(gameObject, entity, compBehave);
				entity.GetCompInteract()?.RegenerateInteractTip();
				RegenerateNpcDialogueBubble(entity);
			}
		}
		else
		{
			LogInvalidModelReason("当前展示规则未配置模型路径。");
		}
		void LogInvalidModelReason(string reason)
		{
			Debug.LogError($"NPC模型资源重建失败。NpcConfigUid: {entranceCollection.NpcConfigUid}，ModelPath: {modelPath}，原因: {reason}");
		}
	}

	private static void RegenerateNpcDialogueBubble(Entity entity)
	{
		CompNpc compNpc = entity.GetCompNpc();
		CompInteract compInteract = entity.GetCompInteract();
		CompBubble compBubble = entity.GetCompBubble();
		if (compNpc != null && compInteract != null && compBubble != null)
		{
			NpcInteractEntryConfig currentActiveInteractEntryConfig = compNpc.CurrentActiveInteractEntryConfig;
			compBubble.BubbleDatas = currentActiveInteractEntryConfig?.chatBubbleCollections;
			if (currentActiveInteractEntryConfig != null)
			{
				compBubble.BindParentFromInteract(compInteract);
			}
		}
	}

	public static Entity SpawnNpcEntity(NpcShowEntranceCollection entranceCollection, NpcDataConfig npcDataConfig, NpcShowRule showRule, bool hideRootUntilSpawned, Action<Entity> onSpawned = null, Action<Exception> onFailed = null, bool loadModel = true)
	{
		Entity newEntity = default;
		newEntity = GameManager.entities.factory.CreateNPCEntity();
		CompNpc? compNpc = newEntity.GetCompNpc();
		compNpc.NpcDataConfig = npcDataConfig;
		compNpc.NpcEntity = newEntity;
		NpcShowRule activeShowRule = showRule ?? entranceCollection.GetActiveRule();
		YooAssetReference modelPath = activeShowRule.ModelPath;
		bool shouldLoadModel = loadModel;
		if (shouldLoadModel)
		{
			if ((object)modelPath != null)
			{
				YooAssetReference yooAssetReference = modelPath;
				if (yooAssetReference.IsValid())
				{
					goto IL_00e2;
				}
			}
			Debug.LogError($"{npcDataConfig.npcConfigUid} 的NPC模型资源不合法, 已跳过模型生成");
			shouldLoadModel = false;
		}
		goto IL_00e2;
		IL_00e2:
		newEntity.SetEntityType(EntityType.Npc);
		CompleteSpawnNpcEntityAsync().Forget();
		return newEntity;
		async UniTaskVoid CompleteSpawnNpcEntityAsync()
		{
			try
			{
				CompBehave compBehave = newEntity.GetCompBehave();
				CompInteract compInteract = newEntity.GetCompInteract();
				if (await LoadNpcAsyncResources(newEntity, compBehave, compInteract) == null)
				{
					onFailed?.Invoke(new Exception($"{npcDataConfig.npcConfigUid} 的NPC资源加载失败。"));
				}
				else
				{
					onSpawned?.Invoke(newEntity);
					compBehave.SetLogicAvailable();
					compInteract.TriggerCurrentOverlaps();
					compBehave.SetCanRemove();
					GameManager.entities.factory.EnqueueBehave(newEntity);
				}
			}
			catch (Exception ex)
			{
				Debug.LogException(ex);
				onFailed?.Invoke(ex);
			}
		}
		async UniTask<GameObject> LoadNpcAsyncResources(Entity entity, CompBehave compBehave, CompInteract compInteract)
		{
			GameObject npcRoot = SetupNpcModelHierarchy(npcDataConfig.npcConfigUid, Vector3.zero, Vector3.zero, null, MonoECS.instance.GetRoot(SceneRootType.Npc).transform);
			GameObject gameObject = null;
			if (shouldLoadModel)
			{
				AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(modelPath, npcRoot.transform);
				if (hideRootUntilSpawned)
				{
					entranceCollection.PendingModelHandle = handle;
				}
				else
				{
					entranceCollection.ActiveModelHandle = handle;
				}
				try
				{
					await handle;
				}
				catch
				{
					UnityEngine.Object.Destroy(npcRoot);
					throw;
				}
				gameObject = handle.As<GameObject>();
				if (gameObject == null)
				{
					Debug.LogError($"{npcDataConfig.npcConfigUid} 的NPC模型资源加载失败, 无法生成NPC实体");
					UnityEngine.Object.Destroy(npcRoot);
					return null;
				}
			}
			else if (!hideRootUntilSpawned && entranceCollection.ActiveModelHandle.IsValid)
			{
				AssetStationManager.BattleStation.Release(entranceCollection.ActiveModelHandle);
				entranceCollection.ActiveModelHandle = default;
			}
			if (hideRootUntilSpawned)
			{
				npcRoot.SetActive(value: false);
			}
			SetupNpcRoot(npcRoot, gameObject, entity, compBehave, compInteract);
			YooAssetReference behaviorTreePath = activeShowRule.BehaviorTreePath;
			if ((object)behaviorTreePath != null && !string.IsNullOrEmpty(activeShowRule.BehaviorTreePath.GUID))
			{
				if (!behaviorTreePath.IsValid())
				{
					Debug.LogError($"{npcDataConfig.npcConfigUid} 的NPC行为树资源引用无效，已跳过加载。GUID: {behaviorTreePath.GUID}");
					return npcRoot;
				}
				ActBehaviorTree orAddComponent = npcRoot.GetOrAddComponent<ActBehaviorTree>();
				if (!(await LoadNpcBehaviorTreeAsync(entity.AddComponent<CompAI>(), orAddComponent, behaviorTreePath)))
				{
					Debug.LogError($"{npcDataConfig.npcConfigUid} 的NPC行为树资源加载失败，无法生成NPC实体。");
					return null;
				}
			}
			return npcRoot;
		}
		static async UniTask<bool> LoadNpcBehaviorTreeAsync(CompAI compAI, ActBehaviorTree btree, YooAssetReference behaviorTreePath)
		{
			if (!(await compAI.LoadAsync(behaviorTreePath)))
			{
				return false;
			}
			btree.Resume();
			btree.running = true;
			return true;
		}
		async void OnNpcInteract(Entity other, InteractEntry interactEntry)
		{
			CompNpc compNpc2 = interactEntry.EntityReference.GetCompNpc();
			if (compNpc2 != null && (!Singleton<RuntimeNpcManager>.HasInstance() || Singleton<RuntimeNpcManager>.instance.CurrentDialogueNpc == null))
			{
				NpcInteractEntryConfig npcInteractEntryConfig = npcDataConfig.defaultInteractEntryConfigs.FirstOrDefault((NpcInteractEntryConfig x) => x.interactEntry == interactEntry);
				if (npcInteractEntryConfig == null)
				{
					Debug.LogError($"{npcDataConfig} 对应 {interactEntry} 的交互入口对话树为空？");
				}
				else if (npcInteractEntryConfig.interactActionWraps != null)
				{
					List<NpcInteractAction> sortedActions = ListPool<NpcInteractAction>.Get();
					sortedActions.AddRange(npcInteractEntryConfig.GetAllInteractActions());
					sortedActions.Sort();
					NpcInteractActionContext context = new NpcInteractActionContext
					{
						Npc = interactEntry.EntityReference,
						Other = other,
						InteractEntryConfig = npcInteractEntryConfig
					};
					if (compNpc2 != null)
					{
						int npcConfigUid = compNpc2.NpcConfigUid;
						Singleton<AchievementSyncBattleTypeManager>.instance.DispatchInteractedNPC(npcConfigUid);
					}
					Singleton<RuntimeNpcManager>.instance.PushNpcDialogueState(compNpc2);
					foreach (NpcInteractAction item in sortedActions)
					{
						await item.DoAction(context);
					}
					ListPool<NpcInteractAction>.Release(sortedActions);
					Singleton<RuntimeNpcManager>.instance.PopNpcDialogueState();
				}
			}
		}
		void SetupNpcRoot(GameObject npcRoot, GameObject model, Entity entity, CompBehave compBehave, CompInteract compInteract)
		{
			compBehave.SetupRoot(npcRoot);
			SetupNpcModelHierarchy(npcDataConfig.npcConfigUid, entranceCollection.RuntimeWorldPosition, entranceCollection.RuntimeWorldRotation, model, null, npcRoot);
			CompNpc compNpc2 = entity.GetCompNpc();
			compNpc2.NpcBehaviour = npcRoot.GetOrAddComponent<NPCBehaviour>();
			compNpc2.NpcDataConfig = npcDataConfig;
			compNpc2.NpcEntity = entity;
			if ((bool)model)
			{
				SetupNpcModel(model, entity, compBehave);
			}
			else
			{
				compBehave.SetupModel(null);
				compNpc2.ReleaseModelReferences();
				compBehave.UpdateMonoRef();
				MonoEntity monoEntity = compBehave.MonoEntity;
				if ((object)monoEntity != null)
				{
					monoEntity.renderers = Array.Empty<Renderer>();
				}
			}
			GameObject gameObject = (compInteract.TriggerRoot = EnsureNpcInteractTriggerRoot(npcRoot));
			compInteract.CanLoadCommonInteractTip = () => entity.GetModel() != null;
			compInteract.EntityBehave = entity;
			MonoTriggerInteract monoTriggerInteract = compInteract.MonoTriggerInteract;
			monoTriggerInteract.AddTriggerByTriggerConfig(npcDataConfig.triggerConfig);
			AlignInteractTriggerTransform(gameObject.transform);
			compInteract.OnEntryInteract = (Action<Entity, InteractEntry>)Delegate.Combine(compInteract.OnEntryInteract, new Action<Entity, InteractEntry>(OnNpcInteract));
			entity.GetCompTransform().SetBaseCollider(monoTriggerInteract.Trigger);
		}
	}

	private static void SetupNpcModel(GameObject model, Entity entity, CompBehave compBehave)
	{
		compBehave.SetupModel(model);
		AttachNpcModelToWrap(compBehave.Root, model);
		CompNpc compNpc = entity.GetCompNpc();
		if (compNpc == null || compNpc.NpcEntity != entity)
		{
			Debug.LogWarning($"NPC模型就绪时实体已失效或CompNpc已被其他NPC复用，已跳过动画状态恢复。NpcConfigUid: {entity.GetCompNpc()?.NpcDataConfig?.npcConfigUid}");
			return;
		}
		compNpc.Animator = model.GetOrAddComponent<Animator>();
		compNpc.RestoreModelAnimatorState();
		List<LookAtIK> list = ListPool<LookAtIK>.Get();
		model.GetComponents(list);
		if (list.Count >= 1)
		{
			compNpc.OnlyNeckLookAtIK = list[0];
		}
		else
		{
			Debug.LogWarning($"Npc {compNpc.NpcConfigUid} 没有配置Ik组件或者组件数量不正确，无法进行注视");
		}
		ListPool<LookAtIK>.Release(list);
		compBehave.UpdateMonoRef();
		MonoEntity monoEntity = compBehave.MonoEntity;
		if ((object)monoEntity != null)
		{
			monoEntity.renderers = model.GetComponentsInChildren<Renderer>();
		}
	}
}
