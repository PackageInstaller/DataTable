using System.Collections.Generic;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase;

[Trigger("怪物组2改变队伍触发器")]
public class MonsterGroupEvent2ChangeTeamEventTrigger : MonsterGroupEventTrigger
{
	public bool useOriginTeam;

	public int storyId;

	public StoryEventExcuteType storyEventExcuteType = StoryEventExcuteType.End;

	public List<TimelineEventTrigger> eventTriggers = new List<TimelineEventTrigger>();

	public string telerportKey;

	public List<int> teamMemberList;

	public override string TriggerName => "怪物组-改变队伍触发器";

	protected override async void DoExecute()
	{
		base.DoExecute();
		if (sceneSystem == null)
		{
			return;
		}
		if (useOriginTeam)
		{
			teamMemberList = sceneSystem.GetOriginTeamIds();
		}
		if (teamMemberList == null || teamMemberList.Count <= 0)
		{
			return;
		}
		sceneSystem.GamePause(transition: true);
		BlackScreen blackScreen = await BlackScreen.Show("TIMELINE");
		await UniTask.WaitForSeconds(1);
		if ((Object)(object)this == null)
		{
			return;
		}
		await sceneSystem.GetSystem<BattleSystem>().SwitchTeam(teamMemberList, useBornFire: false, changeOriginTeam: false);
		if ((Object)(object)this == null)
		{
			return;
		}
		if (!string.IsNullOrEmpty(telerportKey))
		{
			await sceneSystem.Teleport(telerportKey, updateBornPointKey: false);
			await UniTask.WaitForEndOfFrame();
			await UniTask.WaitUntil(() => !sceneSystem.GetSystem<VirtualCameraSystem>().IsBlendState());
		}
		if ((Object)(object)this == null)
		{
			return;
		}
		if (storyId > 0)
		{
			if (storyEventExcuteType == StoryEventExcuteType.Start)
			{
				Singleton<Story>.Instance.ExecuteEvent(eventTriggers);
				await Singleton<Story>.Instance.PlayStory(sceneSystem.GetWorld().Id, storyId, pause: false, blackScreen);
				sceneSystem?.GameResume();
			}
			else
			{
				await Singleton<Story>.Instance.PlayStory(sceneSystem.GetWorld().Id, storyId, pause: false, blackScreen);
				await new WaitForSecondsRealtime(0.05f);
				sceneSystem?.GameResume();
				Singleton<Story>.Instance.ExecuteEvent(eventTriggers);
			}
		}
		else
		{
			blackScreen.Dispose();
			sceneSystem?.GameResume();
		}
	}
}
