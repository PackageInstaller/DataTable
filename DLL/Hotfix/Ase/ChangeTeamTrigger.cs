using System.Collections.Generic;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase;

[Trigger("切换队伍配置触发器")]
public class ChangeTeamTrigger : BaseTrigger
{
	public bool useOriginTeam;

	public List<int> teamMemberList;

	public bool useTeleport;

	public string telerportKey;

	public bool useStory;

	public int storyId;

	public StoryEventExcuteType storyEventExcuteType = StoryEventExcuteType.End;

	public List<TimelineEventTrigger> eventTriggers = new List<TimelineEventTrigger>();

	public bool useBlack;

	public bool showSkillBtn;

	public List<HeroSkillTypeEnum> skillTypeEnums;

	public override string TriggerName => "切换队伍配置触发器";

	protected override async void DoExecute()
	{
		base.DoExecute();
		if (useOriginTeam)
		{
			teamMemberList = sceneSystem.GetOriginTeamIds();
		}
		if (teamMemberList == null || teamMemberList.Count <= 0)
		{
			return;
		}
		if (useStory)
		{
			sceneSystem.GamePause(transition: true);
			BlackScreen blackScreen = await BlackScreen.Show("TIMELINE");
			await UniTask.WaitForSeconds(1);
			await sceneSystem.GetSystem<BattleSystem>().SwitchTeam(teamMemberList, useBornFire: false, changeOriginTeam: false);
			if (useTeleport)
			{
				await sceneSystem.Teleport(telerportKey, updateBornPointKey: false);
				await UniTask.WaitForEndOfFrame();
				await UniTask.WaitUntil(() => !sceneSystem.GetSystem<VirtualCameraSystem>().IsBlendState());
			}
			if (storyEventExcuteType == StoryEventExcuteType.Start)
			{
				Singleton<Story>.Instance.ExecuteEvent(eventTriggers);
				await Singleton<Story>.Instance.PlayStory(sceneSystem.GetWorld().Id, storyId, pause: false, blackScreen);
				sceneSystem.GameResume();
			}
			else
			{
				await Singleton<Story>.Instance.PlayStory(sceneSystem.GetWorld().Id, storyId, pause: false, blackScreen);
				Singleton<Story>.Instance.ExecuteEvent(eventTriggers);
				await new WaitForSecondsRealtime(0.05f);
				sceneSystem.GameResume();
			}
		}
		if (useBlack || (!useBlack && !useStory))
		{
			sceneSystem.GamePause(transition: true);
			BlackScreen blackScreen = await BlackScreen.Show("TIMELINE");
			await UniTask.WaitForSeconds(1);
			await sceneSystem.GetSystem<BattleSystem>().SwitchTeam(teamMemberList, useBornFire: false, changeOriginTeam: false);
			if (useTeleport)
			{
				await sceneSystem.Teleport(telerportKey, updateBornPointKey: false);
				await UniTask.WaitForEndOfFrame();
				await UniTask.WaitUntil(() => !sceneSystem.GetSystem<VirtualCameraSystem>().IsBlendState());
			}
			blackScreen.Dispose();
			sceneSystem.GameResume();
		}
		if (showSkillBtn && skillTypeEnums.Count > 0)
		{
			for (int num = 0; num < skillTypeEnums.Count; num++)
			{
				sceneSystem.GetSystem<TouchSystem>().SetSkillBtnHide(skillTypeEnums[num], hide: false);
			}
		}
	}
}
