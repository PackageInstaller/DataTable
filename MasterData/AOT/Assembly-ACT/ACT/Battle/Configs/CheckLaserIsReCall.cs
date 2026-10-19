using ACT.World.Asset;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断Laser重新Call", "Predicate", new string[] { "check", "laser", "is", "re", "call", "predicate", "condition" })]
public class CheckLaserIsReCall : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		if (!memory.owner.TryGetCompStateObject(out CompStateObject component))
		{
			return false;
		}
		StateWorldAssetData stateWorldAssetData = component.StateWorldAssetData;
		if (!(stateWorldAssetData is LaserData { isReCall: var isReCall }))
		{
			if (stateWorldAssetData is BlackMixLaserData)
			{
				return true;
			}
			return false;
		}
		return isReCall;
	}
}
