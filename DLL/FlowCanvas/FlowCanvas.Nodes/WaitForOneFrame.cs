using System.Collections;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Time")]
[Description("Wait for one (the next) frame")]
public class WaitForOneFrame : LatentActionNode
{
	public override bool exposeRoutineControls => false;

	public override IEnumerator Invoke()
	{
		yield return null;
	}
}
