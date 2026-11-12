using System;
using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._14001;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private string comboKey_TransformBegin = "Transform_Start";

	private FP totleMaxDuration = 10;

	private int animGroupIndex_Gatling = 1;

	private string comboKey_Transform_Cannon = "Transform_Cannon";

	private string comboKey_Transform_CannonEnd = "Recover_Cannon";

	private string comboKey_Gatling = "Attack_Cannon";

	private string comboKey_Gatling_P1 = "FastShoot_Cannon";

	private int count_Gatling = 8;

	private int animGroupIndex_Tank;

	private string comboKey_Transform_Tank = "Transform_Tank";

	private string comboKey_Transform_TankEnd = "Recover_Tank";

	private string comboKey_Tank = "Attack_Tank";

	private FP count_Tank = 6;

	private string tankShootEvent = "Tank_Attack";

	private string bulletKey_Tank = "Bullet_140_Tank_Attack";

	private TSVector2 shootOffset_Tank = new TSVector2(0, 1);

	private FP shootPositionY_Tank = 1;

	private FP offsetDistance_NoTarget = 1;

	private const int perkId_1 = 1400101;

	private int burstInterval = 2;

	private int burstCount = 3;

	private const int perkId_2 = 1400102;

	private const int perkId_4 = 1400104;

	private string areaEffectKey_P04 = "AreaEffect_14001_Tank_P08";

	private bool isTankForm;

	private CoroutineNode corMain;

	private LogicEntity targetEntity;

	private AimTarget aimTarget = new AimTarget();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		targetEntity = null;
		aimTarget.Cancel();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		aimTarget.Cancel();
		_actor.ResumeAnimationGroup();
	}

	public void OnStart()
	{
		isTankForm = GetPerk(1400102);
		if (isTankForm)
		{
			StartCoroutine(ref corMain, DoTankLogic());
		}
		else
		{
			StartCoroutine(ref corMain, DoGatlingLogic());
		}
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			if (targetEntity != _actor.attackTarget)
			{
				targetEntity = _actor.attackTarget;
				aimTarget.Cancel();
				aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
			}
		}
		else
		{
			aimTarget.Cancel();
			targetEntity = null;
		}
	}

	private IEnumerator DoGatlingLogic()
	{
		RequestComboAttack req = BeginAttack(comboKey_TransformBegin, flushInputedKeys: true, forceInterruptAttack: true);
		_actor.ReplaceAnimationGroup(animGroupIndex_Gatling);
		while (!req.isComboFinish)
		{
			yield return null;
		}
		req = BeginAttack(comboKey_Transform_Cannon, flushInputedKeys: true);
		while (!req.isComboFinish)
		{
			yield return null;
		}
		int currentCount = 0;
		int currentBurst = 0;
		FP curTime = totleMaxDuration;
		while (currentCount < count_Gatling && curTime >= FP.Zero)
		{
			if (_actor.attackTarget != null)
			{
				string actionTag = comboKey_Gatling;
				if (currentCount % burstInterval == 0 && GetPerk(1400101) && currentCount != 0 && currentBurst < burstCount)
				{
					actionTag = comboKey_Gatling_P1;
					currentBurst++;
				}
				req = BeginAttack(actionTag, flushInputedKeys: true);
				while (!req.isComboFinish)
				{
					yield return null;
					curTime -= _actor.LogicDeltaTime;
					if (_actor.attackTarget == null)
					{
						_actor.InterruptAttack(force: true);
						break;
					}
				}
				currentCount++;
			}
			else
			{
				yield return null;
				curTime -= _actor.LogicDeltaTime;
			}
		}
		SkillScript_Skill skillScript_Skill = this;
		string actionTag2 = comboKey_Transform_CannonEnd;
		Action onComboFinish = SkillFinish;
		Action onInterrupt = SkillFinish;
		skillScript_Skill.BeginAttack(actionTag2, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		_actor.ResumeAnimationGroup();
	}

	private IEnumerator DoTankLogic()
	{
		RequestComboAttack req = BeginAttack(comboKey_TransformBegin, flushInputedKeys: true, forceInterruptAttack: true);
		_actor.ReplaceAnimationGroup(animGroupIndex_Tank);
		while (!req.isComboFinish)
		{
			yield return null;
		}
		req = BeginAttack(comboKey_Transform_Tank, flushInputedKeys: true);
		while (!req.isComboFinish)
		{
			yield return null;
		}
		int currentCount = 0;
		FP curTime = totleMaxDuration;
		while (currentCount < count_Tank && curTime >= FP.Zero)
		{
			if (_actor.attackTarget != null)
			{
				string actionTag = comboKey_Tank;
				SkillScript_Skill skillScript_Skill = this;
				Action<string> onCustomEvent = OnTankCustomEvent;
				req = skillScript_Skill.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, null, onCustomEvent);
				while (!req.isComboFinish)
				{
					yield return null;
					curTime -= _actor.LogicDeltaTime;
					if (_actor.attackTarget == null)
					{
						_actor.InterruptAttack(force: true);
						break;
					}
				}
				currentCount++;
			}
			else
			{
				yield return null;
				curTime -= _actor.LogicDeltaTime;
			}
		}
		SkillScript_Skill skillScript_Skill2 = this;
		string actionTag2 = comboKey_Transform_TankEnd;
		Action onComboFinish = SkillFinish;
		Action onInterrupt = SkillFinish;
		skillScript_Skill2.BeginAttack(actionTag2, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		_actor.ResumeAnimationGroup();
	}

	private void OnTankCustomEvent(string eventName)
	{
		if (string.Equals(tankShootEvent, eventName))
		{
			TSVector2 tSVector = _actor.tsTransform.Position + _actor.tsTransform.Left * shootOffset_Tank.x + _actor.tsTransform.Forward * shootOffset_Tank.y;
			TSVector2 targetPosition = tSVector + _actor.tsTransform.Forward * offsetDistance_NoTarget;
			if (_actor.attackTarget != null)
			{
				targetPosition = _actor.attackTarget.tsTransform.Position;
			}
			ILRuntimeAPI.Shoot(bulletKey_Tank, _actor, 0, tSVector, shootPositionY_Tank, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
			if (GetPerk(1400104) && !string.IsNullOrEmpty(areaEffectKey_P04))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectKey_P04, _actor.tsTransform.Position, _actor.tsTransform.Rotation);
			}
		}
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}
}
