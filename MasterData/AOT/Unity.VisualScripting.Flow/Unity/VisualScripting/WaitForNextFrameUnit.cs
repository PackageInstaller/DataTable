using System.Collections;

namespace Unity.VisualScripting;

[UnitTitle("Wait For Next Frame")]
[UnitOrder(4)]
public class WaitForNextFrameUnit : WaitUnit
{
	protected override IEnumerator Await(Flow flow)
	{
		yield return null;
		yield return exit;
	}
}
