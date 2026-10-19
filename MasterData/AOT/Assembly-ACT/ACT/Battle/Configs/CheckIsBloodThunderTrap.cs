using ACT.World.Asset;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

public class CheckIsBloodThunderTrap : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		CompStateObject compStateObject = memory.target.entity.GetCompStateObject();
		if (compStateObject != null)
		{
			return compStateObject.StateWorldAssetData is BloodThunderTrapData;
		}
		return false;
	}
}
