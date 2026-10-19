using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置相对位置", "Action", new string[] { "set", "relative", "pos", "move", "movement", "position", "velocity" })]
public class ActionSetRelativePos : ConfigAction
{
	public float dis;

	public bool attackePriMove;

	[HideInInspector]
	public TargetBounds bounds;

	[HideInInspector]
	public WhereTargets where;

	private (RaycastHit, Vector3) CheckHit(Entity character, Vector3 from, Vector3 to)
	{
		Vector3 vector = to - from;
		float magnitude = vector.magnitude;
		vector /= magnitude;
		return (PhysicsUtility.CapsuleCast(from, character.GetCompTransform().size, vector, magnitude), vector);
	}

	public override void Do(ActionMemory memory)
	{
		if (memory.evt is IGetAttackData getAttackData)
		{
			Entity caster = memory.caster;
			_ = memory.target.entity;
			Entity entity;
			if (attackePriMove)
			{
				entity = getAttackData.GetAttackData().attacker;
				_ = getAttackData.GetAttackData().attackee;
			}
			else
			{
				entity = getAttackData.GetAttackData().attackee;
				_ = getAttackData.GetAttackData().attacker;
			}
			entity.SetFaceLeft(!caster.IsFaceLeft());
			entity.GetCompPhysics().SetDirImmediately();
		}
	}
}
