using System.Collections;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Time")]
[Description("Wait until the physics update frame")]
public class WaitForPhysicsFrame : LatentActionNode
{
	public override bool exposeRoutineControls => false;

	public override IEnumerator Invoke()
	{
		yield return new WaitForFixedUpdate();
	}
}
