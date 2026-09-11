using System;
using UnityEngine;
using UnityEngine.Playables;

namespace T0World;

[Serializable]
public class T0InterationDragBase : T0InterationBaseData
{
	public string dragKey = "DragEvent";

	public string dragAnimName;

	[HideInInspector]
	public PlayableDirector playable;

	public float totalProgress = 5f;

	private float nowProgress;

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	private static void BindTimelineTrackField(HeroUITimelineBrain brain, GameObject timelineGo, bool recursive = true)
	{
		if (!brain)
		{
			return;
		}
		if (recursive)
		{
			PlayableDirector[] componentsInChildren = timelineGo.GetComponentsInChildren<PlayableDirector>();
			foreach (PlayableDirector pd in componentsInChildren)
			{
				brain.BindPlayableDirector(pd);
				brain.RebuildPlayableDirector(pd);
			}
		}
		else
		{
			PlayableDirector component = timelineGo.GetComponent<PlayableDirector>();
			brain.BindPlayableDirector(component);
			brain.RebuildPlayableDirector(component);
		}
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		T0WorldScene.Scene.dataContext.AddRunDragEvent(dragKey, this);
		int characterID = T0WorldScene.Scene.characterID;
		GameObject timelineGo = behaviour.GetTimelineGo(characterID, dragAnimName, out var _);
		BindTimelineTrackField(behaviour ? behaviour.brain : null, timelineGo);
		playable = timelineGo.GetComponent<PlayableDirector>();
		playable.time = 0.0;
		playable.Pause();
		nowProgress = 0f;
		(T0WorldScene.Scene.mWorldUI as T0WorldUI).ChangeGrahiceRaycastTarget(isTarget: false);
	}

	public override void FinishEvent(T0WorldInteractionBehavior behaviour)
	{
		T0WorldScene.Scene.dataContext.RemoveRunDragEvent(dragKey);
	}

	public override void DisposeEvent()
	{
		T0WorldScene.Scene.dataContext.RemoveRunDragEvent(dragKey);
	}

	public virtual void OnDragValueChange(float progress)
	{
		if (!(playable == null))
		{
			progress = Mathf.Clamp01(progress);
			double time = playable.duration * (double)progress;
			playable.time = time;
			playable.Evaluate();
		}
	}

	public virtual void OnDragValueAddChange(float addProgress)
	{
		if (!(playable == null))
		{
			nowProgress += addProgress;
			nowProgress = Mathf.Clamp(nowProgress, 0f, totalProgress);
			double time = playable.duration * (double)nowProgress / (double)totalProgress;
			playable.time = time;
			playable.Evaluate();
			if (nowProgress >= totalProgress)
			{
				OnDragFinish();
			}
		}
	}

	public virtual void OnDragFinish()
	{
		(T0WorldScene.Scene.mWorldUI as T0WorldUI).ChangeGrahiceRaycastTarget(isTarget: true);
		base.IsFinish = true;
	}

	public virtual void OnDragEnd()
	{
	}
}
