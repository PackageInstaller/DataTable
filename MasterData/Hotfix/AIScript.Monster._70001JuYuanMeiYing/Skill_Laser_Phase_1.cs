using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Laser_Phase_1 : SkillSimpleBase
{
	private string key_Base = "Stage1_Skill05";

	private Dictionary<string, string> bullet_Laser = new Dictionary<string, string>
	{
		["Lv1"] = "Bullet_70001_Skill05_Laser_Slow",
		["Lv2"] = "Bullet_70001_Skill05_Laser_Slow",
		["Lv3"] = "Bullet_70001_Skill05_Laser_Slow",
		["Lv4"] = "Bullet_70001_Skill05_Laser",
		["Lv5"] = "Bullet_70001_Skill05_Laser",
		["MainLine"] = "Bullet_70001_Skill05_Laser"
	};

	private Dictionary<string, string> bullet_Ball = new Dictionary<string, string>
	{
		["Lv1"] = "Bullet_70001_Skill05_Ball_Loop_Slow",
		["Lv2"] = "Bullet_70001_Skill05_Ball_Loop_Slow",
		["Lv3"] = "Bullet_70001_Skill05_Ball_Loop_Slow",
		["Lv4"] = "Bullet_70001_Skill05_Ball_Loop",
		["Lv5"] = "Bullet_70001_Skill05_Ball_Loop",
		["MainLine"] = "Bullet_70001_Skill05_Ball_Loop"
	};

	private Dictionary<string, int> loopCount = new Dictionary<string, int>
	{
		["Lv1"] = 1,
		["Lv2"] = 1,
		["Lv3"] = 1,
		["Lv4"] = 2,
		["Lv5"] = 2,
		["MainLine"] = 2
	};

	private string evt_Laser = "evt_Laser";

	private TSVector2 edge_up = new TSVector2(0, 0);

	private TSVector2 edge_down = new TSVector2(0, -15);

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, key_Base);
		yield return WaitFrame(9);
		SpawnBall();
		yield return WaitFrame(30);
		StartCor(LoopLaser1());
		StartCor(LoopLaser2());
		StartCor(LoopBall1());
		StartCor(LoopBall2());
		yield return WaitFrame(180);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator LoopLaser1()
	{
		for (int i = 0; i < loopCount.get_Item(GetMonsterTagValue(_actor, 1)); i++)
		{
			TSVector2 tSVector = ((i % 2 == 0) ? edge_down : edge_up);
			TSVector2 tSVector2 = ((i % 2 == 0) ? edge_up : edge_down);
			AdventureBulletBase bullet1 = ILRuntimeAPI.ShootByDirection(shootDir: (tSVector2 - tSVector).normalized, bulletAlias: bullet_Laser.get_Item(GetMonsterTagValue(_actor, 1)), actor: _actor, range: default, position: tSVector, positionY: 0.5);
			FP waitSeconds = (tSVector2 - tSVector).magnitude / bullet1.velocitySpeed;
			yield return WaitTime(waitSeconds);
			bullet1.Finish();
		}
	}

	protected IEnumerator LoopLaser2()
	{
		for (int i = 0; i < loopCount.get_Item(GetMonsterTagValue(_actor, 1)); i++)
		{
			TSVector2 tSVector = ((i % 2 == 0) ? edge_down : edge_up);
			TSVector2 tSVector2 = ((i % 2 == 0) ? edge_up : edge_down);
			TSVector2 normalized = (tSVector - tSVector2).normalized;
			AdventureBulletBase bullet2 = ILRuntimeAPI.ShootByDirection(bullet_Laser.get_Item(GetMonsterTagValue(_actor, 1)), _actor, default, normalized, tSVector2, 0.5);
			FP waitSeconds = (tSVector2 - tSVector).magnitude / bullet2.velocitySpeed;
			yield return WaitTime(waitSeconds);
			bullet2.Finish();
		}
	}

	protected IEnumerator LoopBall1()
	{
		for (int i = 0; i < loopCount.get_Item(GetMonsterTagValue(_actor, 1)); i++)
		{
			TSVector2 tSVector = ((i % 2 == 0) ? edge_down : edge_up);
			TSVector2 tSVector2 = ((i % 2 == 0) ? edge_up : edge_down);
			AdventureBulletBase bullet3 = ILRuntimeAPI.ShootByDirection(shootDir: (tSVector2 - tSVector).normalized, bulletAlias: bullet_Ball.get_Item(GetMonsterTagValue(_actor, 1)), actor: _actor, range: default, position: tSVector, positionY: 0.5);
			FP waitSeconds = (tSVector2 - tSVector).magnitude / bullet3.velocitySpeed;
			yield return WaitTime(waitSeconds);
			bullet3.Finish();
		}
	}

	protected IEnumerator LoopBall2()
	{
		for (int i = 0; i < loopCount.get_Item(GetMonsterTagValue(_actor, 1)); i++)
		{
			TSVector2 tSVector = ((i % 2 == 0) ? edge_down : edge_up);
			TSVector2 tSVector2 = ((i % 2 == 0) ? edge_up : edge_down);
			TSVector2 normalized = (tSVector - tSVector2).normalized;
			AdventureBulletBase bullet4 = ILRuntimeAPI.ShootByDirection(bullet_Ball.get_Item(GetMonsterTagValue(_actor, 1)), _actor, default, normalized, tSVector2, 0.5);
			FP waitSeconds = (tSVector2 - tSVector).magnitude / bullet4.velocitySpeed;
			yield return WaitTime(waitSeconds);
			bullet4.Finish();
		}
	}

	private void SpawnBall()
	{
		Shoot("Bullet_70001_Skill05_Ball_Start", edge_up, 0.5, 0);
		Shoot("Bullet_70001_Skill05_Ball_Start", edge_down, 0.5, 0);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName.Equals(evt_Laser))
		{
			DispatchCustomEvent(evt_Laser, isSelfEvent: false);
		}
	}
}
