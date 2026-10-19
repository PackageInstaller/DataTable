using ACT.Battle;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Fundamental;

namespace ACT.World.StateObject;

public class InteractBreakChallengePoint : InteractObject
{
	private BreakChallengePointData _data;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is BreakChallengePointData data)
		{
			_data = data;
			base.InitStateObject(stateId);
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId != 0 && stateId != 1)
		{
			return stateId == 2;
		}
		return true;
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (currentStateId == 0)
		{
			Singleton<BreakChallengeManager>.instance.StartChallenge(_data.BreakChallengeConfigId, transform);
		}
	}
}
