using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/\ufffd\ufffd\ufffd\ufffdҪ\ufffdú\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd")]
[TaskDescription("\ufffd\ufffd\ufffd\ufffd\ufffdи\ufffd\ufffd\ufffd\ufffd\ufffd\ufffdɸ\ufffd״\u032c\ufffd\ufffd\ufffd\u0363\ufffd\ufffdжϵ\ufffdǰ\ufffd\ufffd״\u032c\ufffd\ufffd\ufffd\ufffd \ufffdǷ\ufffd\ufffd\ufffd \ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffdɸ\ufffd״\u032c\ufffd\ufffd\ufffd\ufffd\ufffdе\ufffd\ufffd\ufffd\ufffd\ufffdһ\ufffd\ufffd\ufffd\ufffdȣ\ufffd\ufffd\ufffdȷ\ufffd\ufffdؽ\ufffd\ufffdTrue\ufffd\ufffd\ufffd\ufffd\ufffd\ufffdȽ\ufffd\ufffd\ufffd\ufffd\ufffd\ufffdFalse , inverser=True\ufffd\ufffdʾ\ufffd\ufffd\ufffd\ufffd\ufffdȡ\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd \ufffd\ufffd\ufffd\ufffdȷ\ufffd\ufffd\ufffdTrue\ufffd\ufffd\ufffd\ufffdȷ\ufffd\ufffd\ufffdFalse")]
public class CheckMotionState : Conditional
{
	public MotionState[] states;

	public bool inverser;

	public override TaskStatus OnUpdate()
	{
		MotionState curMotionState = ((ActBehaviorTree)Owner).Entity.GetCompMotion().curMotionState;
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
