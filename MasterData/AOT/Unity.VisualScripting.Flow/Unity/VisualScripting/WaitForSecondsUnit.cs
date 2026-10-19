using System.Collections;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitOrder(1)]
[UnitTitle("Wait For Seconds")]
public class WaitForSecondsUnit : WaitUnit
{
	[PortLabel("Delay")]
	[DoNotSerialize]
	public ValueInput seconds { get; private set; }

	[DoNotSerialize]
	[PortLabel("Unscaled")]
	public ValueInput unscaledTime { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		seconds = ValueInput("seconds", 0f);
		unscaledTime = ValueInput("unscaledTime", @default: false);
		Requirement(seconds, enter);
		Requirement(unscaledTime, enter);
	}

	protected override IEnumerator Await(Flow flow)
	{
		float value = flow.GetValue<float>(seconds);
		if (flow.GetValue<bool>(unscaledTime))
		{
			yield return new WaitForSecondsRealtime(value);
		}
		else
		{
			yield return new WaitForSeconds(value);
		}
		yield return exit;
	}
}
