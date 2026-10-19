using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.NPC.BehaviorTree.Action;

[TaskCategory("NPC")]
[TaskDescription("增加计数")]
public class AddCount : NpcActionBase
{
	public SharedBool dontCycle;

	public SharedInt cycleCount;

	public SharedInt intVariable;

	public override TaskStatus OnUpdate()
	{
		base.OnFixedUpdate();
		intVariable.Value++;
		if (!dontCycle.Value)
		{
			intVariable.Value %= cycleCount.Value;
		}
		else if (intVariable.Value >= cycleCount.Value)
		{
			Owner.DisableBehavior(pause: false);
		}
		return TaskStatus.Success;
	}
}
