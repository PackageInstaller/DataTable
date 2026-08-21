using System.Collections.Generic;
using Ase.ECS;
using Cysharp.Threading.Tasks;

namespace Ase;

[Trigger("交互物2切换队伍触发器")]
public class MapItem2ChangeTeamEventTrigger : MapItemEventTrigger
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

	public override string TriggerName => "交互物-切换队伍触发器";

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
		BlackScreen blackScreen;
		if (useStory)
		{
			sceneSystem.GamePause(transition: true);
			blackScreen = await BlackScreen.Show("TIMELINE");
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
				await UniTask.WaitForSeconds(0.05f);
				sceneSystem.GameResume();
				Singleton<Story>.Instance.ExecuteEvent(eventTriggers);
			}
		}
		if (!useBlack && (useBlack || useStory))
		{
			return;
		}
		sceneSystem.GamePause(transition: true);
		blackScreen = await BlackScreen.Show("TIMELINE");
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

	public override void OnUnLoadNode()
	{
		base.OnUnLoadNode();
	}

	public override void OnDisposed()
	{
	}
}
