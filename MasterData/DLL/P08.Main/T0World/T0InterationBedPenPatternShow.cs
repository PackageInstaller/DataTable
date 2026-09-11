using System;
using System.Collections.Generic;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationBedPenPatternShow : T0InterationBaseData
{
	public List<string> patternKeyList;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		RandomShowPattern(behaviour.transform);
	}

	private void RandomShowPattern(Transform interactTrs)
	{
		if (patternKeyList == null || patternKeyList.Count == 0)
		{
			return;
		}
		List<string> list = new List<string>();
		foreach (string patternKey in patternKeyList)
		{
			if (!T0BedGame.bedGame.IsHavePenPattern(patternKey))
			{
				list.Add(patternKey);
			}
		}
		if (list.Count == 0)
		{
			foreach (string patternKey2 in patternKeyList)
			{
				if (T0BedGame.bedGame != null && T0BedGame.bedGame.context != null)
				{
					T0BedGame.bedGame.context.showPenPatternKeyList.Remove(patternKey2);
				}
				Transform transform = interactTrs.Find(patternKey2);
				if (transform != null)
				{
					transform.gameObject.SetActive(value: false);
				}
			}
			list.AddRange(patternKeyList);
		}
		int index = UnityEngine.Random.Range(0, list.Count);
		string text = list[index];
		T0BedGame.bedGame.AddPenPattern(text);
		interactTrs.Find(text).gameObject.SetActive(value: true);
		base.IsFinish = true;
	}

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}
}
