using System.Collections;
using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._50571FengShanJi;

public class Parrallel_BossRush : Parallel_BossRush
{
	private int teamMate_1 = 1;

	private int killCount = 3;

	private int skill_1 = 5057119;

	private int skill_2 = 5057118;

	private int skill_3 = 5057117;

	private int hitTag_1 = CommonHelper.StringToHash("SelfBullet1");

	private int hitTag_2 = CommonHelper.StringToHash("SelfBullet1");

	private int hitTag_3 = CommonHelper.StringToHash("SelfBullet2");

	private readonly string bossTagId = "100005";

	private readonly int buff_sum = 631006001;

	private readonly FP buff_sumCd = 1;

	private readonly FP buff_sumAddTime = 0.6;

	private readonly int buff_player = 631006011;

	private readonly FP buff_playerCd = 1;

	private readonly FP buff_playerAddTime = 0.6;

	private readonly string bossTagId_2 = "100016";

	private readonly int killCount_guwu = 3;

	private readonly int buff_guwu = 631016010;

	private readonly FP buff_guwuAddTime = 5;

	private readonly FP buff_guwuMaxTime = 20;

	private readonly int buffTag_guwu = CommonHelper.StringToHash("GuwuHit");

	private readonly FP buff_BaseTime = 10;

	private bool isHit_1;

	private bool isHit_2;

	private bool isHit_3;

	private int summonId_1;

	private int count_kill;

	private int count_kill2;

	private CoroutineNode corSkill_1;

	private CoroutineNode corSkill_2;

	private CoroutineNode corSkill_3;

	private bool hasTag;

	private List<MonsterAdventureActor> monsters = new List<MonsterAdventureActor>();

	private FP curTime;

	private bool inSumstate;

	private FP buffCD;

	private bool hasTag_2;

	private int count_killGuwu;

	public override void OnStart()
	{
		base.OnStart();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_START_MSG", OnBattleStart);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		isHit_1 = false;
		isHit_2 = false;
		isHit_3 = false;
		MonsterAdventureActor monsterAdventureActor = _actor as MonsterAdventureActor;
		summonId_1 = CommonHelper.GetMonsterTeammateId(monsterAdventureActor.monsterInfo.teamId, teamMate_1);
		hasTag = _actor.CheckTag(bossTagId);
		hasTag_2 = _actor.CheckTag(bossTagId_2);
		count_kill2 = 0;
		count_kill = 0;
		count_killGuwu = 0;
		curTime = 0;
		buffCD = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_START_MSG", OnBattleStart);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		StopCoroutine(ref corSkill_1);
		StopCoroutine(ref corSkill_2);
		StopCoroutine(ref corSkill_3);
		monsters.Clear();
	}

	private void OnBattleStart(IEvent evt)
	{
		if (evt is AdventureMsgBattleStartEvent)
		{
			inSumstate = true;
			if (hasTag && inSumstate)
			{
				_actor.buffComponent?.AddBuff(buff_sum, _actor);
			}
		}
	}

