using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断地面Valid", "Predicate", new string[] { "check", "ground", "valid", "vector", "position", "rotation", "quaternion", "predicate", "condition" })]
public class CheckGroundValidPredicate : ConfigPredicate
{
	public ConfigFunction<Vector3> startPos;

	public float distance = 10f;

	public override bool Check(ActionMemory memory)
	{
		Vector3 origin = startPos.Return(memory);
		Vector3 down = Vector3.down;
		if (Physics.Raycast(new Ray(origin, down), out var _, distance, BattleConsts.enviromentMask))
		{
			return true;
		}
		return false;
	}
}
