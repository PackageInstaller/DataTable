using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31701MoFaZhen;

public class MagicCircle_MiniBoss : SkillSimpleBase
{
	private int _deathCount;

	private bool _finalStarted;

	protected override void OnSkillEnable()
	{
		SetHideModelEnable(autoDisableWhenSkillDisable: false);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		InitListenEvent(MonsterEventType.MonsterDie, true, InterruptStrong, 1900602);
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
		if (Distance(position, entityPosition) <= 20f)
		{
			_deathCount++;
		}
		if (!_finalStarted && _deathCount == 1)
		{
			_finalStarted = true;
			DoSomething();
		}
	}

	private void DoSomething()
	{
		PlayFeedbackEffect("CameraShake_Down");
		PlayEffect("fx_StoryActivity_17_loop_MagicCircle_3", 1f, 0, GetPosition(), 0);
		foreach (LogicEntity item in GetTargetsByFaction(isFriend: true))
		{
			if (GetBuffNum(item, 317010030) >= 1)
			{
				AddBuffToTarget(item, 317010020);
			}
		}
		List<LogicEntity> targetByDataIDs = GetTargetByDataIDs(new List<int> { 1900608, 1900609, 1900610 });
		ClearActors(targetByDataIDs);
		List<LogicEntity> targetByDataIDs2 = GetTargetByDataIDs(new List<int> { 1900604, 1900611 });
		KillActors(targetByDataIDs2);
	}
}
