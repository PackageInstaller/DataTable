using System.Collections.Generic;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase;

[Trigger("传送触发器")]
public class TeleportTrigger : BaseTrigger
{
	public string teleportId;

	public bool updateBornPointKey;

	public bool useStory;

	public int storyId;

	public StoryEventExcuteType storyEventExcuteType = StoryEventExcuteType.End;

	public List<TimelineEventTrigger> eventTriggers = new List<TimelineEventTrigger>();

	public bool useBlack;

	public CavesTransform CavesTransform;

	public int CavesId;

	public override string TriggerName => "传送触发器";

	protected override async void DoExecute()
	{
		base.DoExecute();
		bool excuteCavesTrans = false;
		if (useStory)
		{
			sceneSystem.GamePause(transition: true);
			BlackScreen blackScreen = await BlackScreen.Show("TIMELINE");
			await UniTask.WaitForSeconds(1);
			excuteCavesTrans = ExcuteCavesTrans(excuteCavesTrans);
			await sceneSystem.Teleport(teleportId, updateBornPointKey);
			await UniTask.WaitForEndOfFrame();
			await UniTask.WaitUntil(() => !sceneSystem.GetSystem<VirtualCameraSystem>().IsBlendState());
			await new WaitForSeconds(0.05f);
			if (storyEventExcuteType == StoryEventExcuteType.Start)
			{
				Singleton<Story>.Instance.ExecuteEvent(eventTriggers);
				await Singleton<Story>.Instance.PlayStory(sceneSystem.GetWorld().Id, storyId, pause: false, blackScreen);
			}
			else
			{
				await Singleton<Story>.Instance.PlayStory(sceneSystem.GetWorld().Id, storyId, pause: false, blackScreen);
				Singleton<Story>.Instance.ExecuteEvent(eventTriggers);
			}
			sceneSystem.GameResume();
		}
		if (useBlack || (!useBlack && !useStory))
		{
			sceneSystem.GamePause(transition: true);
			BlackScreen blackScreen = await BlackScreen.Show("TIMELINE");
			await new WaitForSecondsRealtime(1f);
			excuteCavesTrans = ExcuteCavesTrans(excuteCavesTrans);
			await sceneSystem.Teleport(teleportId, updateBornPointKey);
			await UniTask.WaitForEndOfFrame();
			await UniTask.WaitUntil(() => !sceneSystem.GetSystem<VirtualCameraSystem>().IsBlendState());
			blackScreen.Dispose();
			sceneSystem.GameResume();
		}
		ExcuteCavesTrans(excuteCavesTrans);
	}

	private bool ExcuteCavesTrans(bool excuteCavesTrans)
	{
		if (!excuteCavesTrans)
		{
			sceneSystem.SetCavesState(CavesTransform, CavesId);
			excuteCavesTrans = true;
		}
		return excuteCavesTrans;
	}
}
