using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._13500010BigHeadGhost;

public class SkillScript_Death : SkillSimpleBase
{
	private int keyIndex1 = 1;

	private string key_dead = "Dead";

	private int keyIndex2 = 2;

	private string key_dash = "Dash";

	private string evt_boom = "135MainGhostDieBoom";

	private string evt_whine = "135MainGhostScream";

	private const int perkId_1 = 513501;

	private string areaEffect_1 = "AreaEffect_135_DieBoom_T2";

	private const int perkId_5 = 513505;

	private FP radiu_5 = 3;

	private string areaEffect_5 = "AreaEffect_135_DieCurse_T5";

	private const int buff_5 = 13550511;

	private PlayerAdventureActor mainCtrActor;

	private PlayerAdventureActor _summoner;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		mainCtrActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		_summoner = logicComponent.SummonActor as PlayerAdventureActor;
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		if (target != null && GetPerkLv(513501, out var lv))
		{
			BeginAttack(keyIndex2, key_dash, flushInputedKeys: true);
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			yield return BeginLookAt(target, 0);
			FP fP = _actor.DistanceWithRadius(target);
			FP speed = fP / 0.5f;
			BeginDashActorForward(keyIndex2, speed, fP, 360, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false);
			yield return WaitDashFinish();
		}
		_actor.PlayDeathAnim();
		BeginAttack(keyIndex1, key_dead, flushInputedKeys: true, forceInterruptAttack: true);
		if (GetPerkLv(513505, out var _))
		{
			yield return WaitCustomEvent(evt_whine);
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_5, _actor.tsTransform.Position);
			SkillScript_Death skillScript_Death = this;
			TSVector2 position = _actor.tsTransform.Position;
			FP radius = radiu_5;
			FP innerRadius = 0;
			DeterministicShape shapeData = skillScript_Death.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
			foreach (LogicEntity item in GetTargetsFromShape(shapeData))
			{
				if (item.IsConfrontWith(_actor))
				{
					(item as AdventureActor).buffComponent?.AddBuff(13550511, _actor);
				}
			}
		}
		if (GetPerkLv(513501, out lv))
		{
			yield return WaitCustomEvent(evt_boom);
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_1, _actor.tsTransform.Position);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_summoner.dataID, perkId, out lv);
	}

	private LogicEntity GetAttackTarget()
	{
		if (mainCtrActor == null)
		{
			return _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: false);
		}
		if (mainCtrActor.attackTarget == null)
		{
			return _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: false);
		}
		return mainCtrActor.attackTarget;
	}
}
