using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("队列的大小与指定值作比较 ,例如：队列的大小 < 指定值 ? True:False")]
public class BTGroupEntityListCheckSize : Conditional
{
	public enum Operation
	{
		LessThan,
		LessThanOrEqualTo,
		EqualTo,
		NotEqualTo,
		GreaterThanOrEqualTo,
		GreaterThan
	}

	[SharedRequired]
	public SharedEntityList list;

	[SharedRequired]
	public SharedInt size;

	public Operation operation;

	public override void OnStart()
	{
	}

	public override TaskStatus OnUpdate()
	{
		int count = list.Value.Count;
		switch (operation)
		{
		case Operation.LessThan:
			if (count >= size.Value)
			{
				return TaskStatus.Failure;
			}
			return TaskStatus.Success;
		case Operation.LessThanOrEqualTo:
			if (count > size.Value)
			{
				return TaskStatus.Failure;
			}
			return TaskStatus.Success;
		case Operation.EqualTo:
			if (count != size.Value)
			{
				return TaskStatus.Failure;
			}
			return TaskStatus.Success;
		case Operation.NotEqualTo:
			if (count == size.Value)
			{
				return TaskStatus.Failure;
			}
			return TaskStatus.Success;
		case Operation.GreaterThanOrEqualTo:
			if (count < size.Value)
			{
				return TaskStatus.Failure;
			}
			return TaskStatus.Success;
		case Operation.GreaterThan:
			if (count <= size.Value)
			{
				return TaskStatus.Failure;
			}
			return TaskStatus.Success;
		default:
			return TaskStatus.Failure;
		}
	}
}
