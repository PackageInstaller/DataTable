using System;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行帧停顿", "Action", new string[] { "frame", "halt" })]
public class ActionFrameHalt : ConfigAction
{
	public float duration;

	public float airDuration;

	public float speed;

	public bool isNoHituseExtraDuration;

	public float noHituseExtraDuration;

	public override void Do(ActionMemory memory)
	{
		float num = duration;
		Entity entity = memory.target.entity;
		CompPhysics compPhysics = entity.GetCompPhysics();
		if (compPhysics == null)
		{
			return;
		}
		CompAbility compAbility = entity.GetCompAbility();
		if (compAbility == null || entity.IsDummy())
		{
			return;
		}
		if (compPhysics != null && compPhysics.groundDistance > 0.5f)
		{
			num = ((airDuration == 0f) ? duration : airDuration);
		}
		if (num > 0f && compAbility.tenacityValue > 0 && isNoHituseExtraDuration)
		{
			num = noHituseExtraDuration;
		}
		num = Math.Max(num - compAbility.GetProperty(16u).value, 0f);
		if (num > 0f)
		{
			if (memory.target.entity.IsMonster() && compAbility.hp <= 0)
			{
				memory.target.entity.ApplyFrameHalt(num, MathF.Max(speed, 0.01f));
			}
			else
			{
				memory.target.entity.ApplyFrameHalt(num, speed);
			}
		}
		else
		{
			memory.target.entity.ApplyFrameHalt(0.01f, 0f);
		}
	}
}
