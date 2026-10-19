using System.Collections;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitTitle("Wait For End of Frame")]
[UnitOrder(5)]
public class WaitForEndOfFrameUnit : WaitUnit
{
	protected override IEnumerator Await(Flow flow)
	{
		yield return new WaitForEndOfFrame();
		yield return exit;
	}
}
