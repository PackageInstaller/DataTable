using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Disc;

public class Disc_214002 : DiscScriptBase
{
	private const int discId = 214002;

	private int buff_state = 4002000;

	private List<int> skillId_s1 = new List<int> { 4002000, 4002001, 4002002, 4002003, 4002004 };

	private List<int> buffId_1 = new List<int> { 4002000, 4002001, 4002002, 4002003, 4002004 };

	private List<int> prob_l = new List<int> { 0, 0, 0, 0, 0 };

	private List<int> skillId_s2 = new List<int> { 4002000, 4002001, 4002002, 4002003, 4002004 };

	private List<int> once_2_1 = new List<int> { 0, 0, 0, 0, 0 };

	private List<int> once_2_2 = new List<int> { 0, 0, 0, 0, 0 };

	private List<int> skillId_s3 = new List<int> { 4002000, 4002001, 4002002, 4002003, 4002004 };

	private FP cd_3 = 15;

	private int lv_s1;

	private int lv_s2;

	private int lv_s3;

	private int stage_s1;

	private int stage_s2;

	private int stage_s3;

	private FP curTime;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		curTime = 0;
		(stage_s1, lv_s1) = GetDiscInfo(214002, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214002, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214002, skillId_s3);
		if (lv_s1 > 0)
		{
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
				playerAdventureActor.buffComponent.AddBuff(buffId_1.get_Item(stage_s1), playerAdventureActor);
			}
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		if (damageEvent.from is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.WE && damageEvent.to is MonsterAdventureActor monsterAdventureActor && lv_s1 > 0 && monsterAdventureActor.buffComponent.CheckBuffByBuffID(buff_state))
		{
			AdventureActor.AddFromAttr(once_2_1.get_Item(stage_s2), playerAdventureActor);
		}
		if (damageEvent.from is MonsterAdventureActor monsterAdventureActor2 && damageEvent.to is PlayerAdventureActor playerAdventureActor2 && playerAdventureActor2.actorElementInfo.elementType == HotfixEnum.elementType.WE && playerAdventureActor2 == _actor && lv_s2 > 0 && monsterAdventureActor2.buffComponent.CheckBuffByBuffID(buff_state))
		{
			AdventureActor.AddFromAttr(once_2_2.get_Item(stage_s2), monsterAdventureActor2);
		}
	}

	protected override void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforePlayerActorHit(actor, target, damageEvent);
		if (lv_s1 >= 1 && actor.actorElementInfo.elementType == HotfixEnum.elementType.WE && damageEvent.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, prob_l.get_Item(stage_s1));
			if (TSRandom.Range(0, 100) < scriptValue)
			{
				target.buffComponent.AddBuff(buff_state, actor);
			}
		}
	}

	protected override void OnPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		if (lv_s3 >= 1 && actor.actorElementInfo.elementType == HotfixEnum.elementType.AE && damageEvent.isKill && (_actor.LogicTime - curTime > cd_3 || curTime <= 0))
		{
			curTime = _actor.LogicTime;
			actor.GetLogicComponent<PlayerSkillCd>().ResetSkillCD(ActionKey.B);
		}
	}
}
