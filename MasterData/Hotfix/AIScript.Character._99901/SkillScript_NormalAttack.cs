using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._99901;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private ComboInputBuffer.ActionKey[] actionKey = new ComboInputBuffer.ActionKey[2];

	private string evt_shoot1 = "999_NrmAtk_Shoot1";

	private string evt_shoot2 = "999_NrmAtk_Shoot2";

	private string bullet = "Bullet_99901_NormalAttack";

	private int bulletCount = 5;

	private FP fanAngle = 45;

	private FP shootHeight = 1.8;

	private FP radiusOffset = 0.5;

	private TSVector offset_Combo1 = new TSVector(-1.2, 1.8, 0.5);

	private TSVector offset_Combo2 = new TSVector(1.2, 1.8, 0.5);

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget == null)
		{
			comboAttack?.CancelAttack();
		}
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		_skill?.Clear();
	}

	private void DoMainLogic()
	{
		ComboInputBuffer.ActionKey[] keys = actionKey;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (eventName.Equals(evt_shoot1))
		{
			FanShoot(offset_Combo1);
		}
		else if (eventName.Equals(evt_shoot2))
		{
			FanShoot(offset_Combo2);
		}
	}

	private void FanShoot(TSVector localOffset)
	{
		TSVector2 tSVector = _actor.tsTransform.TransformLocalPointToWorldSpace(new TSVector2(localOffset.x, localOffset.z));
		TSVector2 multiShootDirection = _actor.tsTransform.Forward;
		if (_actor.attackTarget != null)
		{
			multiShootDirection = (_actor.attackTarget.tsTransform.Position - tSVector).normalized;
		}
		ILRuntimeAPI.FanMultipleShoot(_actor, bullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, bulletCount, 0, tSVector, localOffset.y + shootHeight, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, fanAngle, 0, radiusOffset);
	}
}
