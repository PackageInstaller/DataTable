using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Blackboard")]
[Description("Set a blackboard boolean variable")]
public class SetBoolean : ActionTask
{
	public enum BoolSetModes
	{
		False,
		True,
		Toggle
	}

	[RequiredField]
	[BlackboardOnly]
	public BBParameter<bool> boolVariable;

	public BoolSetModes setTo = BoolSetModes.True;

	protected override string info
	{
		get
		{
			if (setTo == BoolSetModes.Toggle)
			{
				return "Toggle " + boolVariable.ToString();
			}
			return "Set " + boolVariable.ToString() + " to " + setTo;
		}
	}

	protected override void OnExecute()
	{
		if (setTo == BoolSetModes.Toggle)
		{
			boolVariable.value = !boolVariable.value;
		}
		else
		{
			bool value = setTo == BoolSetModes.True;
			boolVariable.value = value;
		}
		EndAction();
	}
}
