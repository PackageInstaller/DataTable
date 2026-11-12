#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._5051500ShuangShaYuFaShi_Shui;

public class Skill_WaterColumn_LD : SkillSimpleBase
{
	private bool interrupted;

	private readonly string laserFx = "fx_50020_loop_LaserRound_Laser_loop_02";

	private List<long> _laserFx = new List<long>();

	private readonly string laserWarningFx = "fx_50020shayufashi_warning_YuJing_10_start";

	private readonly int GeneralATKIndex;

	private readonly string GeneralATKKey = "GeneralATK";

	private List<FP> _DamageRotation = new List<FP> { 0, 0, 0 };

	private DeterministicShape ShapeData;

	private readonly FP rotateSpeed = 60;

	protected override void OnSkillEnable()
	{
		interrupted = true;
		NovaLogger.Debug("水鲨鱼法师.水激光开始释放");
	}

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("水鲨鱼法师.技能结束");
		if (_laserFx.Count > 0)
		{
			for (int i = 0; i < _laserFx.Count; i++)
			{
				StopEffect(_laserFx.get_Item(i));
			}
		}
		if (interrupted)
		{
			ClearOwnerWeapon();
		}
		_laserFx.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(GeneralATKIndex, GeneralATKKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.6);
		if (_laserFx.Count > 0)
		{
			for (int i = 0; i < _laserFx.Count; i++)
			{
				StopEffect(_laserFx.get_Item(i));
			}
		}
		CircleMultipleShoot("WaterLaser", AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 1, 5, GetPosition(), 0, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
		yield return WaitTime(6);
		interrupted = false;
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
