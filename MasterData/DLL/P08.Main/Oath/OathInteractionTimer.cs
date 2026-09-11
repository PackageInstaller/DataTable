using System;
using UnityEngine;

namespace Oath;

[Serializable]
public class OathInteractionTimer : OathInteractionNode
{
	public float timeValue;

	private float timeCount;

	public override void StartEvent()
	{
		timeCount = 0f;
	}

	public override void UpdateEvent()
	{
		timeCount += Time.deltaTime;
		if (timeCount >= timeValue)
		{
			base.IsFinish = true;
		}
	}
}
