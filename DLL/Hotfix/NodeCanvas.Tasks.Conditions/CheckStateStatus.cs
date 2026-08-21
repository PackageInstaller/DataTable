using NodeCanvas.Framework;
using NodeCanvas.StateMachines;
using ParadoxNotion;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Conditions;

[Category("✫ Utility")]
[Description("Check the parent state status. This condition is only meant to be used along with an FSM system.")]
public class CheckStateStatus : ConditionTask
{
	public CompactStatus status = CompactStatus.Success;

	protected override string info => $"State == {status}";

	protected override bool OnCheck()
	{
		FSM fSM = base.ownerSystem as FSM;
		if (fSM != null)
		{
			return fSM.currentState.status == (Status)status;
		}
		return false;
	}
}
