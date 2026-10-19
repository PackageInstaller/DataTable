using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Event;
using ACT.Model;
using ACT.UI;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Bamboo.Precache;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

public abstract class StateObjectBase : MonoTriggerEvent, ITrigger
{
	public Entity onlyEntity;

	[HideInInspector]
	public bool isAttackInit;

	private int _swid = int.MinValue;

	private bool waitTransition;

	protected bool m_Inited;

	protected bool m_HasChild;

	internal bool isStateChanged;

	[HideInInspector]
	public int cleanedTs;

	private Animator[] animators;

	private CompTime _compTime;

	private IShowInteractTip _registeredInteractTip;

	private InstanceHandle m_InteractTip;

	private List<Collider> _collectColliders = new List<Collider>();

	private static List<StateObjectBase> InInteraction = new List<StateObjectBase>();

	private Collider _pendingTriggerEnterCollider;

	private bool _pendingTriggerEnterWaitLogicAvailable;

	private bool _pendingTriggerEnterWaitMainEntity;

	private bool _pendingTriggerEnterWaitSceneComplete;

	protected MonoEntity target;

	public abstract bool serviceSave { get; }

	public Entity entity { get; private set; }

	public int currentStateId { get; protected set; } = int.MinValue;

	public int swid => _swid;

	public bool Inited => m_Inited;

	public InstanceHandle InteractTip
	{
		get
		{
			return m_InteractTip;
		}
		private set
		{
			m_InteractTip = value;
		}
	}

	public CommonInteractUI CustomUi { get; private set; }

	public List<Collider> CollectColliders => _collectColliders;

	public bool IsStay => InInteraction.Contains(this);

	protected void ResetEntryInteractType(InteractEntry entry, InteractType type)
	{
		entry?.ResetInteractType(type);
	}

	public void SetEntity(Entity entity)
	{
		UnbindCompTimeSpeedChange();
		this.entity = entity;
		_swid = entity.GetCompStateObject().StateWorldAssetData.stateWorldAssetUid;
		animators = GetComponentsInChildren<Animator>(includeInactive: true);
		if (entity.TryGetCompTime(out CompTime component))
		{
			_compTime = component;
			_compTime.OnFixedSpeedChange += OnCompTimeOnOnFixedSpeedChange;
		}
	}

	private void UnbindCompTimeSpeedChange()
	{
		if (_compTime != null)
		{
			_compTime.OnFixedSpeedChange -= OnCompTimeOnOnFixedSpeedChange;
			_compTime = null;
		}
	}

	private void OnCompTimeOnOnFixedSpeedChange(float f)
	{
		if (animators == null)
		{
			return;
		}
		Animator[] array = animators;
		foreach (Animator animator in array)
		{
			if ((bool)animator)
			{
				animator.speed = f;
			}
		}
	}

	private void UpdateInteractTipRegistration()
	{
		InteractEntry interactEntry = GetInteractEntry();
		if (_registeredInteractTip != interactEntry)
		{
			if (_registeredInteractTip != null)
			{
				Singleton<InteractTipManager>.instance.Unregister(_registeredInteractTip);
			}
			_registeredInteractTip = interactEntry;
			if (_registeredInteractTip != null)
			{
				Singleton<InteractTipManager>.instance.Register(_registeredInteractTip);
			}
		}
	}

	private void UpdateInteractEntryCondition()
	{
		InteractEntry interactEntry = GetInteractEntry();
		if (interactEntry != null)
		{
			interactEntry.EvaluateConditions();
			interactEntry.EvaluateTipConditions();
		}
	}

	private void OnInteractTipLoaded(CommonInteractUI commonInteractUI)
	{
		CustomUi = commonInteractUI;
		CustomUi.Init(entity, GetInteractEntry());
		CustomUi.OnExitInteractObj();
	}

