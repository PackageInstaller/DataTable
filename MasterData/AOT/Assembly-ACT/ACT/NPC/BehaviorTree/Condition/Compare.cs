using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.NPC.BehaviorTree.Condition;

[TaskCategory("NPC")]
[TaskDescription("比较左值和右值")]
public class Compare : NpcConditionBase
{
	public SharedInt leftValue;

	public SharedInt rightValue;

	public CompareOperator compareOperator;

	public override TaskStatus OnUpdate()
	{
		if (!(compareOperator switch
		{
			CompareOperator.Equal => leftValue.Value == rightValue.Value, 
			CompareOperator.NotEqual => leftValue.Value != rightValue.Value, 
			CompareOperator.Greater => leftValue.Value > rightValue.Value, 
			CompareOperator.GreaterEqual => leftValue.Value >= rightValue.Value, 
			CompareOperator.Less => leftValue.Value < rightValue.Value, 
			CompareOperator.LessEqual => leftValue.Value <= rightValue.Value, 
			_ => false, 
		}))
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
