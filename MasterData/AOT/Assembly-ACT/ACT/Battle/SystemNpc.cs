using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Battle.ECS.System.SystemNPC;
using ACT.Core;
using ACT.Event;
using ACT.Factory;
using ACT.MissionSystem;
using ACT.NPC;
using ACT.NPC.Conditions;
using ACT.Utility;
using ACT.World.StateObject;
using Bamboo.AssetField;
using Bamboo.ECS;
using Fundamental;
using Runtime;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.Battle;

public class SystemNpc : EntitySystem
{
	private delegate int InteractEntryPriorityComparer(InteractEntryPriorityContext priorityContext, NpcInteractEntryConfig x, NpcInteractEntryConfig y);

	private readonly struct InteractEntryPriorityContext(List<NpcInteractEntryConfig> entries, int tracingMissionId)
	{
		public readonly List<NpcInteractEntryConfig> Entries = entries;

		public readonly int TracingMissionId = tracingMissionId;
	}

	private readonly List<NpcShowEntranceCollection> _toAdd = new List<NpcShowEntranceCollection>();

	private readonly List<NpcShowEntranceCollection> _toRemove = new List<NpcShowEntranceCollection>();

	private readonly HashSet<NpcShowEntranceCollection> _toAddSet = new HashSet<NpcShowEntranceCollection>();

	private readonly HashSet<NpcShowEntranceCollection> _toRemoveSet = new HashSet<NpcShowEntranceCollection>();

	private readonly Queue<int> _npcModelLoadQueue = new Queue<int>();

	private readonly Queue<int> _npcModelUnloadQueue = new Queue<int>();

	private readonly HashSet<int> _queuedNpcModelLoads = new HashSet<int>();

	private readonly HashSet<int> _queuedNpcModelUnloads = new HashSet<int>();

	private readonly HashSet<int> _queuedNpcModelReloads = new HashSet<int>();

	private readonly List<int> _npcModelCullingSchedule = new List<int>(64);

	private readonly Dictionary<int, int> _npcModelCullingScheduleIndices = new Dictionary<int, int>(64);

	private readonly Dictionary<int, bool> _npcModelCulledStates = new Dictionary<int, bool>(64);

	private readonly Dictionary<int, Entity> _instantiatedNpcDic = new Dictionary<int, Entity>();

	private readonly Dictionary<int, NpcShowEntranceCollection> _instantiatedNpcEntrances = new Dictionary<int, NpcShowEntranceCollection>();

	private readonly Plane[] _mainCameraLoadFrustumPlanes = new Plane[6];

	private readonly Plane[] _mainCameraUnloadFrustumPlanes = new Plane[6];

	private NpcModelLoadStrategy _modelLoadStrategy;

	private const float NpcFadeDuration = 0.5f;

	private const float NpcModelCullingUnloadPaddingOffset = 5f;

	private const int MaxNpcModelCullingChecksPerFrame = 5;

	private const int MaxNpcModelLoadsPerFrame = 1;

	private const int MaxNpcModelUnloadsPerFrame = 1;

	private int _nextNpcModelCullingScheduleIndex;

	private Filter _filter;

	private EntityAction<CompNpc, CompTime> _updateAnimatorAction;

	private EntityAction<CompNpc> _updateIKAction;

	private Action<NpcInteractEntryRuntime, bool> _interactEntryConditionChangedHandler;

	private static readonly InteractEntryPriorityComparer[] s_InteractEntryPriorityComparers = new InteractEntryPriorityComparer[2] { CompareInteractEntryMissionMarkPriority, CompareInteractEntryListOrderPriority };

	public bool DisableNPCFunc { get; set; }

	public float NpcModelCullingFrustumPadding { get; set; } = 10f;

	public NpcModelLoadStrategy ModelLoadStrategy
	{
		get
		{
			return _modelLoadStrategy;
		}
		set
		{
			if (_modelLoadStrategy != value)
			{
				ApplyModelLoadStrategy(value);
			}
		}
	}

	public bool EnableNpcModelCulling
	{
		get
		{
			return IsFrustumCullingEnabled;
		}
		set
		{
			ModelLoadStrategy = ((!value) ? NpcModelLoadStrategy.LoadAll : NpcModelLoadStrategy.FrustumCulling);
		}
	}

	public InstantiatedNpcDictionaryView InstantiatedNpcDictionary => new InstantiatedNpcDictionaryView(_instantiatedNpcDic);

	public override Filter MajorFilter => _filter;

	private bool IsFrustumCullingEnabled => _modelLoadStrategy == NpcModelLoadStrategy.FrustumCulling;

	public int PendingNpcLoadCount
	{
		get
		{
			if (DisableNPCFunc)
			{
				return 0;
			}
			int num = _toAdd.Count;
			foreach (KeyValuePair<int, NpcShowEntranceCollection> instantiatedNpcEntrance in _instantiatedNpcEntrances)
			{
				NpcShowEntranceCollection value = instantiatedNpcEntrance.Value;
				if (value != null && IsNpcEntranceLoading(value))
				{
					num++;
				}
			}
			return num + _queuedNpcModelLoads.Count;
		}
	}

