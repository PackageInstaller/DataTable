using System.Collections;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Time")]
[Description("Wait While condition value is true")]
public class WaitWhile : LatentActionNode
{
	private ValueInput<bool> condition;

	public override bool exposeRoutineControls => false;

	public override IEnumerator Invoke()
	{
		yield return new UnityEngine.WaitWhile(condition.GetValue);
	}

	protected override void OnRegisterExtraPorts(FlowNode node)
	{
		condition = node.AddValueInput<bool>("Condition");
	}
}
