using ACT.BluePrint;
using BehaviorDesigner.Runtime.Tasks;
using Unity.VisualScripting.Community;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
public class BPSignal : Action
{
	public int signal;

	public override TaskStatus OnUpdate()
	{
		GlobalDefinedEventNode.Trigger(new BPGlobalEvent(signal));
		return TaskStatus.Success;
	}
}
