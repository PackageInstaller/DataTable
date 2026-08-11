using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Blackboard")]
[Description("Set a blackboard float variable")]
public class SetFloat : ActionTask
{
	[BlackboardOnly]
	public BBParameter<float> valueA;

	public OperationMethod Operation;

	public BBParameter<float> valueB;

	public bool perSecond;

	protected override string info => string.Format("{0} {1} {2}{3}", valueA, OperationTools.GetOperationString(Operation), valueB, perSecond ? " Per Second" : "");

	protected override void OnExecute()
	{
		valueA.value = OperationTools.Operate(valueA.value, valueB.value, Operation, perSecond ? Time.deltaTime : 1f);
		EndAction(success: true);
	}
}
