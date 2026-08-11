using NodeCanvas.Framework;
using NodeCanvas.StateMachines;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Utility")]
[Description("Switch the entire FSM of FSMTreeOwner")]
public class SwitchFSM : ActionTask<FSMOwner>
{
	[RequiredField]
	public BBParameter<FSM> fsm;

	protected override string info => $"Switch FSM {fsm}";

	protected override void OnExecute()
	{
		base.agent.SwitchBehaviour(fsm.value);
		EndAction();
	}
}
