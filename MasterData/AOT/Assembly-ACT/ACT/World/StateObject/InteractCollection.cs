using System;
using System.Linq;
using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.Initialize;
using ACT.UI;
using ACT.World.Actions;
using ACT.World.Asset;
using ACT.World.Behave;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Sirenix.Utilities;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractCollection")]
public class InteractCollection : StateObjectBase
{
	[NonSerialized]
	public CollectionBehaveEvents collection;

	private CollectionPointData _data;

	[SerializeField]
	private YooAssetReference _attackTipAsset;

	private AssetLoadHandle _attackTipHandle;

	private AttackCollectionTip _attackCollectionTip;

	private Bounds _tipBounds;

	private bool _tipShouldBeActive;

	private bool _tipIsShowing;

	private const int UnLocking = 4;

	private InteractEntry _mEntry;

	private int m_BehaveId;

	private AssetLoadHandle m_Handle;

	private static readonly int onceObjectId = 33;

	public CollectionPointData Data => _data;

	public override bool serviceSave => true;

	protected InteractEntry entry
	{
		get
		{
			return _mEntry;
		}
		set
		{
			_mEntry = value;
			CustomUi?.Init(entity, _mEntry);
		}
	}

	protected int behaveId
	{
		get
		{
			return m_BehaveId;
		}
		set
		{
			if (m_BehaveId != value)
			{
				m_BehaveId = value;
				if (entry != null)
				{
					entry.HandleUninit();
					entry = null;
				}
				if (AssetLoadHandleExtensions.IsValid(m_Handle))
				{
					AssetStationManager.BattleStation.ReleaseInstance(m_Handle);
					m_Handle = default;
					collection = null;
				}
				m_Handle = AssetStationManager.BattleStation.InstantiateAsync("StateObjectBehave/" + RuntimeConfigs.data.collections[value].address, transform, instantiateInWorldSpace: false, (AssetLoadHandle result) =>
				{
					OnHandleOnCompleted(result.AsGameObject());
				});
			}
		}
	}

	private void OnHandleOnCompleted(GameObject handle)
	{
		collection = handle.GetComponentInChildren<CollectionBehaveEvents>();
		collection.interactCollection = this;
		collection.InitModelRotate();
		if (collection.customBoxCollider != null)
		{
			BoxCollider component = GetComponent<BoxCollider>();
			component.size = collection.customBoxCollider.size;
			component.center = collection.customBoxCollider.center;
		}
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (compStateObject?.StateWorldAssetData is CollectionPointData collectionPointData)
		{
			_data = collectionPointData;
			entry = collection.entry;
			if (!collectionPointData.useMiniGame)
			{
				InteractEntry interactEntry = entry;
				interactEntry.onInteract = (Action<Entity>)Delegate.Combine(interactEntry.onInteract, new Action<Entity>(collection.OnInteract));
			}
			entry.BindInteractObjectBase(this);
			entry.BindData(compStateObject.StateWorldAssetData);
			entry.BindInteractState(0, 0);
			if (collection.interactType == InteractType.Attack)
			{
				AttackCollectionBehaveEvents attackCollectionBehaveEvents = collection as AttackCollectionBehaveEvents;
				int attackableId = ((RuntimeConfigs.data.collections[behaveId].entityNeutralID != 0) ? RuntimeConfigs.data.collections[behaveId].entityNeutralID : entry.AttackableId);
				InteractEntry.ResetAttackEntry(entry, in attackableId, in attackCollectionBehaveEvents.abilities, in attackCollectionBehaveEvents.alliance, in attackCollectionBehaveEvents.size, in attackCollectionBehaveEvents.posOffset);
				InteractEntry interactEntry2 = entry;
				interactEntry2.onHPChangeInteract = (Action<int, int>)Delegate.Combine(interactEntry2.onHPChangeInteract, new Action<int, int>(attackCollectionBehaveEvents.OnHited));
				InteractEntry interactEntry3 = entry;
				interactEntry3.onComboChallengeInteract = (Action<int>)Delegate.Combine(interactEntry3.onComboChallengeInteract, new Action<int>(attackCollectionBehaveEvents.OnCombo));
				InteractEntry interactEntry4 = entry;
				interactEntry4.onSpawnAttackable = (Action<Entity>)Delegate.Combine(interactEntry4.onSpawnAttackable, new Action<Entity>(OnAttackableSpawn));
				InteractEntry interactEntry5 = entry;
				interactEntry5.onSpawnAttackable = (Action<Entity>)Delegate.Combine(interactEntry5.onSpawnAttackable, new Action<Entity>(collection.OnSpawnAttackable));
			}
			else if (collection.interactType == InteractType.TriggerEnter)
			{
				entry.ResetInteractType(InteractType.TriggerEnter);
			}
			else
			{
				entry.ResetInteractType(InteractType.Button);
				entry.OpenBoxAni = collection.openBoxAni;
			}
			InteractEntryLoaded evt = Singleton<EventManager>.instance.GetEvt<InteractEntryLoaded>();
			evt.Entry = entry;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.InteractEntry_Loaded, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	protected void UpdateBehaveId(int previousValue, int newValue)
	{
		behaveId = newValue;
	}

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		behaveId = compStateObject.BehaveId;
		compStateObject.BehaveIdChangeEvent += UpdateBehaveId;
		_data = (CollectionPointData)compStateObject.StateWorldAssetData;
		if (LuminRuntimeInitializer.GameLoader.mode == GameLoader.GameMode.ConfigSave && RuntimeConfigs.data.collectionPoints.TryGetValue(_data.collectionPointId, out var value))
		{
			int newValue = value.collectionId.FirstOrDefault()?.id ?? 0;
			UpdateBehaveId(0, newValue);
		}
		if (_data.ShowAttackTip)
		{
			if (_attackTipAsset != null && _attackTipAsset.RuntimeKeyIsValid())
			{
				_attackTipHandle = AssetStationManager.BattleStation.Instantiate(_attackTipAsset, transform);
				_attackTipHandle.AsGameObject().transform.position = _data.TipPos;
				_attackCollectionTip = _attackTipHandle.AsGameObject().GetComponent<AttackCollectionTip>();
				_attackCollectionTip.ForceReset();
			}
			MixedBox tipFiled = _data.TipFiled;
			Vector3 center = transform.position + tipFiled.localPos + tipFiled.center;
			_tipBounds = new Bounds(center, tipFiled.size);
		}
		base.InitStateObject(stateId);
		if (stateId == 4)
		{
			NetEnterState(0).Forget();
		}
	}

	public override void ReleaseStateObject()
	{
		base.ReleaseStateObject();
		if (_data.ShowAttackTip && _attackTipHandle.IsValid)
		{
			_tipShouldBeActive = false;
			_tipIsShowing = false;
			_attackCollectionTip = null;
			AssetStationManager.BattleStation.ReleaseInstance(_attackTipHandle);
		}
		entity.GetCompStateObject().BehaveIdChangeEvent -= UpdateBehaveId;
		Singleton<DropItemManager>.instance.CleanupCollectionDrop(swid);
		AssetStationManager.BattleStation.ReleaseInstance(m_Handle);
	}

	public override async void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (currentStateId != 0 || entryIndex != 0)
		{
			return;
		}
		if (entry == null)
		{
			await UniTask.WaitUntil(() => entry != null);
		}
		entry.HandleInteract(eb, InteractAction.InteractSource.Player);
	}

