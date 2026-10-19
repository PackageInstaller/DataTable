using ACT.Core;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断状态对象状态", "Predicate", new string[] { "check", "state", "object", "status", "tag", "predicate", "condition" })]
public class CheckStateObjectStatePredicate : ConfigPredicate
{
	public int state;

	public override bool Check(ActionMemory memory)
	{
		int stateWorldAssetUid = memory.owner.GetCompStateObject().StateWorldAssetData.stateWorldAssetUid;
		if (CoreUtils.TryGetServiceSaveStateId(Singleton<GameManager>.instance.worldManager.ActiveWorldId, stateWorldAssetUid, out var stateId))
		{
			return stateId == state;
		}
		return false;
	}
}
