using ACT.World.Asset;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取史莱姆头部位置", "Function", new string[] { "slime", "head", "pos", "vector", "position", "rotation", "quaternion" })]
public class FunctionSlimeHeadPos : ConfigFunction<Vector3>
{
	protected override Vector3 Evaluate(ActionMemory memory)
	{
		SlimeMouldData slimeMouldData = (SlimeMouldData)memory.owner.GetCompStateObject().StateWorldAssetData;
		SlimeMouldGroupData[] array = slimeMouldData?.SlimeMouldGroups;
		if (array != null && array.Length > 0)
		{
			return slimeMouldData.SlimeMouldGroups[0].ModelPos[0].value;
		}
		return default;
	}
}
