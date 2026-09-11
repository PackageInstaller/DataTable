using System.Collections;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Time")]
[Description("Wait for a certain amount of time before continueing")]
public class Wait : LatentActionNode<float>
{
	public float timeLeft { get; private set; }

	public override IEnumerator Invoke(float time = 1f)
	{
		timeLeft = time;
		while (timeLeft > 0f)
		{
			timeLeft -= Time.deltaTime;
			timeLeft = Mathf.Max(timeLeft, 0f);
			yield return null;
		}
	}
}
