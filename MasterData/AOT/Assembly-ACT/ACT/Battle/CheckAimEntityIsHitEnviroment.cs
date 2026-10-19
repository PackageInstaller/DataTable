using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待定要好好想想的")]
[TaskDescription("Entity的某个AttachPoint点 和仇恨目标之间是否与周围的环境有碰撞，检测到碰撞或者是悬空就返回false，否则返回success")]
public class CheckAimEntityIsHitEnviroment : Conditional
{
	public const string AimAttach = "waist";

	public string AimFirePoint = "muzzle";

	public override TaskStatus OnUpdate()
	{
		Entity entity = ((ActBehaviorTree)Owner).Entity;
		if (!entity.GetMono().TryGetAttachPoint(AimFirePoint, out var attackPoint))
		{
			return TaskStatus.Failure;
		}
		Entity hatredTarget = entity.GetCompHatred().hatredTarget;
		if (hatredTarget.IsValid)
		{
			if (!hatredTarget.GetMono().TryGetAttachPoint("waist", out var attackPoint2))
			{
				return TaskStatus.Failure;
			}
			if (Physics.Linecast(attackPoint.position, attackPoint2.position, out var _, BattleConsts.enviromentMask))
			{
				return TaskStatus.Failure;
			}
			Debug.DrawLine(attackPoint.position, attackPoint2.position);
		}
		return TaskStatus.Success;
	}
}
