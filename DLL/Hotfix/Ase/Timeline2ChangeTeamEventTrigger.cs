using System.Collections.Generic;

namespace Ase;

[Trigger("Timeline2改变队伍")]
public class Timeline2ChangeTeamEventTrigger : TimelineEventTrigger
{
	public bool useOriginTeam;

	public List<int> teamMemberList;

	public bool IsChangeOriginTeam;

	public override string TriggerName => "Timeline-改变队伍";

	protected override void DoExecute()
	{
		base.DoExecute();
		if (useOriginTeam)
		{
			teamMemberList = sceneSystem.GetOriginTeamIds();
		}
		if (teamMemberList != null && teamMemberList.Count > 0)
		{
			sceneSystem.GetSystem<BattleSystem>().SwitchTeam(teamMemberList, useBornFire: false, IsChangeOriginTeam);
		}
	}
}
