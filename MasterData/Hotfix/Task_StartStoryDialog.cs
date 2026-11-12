using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

[AddComponentMenu("触发器结果/表现事件/开始AVG对话", 2)]
public class Task_StartStoryDialog : TaskCellBase
{
	private const string AVG_START = "StoryDialog_DialogStart";

	private const string AVG_END = "StoryDialog_DialogEnd";

	public string dialogID;

	public float blurTransitionTime = 1f;

	public List<PlayableDirector> pauseTimelineList;

	private bool needDisableInput;

	protected override void OnExecute()
	{
		if (string.IsNullOrEmpty(dialogID))
		{
			LogWarning("未配置");
			EndAction(success: false);
			return;
		}
		PauseLogicAndPlayer();
		if (blurTransitionTime < Mathf.Epsilon)
		{
			OpenAvg();
			MonoSingleton<GameCameraStackManager>.Instance.StopMainCameraBlackScreenTransition();
		}
		else
		{
			MonoSingleton<GameCameraStackManager>.Instance.StartMainCameraAvgBlurTransition(blurTransitionTime, OpenAvg);
		}
	}

	protected void OpenAvg()
	{
		Singleton<EventDispatchManager>.Instance.AddEventListener("StoryDialog_DialogEnd", OnDialogEnd);
		MonoSingleton<LuaManager>.Instance.FireEvent("StoryDialog_DialogStart", dialogID);
		if (pauseTimelineList == null)
		{
			return;
		}
		foreach (PlayableDirector pauseTimeline in pauseTimelineList)
		{
			pauseTimeline?.Pause();
		}
	}

	protected override void OnStop(bool success)
	{
		if (!success)
		{
			return;
		}
		Singleton<EventDispatchManager>.Instance.RemoveEventListener("StoryDialog_DialogEnd", OnDialogEnd);
		if (blurTransitionTime < Mathf.Epsilon)
		{
			ResumeLogicAndPlayer();
		}
		else
		{
			MonoSingleton<GameCameraStackManager>.Instance.StopMainCameraAvgBlurTransition(blurTransitionTime, ResumeLogicAndPlayer);
		}
		if (pauseTimelineList == null)
		{
			return;
		}
		foreach (PlayableDirector pauseTimeline in pauseTimelineList)
		{
			pauseTimeline?.Resume();
		}
	}

	protected void PauseLogicAndPlayer()
	{
		needDisableInput = SceneSingleton<AdventurePlayerController>.Instance.inputEnabled;
		TaskCellBase.PauseLogic();
		if (needDisableInput)
		{
			TaskCellBase.SuspendPlayer();
			TaskCellBase.SetHud_Invisible();
		}
	}

	protected void ResumeLogicAndPlayer()
	{
		TaskCellBase.ResumeLogic();
		if (needDisableInput)
		{
			TaskCellBase.ResumePlayer();
			TaskCellBase.SetHud_Visible();
		}
	}

	protected void OnDialogEnd(IEvent evt)
	{
		EndAction();
	}
}
