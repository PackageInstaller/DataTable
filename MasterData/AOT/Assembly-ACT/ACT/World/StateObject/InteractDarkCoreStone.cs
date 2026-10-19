using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.World.Actions;
using ACT.World.Asset;
using ACT.World.Behave;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractDarkCoreStone")]
public class InteractDarkCoreStone : StateObjectBase
{
	public DarkCoreStoneBehaveEvents stone;

	private DarkCoreStoneData m_Data;

	private List<StoneStopInfo> stopInfos;

	[NonSerialized]
	public PushImpetusData pushImpetusConfig;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is DarkCoreStoneData data)
		{
			m_Data = data;
			stopInfos = m_Data.stopInfos;
			pushImpetusConfig = m_Data.pushImpetusConfig;
			stone.OnInit(stateId);
			base.InitStateObject(stateId);
		}
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (0 <= stateId)
		{
			return stateId <= 2;
		}
		return false;
	}

	protected override void HandleInitState(int stateId)
	{
		if (currentStateId < 2)
		{
			stone.aimIndex = currentStateId;
		}
		if (currentStateId == 2 && stone.phase == 0)
		{
			stone.Hide();
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
		if (currentStateId == 2 && stone.phase == 0)
		{
			stone.Show();
		}
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}

	protected override void HandleEnterInteract()
	{
	}

	protected override void HandleExitInteract()
	{
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}
}
