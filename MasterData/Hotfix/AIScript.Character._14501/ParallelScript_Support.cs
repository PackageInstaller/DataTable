using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14501;

public class ParallelScript_Support : ParallelScript
{
	private int bufff_Dot = 14590011;

	private int buffTag_Dot = CommonHelper.StringToHash("145NinjaKill");

	private string areaTag = "AreaEffect_145_SkilSup_SteelRain";

	private FP interval_Dot = 0.5;

	private string hurtFx_Dot = "";

	private int hitDmgId_Dot = 145300007;

	private int perkId_21 = 514521;

	private int buff_Dot_21 = 14521011;

	private int paramId_21_Cd = 14521012;

	private int paramId_21_ReduceCD = 14521011;

	private int paramId_21_RecoveryEnergy = 14521013;

	private int perkId_22 = 514522;

	private int paramId_22_Cd = 14522012;

	private int paramId_22_RecoveryEnergy = 14522011;

	private int hitId_22 = 145300010;

	private int perkId_23 = 514523;

	private string areaEffect_23 = "AreaEffect_145_P23_LiuDan";

	private string areaEffect_23_Sp = "AreaEffect_145_P23_LiuDan_Sp";

	private int paramId_23_BasePro = 14523011;

	private int paramId_23_AdditionPro = 14523012;

	private FP interval_23 = 0.3;

	private FP startTime_23 = 0.2;

	private int count_23 = 10;

	private int once_23 = 14523011;

	private int perkId_24 = 514524;

	private int once_24 = 14524011;

	private int perkId_25 = 514525;

	private string areaEffect_25_1 = "AreaEffect_145_P22_Sniper_1";

	private string areaEffect_25_2 = "AreaEffect_145_P22_Sniper_2";

	private string areaEffect_25_3 = "AreaEffect_145_P22_Sniper_3";

	private int paramId_25_cd = 14525011;

	private FP radius_25 = 5;

	private FP interval_25 = 0.2f;

	private int paramId_rate_25 = 14525012;

	private const int perkId_26 = 514526;

	private int buff_26 = 14526011;

	private const int perkId_27 = 514527;

	private int buff_27 = 14527011;

	private const int perkId_28 = 514528;

	private int once_28 = 14528001;

	private const int perkId_29 = 514529;

	private int buff_29 = 14529011;

	private const int perkId_30 = 514530;

	private int once_30 = 14530001;

	private const int perkId_31 = 514531;

	private int buff_31 = 14531011;

	private const int perkId_32 = 514532;

	private int buff_32 = 14532011;

	private const int perkId_33 = 514533;

	private CoroutineNode corP23;

	private CoroutineNode corP25;

	private DeterministicShape shape = new DeterministicShape
	{
		shapeType = DeterministicShape.ShapeType.Rectangle
	};

	private List<FP> triggerTimes = new List<FP>();

	private int skillId_B;

	private CoroutineNode corCd;

	private bool isAddBuff;

	private List<CoroutineNode> corList = new List<CoroutineNode>();

	private int addPro_23;

