using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Name("Set Parameter Trigger", 0)]
[Category("Animator")]
[Description("You can either use a parameter name OR hashID. Leave the parameter name empty or none to use hashID instead.")]
public class MecanimSetTrigger : ActionTask<Animator>
{
	public BBParameter<string> parameter;

	public BBParameter<int> parameterHashID;

	protected override string info => $"Mec.SetTrigger {((string.IsNullOrEmpty(parameter.value) && !parameter.useBlackboard) ? parameterHashID.ToString() : parameter.ToString())}";

	protected override void OnExecute()
	{
		if (!string.IsNullOrEmpty(parameter.value))
		{
			base.agent.SetTrigger(parameter.value);
		}
		else
		{
			base.agent.SetTrigger(parameterHashID.value);
		}
		EndAction();
	}
}
