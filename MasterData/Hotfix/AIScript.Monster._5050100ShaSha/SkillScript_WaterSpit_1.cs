#define LOG_ERROR
using System.Collections;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_WaterSpit_1 : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] _actionKey_Water = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	protected readonly ComboInputBuffer.ActionKey[] _actionKey_Dark = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.W };

	protected readonly string eventShoot = "Shoot";

	protected readonly string bulletPath_Water = "Weapon_50501ShaSha_Water_Throw";

	protected readonly string bulletPath_Dark = "Weapon_50501ShaSha_Dark_Throw";

	protected FP bulletYPos = 4;

	protected TSVector2 bulletOffset = new TSVector2(0, 5);

	protected TSVector2 NonePlayerOffset = new TSVector2(0, 8);

	protected ComboInputBuffer.ActionKey[] _actionKey;

	protected string _bulletPath;

	protected int _buttleCount;

	protected override void OnSkillEnable()
	{
		UpdateData();
	}

	protected void UpdateData()
	{
		if (_actor.buffComponent.CheckBuffByBuffID(505010110))
		{
			_actionKey = _actionKey_Dark;
			_bulletPath = bulletPath_Dark;
		}
		else
		{
			_actionKey = _actionKey_Water;
			_bulletPath = bulletPath_Water;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = _actor.actorSearchTargetInfo?.GetMonsterAttackTarget();
		BeginLookAt_NotWait(target, 0.4, 200);
		yield return WaitTime(0.2);
		BeginAttack(1, _actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(eventShoot);
		AimAtTarget(target, 70);
		while (_buttleCount < 2)
		{
			Shoot1();
			_buttleCount++;
			yield return WaitCustomEvent(eventShoot);
		}
		Shoot1();
		CancelAim();
		yield return WaitCustomEvent("ShootEnd");
		CancelAttack();
		_buttleCount = 0;
		yield return WaitTime(0.5);
	}

	private void Shoot1()
	{
		LogicEntity logicEntity = _actor.actorSearchTargetInfo?.GetMonsterAttackTarget();
		if (logicEntity == null)
		{
			NovaLogger.Error("Attack target is null in Shoot1");
			return;
		}
		TSVector2 position = logicEntity.tsTransform.Position;
		TSVector2 shootPosition = _actor.tsTransform.Position + TSVector2.Rotate(bulletOffset, _actor.tsTransform.Rotation);
		TSVector2 entityForward = GetEntityForward(_actor);
		FanMultipleShoot(_bulletPath, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, shootPosition, 4, entityForward, 60, AimType.Position, BulletDirectionType.ActorToBullet, 30, 5, 0, position);
	}

	private bool CheckPlay()
	{
		LogicEntity attackTarget = GetAttackTarget();
		FP fP = CalcAngleBetweenSelfAndAttackTarget();
		if (_actor.DistanceWithRadius(attackTarget) <= 12 && fP <= 80)
		{
			return true;
		}
		return false;
	}

	protected void OnFinish()
	{
		_skill?.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}
}
