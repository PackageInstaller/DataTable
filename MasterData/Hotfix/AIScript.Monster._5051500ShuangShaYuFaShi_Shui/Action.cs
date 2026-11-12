#define LOG_DEBUG
using System;
using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._5051500ShuangShaYuFaShi_Shui;

public class Action : AIBase
{
	protected enum Stage
	{
		Common,
		Fury
	}

	protected enum SkillId
	{
		ShuiKeng = 5051500,
		ShuiKeng_QiangHua = 5051502,
		ShuiLiu = 5051501,
		ShuiLiu_QiangHua = 5051503
	}

	private readonly int targetMonsterId = 5052000;

	private readonly FP commonDuration = 6;

	private readonly FP furyDuration = 0;

	private Stage stage;

	private bool checkSkill;

	private FP skillDuration = 6;

	private CoroutineNode chooseSkill;

	private SkillId curSkillId = SkillId.ShuiLiu;

	private FP curDuration = 0;

	public void OnEnable()
	{
		checkSkill = true;
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDied);
		instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		stage = Stage.Common;
		InitSkill();
	}

	public void OnDisable()
	{
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		instance.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDied);
		instance.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
	}

	private void MonsterDied(IEvent ievent)
	{
		if (ievent != null && ((AdventureMonsterDiedEvent)ievent).id == targetMonsterId)
		{
			ResetStage(Stage.Fury);
			if (chooseSkill != null)
			{
				_actor.StopLogicCoroutine(chooseSkill);
				chooseSkill = null;
			}
			CheckSkill();
		}
	}

	protected void InitSkill()
	{
	}

	public void OnStart()
	{
		ResetStage(Stage.Common);
		CheckSkill();
	}

	public void OnStop()
	{
		Clear();
	}

	private void Clear()
	{
		if (chooseSkill != null)
		{
			StopCoroutine(chooseSkill);
			chooseSkill = null;
		}
		checkSkill = false;
	}

	private void ResetStage(Stage stage)
	{
		this.stage = stage;
		if (this.stage == Stage.Common)
		{
			curDuration = commonDuration;
			curSkillId = SkillId.ShuiLiu;
		}
		else if (this.stage == Stage.Fury)
		{
			curDuration = furyDuration;
			curSkillId = SkillId.ShuiLiu_QiangHua;
		}
		NovaLogger.Debug("cur skill id = " + curSkillId);
		FP fP = curDuration;
		NovaLogger.Debug("cur curDuration = " + fP.ToString());
	}

	private void CheckSkill()
	{
		NovaLogger.Debug("check skill");
		switch (stage)
		{
		case Stage.Common:
			if (curSkillId == SkillId.ShuiKeng)
			{
				curSkillId = SkillId.ShuiLiu;
			}
			else if (curSkillId == SkillId.ShuiLiu)
			{
				curSkillId = SkillId.ShuiKeng;
			}
			break;
		case Stage.Fury:
			if (curSkillId == SkillId.ShuiKeng_QiangHua)
			{
				curSkillId = SkillId.ShuiLiu_QiangHua;
			}
			else if (curSkillId == SkillId.ShuiLiu_QiangHua)
			{
				curSkillId = SkillId.ShuiKeng_QiangHua;
			}
			break;
		}
		NovaLogger.Debug("check skill" + curSkillId);
		ILRuntimeAPI.CreateSkill((int)curSkillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false);
	}

	private IEnumerator Wait(System.Action callback, FP duration)
	{
		yield return duration;
		callback?.Invoke();
	}

	private void OnCastSkillEnd(IEvent ievent)
	{
		AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent = (AdventureActorCastSkillEndEvent)ievent;
		if (adventureActorCastSkillEndEvent == null || ((AdventureActor)adventureActorCastSkillEndEvent.sender).Id != _actor.Id)
		{
			return;
		}
		if (curDuration <= 0)
		{
			CheckSkill();
			return;
		}
		if (chooseSkill != null)
		{
			StopCoroutine(chooseSkill);
			chooseSkill = null;
		}
		chooseSkill = StartCoroutine(Wait(CheckSkill, curDuration));
	}
}
