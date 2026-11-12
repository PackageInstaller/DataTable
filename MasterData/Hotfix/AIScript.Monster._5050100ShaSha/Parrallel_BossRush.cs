using System.Collections;
using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class Parrallel_BossRush : Parallel_BossRush
{
	private int skill_1 = 5050191;

	private int skill_2 = 5050186;

	private int skill_3 = 5050198;

	private int skill_4 = 5050196;

	private static int hitTag = CommonHelper.StringToHash("ShaSha_Duyu");

	private FP delayTime = 6;

	private string bossTagId_2 = "100004";

	private string areaEffect_water_2 = "AreaEffect_DarkRing_BossRush";

	private int buff_dmg_2 = 631005001;

	private int interval_2 = 5;

	private int accumulate_2 = 20;

	private int buff_skill_2 = 631005002;

	private int lost_time_2 = 15;

	private FP cd_2 = 3;

	private string bossTagId_3 = "100010";

	private string areaEffect_water_3 = "AreaEffect_WaterRing_BossRush";

	private int buff_dmg_3 = 631010001;

	private int interval_3 = 5;

	private int accumulate_3 = 10;

	private int lost_time_3 = 20;

	private FP cd_3 = 5;

	private int accumulate_3_1 = 20;

	private int buff_3_atk = 631001002;

	private FP cd_3_1 = 5;

	private int accumulate_3_2 = 10;

	private int buff_3_skill = 631001003;

	private FP cd_3_2 = 5;

	private string bossTagId_4 = "100024";

	private int buff_hpMax_4 = 631025010;

	private int buff_hurt_4 = 631025020;

	private int buff_dmg_4 = 631025030;

	private int accumulate_4 = 3;

	private FP cd_4 = 15;

	private FP duration_4 = 15;

	private bool isHit_1;

	private bool isHit_2;

	private bool isHit_3;

	private bool isHit_4;

	private CoroutineNode corSkill_1;

	private CoroutineNode corSkill_2;

	private CoroutineNode corSkill_3;

	private CoroutineNode corSkill_4;

	private bool hasTag_2;

	private bool hasTag_3;

	private CoroutineNode corCheckArea_2;

	private CoroutineNode corCheckArea_3;

	private CoroutineNode corBuff;

	private bool inLost;

	private FP curTime_2;

	private FP curTime_3;

	private FP curTime_3_1;

	private FP curTime_3_2;

	private Queue<FP> triggerTimes_2 = new Queue<FP>();

	private Queue<FP> triggerTimes_3 = new Queue<FP>();

	private Queue<FP> triggerTimes_3_1 = new Queue<FP>();

	private Queue<FP> triggerTimes_3_2 = new Queue<FP>();

	private bool hasTag_4;

	private FP curTime_4;

	private Queue<FP> triggerTimes_4 = new Queue<FP>();

	private CoroutineNode corBuffC_4;

	public override void OnStart()
	{
		base.OnStart();
		isHit_1 = false;
		isHit_2 = false;
		isHit_3 = false;
		isHit_4 = false;
		inLost = false;
		curTime_2 = 0;
		curTime_3 = 0;
		curTime_3_1 = 0;
		curTime_3_2 = 0;
		curTime_4 = 0;
		hasTag_2 = _actor.CheckTag(bossTagId_2);
		if (hasTag_2)
		{
			StartCoroutine(ref corCheckArea_2, CheckAreaEffect(buff_dmg_2, areaEffect_water_2, interval_2));
		}
		hasTag_3 = _actor.CheckTag(bossTagId_3);
		if (hasTag_3)
		{
			StartCoroutine(ref corCheckArea_3, CheckAreaEffect(buff_dmg_3, areaEffect_water_3, interval_3));
		}
		hasTag_4 = _actor.CheckTag(bossTagId_4);
		if (hasTag_4 && mainActor != null)
		{
			mainActor.buffComponent?.AddBuff(buff_hpMax_4, mainActor);
			mainActor.buffComponent?.AddBuff(buff_hurt_4, mainActor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		StopCoroutine(ref corSkill_1);
		StopCoroutine(ref corSkill_2);
		StopCoroutine(ref corSkill_3);
		StopCoroutine(ref corSkill_4);
		StopCoroutine(ref corCheckArea_2);
		StopCoroutine(ref corCheckArea_3);
		StopCoroutine(ref corBuff);
		StopCoroutine(ref corBuffC_4);
		triggerTimes_2.Clear();
		triggerTimes_3.Clear();
		triggerTimes_3_1.Clear();
		triggerTimes_3_2.Clear();
		triggerTimes_4.Clear();
		if (hasTag_4 && mainActor != null)
		{
			mainActor.buffComponent?.RemoveBuffByBuffId(buff_hpMax_4);
			mainActor.buffComponent?.RemoveBuffByBuffId(buff_hurt_4);
		}
	}

	protected override void OnActorCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnActorCastSkill(castSkillEvent);
		if (_actor != null && castSkillEvent.sender as AdventureActor == _actor)
		{
			if (castSkillEvent.skillEventInfo.skillId == skill_1)
			{
				isHit_1 = false;
				StartCoroutine(ref corSkill_1, DoCheckHit(skill_1));
			}
			else if (castSkillEvent.skillEventInfo.skillId == skill_2)
			{
				isHit_2 = false;
				StartCoroutine(ref corSkill_2, DoCheckHit(skill_2));
			}
			else if (castSkillEvent.skillEventInfo.skillId == skill_3)
			{
				isHit_3 = false;
				StartCoroutine(ref corSkill_3, DoCheckHit(skill_3));
			}
			else if (castSkillEvent.skillEventInfo.skillId == skill_4)
			{
				isHit_4 = false;
				StartCoroutine(ref corSkill_4, DoCheckHit(skill_4));
			}
		}
	}

	private IEnumerator DoCheckHit(int skillId)
	{
		yield return _actor.WaitTime(delayTime);
		if (skillId == skill_1)
		{
			if (!isHit_1 && _monster.CheckScoreBossBehaviour(15))
			{
				_monster.TriggerScoreBossBehaviour(15);
			}
			isHit_1 = false;
		}
		else if (skillId == skill_2)
		{
			if (!isHit_2 && _monster.CheckScoreBossBehaviour(15))
			{
				_monster.TriggerScoreBossBehaviour(15);
			}
			isHit_2 = false;
		}
		if (skillId == skill_3)
		{
			if (!isHit_3 && _monster.CheckScoreBossBehaviour(15))
			{
				_monster.TriggerScoreBossBehaviour(15);
			}
			isHit_3 = false;
		}
		else if (skillId == skill_4)
		{
			if (!isHit_4 && _monster.CheckScoreBossBehaviour(15))
			{
				_monster.TriggerScoreBossBehaviour(15);
			}
			isHit_4 = false;
		}
	}

	protected override void OnActorReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, hitTag) && damageEvent.to is PlayerAdventureActor)
		{
			isHit_1 = true;
			isHit_2 = true;
			isHit_3 = true;
			isHit_4 = true;
		}
		if (damageEvent.to.Id != _actor.Id)
		{
			return;
		}
		if (hasTag_4 && damageEvent.damageType == HotfixEnum.damageType.MARK && WinCheck(triggerTimes_4, accumulate_4, cd_4, ref curTime_4))
		{
			StartCoroutine(ref corBuffC_4, DoBuffC());
		}
		if (hasTag_2 && WinCheck(triggerTimes_2, accumulate_2, cd_2, ref curTime_2))
		{
			StartCoroutine(ref corBuff, DoLost(lost_time_2));
		}
		if (!hasTag_3)
		{
			return;
		}
		if (WinCheck(triggerTimes_3, accumulate_3, cd_3, ref curTime_3))
		{
			StartCoroutine(ref corBuff, DoLost(lost_time_3));
		}
		if (!inLost || !(damageEvent.from is PlayerAdventureActor playerAdventureActor))
		{
			return;
		}
		if (playerAdventureActor.isAssist)
		{
			if (WinCheck(triggerTimes_3_1, accumulate_3_1, cd_3_1, ref curTime_3_1))
			{
				_actor.buffComponent.AddBuff(buff_3_atk, playerAdventureActor);
			}
		}
		else if (WinCheck(triggerTimes_3_2, accumulate_3_2, cd_3_2, ref curTime_3_2))
		{
			_actor.buffComponent.AddBuff(buff_3_skill, playerAdventureActor);
		}
	}

	private IEnumerator DoLost(int lostTime)
	{
		inLost = true;
		if (hasTag_2)
		{
			_actor.buffComponent.AddBuff(buff_skill_2, _actor);
		}
		yield return _actor.WaitTime(lostTime);
		inLost = false;
		triggerTimes_3_1.Clear();
		triggerTimes_3_2.Clear();
		curTime_3_1 = 0;
		curTime_3_2 = 0;
		if (hasTag_2)
		{
			_actor.buffComponent.RemoveBuffByBuffId(buff_skill_2);
		}
		if (hasTag_3)
		{
			_actor.buffComponent.RemoveBuffByBuffId(buff_3_atk);
			_actor.buffComponent.RemoveBuffByBuffId(buff_3_skill);
		}
	}

	private IEnumerator DoBuffC()
	{
		_actor.buffComponent.AddBuff(buff_dmg_4, _actor);
		yield return _actor.WaitTime(duration_4);
		_actor.buffComponent.RemoveBuffByBuffId(buff_dmg_4);
	}

	private IEnumerator CheckAreaEffect(int buffId, string areaEffect, FP interval)
	{
		bool hasBuff = false;
		FP curTime = interval;
		while (true)
		{
			if (inLost || _actor.isUnparalleled)
			{
				if (hasBuff)
				{
					hasBuff = false;
					_actor.buffComponent.RemoveBuffByBuffId(buffId);
				}
			}
			else if (!hasBuff)
			{
				hasBuff = true;
				_actor.buffComponent.AddBuff(buffId, _actor);
			}
			if (hasBuff)
			{
				if (curTime <= 0)
				{
					curTime = interval;
					ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect, _actor.tsTransform.Position);
				}
				curTime -= _actor.LogicDeltaTime;
			}
			yield return null;
		}
	}

	private bool WinCheck(Queue<FP> triggerTimes, int accumulate, FP cd, ref FP curTime)
	{
		if (_actor.LogicTime - curTime > cd || curTime <= 0)
		{
			triggerTimes.Enqueue(_actor.LogicTime);
			_ = _actor.LogicTime;
			FP fP = _actor.LogicTime - interval_2;
			while (triggerTimes.Count > 0 && triggerTimes.Peek() < fP)
			{
				triggerTimes.Dequeue();
			}
			if (triggerTimes.Count >= accumulate)
			{
				triggerTimes.Clear();
				curTime = _actor.LogicTime;
				return true;
			}
		}
		return false;
	}
}
