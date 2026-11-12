using System.Collections;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Attack_OctopusBattery_Trap : SkillSimpleBase
{
	private static readonly string combo_Attack = "Attack";

	private static readonly string combo_Awake = "Awake";

	private static readonly string combo_Sleep = "Sleep";

	private CoroutineNode _sleepCor;

	private CoroutineNode _attackCor;

	private TSVector2 _enterForward;

	private bool _sleeping;

	private LogicEntity targetEnemy;

	private long WarningFX;

	private int trapGroupId;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_enterForward = GetForward();
		_sleeping = false;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		StopEffect(WarningFX);
		StopCor(_sleepCor);
		StopCor(_attackCor);
		StopWaitLookAt();
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && !(adventureActorCustomEvent.eventName != "weiluohuodongEvent") && !_sleeping)
		{
			_sleeping = true;
			trapGroupId = adventureActorCustomEvent.eventHashCode;
			StartCor(ref _sleepCor, DoSleep());
		}
	}

	private IEnumerator DoSleep()
	{
		StopCor(_attackCor);
		StopWaitLookAt();
		StopEffect(WarningFX);
		BeginLookAtByPos(GetPosition() + _enterForward, 0, 720);
		yield return WaitTime(0.3);
		StopWaitLookAt();
		BeginAttack(3, combo_Sleep, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.2);
		ReplaceAnimationGroup(1);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		OntrapDeactive();
	}

	private IEnumerator DoAttack()
	{
		while (true)
		{
			GetEnemy();
			if (targetEnemy != null)
			{
				BeginLookAt_NotWait(targetEnemy, 1.5, 720);
			}
			BeginAttack(2, combo_Attack, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitTime(1.5);
			CancelAttack();
			WarningFX = PlayEffect("fx_common_base_charge_water_actor", 1f, 1, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1.5)), 0);
			yield return WaitTime(0.2);
			StopEffect(WarningFX);
			TSVector2 shootPosition = GetPosition() + TSVector2.Rotate(new TSVector2(0, 1f), _actor.tsTransform.Rotation);
			FanMultipleShoot("Bullet_31302ZhangYuPaoTai_Skill01", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 5, 0, shootPosition, 1.2, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 120, 0, 0);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield return WaitTime(0.5);
		}
	}

	private void OntrapDeactive()
	{
		AdventureTrapActive adventureTrapActive = AdventureTrapActive.Generate();
		adventureTrapActive.GroupId = trapGroupId;
		adventureTrapActive.isActive = false;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureTrapActive);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, combo_Awake, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.5);
		ReplaceAnimationGroup();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StartCor(ref _attackCor, DoAttack());
		yield return WaitTime(99999);
	}

	private void GetEnemy()
	{
		targetEnemy = GetAttackTarget();
		if (targetEnemy == null)
		{
			targetEnemy = GetCurrentPlayer();
		}
	}
}
