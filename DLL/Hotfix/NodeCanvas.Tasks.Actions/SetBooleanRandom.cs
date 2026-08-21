using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Blackboard")]
[Description("Set a blackboard boolean variable at random between min and max value")]
public class SetBooleanRandom : ActionTask
{
	[BlackboardOnly]
	public BBParameter<bool> boolVariable;

	protected override string info => "Set " + boolVariable?.ToString() + " Random";

	protected override void OnExecute()
	{
		EndAction();
	}
}
