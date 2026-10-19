using ACT.Battle;
using ACT.BluePrint;
using ACT.Event;
using ACT.Model;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractChallengePoint : InteractObject
{
	private ChallengePointData m_Data;

	private GameObject bpLoadHandle;

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is ChallengePointData data)
		{
			m_Data = data;
			base.InitStateObject(stateId);
		}
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		bpLoadHandle = BPCommon.CreateBpAsset(m_Data.bpAssetAssetID, transform);
		base.Interact(entryIndex, eb, interactSource);
	}

	public override void ReleaseStateObject()
	{
		if (bpLoadHandle != null)
		{
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.ChallengeExit, null);
		}
		Model<BigWorldChallengeProgressModel>.Interface.isInBigWorld = false;
		base.ReleaseStateObject();
	}

	public override ShowType GetInteractBtnShowType()
	{
		if (!Singleton<ProtagonistManager>.instance.IsProtagonist)
		{
			return ShowType.Show;
		}
		return ShowType.Hide;
	}

	public override bool ShowInteractTip()
	{
		return !Singleton<ProtagonistManager>.instance.IsProtagonist;
	}

	public override bool CanInteract()
	{
		if (!Singleton<ProtagonistManager>.instance.IsProtagonist)
		{
			return base.CanInteract();
		}
		return false;
	}
}