	protected override void OnActorCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnActorCastSkill(castSkillEvent);
		if (castSkillEvent.sender as AdventureActor == _actor)
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
		}
		if (!hasTag_2 || !(castSkillEvent.sender is PlayerAdventureActor { isAssist: false }) || castSkillEvent.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.B)
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor2 = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor2.buffComponent.CheckBuffByBuffID(buff_guwu))
			{
				FP buffLeftTimeByBuffTag = playerAdventureActor2.buffComponent.GetBuffLeftTimeByBuffTag(buffTag_guwu);
				FP val = buff_guwuAddTime;
				val = TSMath.Min(val, buff_guwuMaxTime - buffLeftTimeByBuffTag);
				playerAdventureActor2.buffComponent.AddBuffDurationByBuffID(buff_guwu, val);
			}
		}
	}

	private IEnumerator DoCheckHit(int skillId)
	{
		if (skillId == skill_1)
		{
			if (_actor.logicVariable.GetLogicTagValue("BattleStage") == 1)
			{
				yield return _actor.WaitTime(5.5f);
			}
			else
			{
				yield return _actor.WaitTime(8f);
			}
			if (!isHit_1 && _monster.CheckScoreBossBehaviour(19))
			{
				_monster.TriggerScoreBossBehaviour(19);
			}
			isHit_1 = false;
		}
		else if (skillId == skill_2)
		{
			yield return _actor.WaitTime(4f);
			if (!isHit_2 && _monster.CheckScoreBossBehaviour(19))
			{
				_monster.TriggerScoreBossBehaviour(19);
			}
			isHit_2 = false;
		}
		else if (skillId == skill_3)
		{
			yield return _actor.WaitTime(3.5f);
			if (!isHit_3 && _monster.CheckScoreBossBehaviour(19))
			{
				_monster.TriggerScoreBossBehaviour(19);
			}
			isHit_3 = false;
		}
	}

	protected override void OnActorDied(IEvent e)
	{
		if (!(e is AdventureActorDiedEvent adventureActorDiedEvent) || adventureActorDiedEvent.actor.dataID != summonId_1 || (adventureActorDiedEvent.deadType != DeadType.NormalDmgkill && adventureActorDiedEvent.deadType != DeadType.DirectDmgKill && adventureActorDiedEvent.deadType != DeadType.Kill) || !adventureActorDiedEvent.actor.IsConfrontWith(adventureActorDiedEvent.killer))
		{
			return;
		}
		count_kill++;
		if (count_kill >= killCount)
		{
			count_kill = 0;
			if (_monster.CheckScoreBossBehaviour(18))
			{
				_monster.TriggerScoreBossBehaviour(18);
			}
		}
		if (!hasTag_2)
		{
			return;
		}
		count_killGuwu++;
		if (count_killGuwu < killCount_guwu)
		{
			return;
		}
		count_killGuwu = 0;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.buffComponent.GetBuffLeftTimeByBuffTag(buffTag_guwu) <= buff_BaseTime)
			{
				playerAdventureActor.buffComponent.AddBuff(buff_guwu, playerAdventureActor);
			}
		}
	}

	protected override void OnActorReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, hitTag_1))
		{
			if (damageEvent.to is PlayerAdventureActor)
			{
				isHit_1 = true;
				isHit_2 = true;
			}
		}
		else if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, hitTag_3) && damageEvent.to is PlayerAdventureActor)
		{
			isHit_3 = true;
		}
		if (damageEvent.to is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor == _actor && hasTag && damageEvent.from.IsPlayerMinion(out var _) && !inSumstate && _actor.LogicTime - buffCD > buff_playerCd)
		{
			buffCD = _actor.LogicTime;
			_actor.buffComponent?.AddBuffDurationByBuffID(buff_player, buff_playerAddTime);
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent elementMarkTriggerEvent)
	{
		if (hasTag && !(SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor == null) && elementMarkTriggerEvent.markActor == _actor && inSumstate && _actor.LogicTime - buffCD > buff_sumCd)
		{
			buffCD = _actor.LogicTime;
			_actor.buffComponent?.AddBuffDurationByBuffID(buff_sum, buff_sumAddTime);
		}
	}

	private void OnRemoveBuff(IEvent evt)
	{
		AdventureActorRemoveBuff adventureActorRemoveBuff = evt as AdventureActorRemoveBuff;
		if (hasTag && adventureActorRemoveBuff.eventInfo.iRemoveNature)
		{
			if (adventureActorRemoveBuff.eventInfo.buffId == buff_sum)
			{
				inSumstate = false;
				_actor.buffComponent?.AddBuff(buff_player, _actor);
			}
			else if (adventureActorRemoveBuff.eventInfo.buffId == buff_player)
			{
				inSumstate = true;
				_actor.buffComponent?.AddBuff(buff_sum, _actor);
			}
		}
	}
}
