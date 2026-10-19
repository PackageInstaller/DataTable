using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/待定要好好想想的")]
[TaskDescription("判断仇恨目标的当前状态是否是特定状态类型参数中给定若干个状态类型，判断当前的状态类型 是否与 给定的若干个状态类型中的其中一个相等，相等返回结果True，不相等结果返回False , inverser=True表示将结果取反，即 不相等返回True，相等返回False")]
public class CheckHatredStates : Conditional
{
	public MotionState[] states;

	public bool inverser;

	public override TaskStatus OnUpdate()
	{
		Entity hatredTarget = ((ActBehaviorTree)Owner).Entity.GetCompHatred().hatredTarget;
		if (!hatredTarget.IsValid)
		{
			return TaskStatus.Failure;
		}
		MotionState curMotionState = hatredTarget.GetCompMotion().curMotionState;
		int num = states.Length;
		bool flag = false;
		for (int i = 0; i < num; i++)
		{
			if (curMotionState == states[i])
			{
				flag = true;
				break;
			}
		}
		if (flag == inverser)
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
