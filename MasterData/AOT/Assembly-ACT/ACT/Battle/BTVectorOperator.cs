using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT")]
[TaskDescription("V3计算")]
public class BTVectorOperator : Action
{
	public enum Operation
	{
		Add,
		Subtract
	}

	public Operation operation;

	public SharedVector3 vector1;

	public SharedVector3 vector2;

	public SharedVector3 resultVector;

	public override void OnReset()
	{
		operation = Operation.Add;
		vector1 = new SharedVector3();
		vector2 = new SharedVector3();
		resultVector = new SharedVector3();
	}

	public override TaskStatus OnUpdate()
	{
		switch (operation)
		{
		case Operation.Add:
			resultVector.Value = vector1.Value + vector2.Value;
			break;
		case Operation.Subtract:
			resultVector.Value = vector1.Value - vector2.Value;
			break;
		}
		return TaskStatus.Success;
	}
}
