using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("设置怪物当前是否可以攻击仇恨目标,result==true表示可以攻击，result的值取决于设置之前的条件判断，这里只是设置值， 永远返回成功")]
public class SetWhetherCanAttackHatredTarget : Action
{
	public SharedBool result;

	public override TaskStatus OnUpdate()
	{
		_ = ((ActBehaviorTree)Owner).Entity;
		return TaskStatus.Success;
	}
}
