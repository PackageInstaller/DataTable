using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Trigger("Timeline2引导事件触发器")]
public class Timeline2GuidanceEventTrigger : TimelineEventTrigger
{
	[SerializeField]
	private List<int> guidanceIds = new List<int>();

	public override string TriggerName => "Timeline-引导事件触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		Singleton<GuidanceManager>.Instance.RegisterGuidance(guidanceIds);
	}
}
