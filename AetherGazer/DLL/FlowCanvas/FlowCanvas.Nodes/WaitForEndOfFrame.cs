using System.Collections;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Time")]
[Description("Wait until the end of current frame")]
public class WaitForEndOfFrame : LatentActionNode
{
	public override bool exposeRoutineControls => false;

	public override IEnumerator Invoke()
	{
		yield return new UnityEngine.WaitForEndOfFrame();
	}
}
