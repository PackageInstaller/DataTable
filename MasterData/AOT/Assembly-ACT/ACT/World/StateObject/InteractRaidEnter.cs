using System;
using ACT.Battle;
using ACT.UI;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractRaidEnter")]
public class InteractRaidEnter : StateObjectBase
{
	public InteractEntry entry;

	private RaidEnterData _data;

	private AssetLoadHandle m_Handle;

	private Animator modelAni;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (compStateObject?.StateWorldAssetData is RaidEnterData raidEnterData)
		{
			_data = raidEnterData;
			ResetEntryInteractType(entry, InteractType.Button);
			InteractEntry interactEntry = entry;
			interactEntry.onInteract = (Action<Entity>)Delegate.Combine(interactEntry.onInteract, new Action<Entity>(OnInteract));
			entry.BindInteractObjectBase(this);
			entry.BindData(compStateObject.StateWorldAssetData);
			entry.BindInteractState(stateId, 0);
			m_Handle = AssetStationManager.BattleStation.Instantiate(raidEnterData.modelAssetID, transform);
			modelAni = m_Handle.AsGameObject().GetComponent<Animator>();
			base.InitStateObject(stateId);
		}
	}

	public override void ReleaseStateObject()
	{
		base.ReleaseStateObject();
		AssetStationManager.BattleStation.ReleaseInstance(m_Handle);
	}

	private void OnInteract(Entity eb)
	{
		if (currentStateId == 0)
		{
			NetEnterState(1);
			return;
		}
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_RAID, new MonoRaidViewData
		{
			RaidEntranceId = _data.id
		});
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (currentStateId == 0 || currentStateId == 1)
		{
			entry.HandleInteract(eb, InteractAction.InteractSource.Player);
		}
	}

	protected override void HandleEnterInteract()
	{
		switch (currentStateId)
		{
		case 0:
			entry.HandleEnter();
			break;
		case 1:
			entry.HandleEnter();
			break;
		}
	}

	protected override void HandleExitInteract()
	{
		switch (currentStateId)
		{
		case 0:
			entry.HandleExit();
			break;
		case 1:
			entry.HandleExit();
			break;
		}
	}

	public void SetMondel(int stateId)
	{
		if (modelAni != null)
		{
			modelAni.SetInteger("state", stateId);
		}
	}

	protected override void HandleInitState(int stateId)
	{
		switch (currentStateId)
		{
		case 0:
			entry.HandleInit();
			break;
		case 1:
			entry.HandleInit();
			break;
		}
		entry.BindInteractState(stateId, 0);
		SetMondel(stateId);
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
		switch (currentStateId)
		{
		case 0:
			entry.HandleUninit();
			break;
		case 1:
			entry.HandleUninit();
			break;
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (-4 <= stateId)
		{
			return stateId <= 1;
		}
		return false;
	}

	protected override InteractEntry GetInteractEntry()
	{
		return entry;
	}
}
