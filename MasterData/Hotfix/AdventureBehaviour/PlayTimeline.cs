using System;
using UnityEngine;

namespace AdventureBehaviour;

public class PlayTimeline
{
	private Action _onNormalComplete;

	private Action _onCannotPlay;

	public void Play(AdventureActor actor, Action onNormalComplete = null, Action onCannotPlay = null, int phaseIndex = 1, bool addPlayTime = true)
	{
		_onNormalComplete = onNormalComplete;
		_onCannotPlay = onCannotPlay;
		string ultraSkillTimelineAlias = CommonHelper.GetUltraSkillTimelineAlias(actor, phaseIndex, addPlayTime);
		if (!string.IsNullOrEmpty(ultraSkillTimelineAlias))
		{
			GameObject timelineByAlias = ModuleController<AdventureModuleController>.Instance.GetTimelineByAlias(actor, ultraSkillTimelineAlias);
			if (null == timelineByAlias)
			{
				Debug.LogError(actor.name + " 大招演出资源不存在:" + ultraSkillTimelineAlias);
			}
			else
			{
				AdventureFXManager.PlaySkillTimeline(timelineByAlias, actor, OnNormalComplete);
			}
		}
		else
		{
			OnCannotPlay();
		}
	}

	private void OnNormalComplete()
	{
		_onNormalComplete?.Invoke();
	}

	private void OnCannotPlay()
	{
		_onCannotPlay?.Invoke();
	}

	public void Clear()
	{
		_onNormalComplete = null;
		_onCannotPlay = null;
	}
}