	protected override void OnCreate()
	{
		_filter = World.NewFilter().All<CompNpc>().Build();
		_updateAnimatorAction = UpdateAnimator;
		_updateIKAction = UpdateIK;
		RefreshModelLoadStrategy();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.TracingPointAdded, OnMissionPointChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.TracingPointRemoved, OnMissionPointChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_Tracing, OnTracingMissionChanged);
	}

	protected override void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TracingPointAdded, OnMissionPointChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TracingPointRemoved, OnMissionPointChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_Tracing, OnTracingMissionChanged);
		base.OnDestroy();
	}

	public static NpcModelLoadStrategy ResolveModelLoadStrategy(DeviceGrade deviceGrade, bool isPCPlatform)
	{
		if (isPCPlatform)
		{
			return NpcModelLoadStrategy.LoadAll;
		}
		if (deviceGrade != DeviceGrade.Low)
		{
			return NpcModelLoadStrategy.LoadAll;
		}
		return NpcModelLoadStrategy.FrustumCulling;
	}

	public void RefreshModelLoadStrategy()
	{
		DeviceGrade currentDeviceGrade = DeviceGradeInfo.CurrentDeviceGrade;
		bool isPCPlatform = DeviceGradeInfo.IsPCPlatform;
		ModelLoadStrategy = ResolveModelLoadStrategy(currentDeviceGrade, isPCPlatform);
	}

	private void ApplyModelLoadStrategy(NpcModelLoadStrategy modelLoadStrategy)
	{
		_modelLoadStrategy = modelLoadStrategy;
		ClearNpcModelResourceQueues();
		_npcModelCulledStates.Clear();
		if (modelLoadStrategy == NpcModelLoadStrategy.LoadAll)
		{
			LoadAllInstantiatedNpcModelsImmediately();
		}
	}

	public override void Update()
	{
		try
		{
			base.Update();
			UpdateNpcModelCulling();
			ProcessNpcModelResourceQueues();
			UpdateNpcState();
			_filter.ForEachStable(_updateAnimatorAction);
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
	}

	public override void LateUpdate()
	{
		_filter.ForEachStable(_updateIKAction);
	}

	private void UpdateIK(Entity entity, CompNpc compNpc)
	{
		if (entity.IsLogicAvailable() && compNpc.IsFocusing)
		{
			compNpc.OnlyNeckLookAtIK?.solver?.IKUpdate();
		}
	}

	private void UpdateAnimator(Entity entity, CompNpc compNpc, CompTime compTime)
	{
		if (entity.IsLogicAvailable() && !(compNpc.Animator == null))
		{
			compNpc.Animator.speed = compTime.fixedSpeed;
		}
	}

	private void UpdateNpcState()
	{
		if (!DisableNPCFunc)
		{
			ProcessPendingAdds();
			ProcessPendingRemoves();
		}
	}

	private void UpdateNpcModelCulling()
	{
		if (DisableNPCFunc || !IsFrustumCullingEnabled)
		{
			return;
		}
		Camera mainCamera = GameUtility.mainCamera;
		if (!mainCamera || _npcModelCullingSchedule.Count == 0)
		{
			return;
		}
		CalculateNpcModelCullingFrustumPlanes(mainCamera);
		int num = 0;
		while (num < 5 && _npcModelCullingSchedule.Count > 0)
		{
			if (_nextNpcModelCullingScheduleIndex >= _npcModelCullingSchedule.Count)
			{
				_nextNpcModelCullingScheduleIndex = 0;
			}
			int num2 = _npcModelCullingSchedule[_nextNpcModelCullingScheduleIndex++];
			num++;
			if (!_instantiatedNpcDic.TryGetValue(num2, out var value) || !_instantiatedNpcEntrances.TryGetValue(num2, out var value2) || value2 == null || !value.IsValid)
			{
				RemoveNpcFromModelCullingSchedule(num2);
			}
			else
			{
				if (!value.IsLogicAvailable())
				{
					continue;
				}
				if (!_npcModelCulledStates.TryGetValue(num2, out var value3))
				{
					value3 = !value.GetModel() && !value2.ActiveModelHandle.IsValid;
					_npcModelCulledStates.Add(num2, value3);
				}
				if (value3)
				{
					if (IsNpcInMainCameraLoadFrustum(value))
					{
						QueueNpcModelLoad(num2);
					}
				}
				else if (!IsNpcInMainCameraUnloadFrustum(value))
				{
					QueueNpcModelUnload(num2);
				}
			}
		}
	}

	public bool ForceReleaseNpcModelResource(int npcConfigUid)
	{
		if (!IsFrustumCullingEnabled)
		{
			if (!HasValidInstantiatedNpc(npcConfigUid, out var entity, out var entrance))
			{
				return false;
			}
			ReleaseNpcDialogueBubbles(entity);
			return NpcFactory.ReleaseNpcModelResource(entrance, entity);
		}
		return QueueNpcModelUnload(npcConfigUid);
	}

	public bool RegenerateNpcModelResource(int npcConfigUid)
	{
		if (!HasValidInstantiatedNpc(npcConfigUid, out var entity, out var entrance))
		{
			return false;
		}
		if (!IsFrustumCullingEnabled)
		{
			ReleaseNpcDialogueBubbles(entity);
			if (!NpcFactory.ReleaseNpcModelResource(entrance, entity))
			{
				return false;
			}
			NpcFactory.ReloadNpcModelResourceAsync(entrance, entity).Forget();
			return true;
		}
		_queuedNpcModelReloads.Add(npcConfigUid);
		_npcModelCulledStates[npcConfigUid] = false;
		if ((bool)entity.GetModel() || entrance.ActiveModelHandle.IsValid)
		{
			EnqueueNpcModelUnload(npcConfigUid);
		}
		else
		{
			EnqueueNpcModelLoad(npcConfigUid);
		}
		return true;
	}

	private void ProcessNpcModelResourceQueues()
	{
		if (!DisableNPCFunc && IsFrustumCullingEnabled)
		{
			ProcessNpcModelUnloads();
			ProcessNpcModelLoads();
		}
	}

	private void ProcessNpcModelUnloads()
	{
		int num = 0;
		while (_npcModelUnloadQueue.Count > 0 && num < 1)
		{
			int num2 = _npcModelUnloadQueue.Dequeue();
			if (!_queuedNpcModelUnloads.Remove(num2))
			{
				continue;
			}
			num++;
			if (!HasValidInstantiatedNpc(num2, out var entity, out var entrance))
			{
				_queuedNpcModelReloads.Remove(num2);
				continue;
			}
			ReleaseNpcDialogueBubbles(entity);
			NpcFactory.ReleaseNpcModelResource(entrance, entity);
			if (_queuedNpcModelReloads.Remove(num2))
			{
				EnqueueNpcModelLoad(num2);
			}
		}
	}

	private static void ReleaseNpcDialogueBubbles(Entity entity)
	{
		CompBubble compBubble = entity.GetCompBubble();
		if (compBubble != null)
		{
			compBubble.BubbleDatas = null;
			compBubble.Parent = null;
		}
	}

	private void ProcessNpcModelLoads()
	{
		int num = 0;
		while (_npcModelLoadQueue.Count > 0 && num < 1)
		{
			int num2 = _npcModelLoadQueue.Dequeue();
			if (_queuedNpcModelLoads.Remove(num2))
			{
				num++;
				_queuedNpcModelReloads.Remove(num2);
				if (HasValidInstantiatedNpc(num2, out var entity, out var entrance) && !entity.GetModel() && !entrance.ActiveModelHandle.IsValid)
				{
					NpcFactory.ReloadNpcModelResourceAsync(entrance, entity).Forget();
				}
			}
		}
	}

	private bool QueueNpcModelLoad(int npcConfigUid)
	{
		if (!HasValidInstantiatedNpc(npcConfigUid, out var _, out var _))
		{
			return false;
		}
		_queuedNpcModelUnloads.Remove(npcConfigUid);
		_npcModelCulledStates[npcConfigUid] = false;
		EnqueueNpcModelLoad(npcConfigUid);
		return true;
	}

	private bool QueueNpcModelUnload(int npcConfigUid)
	{
		if (!HasValidInstantiatedNpc(npcConfigUid, out var _, out var _))
		{
			return false;
		}
		_queuedNpcModelLoads.Remove(npcConfigUid);
		_queuedNpcModelReloads.Remove(npcConfigUid);
		_npcModelCulledStates[npcConfigUid] = true;
		EnqueueNpcModelUnload(npcConfigUid);
		return true;
	}

	private void EnqueueNpcModelLoad(int npcConfigUid)
	{
		if (_queuedNpcModelLoads.Add(npcConfigUid))
		{
			_npcModelLoadQueue.Enqueue(npcConfigUid);
		}
	}

	private void EnqueueNpcModelUnload(int npcConfigUid)
	{
		if (_queuedNpcModelUnloads.Add(npcConfigUid))
		{
			_npcModelUnloadQueue.Enqueue(npcConfigUid);
		}
	}

	private bool HasValidInstantiatedNpc(int npcConfigUid, out Entity entity, out NpcShowEntranceCollection entrance)
	{
		entity = default;
		entrance = null;
		if (_instantiatedNpcDic.TryGetValue(npcConfigUid, out entity) && _instantiatedNpcEntrances.TryGetValue(npcConfigUid, out entrance) && entrance != null)
		{
			return entity.IsValid;
		}
		return false;
	}

	private static bool IsNpcEntranceLoading(NpcShowEntranceCollection entrance)
	{
		if (entrance.CurrentState == NpcShowEntranceCollection.State.Loading && (!entrance.ConfigHandle.IsDone || entrance.ConfigHandle.IsValid))
		{
			return true;
		}
		if (entrance.PendingShowRule != null)
		{
			return true;
		}
		if (entrance.ActiveModelHandle.IsValid)
		{
			return !entrance.ActiveModelHandle.IsDone;
		}
		return false;
	}

	private void AddNpcToModelCullingSchedule(int npcConfigUid)
	{
		if (!_npcModelCullingScheduleIndices.ContainsKey(npcConfigUid))
		{
			_npcModelCullingScheduleIndices.Add(npcConfigUid, _npcModelCullingSchedule.Count);
			_npcModelCullingSchedule.Add(npcConfigUid);
			if (HasValidInstantiatedNpc(npcConfigUid, out var entity, out var entrance))
			{
				_npcModelCulledStates[npcConfigUid] = !entity.GetModel() && !entrance.ActiveModelHandle.IsValid;
			}
		}
	}

	private void RemoveNpcFromModelCullingSchedule(int npcConfigUid)
	{
		_npcModelCulledStates.Remove(npcConfigUid);
		if (_npcModelCullingScheduleIndices.TryGetValue(npcConfigUid, out var value))
		{
			int num = _npcModelCullingSchedule.Count - 1;
			int num2 = _npcModelCullingSchedule[num];
			_npcModelCullingSchedule[value] = num2;
			_npcModelCullingSchedule.RemoveAt(num);
			_npcModelCullingScheduleIndices.Remove(npcConfigUid);
			if (value != num)
			{
				_npcModelCullingScheduleIndices[num2] = value;
			}
			if (_nextNpcModelCullingScheduleIndex > value)
			{
				_nextNpcModelCullingScheduleIndex--;
			}
			if (_nextNpcModelCullingScheduleIndex >= _npcModelCullingSchedule.Count)
			{
				_nextNpcModelCullingScheduleIndex = 0;
			}
		}
	}

	private void ClearNpcModelCullingSchedule()
	{
		_npcModelCullingSchedule.Clear();
		_npcModelCullingScheduleIndices.Clear();
		_npcModelCulledStates.Clear();
		_nextNpcModelCullingScheduleIndex = 0;
	}

	private void CancelNpcModelResourceRequests(int npcConfigUid)
	{
		_queuedNpcModelLoads.Remove(npcConfigUid);
		_queuedNpcModelUnloads.Remove(npcConfigUid);
		_queuedNpcModelReloads.Remove(npcConfigUid);
	}

	private void ClearNpcModelResourceQueues()
	{
		_npcModelLoadQueue.Clear();
		_npcModelUnloadQueue.Clear();
		_queuedNpcModelLoads.Clear();
		_queuedNpcModelUnloads.Clear();
		_queuedNpcModelReloads.Clear();
	}

	private void LoadAllInstantiatedNpcModelsImmediately()
	{
		ClearNpcModelResourceQueues();
		foreach (KeyValuePair<int, Entity> item in _instantiatedNpcDic)
		{
			if (HasValidInstantiatedNpc(item.Key, out var entity, out var entrance) && !entity.GetModel() && !entrance.ActiveModelHandle.IsValid)
			{
				NpcFactory.ReloadNpcModelResourceAsync(entrance, entity).Forget();
			}
		}
	}

	private bool ShouldLoadNpcModel(NpcShowEntranceCollection entrance)
	{
		if (!IsFrustumCullingEnabled)
		{
			return true;
		}
		Camera mainCamera = GameUtility.mainCamera;
		if (!mainCamera)
		{
			return true;
		}
		CalculateNpcModelCullingFrustumPlanes(mainCamera);
		return IsNpcPositionInMainCameraLoadFrustum(entrance.RuntimeWorldPosition);
	}

	private void CalculateNpcModelCullingFrustumPlanes(Camera mainCamera)
	{
		GeometryUtility.CalculateFrustumPlanes(mainCamera, _mainCameraLoadFrustumPlanes);
		float num = Mathf.Max(0f, NpcModelCullingFrustumPadding);
		for (int i = 0; i < _mainCameraLoadFrustumPlanes.Length; i++)
		{
			_mainCameraLoadFrustumPlanes[i].distance += num;
			_mainCameraUnloadFrustumPlanes[i] = _mainCameraLoadFrustumPlanes[i];
			_mainCameraUnloadFrustumPlanes[i].distance += 5f;
		}
	}

	private bool IsNpcInMainCameraLoadFrustum(Entity entity)
	{
		Transform rootTransform = entity.GetRootTransform();
		if ((bool)rootTransform)
		{
			return IsNpcPositionInMainCameraLoadFrustum(rootTransform.position);
		}
		return false;
	}

	private bool IsNpcInMainCameraUnloadFrustum(Entity entity)
	{
		Transform rootTransform = entity.GetRootTransform();
		if ((bool)rootTransform)
		{
			return IsNpcPositionInMainCameraUnloadFrustum(rootTransform.position);
		}
		return false;
	}

	private bool IsNpcPositionInMainCameraLoadFrustum(Vector3 position)
	{
		return IsNpcPositionInFrustum(position, _mainCameraLoadFrustumPlanes);
	}

	private bool IsNpcPositionInMainCameraUnloadFrustum(Vector3 position)
	{
		return IsNpcPositionInFrustum(position, _mainCameraUnloadFrustumPlanes);
	}

	private static bool IsNpcPositionInFrustum(Vector3 position, Plane[] frustumPlanes)
	{
		for (int i = 0; i < frustumPlanes.Length; i++)
		{
			Plane plane = frustumPlanes[i];
			if (Vector3.Dot(plane.normal, position) + plane.distance < 0f)
			{
				return false;
			}
		}
		return true;
	}

	private void ProcessPendingAdds()
	{
		foreach (NpcShowEntranceCollection item in _toAdd)
		{
			TryLoadNpc(item);
		}
		_toAdd.Clear();
		_toAddSet.Clear();
	}

	private void TryLoadNpc(NpcShowEntranceCollection entrance)
	{
		if (entrance.ActiveModelHandle.IsValid)
		{
			TrySwitchNpcShowRuleResources(entrance);
			if (entrance.PendingShowRule == null)
			{
				entrance.CurrentState = NpcShowEntranceCollection.State.Loaded;
				EnsureNpcVisible(entrance.EntityReference);
				RefreshNpcPosition(entrance);
				_instantiatedNpcDic[entrance.NpcConfigUid] = entrance.EntityReference;
				_instantiatedNpcEntrances[entrance.NpcConfigUid] = entrance;
				AddNpcToModelCullingSchedule(entrance.NpcConfigUid);
				ClearNpcLoadError(entrance.NpcConfigUid);
			}
			return;
		}
		if (!entrance.NpcConfig.IsValid())
		{
			RecordNpcLoadError(entrance, $"Npc配置为{entrance.NpcConfigUid}的资源丢失，无法加载。");
			ReleaseNpcHandles(entrance);
			entrance.CurrentState = NpcShowEntranceCollection.State.Removed;
			return;
		}
		entrance.CurrentState = NpcShowEntranceCollection.State.Loading;
		int loadVersion = entrance.BeginRuntimeLoad();
		entrance.ConfigHandle = AssetStationManager.BattleStation.LoadAsync<NpcDataConfig>(entrance.NpcConfig);
		AssetLoadHandle configHandle = entrance.ConfigHandle;
		configHandle.Completed += (AssetLoadHandle l) =>
		{
			try
			{
				if (entrance.IsCurrentRuntimeLoad(loadVersion))
				{
					NpcDataConfig config = l.As<NpcDataConfig>();
					if (config == null)
					{
						throw new Exception($"Npc配置为{entrance.NpcConfigUid}的资源加载结果为空。");
					}
					config.ApplyParametersToFields(saveJson: false);
					NpcShowRule showRule = entrance.GetActiveRule();
					entrance.PendingShowRule = showRule;
					entrance.EntityReference = NpcFactory.SpawnNpcEntity(entrance, config, showRule, hideRootUntilSpawned: false, (Entity entity) =>
					{
						if (!entrance.IsCurrentRuntimeLoad(loadVersion))
						{
							if (entity.IsValid)
							{
								MonoECS.instance.TryRemoveBehave(entity);
							}
						}
						else
						{
							BindInteractEntryConfigs(config, entity);
							entrance.LoadedShowRule = showRule;
							entrance.PendingShowRule = null;
							entrance.CurrentState = NpcShowEntranceCollection.State.Loaded;
							ClearNpcLoadError(entrance.NpcConfigUid);
						}
					}, (Exception e) =>
					{
						if (entrance.IsCurrentRuntimeLoad(loadVersion))
						{
							if (entrance.EntityReference.IsValid)
							{
								MonoECS.instance.TryRemoveBehave(entrance.EntityReference);
							}
							entrance.PendingShowRule = null;
							RecordNpcLoadError(entrance, $"Npc配置为{entrance.NpcConfigUid}生成失败：{e}");
							ReleaseNpcHandles(entrance);
							entrance.CurrentState = NpcShowEntranceCollection.State.Removed;
						}
					}, ShouldLoadNpcModel(entrance));
					if (!entrance.EntityReference.IsValid)
					{
						throw new Exception($"Npc配置为{entrance.NpcConfigUid}的实体生成失败，EntityReference无效。");
					}
					if (!entrance.IsCurrentRuntimeLoad(loadVersion))
					{
						MonoECS.instance.TryRemoveBehave(entrance.EntityReference);
					}
					else
					{
						_instantiatedNpcDic[config.npcConfigUid] = entrance.EntityReference;
						_instantiatedNpcEntrances[config.npcConfigUid] = entrance;
						AddNpcToModelCullingSchedule(config.npcConfigUid);
					}
				}
			}
			catch (Exception arg)
			{
				if (entrance.IsCurrentRuntimeLoad(loadVersion))
				{
					RecordNpcLoadError(entrance, $"Npc配置为{entrance.NpcConfigUid}生成异常：{arg}");
					ReleaseNpcHandles(entrance);
					entrance.CurrentState = NpcShowEntranceCollection.State.Removed;
				}
			}
		};
		Singleton<RuntimeNpcManager>.instance.OnNpcShow?.Invoke(entrance.NpcConfigUid);
	}

	private void RecordNpcLoadError(NpcShowEntranceCollection entrance, string message)
	{
		if (entrance != null)
		{
			Debug.LogError(message);
		}
	}

	private void ClearNpcLoadError(int npcConfigUid)
	{
	}

	public bool TryGetNpcLoadError(int npcConfigUid, out string message)
	{
		message = null;
		return false;
	}

	private void BindInteractEntryConfigs(NpcDataConfig config, Entity entity)
	{
		List<NpcInteractEntryConfig> list = config?.defaultInteractEntryConfigs;
		if (list == null)
		{
			return;
		}
		CompNpc compNpc = entity.GetCompNpc();
		if (compNpc == null)
		{
			return;
		}
		foreach (NpcInteractEntryConfig item in list)
		{
			if (item != null)
			{
				if (_interactEntryConditionChangedHandler == null)
				{
					_interactEntryConditionChangedHandler = OnInteractEntryConditionChanged;
				}
				compNpc.GetOrCreateInteractEntryRuntime(item).BindCondition(entity, _interactEntryConditionChangedHandler);
			}
		}
	}

	private void TrySwitchNpcShowRuleResources(NpcShowEntranceCollection entrance)
	{
		if (entrance == null || entrance.PendingShowRule != null)
		{
			return;
		}
		NpcShowRule targetShowRule = entrance.GetActiveRule();
		if (HasSameShowRuleResources(entrance.LoadedShowRule, targetShowRule))
		{
			entrance.CurrentState = NpcShowEntranceCollection.State.Loaded;
			return;
		}
		YooAssetReference modelPath = targetShowRule.ModelPath;
		if ((object)modelPath == null || !modelPath.IsValid())
		{
			RecordNpcLoadError(entrance, $"Npc配置为{entrance.NpcConfigUid}的当前显示规则模型资源不合法，无法切换NPC实体。");
			return;
		}
		Entity entityReference = entrance.EntityReference;
		NpcDataConfig config = ((!entityReference.IsValid) ? null : entityReference.GetCompNpc()?.NpcDataConfig);
		if (config == null)
		{
			RecordNpcLoadError(entrance, $"Npc配置为{entrance.NpcConfigUid}的当前实体配置为空，无法切换NPC实体。");
			return;
		}
		entrance.PendingShowRule = targetShowRule;
		entrance.CurrentState = NpcShowEntranceCollection.State.Loading;
		int loadVersion = entrance.BeginRuntimeLoad();
		Entity pendingEntity = default;
		pendingEntity = NpcFactory.SpawnNpcEntity(entrance, config, targetShowRule, hideRootUntilSpawned: true, (Entity entity) =>
		{
			if (!entrance.IsCurrentRuntimeLoad(loadVersion))
			{
				if (entity.IsValid)
				{
					MonoECS.instance.TryRemoveBehave(entity);
				}
			}
			else if (!HasSameShowRuleResources(targetShowRule, entrance.GetActiveRule()))
			{
				ReleasePendingNpc(entrance, entity);
				entrance.PendingShowRule = null;
				TrySwitchNpcShowRuleResources(entrance);
				if (entrance.PendingShowRule == null)
				{
					entrance.CurrentState = NpcShowEntranceCollection.State.Loaded;
					EnsureNpcVisible(entrance.EntityReference);
					RefreshNpcPosition(entrance);
				}
			}
			else
			{
				Entity entityReference2 = entrance.EntityReference;
				AssetLoadHandle activeModelHandle = entrance.ActiveModelHandle;
				UnbindInteractEntryConfigs(entityReference2);
				MonoECS.instance.TryRemoveBehave(entityReference2);
				entrance.EntityReference = entity;
				entrance.ActiveModelHandle = entrance.PendingModelHandle;
				entrance.PendingModelHandle = default;
				entrance.LoadedShowRule = targetShowRule;
				entrance.PendingShowRule = null;
				entrance.CurrentState = NpcShowEntranceCollection.State.Loaded;
				entity.GetRootTransform()?.gameObject.SetActive(value: true);
				BindInteractEntryConfigs(config, entity);
				EnsureNpcVisible(entity);
				RefreshNpcPosition(entrance);
				_instantiatedNpcDic[entrance.NpcConfigUid] = entity;
				_instantiatedNpcEntrances[entrance.NpcConfigUid] = entrance;
				AddNpcToModelCullingSchedule(entrance.NpcConfigUid);
				ClearNpcLoadError(entrance.NpcConfigUid);
				if (activeModelHandle.IsValid)
				{
					AssetStationManager.BattleStation.Release(activeModelHandle);
				}
			}
		}, (Exception e) =>
		{
			if (!entrance.IsCurrentRuntimeLoad(loadVersion))
			{
				if (pendingEntity.IsValid)
				{
					MonoECS.instance.TryRemoveBehave(pendingEntity);
				}
			}
			else
			{
				ReleasePendingNpc(entrance, pendingEntity);
				entrance.PendingShowRule = null;
				entrance.CurrentState = NpcShowEntranceCollection.State.Loaded;
				EnsureNpcVisible(entrance.EntityReference);
				RefreshNpcPosition(entrance);
				RecordNpcLoadError(entrance, $"Npc配置为{entrance.NpcConfigUid}切换显示规则资源失败：{e}");
			}
		}, ShouldLoadNpcModel(entrance));
	}

	private static bool HasSameShowRuleResources(NpcShowRule left, NpcShowRule right)
	{
		if (left != null && right != null && left.ModelPath == right.ModelPath)
		{
			return left.BehaviorTreePath == right.BehaviorTreePath;
		}
		return false;
	}

	private void ReleasePendingNpc(NpcShowEntranceCollection entrance, Entity pendingEntity)
	{
		if (pendingEntity.IsValid)
		{
			MonoECS.instance.TryRemoveBehave(pendingEntity);
		}
		if (entrance.PendingModelHandle.IsValid)
		{
			AssetStationManager.BattleStation.Release(entrance.PendingModelHandle);
			entrance.PendingModelHandle = default;
		}
	}

	private void UnbindInteractEntryConfigs(Entity entity)
	{
		if (entity.IsValid)
		{
			CompInteract compInteract = entity.GetCompInteract();
			if (compInteract?.CommonInteractTip != null)
			{
				compInteract.CommonInteractTip.gameObject.SetActive(value: false);
			}
			entity.GetCompNpc()?.UnbindInteractEntryConditions();
		}
	}

	private void OnInteractEntryConditionChanged(NpcInteractEntryRuntime interactEntryRuntime, bool isMet)
	{
		Entity owner = interactEntryRuntime.Owner;
		if (!owner.IsValid || interactEntryRuntime.Config == null)
		{
			return;
		}
		CompInteract compInteract = owner.GetCompInteract();
		CompNpc compNpc = owner.GetCompNpc();
		CompBubble compBubble = owner.GetCompBubble();
		if (compInteract != null && compNpc != null && compBubble != null)
		{
			List<NpcInteractEntryConfig> list = compNpc.NpcDataConfig?.defaultInteractEntryConfigs;
			if (list != null)
			{
				RecalculateActiveInteractEntry(compNpc, compInteract, compBubble, list);
			}
		}
	}

	private void RecalculateActiveInteractEntry(CompNpc compNpc, CompInteract compInteract, CompBubble compBubble, List<NpcInteractEntryConfig> defaultInteractEntries)
	{
		NpcInteractEntryRuntime activeInteractEntryRuntime = compNpc.ActiveInteractEntryRuntime;
		NpcInteractEntryConfig npcInteractEntryConfig = FindBestInteractEntry(defaultInteractEntries, GetTracingMissionId());
		if (npcInteractEntryConfig == null)
		{
			DeactivateInteractEntry(compNpc, compInteract, compBubble, activeInteractEntryRuntime);
		}
		else if (activeInteractEntryRuntime?.Config != npcInteractEntryConfig)
		{
			ActivateInteractEntry(compNpc, compInteract, compBubble, npcInteractEntryConfig, activeInteractEntryRuntime);
		}
	}

	private static NpcInteractEntryConfig FindBestInteractEntry(List<NpcInteractEntryConfig> defaultInteractEntries, int tracingMissionId)
	{
		InteractEntryPriorityContext priorityContext = new InteractEntryPriorityContext(defaultInteractEntries, tracingMissionId);
		NpcInteractEntryConfig npcInteractEntryConfig = null;
		for (int i = 0; i < defaultInteractEntries.Count; i++)
		{
			NpcInteractEntryConfig npcInteractEntryConfig2 = defaultInteractEntries[i];
			NpcCondition npcCondition = npcInteractEntryConfig2?.interactEntryCondition;
			if (npcCondition != null && npcCondition.IsPassed && npcInteractEntryConfig2.interactEntry != null && (npcInteractEntryConfig == null || CompareInteractEntryPriority(npcInteractEntryConfig2, npcInteractEntryConfig, priorityContext) < 0))
			{
				npcInteractEntryConfig = npcInteractEntryConfig2;
			}
		}
		return npcInteractEntryConfig;
	}

	private static int CompareInteractEntryPriority(NpcInteractEntryConfig x, NpcInteractEntryConfig y, InteractEntryPriorityContext priorityContext)
	{
		for (int i = 0; i < s_InteractEntryPriorityComparers.Length; i++)
		{
			int num = s_InteractEntryPriorityComparers[i](priorityContext, x, y);
			if (num != 0)
			{
				return num;
			}
		}
		return 0;
	}

	private static int CompareInteractEntryMissionMarkPriority(InteractEntryPriorityContext priorityContext, NpcInteractEntryConfig x, NpcInteractEntryConfig y)
	{
		bool num = !IsMissionMarkInteractEntry(x, priorityContext.TracingMissionId);
		int num2 = ((!IsMissionMarkInteractEntry(y, priorityContext.TracingMissionId)) ? 1 : 0);
		return (num ? 1 : 0) - num2;
	}

	private static int CompareInteractEntryListOrderPriority(InteractEntryPriorityContext priorityContext, NpcInteractEntryConfig x, NpcInteractEntryConfig y)
	{
		return priorityContext.Entries.IndexOf(x).CompareTo(priorityContext.Entries.IndexOf(y));
	}

	private static bool IsMissionMarkInteractEntry(NpcInteractEntryConfig interactEntryConfig, int tracingMissionId)
	{
		if (interactEntryConfig == null || tracingMissionId == 0)
		{
			return false;
		}
		List<NpcConditionGroup> list = interactEntryConfig.interactEntryCondition?.groups;
		if (list == null)
		{
			return false;
		}
		for (int i = 0; i < list.Count; i++)
		{
			NpcConditionGroup npcConditionGroup = list[i];
			if (npcConditionGroup == null)
			{
				continue;
			}
			for (int j = 0; j < npcConditionGroup.ConditionCount; j++)
			{
				if (npcConditionGroup.GetCondition(j) is MissionDurationCondition missionDurationCondition && missionDurationCondition.missionID == tracingMissionId)
				{
					return true;
				}
			}
		}
		return false;
	}

	private static int GetTracingMissionId()
	{
		if (!Singleton<MissionManager>.HasInstance())
		{
			return 0;
		}
		return Singleton<MissionManager>.instance.GetTracingMission();
	}

	private void ActivateInteractEntry(CompNpc compNpc, CompInteract compInteract, CompBubble compBubble, NpcInteractEntryConfig interactEntryConfig, NpcInteractEntryRuntime previousActiveEntryRuntime)
	{
		if (interactEntryConfig?.interactEntry != null)
		{
			NpcInteractEntryConfig npcInteractEntryConfig = previousActiveEntryRuntime?.Config;
			if (npcInteractEntryConfig != null)
			{
				compInteract.Entries?.Remove(npcInteractEntryConfig.interactEntry);
			}
			previousActiveEntryRuntime?.UnbindAnimator();
			NpcInteractEntryRuntime orCreateInteractEntryRuntime = compNpc.GetOrCreateInteractEntryRuntime(interactEntryConfig);
			compNpc.SetActiveInteractEntryRuntime(orCreateInteractEntryRuntime);
			ApplyNpcLocalizedNameIfUnconfigured(interactEntryConfig.interactEntry, compNpc);
			compInteract.Entries?.Add(interactEntryConfig.interactEntry);
			compInteract.CommonInteractTip?.SetDefaultInteractEntry(interactEntryConfig.interactEntry);
			BindInteractEntryAnimationCollections(orCreateInteractEntryRuntime, compNpc, previousActiveEntryRuntime?.HasAnimationActions() ?? false);
			compBubble.BindParentFromInteract(compInteract);
			compBubble.BubbleDatas = interactEntryConfig.chatBubbleCollections;
		}
	}

	private void DeactivateInteractEntry(CompNpc compNpc, CompInteract compInteract, CompBubble compBubble, NpcInteractEntryRuntime activeInteractEntryRuntime)
	{
		if (activeInteractEntryRuntime != null)
		{
			compInteract.Entries?.Remove(activeInteractEntryRuntime.Config?.interactEntry);
			compNpc.SetActiveInteractEntryRuntime(null);
			activeInteractEntryRuntime.UnbindAnimator();
			compBubble.Parent = null;
			compBubble.BubbleDatas = null;
			if (activeInteractEntryRuntime.HasAnimationActions())
			{
				compNpc.RestartAnimatorFromEntry();
			}
			compInteract.CommonInteractTip?.SetDefaultInteractEntry(null);
		}
	}

	private void OnMissionPointChanged(BaseEventContent evt)
	{
		MissionPointData missionPointData;
		if (evt is MissionNPointAddedEvt missionNPointAddedEvt)
		{
			missionPointData = missionNPointAddedEvt.missionPointData;
		}
		else
		{
			if (!(evt is MissionNPointRemovedEvt missionNPointRemovedEvt))
			{
				return;
			}
			missionPointData = missionNPointRemovedEvt.missionPointData;
		}
		if (missionPointData is NPCMissionPoint nPCMissionPoint)
		{
			RefreshNpcInteractEntries(nPCMissionPoint.NpcUid);
		}
	}

	private void RefreshNpcInteractEntries(int npcConfigUid)
	{
		if (!_instantiatedNpcDic.TryGetValue(npcConfigUid, out var value) || !value.IsValid)
		{
			return;
		}
		CompInteract compInteract = value.GetCompInteract();
		CompNpc compNpc = value.GetCompNpc();
		CompBubble compBubble = value.GetCompBubble();
		if (compInteract != null && compNpc != null && compBubble != null)
		{
			List<NpcInteractEntryConfig> list = compNpc.NpcDataConfig?.defaultInteractEntryConfigs;
			if (list != null)
			{
				RecalculateActiveInteractEntry(compNpc, compInteract, compBubble, list);
			}
		}
	}

	private void OnTracingMissionChanged(BaseEventContent evt)
	{
		foreach (KeyValuePair<int, Entity> item in _instantiatedNpcDic)
		{
			RefreshNpcInteractEntries(item.Key);
		}
	}

	private void BindInteractEntryAnimationCollections(NpcInteractEntryRuntime interactEntryRuntime, CompNpc compNpc, bool restoreStateMachineWhenNoAction)
	{
		if (interactEntryRuntime == null || compNpc == null)
		{
			return;
		}
		if (!interactEntryRuntime.HasAnimationActions())
		{
			if (restoreStateMachineWhenNoAction)
			{
				compNpc.RestartAnimatorFromEntry();
			}
			return;
		}
		interactEntryRuntime.BindAnimator(compNpc.Animator);
		if (interactEntryRuntime.ShouldUseAnimationSnap())
		{
			compNpc.SnapAnimator();
		}
		else
		{
			compNpc.ClearSnap();
		}
	}

	private static void ApplyNpcLocalizedNameIfUnconfigured(InteractEntry interactEntry, CompNpc compNpc)
	{
		if (interactEntry == null || interactEntry.InteractType != InteractType.Button || compNpc == null)
		{
			return;
		}
		LocalizedString localizedString = interactEntry.LocalizedString;
		if (localizedString != null && localizedString.TableEntryReference.KeyId != 0L)
		{
			return;
		}
		int num = CoreUtils.GetData(compNpc.NpcConfigUid, RuntimeConfigs.data.npcConfigs)?.name ?? 0;
		if (num != 0)
		{
			if (localizedString == null)
			{
				interactEntry.ResetLocalizedString(new LocalizedString("shortcommon", num));
				return;
			}
			localizedString.TableReference = "shortcommon";
			localizedString.TableEntryReference = num;
		}
	}

	private void ProcessPendingRemoves()
	{
		for (int num = _toRemove.Count - 1; num >= 0; num--)
		{
			NpcShowEntranceCollection npcShowEntranceCollection = _toRemove[num];
			if (npcShowEntranceCollection != null)
			{
				Entity entityReference = npcShowEntranceCollection.EntityReference;
				if (!entityReference.IsValid)
				{
					npcShowEntranceCollection.CurrentState = NpcShowEntranceCollection.State.Removed;
				}
				if (npcShowEntranceCollection.CurrentState == NpcShowEntranceCollection.State.Loaded)
				{
					BeginRemoveNpc(npcShowEntranceCollection);
				}
				if (npcShowEntranceCollection.CurrentState == NpcShowEntranceCollection.State.Removing)
				{
					UpdateRemovingFade(npcShowEntranceCollection, entityReference);
				}
				if (npcShowEntranceCollection.CurrentState == NpcShowEntranceCollection.State.Removed)
				{
					FinalizeRemoveNpc(npcShowEntranceCollection);
				}
			}
		}
	}

	private void BeginRemoveNpc(NpcShowEntranceCollection entrance)
	{
		CompNpc? compNpc = entrance.EntityReference.GetCompNpc();
		CompInteract compInteract = entrance.EntityReference.GetCompInteract();
		if (compInteract != null && compInteract.CommonInteractTip != null)
		{
			compInteract.CommonInteractTip.gameObject.SetActive(value: false);
		}
		compNpc?.UnbindInteractEntryConditions();
		entrance.RemainFadeTime = 0.5f;
		_instantiatedNpcDic.Remove(entrance.NpcConfigUid);
		_instantiatedNpcEntrances.Remove(entrance.NpcConfigUid);
		RemoveNpcFromModelCullingSchedule(entrance.NpcConfigUid);
		Singleton<RuntimeNpcManager>.instance.OnNpcHide?.Invoke(entrance.NpcConfigUid);
		entrance.CurrentState = NpcShowEntranceCollection.State.Removing;
	}

	private void UpdateRemovingFade(NpcShowEntranceCollection entrance, Entity entityReference)
	{
		if (entrance == null)
		{
			return;
		}
		if (entrance.RemainFadeTime <= 0f)
		{
			entrance.CurrentState = NpcShowEntranceCollection.State.Removed;
		}
		MonoEntity monoEntity = (entityReference.IsValid ? entityReference.GetMono() : null);
		if (monoEntity != null && monoEntity.renderers != null)
		{
			float value = entrance.RemainFadeTime / 0.5f;
			Renderer[] renderers = monoEntity.renderers;
			foreach (Renderer renderer in renderers)
			{
				if (renderer != null && renderer.material != null)
				{
					renderer.material.SetFloat(BattleConsts.SUB_EFFECT_SHADER_DITHER, value);
				}
			}
		}
		entrance.RemainFadeTime -= Time.deltaTime;
	}

	private void FinalizeRemoveNpc(NpcShowEntranceCollection entrance)
	{
		CancelNpcModelResourceRequests(entrance.NpcConfigUid);
		MonoECS.instance.TryRemoveBehave(entrance.EntityReference);
		ReleaseNpcHandles(entrance);
		_toRemove.Remove(entrance);
		_toRemoveSet.Remove(entrance);
	}

	private void ReleaseNpcHandles(NpcShowEntranceCollection entrance)
	{
		if (entrance != null)
		{
			if (entrance.ConfigHandle.IsValid)
			{
				AssetStationManager.BattleStation.Release(entrance.ConfigHandle);
				entrance.ConfigHandle = default;
			}
			if (entrance.ActiveModelHandle.IsValid)
			{
				AssetStationManager.BattleStation.Release(entrance.ActiveModelHandle);
				entrance.ActiveModelHandle = default;
			}
			if (entrance.PendingModelHandle.IsValid)
			{
				AssetStationManager.BattleStation.Release(entrance.PendingModelHandle);
				entrance.PendingModelHandle = default;
			}
			entrance.EntityReference = default;
			_instantiatedNpcEntrances.Remove(entrance.NpcConfigUid);
			RemoveNpcFromModelCullingSchedule(entrance.NpcConfigUid);
		}
	}

	public bool IsNpcShowRequested(NpcShowEntranceCollection entrance)
	{
		if (entrance != null && !_toRemoveSet.Contains(entrance))
		{
			if (!_toAddSet.Contains(entrance))
			{
				NpcShowEntranceCollection.State currentState = entrance.CurrentState;
				return currentState == NpcShowEntranceCollection.State.Loading || currentState == NpcShowEntranceCollection.State.Loaded;
			}
			return true;
		}
		return false;
	}

	public bool IsNpcHideRequested(NpcShowEntranceCollection entrance)
	{
		if (entrance != null && !_toAddSet.Contains(entrance))
		{
			if (entrance.CurrentState != NpcShowEntranceCollection.State.Removed)
			{
				return _toRemoveSet.Contains(entrance);
			}
			return true;
		}
		return false;
	}

	public void ShowNpc(NpcShowEntranceCollection entrance)
	{
		if (entrance == null)
		{
			return;
		}
		if (_toRemoveSet.Remove(entrance))
		{
			_toRemove.Remove(entrance);
		}
		if (entrance.CurrentState == NpcShowEntranceCollection.State.Loaded)
		{
			TrySwitchNpcShowRuleResources(entrance);
			if (entrance.PendingShowRule == null)
			{
				EnsureNpcVisible(entrance.EntityReference);
				RefreshNpcPosition(entrance);
			}
			Singleton<RuntimeNpcManager>.instance.OnNpcShow?.Invoke(entrance.NpcConfigUid);
		}
		else if (entrance.CurrentState != NpcShowEntranceCollection.State.Loading && _toAddSet.Add(entrance))
		{
			_toAdd.Add(entrance);
		}
	}

	public void HideNpc(NpcShowEntranceCollection entrance)
	{
		if (entrance != null)
		{
			CancelNpcModelResourceRequests(entrance.NpcConfigUid);
			if (_toAddSet.Remove(entrance))
			{
				_toAdd.Remove(entrance);
			}
			if (entrance.CurrentState != NpcShowEntranceCollection.State.Removed && _toRemoveSet.Add(entrance))
			{
				_toRemove.Add(entrance);
			}
		}
	}

	public void UnloadNpcsImmediately(IEnumerable<NpcShowEntranceCollection> entrances)
	{
		if (entrances == null)
		{
			return;
		}
		foreach (NpcShowEntranceCollection entrance in entrances)
		{
			if (entrance == null)
			{
				continue;
			}
			entrance.InvalidateRuntimeLoads();
			_toAddSet.Remove(entrance);
			_toRemoveSet.Remove(entrance);
			CancelNpcModelResourceRequests(entrance.NpcConfigUid);
			Entity entityReference = entrance.EntityReference;
			if (entityReference.IsValid)
			{
				UnbindInteractEntryConfigs(entityReference);
				MonoECS.instance.TryRemoveBehave(entityReference);
				if (Singleton<RuntimeNpcManager>.HasInstance())
				{
					Singleton<RuntimeNpcManager>.instance.OnNpcHide?.Invoke(entrance.NpcConfigUid);
				}
			}
			_instantiatedNpcDic.Remove(entrance.NpcConfigUid);
			RemoveNpcFromModelCullingSchedule(entrance.NpcConfigUid);
			ClearNpcLoadError(entrance.NpcConfigUid);
			ReleaseNpcHandles(entrance);
			entrance.ResetRuntimeState();
		}
		_toAdd.Clear();
		_toRemove.Clear();
		_toAddSet.Clear();
		_toRemoveSet.Clear();
		ClearNpcModelResourceQueues();
		_instantiatedNpcDic.Clear();
		_instantiatedNpcEntrances.Clear();
		ClearNpcModelCullingSchedule();
	}

	public void RefreshNpcPosition(NpcShowEntranceCollection entrance)
	{
		if (entrance == null || entrance.CurrentState != NpcShowEntranceCollection.State.Loaded || !entrance.EntityReference.IsValid)
		{
			return;
		}
		Vector3 runtimeWorldPosition = entrance.RuntimeWorldPosition;
		Quaternion quaternion = Quaternion.Euler(entrance.RuntimeWorldRotation);
		Transform rootTransform = entrance.EntityReference.GetRootTransform();
		if (rootTransform == null)
		{
			return;
		}
		bool flag = (rootTransform.position - runtimeWorldPosition).sqrMagnitude > 0.0001f;
		bool flag2 = Quaternion.Angle(rootTransform.rotation, quaternion) > 0.01f;
		if (flag || flag2)
		{
			if (flag)
			{
				rootTransform.position = runtimeWorldPosition;
				entrance.EntityReference.GetCompTransform()?.SetPositionImmediately(runtimeWorldPosition);
			}
			if (flag2)
			{
				rootTransform.rotation = quaternion;
				NpcFactory.AlignNpcInteractTriggerToWorld(rootTransform.gameObject);
			}
		}
	}

	private void EnsureNpcVisible(Entity npcEntityReference)
	{
		if (!npcEntityReference.IsValid)
		{
			return;
		}
		MonoEntity mono = npcEntityReference.GetMono();
		if ((object)mono != null && mono.renderers != null)
		{
			Renderer[] renderers = mono.renderers;
			for (int i = 0; i < renderers.Length; i++)
			{
				renderers[i].material.SetFloat(BattleConsts.SUB_EFFECT_SHADER_DITHER, 1f);
			}
		}
	}
}