	private void TryReleaseInteractTip()
	{
		try
		{
			if (Model<CommonInteractUIModel>.HasInstance())
			{
				Model<CommonInteractUIModel>.Interface.Release(this);
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"头顶提示卸载失败 原因 :\n {arg}");
			}
		}
		finally
		{
			m_InteractTip = null;
			CustomUi = null;
		}
	}

	public bool IsWaitTransition()
	{
		return waitTransition;
	}

	public void EnterState(int stateId)
	{
		if (currentStateId == stateId)
		{
			return;
		}
		if (currentStateId != int.MinValue)
		{
			HandleExitInteract();
			HandleUninitState(currentStateId);
			if (NeedWaitTransition(currentStateId, stateId))
			{
				waitTransition = true;
			}
		}
		HandleChangeState(currentStateId, stateId);
		currentStateId = stateId;
		HandleInitState(stateId);
		if (!IsWaitTransition() && InInteraction.Contains(this))
		{
			HandleEnterInteract();
		}
		TryLoadInteractTip();
		UpdateInteractTipRegistration();
		CustomUi?.Init(entity, GetInteractEntry());
	}

	public async UniTask NetEnterState(int stateId, Action callback = null)
	{
		_ = LuminApplication.LogEnabled;
		if (entity.GetCompStateObject().StateWorldAssetData.IsServiceSaveState(stateId))
		{
			isStateChanged = false;
			MonoECS.instance.ruleManager.SharedChangeState(entity.GetCompStateObject().StateWorldAssetData.stateWorldAssetUid, stateId);
			if (!isStateChanged)
			{
				await UniTask.WaitUntil(() => isStateChanged);
			}
		}
		else
		{
			MonoECS.instance.ruleManager.SharedChangeState(entity.GetCompStateObject().StateWorldAssetData.stateWorldAssetUid, stateId);
		}
	}

	public virtual void BindParentRigidBody(Rigidbody parentRig)
	{
	}

	protected virtual void HandleChangeState(int fromStateId, int toStateId)
	{
	}

	protected virtual void HandleInitState(int stateId)
	{
	}

	protected virtual void HandleUninitState(int stateId)
	{
	}

	protected abstract bool NeedWaitTransition(int fromStateId, int toStateId);

	protected virtual void OnEnterState()
	{
	}

	protected virtual void OnCompleteTransition()
	{
	}

	public void CompleteTransition(int targetStateId)
	{
		if (targetStateId == currentStateId)
		{
			waitTransition = false;
			Transition();
		}
	}

	public void CompleteTransitionClear()
	{
		waitTransition = false;
		Transition();
	}

	private void Transition()
	{
		OnCompleteTransition();
		if (InInteraction.Contains(this))
		{
			HandleEnterInteract();
		}
	}

	public abstract bool CheckStateIdValid(int stateId);

	protected abstract void HandleEnterInteract();

	protected abstract void HandleExitInteract();

	public virtual void OnExposed()
	{
	}

	public virtual void OnExitExposed()
	{
	}

	protected virtual InteractEntry GetInteractEntry()
	{
		return null;
	}

	public virtual int GetInteractId()
	{
		InteractEntry interactEntry = GetInteractEntry();
		if (interactEntry != null)
		{
			return interactEntry.ShowType switch
			{
				ShowType.Show => interactEntry.TipIcon, 
				ShowType.Hide => -1, 
				ShowType.Lock => interactEntry.LockTipIconId, 
				_ => throw new ArgumentOutOfRangeException(), 
			};
		}
		return -1;
	}

	public virtual bool ShowInteractTip()
	{
		return true;
	}

	public virtual Transform GetInteractTipTransform()
	{
		try
		{
			Transform transform = GetInteractEntry()?.TipTransform;
			return (transform == null) ? base.transform : transform;
		}
		catch (Exception)
		{
			_ = LuminApplication.LogEnabled;
			return base.transform;
		}
	}

	protected virtual bool NeedInteractTip()
	{
		if (this is InteractBattleRoom)
		{
			return false;
		}
		foreach (MissionPointData point in Model<BattleMainMarkModelV2>.Interface.Points)
		{
			if (point is StateObjectMissionPoint stateObjectMissionPoint && stateObjectMissionPoint.InteractObjId == swid)
			{
				return true;
			}
		}
		return false;
	}

	public static void EnterInteractObject(StateObjectBase stateObjectBase)
	{
		InInteraction.Add(stateObjectBase);
		if (!stateObjectBase.IsWaitTransition())
		{
			stateObjectBase.HandleEnterInteract();
		}
	}

	public static void ExitInteractObject(StateObjectBase stateObjectBase)
	{
		InInteraction.Remove(stateObjectBase);
		stateObjectBase.HandleExitInteract();
	}

	private void OnTriggerEnter(Collider collision)
	{
		if (TryGetCharacterTriggerInfo(collision, out var _, out var compBehave) && AllowTriggerEnter(MonoECS.instance.PlayerControlType))
		{
			RegisterPendingTriggerEnter(collision, compBehave);
		}
	}

	private async void OnTriggerExit(Collider collision)
	{
		if (collision == _pendingTriggerEnterCollider)
		{
			CancelPendingTriggerEnter();
		}
		if (TryGetMainCharacterTriggerInfo(collision, out var mono, out var compBehave) && compBehave.IsLogicAvailable())
		{
			await HandleTriggerExit(mono, compBehave);
		}
	}

	private bool TryGetMainCharacterTriggerInfo(Collider collision, out MonoEntity mono, out CompBehave compBehave)
	{
		if (!TryGetCharacterTriggerInfo(collision, out mono, out compBehave))
		{
			return false;
		}
		return MonoECS.instance.mainEntity == mono.entity;
	}

	private bool TryGetCharacterTriggerInfo(Collider collision, out MonoEntity mono, out CompBehave compBehave)
	{
		mono = null;
		compBehave = null;
		MonoEntity component = collision.GetComponent<MonoEntity>();
		if ((object)component != null)
		{
			Entity entity = component.entity;
			if (entity.IsValid)
			{
				if (!component.entity.IsCharacter() || !component.entity.TryGetCompBehave(out CompBehave component2))
				{
					return false;
				}
				mono = component;
				compBehave = component2;
				return true;
			}
		}
		return false;
	}

	private bool TryGetTriggerCompBehave(Collider collision, out CompBehave compBehave)
	{
		compBehave = null;
		if (collision == null)
		{
			return false;
		}
		MonoEntity component = collision.GetComponent<MonoEntity>();
		if ((object)component != null)
		{
			Entity entity = component.entity;
			if (entity.IsValid)
			{
				return component.entity.TryGetCompBehave(out compBehave);
			}
		}
		return false;
	}

	private void HandleTriggerEnter(MonoEntity mono, CompBehave compBehave)
	{
		if (target != null)
		{
			compBehave.OnInactive -= OnInactive;
			ExitInteractObject(this);
		}
		target = mono;
		compBehave.OnInactive += OnInactive;
		EnterInteractObject(this);
		OnEnterEvt(mono.entity, this);
		CustomUi?.OnEnterInteractObj();
	}

	private async UniTask HandleTriggerExit(MonoEntity mono, CompBehave compBehave)
	{
		if (MonoECS.instance.IsLoadSubScene)
		{
			return;
		}
		if (!m_Inited)
		{
			try
			{
				await UniTask.WaitUntil(() => m_Inited, PlayerLoopTiming.FixedUpdate, destroyCancellationToken);
			}
			catch (OperationCanceledException)
			{
				return;
			}
		}
		if (!(target != mono) || InInteraction.Contains(this))
		{
			target = null;
			compBehave.OnInactive -= OnInactive;
			ExitInteractObject(this);
			OnExitEvt(mono.entity, this);
			CustomUi?.OnExitInteractObj();
		}
	}

	private void RegisterPendingTriggerEnter(Collider collision, CompBehave compBehave)
	{
		CancelPendingTriggerEnter();
		_pendingTriggerEnterCollider = collision;
		if (!compBehave.IsLogicAvailable())
		{
			_pendingTriggerEnterWaitLogicAvailable = true;
			compBehave.OnLogicAvailable += OnPendingTriggerEnterLogicAvailable;
		}
		if (!MonoECS.instance.mainEntity.IsValid)
		{
			_pendingTriggerEnterWaitMainEntity = true;
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.RuntimeBattleTeam_MainCharacterChanged, OnPendingTriggerEnterMainEntityChanged);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, OnPendingTriggerEnterMainEntityChanged);
		}
		if (MonoECS.instance.IsLoadSubScene)
		{
			_pendingTriggerEnterWaitSceneComplete = true;
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.Scene_Change_Complete, OnSceneChangeComplete);
		}
		TryCompletePendingTriggerEnter();
	}

	private void CancelPendingTriggerEnter()
	{
		if (_pendingTriggerEnterWaitLogicAvailable && TryGetTriggerCompBehave(_pendingTriggerEnterCollider, out var compBehave))
		{
			compBehave.OnLogicAvailable -= OnPendingTriggerEnterLogicAvailable;
		}
		if (_pendingTriggerEnterWaitMainEntity)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RuntimeBattleTeam_MainCharacterChanged, OnPendingTriggerEnterMainEntityChanged);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, OnPendingTriggerEnterMainEntityChanged);
		}
		if (_pendingTriggerEnterWaitSceneComplete)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Scene_Change_Complete, OnSceneChangeComplete);
		}
		_pendingTriggerEnterCollider = null;
		_pendingTriggerEnterWaitLogicAvailable = false;
		_pendingTriggerEnterWaitMainEntity = false;
		_pendingTriggerEnterWaitSceneComplete = false;
	}

	private void OnPendingTriggerEnterLogicAvailable(Entity e)
	{
		if (e.IsValid && e.TryGetCompBehave(out CompBehave component))
		{
			component.OnLogicAvailable -= OnPendingTriggerEnterLogicAvailable;
		}
		_pendingTriggerEnterWaitLogicAvailable = false;
		TryCompletePendingTriggerEnter();
	}

	private void OnPendingTriggerEnterMainEntityChanged(BaseEventContent obj)
	{
		if (MonoECS.instance.mainEntity.IsValid)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RuntimeBattleTeam_MainCharacterChanged, OnPendingTriggerEnterMainEntityChanged);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, OnPendingTriggerEnterMainEntityChanged);
			_pendingTriggerEnterWaitMainEntity = false;
			TryCompletePendingTriggerEnter();
		}
	}

	private void TryCompletePendingTriggerEnter()
	{
		if (!(_pendingTriggerEnterCollider == null) && TryGetMainCharacterTriggerInfo(_pendingTriggerEnterCollider, out var mono, out var compBehave) && CanCompletePendingTriggerEnter(mono, compBehave))
		{
			CancelPendingTriggerEnter();
			HandleTriggerEnter(mono, compBehave);
		}
	}

	private bool CanCompletePendingTriggerEnter(MonoEntity mono, CompBehave compBehave)
	{
		if (!this || mono == null || compBehave == null || !mono.entity.IsValid)
		{
			return false;
		}
		if (MonoECS.instance.mainEntity != mono.entity)
		{
			return false;
		}
		if (!AllowTriggerEnter(MonoECS.instance.PlayerControlType) || !compBehave.IsLogicAvailable())
		{
			return false;
		}
		if (MonoECS.instance.IsLoadSubScene || !m_Inited)
		{
			return false;
		}
		if (target != mono)
		{
			return !InInteraction.Contains(this);
		}
		return false;
	}

	private void OnEvt(BaseEventContent obj)
	{
		TryLoadInteractTip();
	}

	public bool TryLoadInteractTip(bool forceLoad = false)
	{
		if (!NeedInteractTip() && !forceLoad)
		{
			return false;
		}
		if (m_InteractTip != null)
		{
			return false;
		}
		if (!Model<CommonInteractUIModel>.HasInstance())
		{
			return false;
		}
		UpdateInteractEntryCondition();
		m_InteractTip = Model<CommonInteractUIModel>.Interface.Load(this, OnInteractTipLoaded);
		RemoveListeners();
		return true;
	}

	private void AddListeners()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.InteractEntry_Loaded, OnEvt);
	}

	private void RemoveListeners()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.InteractEntry_Loaded, OnEvt);
	}

	public void TriggerExit()
	{
		CancelPendingTriggerEnter();
		Entity battleEntity = MonoECS.instance.localPlayer.battleEntity;
		if (battleEntity.IsValid)
		{
			target = null;
			CompBehave compBehave = battleEntity.GetCompBehave();
			if (compBehave != null)
			{
				compBehave.OnInactive -= OnInactive;
			}
			if (this != null)
			{
				ExitInteractObject(this);
			}
		}
	}

	private void OnInactive(Entity entity)
	{
		ExitInteractObject(this);
	}

	public abstract void Interact(int entryIndex, Entity entity, InteractAction.InteractSource interactSource);

	public virtual void InitStateObject(int stateId)
	{
		gameObject.SetActive(value: true);
		ApplyTheOtherWorldLogic();
		EnterState(stateId);
		m_Inited = true;
		TryCompletePendingTriggerEnter();
		if (!TryLoadInteractTip())
		{
			RemoveListeners();
			AddListeners();
		}
	}

	private void OnSceneChangeComplete(BaseEventContent obj)
	{
		if (_pendingTriggerEnterWaitSceneComplete)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Scene_Change_Complete, OnSceneChangeComplete);
			_pendingTriggerEnterWaitSceneComplete = false;
			TryCompletePendingTriggerEnter();
		}
	}

	public virtual void ReleaseStateObject()
	{
		UnbindCompTimeSpeedChange();
		CancelPendingTriggerEnter();
		HandleUninitState(currentStateId);
		if (_registeredInteractTip != null)
		{
			Singleton<InteractTipManager>.instance.Unregister(_registeredInteractTip);
			_registeredInteractTip = null;
		}
		TryReleaseInteractTip();
		RemoveListeners();
	}

	public virtual void OnBindChildrenChanged(StateObjectBase child)
	{
		m_HasChild = true;
	}

	public virtual Transform OverrideSyncTransform(Transform inputValue)
	{
		return inputValue;
	}

	public virtual bool CanInteract()
	{
		return IsBelongWorld();
	}

	protected virtual bool AllowTriggerEnter(MonoECS.ControlType controlType)
	{
		return controlType != MonoECS.ControlType.OreCar;
	}

	public virtual ShowType GetInteractBtnShowType()
	{
		return ShowType.Show;
	}

	protected void ApplyTheOtherWorldLogic()
	{
		StateWorldAssetData stateWorldAssetData = entity.GetCompStateObject().StateWorldAssetData;
		if (stateWorldAssetData.theOtherWorldOwnerShip == TheOtherWorldModel.TheOtherWorldOwnerShip.Both)
		{
			return;
		}
		int layer = ((!Model<TheOtherWorldModel>.Interface.IsBelongWorld(stateWorldAssetData.theOtherWorldOwnerShip)) ? 2 : 0);
		_collectColliders = new List<Collider>();
		gameObject.GetComponentsInChildren(includeInactive: true, _collectColliders);
		foreach (Collider collectCollider in _collectColliders)
		{
			int layer2 = collectCollider.gameObject.layer;
			if (!collectCollider.isTrigger && layer2 == 0)
			{
				collectCollider.gameObject.layer = layer;
			}
		}
	}

	public void RefreshOtherWorldLogic()
	{
		StateWorldAssetData stateWorldAssetData = entity.GetCompStateObject().StateWorldAssetData;
		int num = ((!Model<TheOtherWorldModel>.Interface.IsBelongWorld(stateWorldAssetData.theOtherWorldOwnerShip) && !Model<TheOtherWorldModel>.Interface.ActiveFollowClairvoyance) ? 2 : 0);
		foreach (Collider collectCollider in _collectColliders)
		{
			int layer = collectCollider.gameObject.layer;
			if (!collectCollider.isTrigger)
			{
				GameObject gameObject = collectCollider.gameObject;
				int layer2 = ((layer != 0 && layer != 2) ? collectCollider.gameObject.layer : num);
				gameObject.layer = layer2;
			}
		}
	}

	public virtual bool IsBelongWorld()
	{
		StateWorldAssetData stateWorldAssetData = entity.GetCompStateObject().StateWorldAssetData;
		if (!Model<TheOtherWorldModel>.Interface.ActiveFollowClairvoyance)
		{
			return Model<TheOtherWorldModel>.Interface.IsBelongWorld(stateWorldAssetData.theOtherWorldOwnerShip);
		}
		return true;
	}
}
