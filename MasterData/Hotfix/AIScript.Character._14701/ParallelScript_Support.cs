using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14701;

public class ParallelScript_Support : ParallelScript
{
	private const int perkId_21 = 514721;

	private int once_21 = 14721011;

	private const int perkId_22 = 514722;

	private int maxCount_22 = 4;

	private int paramId_22_castCd = 14722011;

	private string areaEffect_22 = "AreaEffect_147_P22_AOE";

	private int paramId_22_cd = 14722012;

	private const int perkId_25 = 514725;

	private int once_25 = 14725001;

	private FP pullTime_25 = 0.1;

	private FP pullSpeed_25 = 15;

	private int pullLevel_25 = 4;

	private FP strength_25 = 3;

	private bool pullWithRadius_25;

	private bool changeTargetDirection_25;

	private const int perkId_26 = 514726;

	private int once_26 = 14726001;

	private const int perkId_27 = 514727;

	private int once_27 = 14727001;

	private FP distance_27 = 3;

	private const int perkId_29 = 514729;

	private int buff_29 = 14729011;

	private int once_29 = 14729001;

	private const int perkId_30 = 514730;

	private int once_30 = 14730001;

	private const int perkId_31 = 514731;

	private int buff_31 = 14731011;

	private const int perkId_32 = 514732;

	private int once_32 = 14732001;

	private const int perkId_33 = 514733;

	private int buff_33 = 14733011;

	private List<FP> triggerTimes = new List<FP>();

	public override void OnEnable()
	{
		base.OnEnable();
		if (!GetPerkLv(514733, out var _))
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.DE)
			{
				playerAdventureActor.buffComponent.AddBuff(buff_33, _actor);
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		triggerTimes.Clear();
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnBeforeHit(evt, monster, isSelf);
		if (!isSelf)
		{
			return;
		}
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS1);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS2);
		bool flag3 = flag | flag2;
		int lv;
		if (flag)
		{
			if (GetPerkLv(514721, out lv))
			{
				AdventureActor.AddFromAttr(once_21, _actor);
			}
			if (GetPerkLv(514725, out lv))
			{
				AdventureActor.AddFromAttr(once_25, _actor);
			}
			if (GetPerkLv(514726, out lv))
			{
				AdventureActor.AddFromAttr(once_26, _actor);
			}
			if (GetPerkLv(514727, out lv) && TSVector2.Distance(_actor.tsTransform.Position, monster.tsTransform.Position) < distance_27)
			{
				AdventureActor.AddFromAttr(once_27, _actor);
			}
		}
		else if (flag2)
		{
			if (GetPerkLv(514729, out lv))
			{
				int buffNumByID = monster.buffComponent.GetBuffNumByID(buff_29);
				if (buffNumByID > 0)
				{
					AdventureActor.AddFromAttr(once_29, _actor, buffNumByID);
				}
			}
			if (GetPerkLv(514730, out lv) && (monster.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monster.IsBossMonster()))
			{
				AdventureActor.AddFromAttr(once_30, _actor);
			}
		}
		if (flag3 && GetPerkLv(514732, out lv) && monster.buffComponent.CheckBuffByBuffID(buffId_Dark))
		{
			AdventureActor.AddFromAttr(once_32, _actor);
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		if (!isSelf)
		{
			return;
		}
		CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS);
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS1);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS2);
		int lv;
		if (flag)
		{
			if (GetPerkLv(514722, out lv))
			{
				FP scriptValue = CommonUtils.GetScriptValue(_actor, paramId_22_castCd);
				FP logicTime = _actor.LogicTime;
				FP fP = _actor.LogicTime - scriptValue;
				for (int num = triggerTimes.Count - 1; num >= 0; num--)
				{
					if (triggerTimes.get_Item(num) < fP)
					{
						triggerTimes.RemoveAt(num);
					}
				}
				if (triggerTimes.Count < maxCount_22)
				{
					FP scriptValue2 = CommonUtils.GetScriptValue(_actor, paramId_22_cd);
					skillMgr.ModifyResumeTimeAbs(scriptValue2, ActionKey.B);
					ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_22, monster.tsTransform.Position);
					triggerTimes.Add(logicTime);
				}
			}
			if (GetPerkLv(514725, out lv))
			{
				FP distance = pullSpeed_25 * pullTime_25;
				ILRuntimeAPI.ForceMoveByDistanceToPosition(_actor, _actor.tsTransform.Position, monster, distance, pullSpeed_25, strength_25, pullLevel_25, isPull: true, pullWithRadius_25, isCoExist: true, changeTargetDirection_25);
			}
		}
		else if (flag2 && GetPerkLv(514729, out lv))
		{
			monster.buffComponent.AddBuff(buff_29, _actor);
		}
	}

	public override void OnTriggerMask(AdventureActorReceiveDamageEvent evt)
	{
		base.OnTriggerMask(evt);
		if (GetPerkLv(514731, out var _) && (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS2) || CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS1)))
		{
			_actor.buffComponent.AddBuff(buff_31, _actor);
		}
	}
}
