using System;
using UnityEngine;
using UnityEngine.Playables;

namespace T0World;

[Serializable]
public class T0InterationAddDragTimeline : T0InterationBaseData
{
	public string animName;

	public bool isLoadTimelineNode = true;

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		if (isLoadTimelineNode)
		{
			AddTimeline(behaviour);
		}
		else
		{
			RemoveTimeline(behaviour);
		}
		base.IsFinish = true;
	}

	private void AddTimeline(T0WorldInteractionBehavior behaviour)
	{
		int characterID = T0WorldScene.Scene.characterID;
		GameObject timelineGo = behaviour.GetTimelineGo(characterID, animName, out var _);
		timelineGo.SetActive(value: true);
		PlayableDirector component = timelineGo.GetComponent<PlayableDirector>();
		behaviour.brain.BindPlayableDirector(component);
		behaviour.brain.RebuildPlayableDirector(component);
		component.Play();
		component.Evaluate();
	}

	private void RemoveTimeline(T0WorldInteractionBehavior behaviour)
	{
		int characterID = T0WorldScene.Scene.characterID;
		behaviour.UnloadTimelineGo(characterID, animName);
	}
}
