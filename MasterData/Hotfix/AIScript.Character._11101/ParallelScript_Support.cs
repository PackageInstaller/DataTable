using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._11101;

public class ParallelScript_Support : ParallelScript
{
	public int hitTag_Area = CommonHelper.StringToHash("111_P21");

	public static readonly int areaTag = CommonHelper.StringToHash("Skill_Area");

	private int evt_CastArea = CommonHelper.StringToHash("CastArea");

	private const int perkId_1 = 511121;

	private int once_1 = 11152111;

	private const int perkId_2 = 511122;

	private int once_2 = 11152211;

	private const int perkId_3 = 511123;

	private const string aoe_3 = "AreaEffect_11101_B2P23_Skill_IceWave_Stun";

	private FP delayTime_3 = 1;

	private const int perkId_4 = 511124;

	private string areaEffect_4 = "AreaEffect_11101_B2P24_IceWave_EndHurt";

	private string areaEffect_4_big = "AreaEffect_11101_B2P21P24_IceWave_LargeEndHurt";

	private const int perkId_5 = 511125;

	private const int once_5 = 11152501;

	private const int perkId_6 = 511126;

	private const int once_6 = 11152601;

	private int hitTag_6 = CommonHelper.StringToHash("111_P26");

	private const int perkId_7 = 511127;

	private readonly FP cd_7 = 0;

	private const int buff_7 = 11152711;

	private const int perkId_9 = 511129;

	private readonly FP cd_9 = 0;

	private int buffId_9 = 11152911;

	private readonly string areaEffect_9 = "AreaEffect_11101_B2P29_Skill_IceWave_DeathBoom";

	private const int perkId_12 = 511132;

	private const int buff_12 = 11153211;

	private const int perkId_13 = 511133;

	private const int buff_13 = 11153311;

	private bool firstCast;

	private CoroutineNode corDelay;

	public override void OnEnable()
	{
		base.OnEnable();
		firstCast = false;
		if (GetPerkLv(511132, out var _))
		{
			_actor.buffComponent.AddBuff(11153211, _actor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		StopCoroutine(ref corDelay);
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnCastSkill(evt);
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && GetPerkLv(511133, out var _) && !firstCast)
		{
			firstCast = true;
			Singleton<BuffManager>.Instance.AddBufftoGroup(11153311, _actor);
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		base.OnBeforeHit(evt, monster);
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill);
		CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra);
		if (flag)
		{
			if (GetPerkLv(511121, out var lv) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Area))
			{
				AdventureActor.AddFromAttr(once_1, _actor);
			}
			if (GetPerkLv(511122, out lv) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Area))
			{
				AdventureActor.AddFromAttr(once_2, _actor);
			}
			if (GetPerkLv(511125, out lv) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Area))
			{
				AdventureActor.AddFromAttr(11152501, _actor);
			}
			if (GetPerkLv(511126, out lv) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_6))
			{
				AdventureActor.AddFromAttr(11152601, _actor);
			}
		}
	}

	public override void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster)
	{
		base.OnHitPre(evt, monster);
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra);
		int lv;
		if (flag)
		{
			if (GetPerkLv(511127, out lv) && monster.buffComponent.CheckBuffByBuffTag(ParallelScript.buffTag_Cold))
			{
				(SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor).buffComponent.AddBuff(11152711, _actor);
			}
		}
		else if (flag2 && GetPerkLv(511132, out lv))
		{
			monster.buffComponent.AddBuff(buffA, _actor);
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		base.OnHitPost(evt, monster);
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill);
		CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra);
		if (flag)
		{
			if (GetPerkLv(511129, out var _))
			{
				monster.buffComponent.AddBuff(buffId_9, _actor);
			}
			TriggerMask(monster, evt.hitDamageTag);
		}
	}

	public override void OnMonsterKilled(AdventureActorDiedEvent evt, MonsterAdventureActor monster)
	{
		if (GetPerkLv(511129, out var _) && monster.buffComponent.CheckBuffByBuffID(buffId_9))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_9, monster.tsTransform.Position);
		}
	}

	public override void OnAreaEffectFinish(AdventureAreaEffectFinishEvent evt)
	{
		base.OnAreaEffectFinish(evt);
		AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(evt.entityID);
		if (areaEffect != null && areaEffect.CheckTag(areaTag) && GetPerkLv(511124, out var lv))
		{
			string text = (GetPerkLv(511121, out lv) ? areaEffect_4_big : areaEffect_4);
			Debug.Log(text);
			ILRuntimeAPI.PlayAreaEffect(_actor, text, areaEffect.tsTransform.Position);
		}
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		if (evt.eventHashCode == evt_CastArea)
		{
			TSVector2 pos = evt.tsVector2ParamList.get_Item(0);
			StartCoroutine(ref corDelay, DoCastAreaEffect(pos));
		}
	}

	private IEnumerator DoCastAreaEffect(TSVector2 pos)
	{
		yield return _actor.WaitTime(delayTime_3);
		ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_11101_B2P23_Skill_IceWave_Stun", pos, _actor.tsTransform.Rotation);
	}
}
