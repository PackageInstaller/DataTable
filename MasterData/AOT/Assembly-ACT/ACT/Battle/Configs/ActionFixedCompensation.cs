using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行固定Compensation", "Action", new string[] { "fixed", "compensation" })]
public class ActionFixedCompensation : ActionCompensation
{
	public ConfigFunction<Vector3> compensation;

	[Tooltip("补偿覆盖不会做")]
	public ConfigAction[] onComplete;

	public override void Do(ActionMemory memory)
	{
		config.DoCompensation(compensation.Return(memory) - memory.target.entity.GetCompTransform().physicsPosition, memory.target.entity, () =>
		{
			if (onComplete != null)
			{
				ConfigAction[] array = onComplete;
				for (int i = 0; i < array.Length; i++)
				{
					array[i].CheckDo(memory);
				}
			}
		});
	}
}
