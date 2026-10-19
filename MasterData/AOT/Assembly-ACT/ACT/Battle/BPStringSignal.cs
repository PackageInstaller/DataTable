using ACT.BluePrint;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using Unity.VisualScripting.Community;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
public class BPStringSignal : Action
{
	public SharedString eventName;

	public override TaskStatus OnUpdate()
	{
		GlobalDefinedEventNode.Trigger(new BPGlobalStringEvent(eventName.Value));
		return TaskStatus.Success;
	}
}
