using System.Collections.Generic;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase;

[Trigger("切换剧情队伍配置触发器")]
public class ChangeStoryTeamTrigger : BaseTrigger
{
	public bool useOriginTeam;

	public List<HeroModelStoryCreateData> heroModelStoryCreateDatas = new List<HeroModelStoryCreateData>();

	public bool useTeleport;

	public string telerportKey;

	public bool useStory;

	public int storyId;

	public StoryEventExcuteType storyEventExcuteType = StoryEventExcuteType.End;

	public List<TimelineEventTrigger> eventTriggers = new List<TimelineEventTrigger>();

	public bool useBlack;

	private List<PeripheryHeroData> team = new List<PeripheryHeroData>();

	public override string TriggerName => "切换剧情队伍配置触发器";

	protected override async void DoExecute()
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
		if (team == null || team.Count <= 0)
		{
			return;
		}
		BlackScreen blackScreen;
		if (useStory)
		{
			sceneSystem.GamePause(transition: true);
			blackScreen = await BlackScreen.Show("TIMELINE");
			await UniTask.WaitForSeconds(1);
			await sceneSystem.GetSystem<BattleSystem>().SwitchTeam(team, useBornFire: false, changeOriginTeam: false);
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
		if (!useBlack && (useBlack || useStory))
		{
			return;
		}
		sceneSystem.GamePause(transition: true);
		blackScreen = await BlackScreen.Show("TIMELINE");
		await UniTask.WaitForSeconds(1);
		await sceneSystem.GetSystem<BattleSystem>().SwitchTeam(team, useBornFire: false, changeOriginTeam: false);
		if (useTeleport)
		{
			await sceneSystem.Teleport(telerportKey, updateBornPointKey: false);
			await UniTask.WaitForEndOfFrame();
			await UniTask.WaitUntil(() => !sceneSystem.GetSystem<VirtualCameraSystem>().IsBlendState());
		}
		blackScreen.Dispose();
		sceneSystem.GameResume();
	}
}
