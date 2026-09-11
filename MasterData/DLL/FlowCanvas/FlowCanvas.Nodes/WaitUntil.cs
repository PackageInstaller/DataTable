using System.Collections;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Time")]
[Description("Wait Until condition value becomes true")]
public class WaitUntil : LatentActionNode
{
	private ValueInput<bool> condition;

	public override bool exposeRoutineControls => false;

	public override IEnumerator Invoke()
	{
		yield return new UnityEngine.WaitUntil(condition.GetValue);
	}

	protected override void OnRegisterExtraPorts(FlowNode node)
	{
		condition = node.AddValueInput<bool>("Condition");
	}
}
