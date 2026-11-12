using System.Collections;
using TrueSync;

namespace AIScript.Monster._31701MoFaZhen;

public class MagicCircle_2 : SkillSimpleBase
{
	private int _deathCount;

	private bool _finalStarted;

	protected override void OnSkillEnable()
	{
		SetHideModelEnable(autoDisableWhenSkillDisable: false);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		InitListenEvent(MonsterEventType.MonsterDie, true, InterruptStrong, 1900614);
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(9999f);
	}

	private void InterruptStrong(IEvent evt)
	{
		TSVector2 position = GetPosition();
		TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
		if (Distance(position, entityPosition) <= 14f)
		{
			_deathCount++;
		}
		if (!_finalStarted && _deathCount == 2)
		{
			_finalStarted = true;
			DoSomething();
		}
	}

	private void DoSomething()
	{
		DispatchCustomEvent("OnCustomEvt", isSelfEvent: false);
		PlayFeedbackEffect("CameraShake_Down");
		PlayEffect("fx_StoryActivity_17_loop_MagicCircle_3", 1f, 0, GetPosition(), 0);
		PlayAreaEffect("Area_StoryActivity_17_Damge", GetPosition());
		foreach (LogicEntity item in GetTargetsByFaction(isFriend: false))
		{
			if (GetBuffNum(item, 317010030) >= 1)
			{
				AddBuffToTarget(item, 317010020);
			}
		}
	}
}
