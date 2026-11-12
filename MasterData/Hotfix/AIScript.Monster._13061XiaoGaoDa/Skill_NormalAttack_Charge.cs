using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._13061XiaoGaoDa;

public class Skill_NormalAttack_Charge : SkillSimpleBase
{
	private static readonly FP _rotateSpeed = 240;

	private static readonly FP _duration = 0.6;

	private static readonly FP _waitSeconds = 0;

	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1];

	private int hitTag = CommonHelper.StringToHash("XiaoGaoda_Dash");

	private int hitCount;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		hitCount = 0;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity _target = GetAttackTarget();
		BeginLookAt(_target, 1, 400);
		yield return WaitTime(0.5);
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		BeginLookAt_NotWait(_target, _duration, _rotateSpeed);
		yield return WaitTime(1.5);
		doDash_A();
		yield return WaitTime(0.4);
		BeginLookAt_NotWait(_target, 0.6, 280);
		yield return WaitTime(0.6);
		doDash_B();
		yield return WaitTime(0.4);
		BeginLookAt_NotWait(_target, 0.4, 400);
		yield return WaitTime(0.4);
		doDash_C();
		yield return WaitTime(0.2);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		if (hitCount == 3 && !ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.XiaoGaoDa_002))
		{
			ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(HotfixEnum.questCompleteCondClient.XiaoGaoDa_002);
		}
	}

	private void doDash_A()
	{
		BeginDashActorForward(1, 60, 10, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void doDash_B()
	{
		BeginDashActorForward(2, 60, _actor.DistanceWithRadius(GetAttackTarget()) + 1, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void doDash_C()
	{
		BeginDashActorForward(3, 60, _actor.DistanceWithRadius(GetAttackTarget()), 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void OnReceiveDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent)
		{
			PlayerAdventureActor playerAdventureActor = adventureActorReceiveDamageEvent.to as PlayerAdventureActor;
			MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageEvent.from as MonsterAdventureActor;
			if (playerAdventureActor != null && monsterAdventureActor != null && monsterAdventureActor == _actor && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, hitTag))
			{
				hitCount++;
			}
		}
	}
}
