using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31701MoFaZhen;

public class MagicCircle_Activity_1 : SkillSimpleBase
{
	private int _deathCount;

	private bool _finalStarted;

	private string interactiveID_Dead = "FaZhengDie";

	protected override void OnSkillEnable()
	{
		SetHideModelEnable(autoDisableWhenSkillDisable: false);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		InitListenEvent(MonsterEventType.MonsterDie, true, InterruptStrong, 3170004);
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
		Singleton<InteractiveManager>.Instance.triggerOpListener(interactiveID_Dead);
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
		PlayAreaEffect("Area_StoryActivity_17_Damge", GetPosition());
		foreach (LogicEntity item in GetTargetsByFaction(isFriend: true))
		{
			if (GetBuffNum(item, 317010030) >= 1)
			{
				AddBuffToTarget(item, 317010020);
			}
		}
		List<LogicEntity> targetByDataIDs = GetTargetByDataIDs(new List<int> { 3170008, 3170009, 3170010 });
		ClearActors(targetByDataIDs);
		List<LogicEntity> targetByDataIDs2 = GetTargetByDataIDs(new List<int> { 3170006, 3170007 });
		KillActors(targetByDataIDs2);
	}
}
