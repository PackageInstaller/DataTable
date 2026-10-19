using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断碰撞", "Predicate", new string[] { "check", "collision", "predicate", "condition" })]
public class CheckCollisionPredicate : ConfigPredicate
{
	public ConfigFunction<Vector3> start;

	public ConfigFunction<Vector3> end;

	public override bool Check(ActionMemory memory)
	{
		Vector3 vector = start.Return(memory);
		Vector3 direction = end.Return(new ActionMemory(memory.caster, memory.target.entity, memory.target, memory.evt, memory.ability)) - vector;
		return !Physics.Raycast(vector, direction, direction.magnitude, BattleConsts.enviromentMask);
	}
}
