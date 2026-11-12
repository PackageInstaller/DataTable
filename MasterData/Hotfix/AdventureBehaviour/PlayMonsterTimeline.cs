using System;
using UnityEngine;

namespace AdventureBehaviour;

public class PlayMonsterTimeline
{
	public void Play(AdventureActor actor, Action onNormalComplete = null, Action onCannotPlay = null, int phaseIndex = 0)
	{
		string timelineAlias = GetTimelineAlias(actor, phaseIndex);
		if (!string.IsNullOrEmpty(timelineAlias))
		{
			GameObject monsterTimelineByAlias = ModuleController<AdventureModuleController>.Instance.GetMonsterTimelineByAlias(actor, timelineAlias);
			if (null == monsterTimelineByAlias)
			{
				Debug.LogError(actor.name + "怪物演出资源不存在:" + timelineAlias);
				onCannotPlay?.Invoke();
			}
			else
			{
				AdventureFXManager.PlayMonsterTimeline(monsterTimelineByAlias, actor, () =>
				{
					onNormalComplete?.Invoke();
				});
			}
		}
		else
		{
			Debug.LogError(actor.name + "怪物演出资源未配置,索引:" + phaseIndex);
			onCannotPlay?.Invoke();
		}
	}

	private string GetTimelineAlias(AdventureActor actor, int phaseIndex)
	{
		string[] monsterTimelineAlias = actor.comboGroup.monsterTimelineAlias;
		if (monsterTimelineAlias == null || monsterTimelineAlias.Length <= 0)
		{
			return null;
		}
		return actor.comboGroup.monsterTimelineAlias[phaseIndex];
	}
}
