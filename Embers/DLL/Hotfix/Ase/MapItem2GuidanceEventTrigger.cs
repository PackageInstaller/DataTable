using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Trigger("交互物2引导事件触发器")]
public class MapItem2GuidanceEventTrigger : MapItemEventTrigger
{
	[SerializeField]
	private List<int> guidanceIds = new List<int>();

	public override string TriggerName => "交互物-引导事件触发器";

	public override void OnDisposed()
	{
	}

	protected override async void DoExecute()
	{
		base.DoExecute();
		Singleton<GuidanceManager>.Instance.RegisterGuidance(guidanceIds);
	}
}
