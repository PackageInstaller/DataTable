using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskDescription("填一个0-1的值，表示有多少概率返回成功")]
public class RandomCondition : Conditional
{
	public SharedFloat arg;

	public override void OnStart()
	{
		arg = Mathf.Abs(arg.Value);
		while (arg.Value > 1f)
		{
			arg.Value /= 10f;
		}
	}

	public override TaskStatus OnUpdate()
	{
		float num = arg.Value * 100f;
		float num2 = (1f - arg.Value) * 100f;
		float num3 = Random.Range(0f, 100f);
		if (num3 <= num)
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
