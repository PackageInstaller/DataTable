using System;
using ACT.Battle;
using ACT.Config;
using ACT.Event;
using ACT.Model;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractRaidCollector")]
public class InteractRaidCollection : StateObjectBase
{
	public InteractEntry entry;

	private Animator m_animator;

	protected bool m_isOption;

	protected bool m_isInInteract;

	private int m_BehaveId;

	private AssetLoadHandle m_Handle;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (compStateObject?.StateWorldAssetData is RaidCollectionData raidCollectionData)
		{
			ResetEntryInteractType(entry, InteractType.TriggerEnter);
			m_isInInteract = false;
			m_isOption = false;
			InteractEntry interactEntry = entry;
			interactEntry.onInteract = (Action<Entity>)Delegate.Combine(interactEntry.onInteract, new Action<Entity>(OnInteract));
			entry.BindInteractObjectBase(this);
			entry.BindData(compStateObject.StateWorldAssetData);
			entry.BindInteractState(0, 1);
			m_Handle = AssetStationManager.BattleStation.Instantiate(raidCollectionData.modelAssetID, transform);
			m_Handle.Completed += (AssetLoadHandle x) =>
			{
				m_animator = m_Handle.AsGameObject().GetComponentInChildren<Animator>();
				m_animator?.SetInteger("state", stateId);
			};
			base.InitStateObject(stateId);
		}
	}

	public override void ReleaseStateObject()
	{
		base.ReleaseStateObject();
		AssetStationManager.BattleStation.ReleaseInstance(m_Handle);
	}

	public virtual void OnInteract(Entity eb)
	{
		if (!m_isInInteract)
		{
			NetEnterState(1);
		}
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		entry.HandleInteract(eb, InteractAction.InteractSource.Player);
	}

	protected override void HandleEnterInteract()
	{
		if (currentStateId == 0)
		{
			entry.HandleEnter();
		}
	}

	protected override void HandleExitInteract()
	{
		if (currentStateId == 0)
		{
			entry.HandleExit();
		}
	}

	protected override void HandleInitState(int stateId)
	{
		m_animator?.SetInteger("state", stateId);
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		m_animator?.SetInteger("state", toStateId);
		if (fromStateId == 0 && toStateId == 1)
		{
			RaidCollectInfoChangeEvt evt = Singleton<EventManager>.instance.GetEvt<RaidCollectInfoChangeEvt>();
			evt.collectCount = MonoECS.instance.ruleManager.GetStateWorldAssetInStateNumberByTag(ServiceSaveTag.RaidCollection, 1);
			Model<RaidModel>.Interface.CollectInfoNum = evt.collectCount;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.RaidCollectInfoChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		if (currentStateId == 0)
		{
			entry.HandleUninit();
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (0 <= stateId)
		{
			return stateId <= 1;
		}
		return false;
	}
}
