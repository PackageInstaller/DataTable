using System;
using System.Collections.Generic;
using UnityEngine;

namespace MusicGame;

public class MusicSpecialEffectMgr : MonoBehaviour
{
	[SerializeField]
	private List<Animator> lineAnimatorList;

	[SerializeField]
	private int lineShowTime;

	private List<MusicSpecialEffect> specialEffectList;

	public void SetSpecialEffectData(MusicGameStruct gameData)
	{
		List<List<int>> list = gameData.specialEffectList;
		if (list != null && list.Count > 0)
		{
			specialEffectList = new List<MusicSpecialEffect>();
			for (int i = 0; i < list.Count; i++)
			{
				List<int> list2 = list[i];
				MusicSpecialEffectType effectType = (MusicSpecialEffectType)list2[0];
				_ = list2[1];
				int triggerTime = Convert.ToInt32(list2[1]);
				int belongTrack = ((list2.Count > 2) ? Convert.ToInt32(list2[2]) : 0);
				specialEffectList.Add(new MusicSpecialEffect
				{
					effectType = effectType,
					triggerTime = triggerTime,
					belongTrack = belongTrack
				});
			}
		}
		else
		{
			specialEffectList = null;
		}
	}

	public void TimeUpdate(int curTime)
	{
		if (specialEffectList == null)
		{
			return;
		}
		for (int num = specialEffectList.Count - 1; num >= 0; num--)
		{
			if (curTime >= specialEffectList[num].triggerTime)
			{
				TriggerEvent(specialEffectList[num]);
				specialEffectList.RemoveAt(num);
			}
		}
	}

	private void TriggerEvent(MusicSpecialEffect musicSpecialEffect)
	{
		MusicSpecialEffectType effectType = musicSpecialEffect.effectType;
		switch (effectType)
		{
		case MusicSpecialEffectType.HIDE_LINE:
		{
			foreach (Animator lineAnimator in lineAnimatorList)
			{
				lineAnimator.Play("UI_line_special");
			}
			break;
		}
		case MusicSpecialEffectType.SHOW_LINE:
		{
			foreach (Animator lineAnimator2 in lineAnimatorList)
			{
				lineAnimator2.Play("UI_line_normal");
			}
			break;
		}
		case MusicSpecialEffectType.PLAY_VOICE_SHOW:
			LuaHelper.CallFunction("MusicToLuaBridge.OnSpecialEffectTriggerEvent", (int)effectType);
			break;
		}
	}
}