	protected override async void HandleEnterInteract()
	{
		if (currentStateId != 0)
		{
			return;
		}
		if (entry == null)
		{
			await UniTask.WaitUntil(() => entry != null);
		}
		entry.HandleEnter();
	}

	protected override async void HandleExitInteract()
	{
		if (currentStateId != 0)
		{
			return;
		}
		if (entry == null)
		{
			await UniTask.WaitUntil(() => entry != null);
		}
		entry.HandleExit();
	}

	protected override async void HandleInitState(int stateId)
	{
		if (collection == null)
		{
			await UniTask.WaitUntil(() => collection != null);
		}
		switch (stateId)
		{
		case 0:
			collection.Close();
			entry.HandleInit();
			SetOnceObjectInitState(active: true);
			break;
		case 1:
			collection.Open();
			SetOnceObjectInitState(active: false);
			break;
		case 2:
			collection.Break();
			SetOnceObjectInitState(active: false);
			break;
		case 3:
			collection.Close();
			entry.HandleUninit();
			break;
		case -2:
		case -1:
			collection.Hide();
			SetOnceObjectInitState(active: false);
			break;
		case -4:
			collection.Lock();
			SetOnceObjectInitState(active: false);
			break;
		case -5:
			SetOnceObjectInitState(active: false);
			break;
		}
		if (_data.ShowAttackTip && _attackCollectionTip != null)
		{
			_tipShouldBeActive = stateId == 0;
			if (!_tipShouldBeActive && _tipIsShowing)
			{
				_attackCollectionTip.UnInit();
				_tipIsShowing = false;
			}
		}
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		if (!collection)
		{
			return;
		}
		if (fromStateId == -4 && (toStateId == 4 || toStateId == 0))
		{
			if (_data.showUnlockTimeline)
			{
				if (toStateId == 4)
				{
					collection.Unlock();
				}
				collection.UnlockAnimation(destroyCancellationToken);
			}
		}
		else if (fromStateId == -1 && toStateId == 0)
		{
			collection.ShowAnimation(destroyCancellationToken);
		}
	}

	private void Update()
	{
		if (_tipShouldBeActive && !(_attackCollectionTip == null) && !(MonoECS.instance == null) && MonoECS.instance.mainEntity.IsLogicAvailable())
		{
			Vector3 physicsPosition = MonoECS.instance.mainEntity.GetCompTransform().physicsPosition;
			bool flag = _tipBounds.Contains(physicsPosition);
			if (flag && !_tipIsShowing)
			{
				_attackCollectionTip.Init();
				_tipIsShowing = true;
			}
			else if (!flag && _tipIsShowing)
			{
				_attackCollectionTip.UnInit();
				_tipIsShowing = false;
			}
		}
	}

	protected override async void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
		if (currentStateId != 0)
		{
			return;
		}
		if (entry == null)
		{
			await UniTask.WaitUntil(() => entry != null);
		}
		entry?.HandleUninit();
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (-5 <= stateId)
		{
			return stateId <= 4;
		}
		return false;
	}

	protected void OnAttackableSpawn(Entity behave)
	{
		CollectionPointData collectionPointData = behave.GetCompStateObject().StateWorldAssetData as CollectionPointData;
		if (!collectionPointData.abilities.IsNullOrEmpty())
		{
			behave.GetCompAbility().AddAbilities(collectionPointData.abilities, AbilitySource.Ability);
		}
	}

	protected void SetOnceObjectInitState(bool active)
	{
		if (behaveId == onceObjectId && collection != null)
		{
			collection.SetColliderEnable(active);
		}
	}

	protected override bool NeedInteractTip()
	{
		if (!base.NeedInteractTip())
		{
			return currentStateId == 0;
		}
		return true;
	}

	protected override InteractEntry GetInteractEntry()
	{
		return entry;
	}

	public override int GetInteractId()
	{
		if (currentStateId == 0)
		{
			return GetInteractEntry()?.TipIcon ?? (-1);
		}
		return -1;
	}
}
