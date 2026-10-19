using System;
using ACT.Battle;
using ACT.Core;
using ACT.World.Behave;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractCollectionGem : InteractCollection
{
	[Tooltip("lockState的攻击Entry")]
	private InteractEntry _lockStateEntry;

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		behaveId = compStateObject.BehaveId;
		compStateObject.BehaveIdChangeEvent += UpdateBehaveId;
		entry = collection.entry;
		InteractEntry interactEntry = entry;
		interactEntry.onInteract = (Action<Entity>)Delegate.Combine(interactEntry.onInteract, new Action<Entity>(collection.OnInteract));
		entry.BindInteractObjectBase(this);
		entry.BindData(compStateObject.StateWorldAssetData);
		entry.BindInteractState(0, 0);
		CollectionGemBehaveEvents collectionGemBehaveEvents = collection as CollectionGemBehaveEvents;
		InteractEntry.ResetAttackEntry(entry, in RuntimeConfigs.data.collections[behaveId].entityNeutralID, in collectionGemBehaveEvents.abilities, in collectionGemBehaveEvents.alliance, in collectionGemBehaveEvents.size, in collectionGemBehaveEvents.posOffset);
		InteractEntry interactEntry2 = entry;
		interactEntry2.onHPChangeInteract = (Action<int, int>)Delegate.Combine(interactEntry2.onHPChangeInteract, new Action<int, int>(collectionGemBehaveEvents.OnHited));
		InteractEntry interactEntry3 = entry;
		interactEntry3.onSpawnAttackable = (Action<Entity>)Delegate.Combine(interactEntry3.onSpawnAttackable, new Action<Entity>(OnAttackableSpawn));
		InteractEntry interactEntry4 = entry;
		interactEntry4.onSpawnAttackable = (Action<Entity>)Delegate.Combine(interactEntry4.onSpawnAttackable, new Action<Entity>(collection.OnSpawnAttackable));
		_lockStateEntry = InteractEntry.CreateAttackEntry(in RuntimeConfigs.data.collections[behaveId].entityNeutralID, in collectionGemBehaveEvents.lockStateAbilities, in collectionGemBehaveEvents.alliance, in collectionGemBehaveEvents.size, in collectionGemBehaveEvents.posOffset);
		_lockStateEntry.BindInteractObjectBase(this);
		_lockStateEntry.BindData(compStateObject.StateWorldAssetData);
		_lockStateEntry.BindInteractState(3, 0);
		InteractEntry lockStateEntry = _lockStateEntry;
		lockStateEntry.onHPChangeInteract = (Action<int, int>)Delegate.Combine(lockStateEntry.onHPChangeInteract, new Action<int, int>(collectionGemBehaveEvents.OnHited));
		InteractEntry lockStateEntry2 = _lockStateEntry;
		lockStateEntry2.onSpawnAttackable = (Action<Entity>)Delegate.Combine(lockStateEntry2.onSpawnAttackable, new Action<Entity>(OnAttackableSpawn));
		InteractEntry lockStateEntry3 = _lockStateEntry;
		lockStateEntry3.onSpawnAttackable = (Action<Entity>)Delegate.Combine(lockStateEntry3.onSpawnAttackable, new Action<Entity>(collection.OnSpawnAttackable));
		if (gameObject.activeInHierarchy && LuminApplication.LogEnabled)
		{
			Debug.LogWarning(gameObject.name + ",交互物prefab配置不设置active为false存在风险", gameObject);
		}
		gameObject.SetActive(value: true);
		EnterState(stateId);
	}

	protected override void HandleInitState(int stateId)
	{
		base.HandleInitState(stateId);
		if (currentStateId == 3)
		{
			_lockStateEntry.HandleInit();
			SetOnceObjectInitState(active: true);
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
		switch (currentStateId)
		{
		case 0:
			entry.HandleUninit();
			break;
		case 3:
			_lockStateEntry.HandleUninit();
			break;
		}
	}

	public void SetGemLock(bool b)
	{
		if (b && currentStateId == 0)
		{
			NetEnterState(3).Forget();
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("锁住宝石");
			}
		}
		else if (!b && currentStateId == 3)
		{
			EnterState(0);
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("解锁宝石");
			}
		}
		(collection as CollectionGemBehaveEvents).SetGemLock(b);
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (-4 <= stateId)
		{
			return stateId <= 3;
		}
		return false;
	}

	protected override InteractEntry GetInteractEntry()
	{
		return entry;
	}
}
