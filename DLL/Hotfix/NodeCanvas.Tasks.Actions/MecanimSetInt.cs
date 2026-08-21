using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Name("Set Parameter Integer", 0)]
[Category("Animator")]
[Description("You can either use a parameter name OR hashID. Leave the parameter name empty or none to use hashID instead.")]
public class MecanimSetInt : ActionTask<Animator>
{
	public BBParameter<string> parameter;

	public BBParameter<int> parameterHashID;

	public BBParameter<int> setTo;

	protected override string info => $"Mec.SetInt {((string.IsNullOrEmpty(parameter.value) && !parameter.useBlackboard) ? parameterHashID.ToString() : parameter.ToString())} to {setTo}";

	protected override void OnExecute()
	{
		if (!string.IsNullOrEmpty(parameter.value))
		{
			base.agent.SetInteger(parameter.value, setTo.value);
		}
		else
		{
			base.agent.SetInteger(parameterHashID.value, setTo.value);
		}
		EndAction();
	}
}
