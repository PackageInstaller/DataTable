using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行携带", "Action", new string[] { "carry", "move", "movement", "position", "velocity" })]
public class ActionCarry : ConfigAction
{
	public bool open;

	public ConfigFunction<Transform> carryCenter;

	public ConfigFunction<Vector3> carryOffest;

	public override void Do(ActionMemory memory)
	{
		if (open)
		{
			if (carryCenter == null || carryOffest == null)
			{
				_ = LuminApplication.LogEnabled;
				return;
			}
			if (memory.target.entity.GetCompTransform().IsBeCarryed())
			{
				_ = LuminApplication.LogEnabled;
				return;
			}
			ActionMemory memory2 = new ActionMemory(memory.owner, memory.owner, memory.owner, memory.evt, memory.ability);
			Transform transform = carryCenter.Return(memory2);
			Vector3 carryoffset = carryOffest.Return(memory2);
			Transform transform2 = memory.target.entity.GetMono().GetAttachPointAll(BattleConsts.AIM_ATTACH_POINT).transform;
			memory.owner.GetCompAbility().AddCarryTarget(memory.target.entity, transform, carryoffset, transform2);
		}
		else
		{
			memory.owner.GetCompAbility().ClearCarryed();
		}
	}
}
