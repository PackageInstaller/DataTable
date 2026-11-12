using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_LightShoot_Phase_1 : SkillSimpleBase
{
	private string key_Base1 = "Stage1_Skill02_1";

	private string key_Base2 = "Stage1_Skill02_2";

	private string key_Base3 = "Stage1_Skill02_3";

	private string bullet_laser = "Bullet_70001_Skill02_Laser_Wave";

	private List<int> shootTime = new List<int> { 0, 16 };

	private string bullet_tide = "Bullet_70001_Skill02_Tide_1";

	private string evt_Wave = "evt_Wave";

	private List<TSVector2> shootPos = new List<TSVector2>
	{
		new TSVector2(-10, 0),
		new TSVector2(0, 0),
		new TSVector2(10, 0)
	};

	private TSVector2 shootOffset = new TSVector2(0, 3);

	private FP shootY = 1.5;

	private TSVector2 center = new TSVector2(0, -7.5);

	private TSVector2 edge_up = new TSVector2(0, 0);

	private TSVector2 edge_down = new TSVector2(0, -15);

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, key_Base1);
		yield return WaitFrame(15);
		LogicEntity currentPlayer = GetCurrentPlayer();
		AimAtTarget(currentPlayer, 120);
		yield return WaitFrame(69);
		CancelAim();
		BeginAttack(2, key_Base2, flushInputedKeys: true, forceInterruptAttack: true);
		ShootLaser();
		yield return WaitFrame(16);
		ShootLaser();
		yield return WaitFrame(20);
		CancelAttack();
		BeginAttack(3, key_Base3, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAtByDir_NotWait(center, 1.5, 150);
		WaveBullet();
		yield return WaitFrame(75);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void ShootLaser()
	{
		TSVector2 tSVector = _actor.tsTransform.TransformLocalPointToWorldSpace(shootOffset);
		TSVector2 shootDir = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 5)) - tSVector;
		ILRuntimeAPI.ShootByDirection(bullet_laser, _actor, default, shootDir, tSVector, shootY);
	}

	protected IEnumerator ShootLaserLoop()
	{
		for (int i = 0; i < shootTime.Count; i++)
		{
			LogicEntity target = GetAttackTarget();
			if (target == null)
			{
				target = GetCurrentPlayer();
			}
			yield return WaitFrame(shootTime.get_Item(i));
			TSVector2 tSVector = _actor.tsTransform.TransformLocalPointToWorldSpace(shootOffset);
			TSVector2 normalized = (new TSVector2(target.tsTransform.Position.x, target.tsTransform.Position.y) - tSVector).normalized;
			ILRuntimeAPI.ShootByDirection(bullet_laser, _actor, default, normalized, tSVector, shootY);
		}
	}

	private void WaveBullet()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		TSVector2 value = new TSVector2(logicEntity.tsTransform.Position.x, 0);
		TSVector2 tSVector = shootPos.get_Item(0);
		FP fP = Distance(value, tSVector);
		for (int i = 0; i < shootPos.Count; i++)
		{
			FP fP2 = Distance(value, shootPos.get_Item(i));
			if (fP2 <= fP)
			{
				fP = fP2;
				tSVector = shootPos.get_Item(i);
			}
		}
		TSVector2 tSVector2 = tSVector;
		TSVector2 tSVector3 = new TSVector2(tSVector.x, edge_down.y);
		int num = 0;
		TSVector2 shootDir = tSVector3 - tSVector2;
		ILRuntimeAPI.ShootByDirection(bullet_tide, _actor, default, shootDir, tSVector2, num);
		PlayAreaEffect("Area_70001_Skill02_Tide_Warn01", tSVector2, 180);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName.Equals(evt_Wave))
		{
			DispatchCustomEvent(evt_Wave, isSelfEvent: false);
		}
	}
}
