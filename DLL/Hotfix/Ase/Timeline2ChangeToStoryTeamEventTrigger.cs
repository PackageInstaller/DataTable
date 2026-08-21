using System.Collections.Generic;

namespace Ase;

[Trigger("Timeline2切换到剧情队伍")]
public class Timeline2ChangeToStoryTeamEventTrigger : TimelineEventTrigger
{
	public bool useOriginTeam;

	public List<HeroModelStoryCreateData> heroModelStoryCreateDatas = new List<HeroModelStoryCreateData>();

	private List<PeripheryHeroData> team = new List<PeripheryHeroData>();

	public override string TriggerName => "Timeline-切换到剧情队伍";

	protected override void DoExecute()
	{
		base.DoExecute();
		if (useOriginTeam)
		{
			team = sceneSystem.GetOriginTeam();
		}
		else
		{
			team.Clear();
			for (int i = 0; i < heroModelStoryCreateDatas.Count; i++)
			{
				PeripheryHeroData peripheryHeroData = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(heroModelStoryCreateDatas[i].id, emptyCreateNew: true).GetPeripheryHeroData(0L);
				peripheryHeroData.PropertyAdd("Hp", heroModelStoryCreateDatas[i].hp);
				peripheryHeroData.PropertyAdd("Attack", heroModelStoryCreateDatas[i].attack);
				peripheryHeroData.PropertyAdd("Defence", heroModelStoryCreateDatas[i].defence);
				team.Add(peripheryHeroData);
			}
		}
		if (team != null && team.Count > 0)
		{
			sceneSystem.GetSystem<BattleSystem>().SwitchTeam(team, useBornFire: false, changeOriginTeam: false);
		}
	}
}
