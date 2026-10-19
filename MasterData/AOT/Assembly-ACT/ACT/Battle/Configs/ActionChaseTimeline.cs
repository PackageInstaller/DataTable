using Fundamental;
using Runtime.Battle.ChaseBattle;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行追踪Timeline", "Action", new string[] { "chase", "timeline", "motion" })]
public class ActionChaseTimeline : ActionPlayTimeline
{
	[SerializeField]
	private int chaseBattleID;

	public override void Do(ActionMemory memory)
	{
		base.Do(memory);
		Singleton<ChaseBattleManager>.instance.ChaseBattleID = chaseBattleID;
	}
}