	public override void OnEnable()
	{
		base.OnEnable();
		addPro_23 = 0;
		skillId_B = skillMgr.GetCurrentBindSkillId(ActionKey.B);
		if (GetPerk(514526))
		{
			StartCoroutine(ref corCd, DoAddBuff());
		}
		if (GetPerk(514531))
		{
			bool flag = true;
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				if (actorL.actorElementInfo.elementType != HotfixEnum.elementType.DE)
				{
					flag = false;
					break;
				}
			}
			if (flag)
			{
				foreach (PlayerAdventureActor actorL2 in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
				{
					actorL2.buffComponent.AddBuff(buff_31, _actor);
				}
			}
		}
		if (!GetPerk(514532))
		{
			return;
		}
		List<PlayerAdventureActor> actorLs = SceneSingleton<AdventurePlayerController>.Instance.ActorLs;
		int num = 0;
		foreach (PlayerAdventureActor item in actorLs)
		{
			if (item.actorElementInfo.elementType == HotfixEnum.elementType.DE)
			{
				num++;
			}
		}
		foreach (PlayerAdventureActor item2 in actorLs)
		{
			if (item2.actorElementInfo.elementType == HotfixEnum.elementType.DE)
			{
				item2.buffComponent.AddBuffNum(buff_32, num, _actor);
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		StopCoroutine(ref corP25);
		StopCoroutine(ref corP23);
		StopCoroutine(ref corCd);
		triggerTimes.Clear();
		foreach (CoroutineNode cor in corList)
		{
			StopCoroutine(cor);
		}
		corList.Clear();
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt, bool isSelf)
	{
		base.OnCastSkill(evt, isSelf);
		if (GetPerk(514527) && evt.sender is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.DE && evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			_actor.buffComponent.AddBuff(buff_27, _actor);
		}
		if (isSelf && evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			addPro_23 = 0;
		}
	}

	public override void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPre(evt, monster, isSelf);
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnBeforeHit(evt, monster, isSelf);
		if (!isSelf)
		{
			return;
		}
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS);
		CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra);
		if (flag)
		{
			if (GetPerk(perkId_23))
			{
				AdventureActor.AddFromAttr(once_23, _actor);
			}
			if (GetPerk(perkId_24) && (monster.buffComponent.CheckBuffByBuffID(buffId_Dark) || CommonUtils.CheckElementMark(CommonDefine.Dark, monster)))
			{
				AdventureActor.AddFromAttr(once_24, _actor);
			}
			if (GetPerk(514528))
			{
				AdventureActor.AddFromAttr(once_28, _actor);
			}
			if (GetPerk(514530) && (monster.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monster.IsBossMonster()))
			{
				AdventureActor.AddFromAttr(once_30, _actor);
			}
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		if (isSelf)
		{
			bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS);
			bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra);
			bool flag3 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Mark);
			if (flag)
			{
				int num = (GetPerk(perkId_21) ? buff_Dot_21 : bufff_Dot);
				if (!monster.buffComponent.CheckBuffByBuffID(num))
				{
					monster.buffComponent.AddBuff(num, _actor);
					CoroutineNode item = StartCoroutine(DoDot(monster, num));
					corList.Add(item);
				}
				if (GetPerk(514529))
				{
					monster.buffComponent.AddBuff(buff_29, _actor);
				}
			}
			else if (flag2 && GetPerk(514533))
			{
				monster.buffComponent.AddBuff(buffId_Mark, _actor);
			}
			if (flag3)
			{
				monster.buffComponent.AddBuff(buffId_Mark, _actor);
			}
			if (evt.damageType == HotfixEnum.damageType.ULTIMATE)
			{
				if (GetPerk(perkId_21))
				{
					FP scriptValue = CommonUtils.GetScriptValue(_actor, paramId_21_Cd);
					if (CheckPerkCd(perkId_21, scriptValue))
					{
						FP scriptValue2 = CommonUtils.GetScriptValue(_actor, paramId_21_ReduceCD);
						skillMgr.ModifyResumeTimeAbs(-scriptValue2, ActionKey.D);
						FP scriptValue3 = CommonUtils.GetScriptValue(_actor, paramId_21_RecoveryEnergy);
						skillMgr.AddEnergy(scriptValue3);
					}
				}
				if (GetPerk(perkId_25))
				{
					FP scriptValue4 = CommonUtils.GetScriptValue(_actor, paramId_rate_25);
					if (TSRandom.value <= scriptValue4)
					{
						FP scriptValue5 = CommonUtils.GetScriptValue(_actor, paramId_25_cd);
						if (CheckPerkCd(perkId_25, scriptValue5))
						{
							StartCoroutine(ref corP25, OnCastAreaEffect(monster));
						}
					}
				}
			}
		}
		if (!(SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor == evt.from) || SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.actorElementInfo.elementType != HotfixEnum.elementType.DE || !GetPerk(perkId_22) || !monster.buffComponent.CheckBuffByBuffTag(buffTag_Dot))
		{
			return;
		}
		FP scriptValue6 = CommonUtils.GetScriptValue(_actor, paramId_22_Cd);
		if (!CheckPerkCd(perkId_22, scriptValue6))
		{
			return;
		}
		int key = TSRandom.Range(0, dicAreaEffectAim.Count);
		ILRuntimeAPI.PlayAreaEffect(_actor, dicAreaEffectAim.get_Item(key), monster.tsTransform.Position, default, (AreaEffectEntity entity) =>
		{
			AreaEffect_AttackComponent logicComponent = entity.GetLogicComponent<AreaEffect_AttackComponent>();
			if (logicComponent != null)
			{
				logicComponent.hitDamageId = hitId_22;
			}
		});
		FP scriptValue7 = CommonUtils.GetScriptValue(_actor, paramId_22_RecoveryEnergy);
		skillMgr.AddEnergy(scriptValue7);
	}

	public override void OnTriggerMask(AdventureActorReceiveDamageEvent evt)
	{
		base.OnTriggerMask(evt);
	}

	public override void OnAreaEffectBegin(AdventureAreaEffectBeginEvent evt)
	{
		base.OnAreaEffectBegin(evt);
		if (evt.sender as LogicEntity is AreaEffectEntity areaEffectEntity && areaEffectEntity.areaTag.Equals(areaTag) && GetPerk(perkId_23))
		{
			CoroutineNode item = StartCoroutine(OnShootBomb(areaEffectEntity));
			corList.Add(item);
		}
	}

	private IEnumerator OnShootBomb(AreaEffectEntity areaEffect)
	{
		yield return _actor.WaitTime(startTime_23);
		AreaEffect_MoveComponent moveCom = areaEffect.GetAreaEffectComponent<AreaEffect_MoveComponent>();
		int curCount = 0;
		int basePro = CommonUtils.GetScriptValue(_actor, paramId_23_BasePro).AsInt();
		int additionPro = CommonUtils.GetScriptValue(_actor, paramId_23_AdditionPro).AsInt();
		while (!(areaEffect == null) && !areaEffect.Finished && curCount < count_23)
		{
			shape.length = 0.2;
			shape.width = 7;
			shape.position = areaEffect.tsTransform.Position + areaEffect.tsTransform.Forward * moveCom.Speed * 0.5;
			shape.rotation = areaEffect.tsTransform.Rotation;
			TSVector2 position = _actor.RandomActorReachablePointInsideShape(shape);
			if (TSRandom.Range(0, 100) < addPro_23 + basePro)
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_23_Sp, position);
			}
			else
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_23, position);
			}
			curCount++;
			addPro_23 += additionPro;
			yield return _actor.WaitTime(interval_23);
		}
	}

	private IEnumerator DoAddBuff()
	{
		isAddBuff = false;
		while (true)
		{
			if (skillMgr.CheckCD(skillId_B))
			{
				if (!isAddBuff)
				{
					_actor.buffComponent.AddBuff(buff_26, _actor);
					isAddBuff = true;
				}
			}
			else if (isAddBuff)
			{
				_actor.buffComponent.RemoveBuffByBuffId(buff_26);
				isAddBuff = false;
			}
			yield return null;
		}
	}

	private IEnumerator OnCastAreaEffect(MonsterAdventureActor monster)
	{
		FP fP = radius_25 + monster.GetRadius();
		TSVector2 v = (_actor.tsTransform.Position - monster.tsTransform.Position).normalized * fP;
		TSVector2 tSVector = monster.tsTransform.Position + TSVector2.Rotate(v, TSRandom.Range(-90, -31));
		TSVector2 normalized = (monster.tsTransform.Position - tSVector).normalized;
		TSVector2 targetPosition2 = monster.tsTransform.Position + TSVector2.Rotate(v, TSRandom.Range(-30, 31));
		TSVector2 dir2 = (monster.tsTransform.Position - targetPosition2).normalized;
		TSVector2 targetPosition3 = monster.tsTransform.Position + TSVector2.Rotate(v, TSRandom.Range(30, 91));
		TSVector2 dir3 = (monster.tsTransform.Position - targetPosition3).normalized;
		ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_25_1, tSVector, normalized.GetAngle());
		yield return _actor.WaitTime(interval_25);
		ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_25_2, targetPosition2, dir2.GetAngle());
		yield return _actor.WaitTime(interval_25);
		ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_25_3, targetPosition3, dir3.GetAngle());
	}

	private IEnumerator DoDot(MonsterAdventureActor monster, int buffId)
	{
		ILRuntimeAPI.HitActor(_actor, monster, hitDmgId_Dot, hurtFx_Dot);
		FP curTime = interval_Dot;
		while (!(monster == null) && monster.buffComponent.CheckBuffByBuffID(buffId))
		{
			if (curTime <= 0)
			{
				curTime = interval_Dot;
				ILRuntimeAPI.HitActor(_actor, monster, hitDmgId_Dot, hurtFx_Dot);
			}
			yield return null;
			curTime -= _actor.LogicDeltaTime;
		}
	}
}
