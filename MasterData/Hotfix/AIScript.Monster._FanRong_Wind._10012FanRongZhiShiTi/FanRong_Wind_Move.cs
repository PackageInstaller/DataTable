#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._FanRong_Wind._10012FanRongZhiShiTi;

public class FanRong_Wind_Move : SkillSimpleBase
{
	private FP HomeDistance;

	protected override void OnSkillEnable()
	{
		SetHideModelEnable();
		SetUnparalleledEnable();
		SetSearchedImmunityEnable();
		SetCloseBlockEnable();
		SetHideOutEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		PlayAreaEffect("AreaEffect_Wind_Skill05", GetPosition());
		if (Distance(GetPosition(), new TSVector2(0, 0)) <= 4.5)
		{
			StartCor(AttackCombo01());
		}
		else if (Distance(GetPosition(), new TSVector2(0, 0)) >= 11)
		{
			StartCor(AttackCombo02());
		}
		else
		{
			StartCor(AttackCombo03());
		}
		NovaLogger.Debug("触发4" + Distance(GetPosition(), new TSVector2(0, 0)).ToString());
		yield return WaitFrame(300);
		ClearActors(new List<LogicEntity> { _actor });
	}

	private IEnumerator AttackCombo01()
	{
		Dash dash = BeginDash(1, RotateTo(GetPosition() - new TSVector2(0, 0), 90), 10, 999, 999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		for (int i = 0; i < 9999; i++)
		{
			if (Distance(GetPosition(), new TSVector2(0, 0)) <= 4)
			{
				dash._direction = RotateTo(GetPosition() - new TSVector2(0, 0), 85);
			}
			else if (Distance(GetPosition(), new TSVector2(0, 0)) >= 4.5)
			{
				dash._direction = RotateTo(GetPosition() - new TSVector2(0, 0), 95);
			}
			else
			{
				dash._direction = RotateTo(GetPosition() - new TSVector2(0, 0), 91);
			}
			yield return WaitFrame(1);
		}
	}

	private IEnumerator AttackCombo02()
	{
		Dash dash = BeginDash(1, RotateTo(GetPosition() - new TSVector2(0, 0), 90), 15, 999, 999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		for (int i = 0; i < 9999; i++)
		{
			if (Distance(GetPosition(), new TSVector2(0, 0)) <= 12)
			{
				dash._direction = RotateTo(GetPosition() - new TSVector2(0, 0), 85);
			}
			else if (Distance(GetPosition(), new TSVector2(0, 0)) >= 12.5)
			{
				dash._direction = RotateTo(GetPosition() - new TSVector2(0, 0), 95);
			}
			else
			{
				dash._direction = RotateTo(GetPosition() - new TSVector2(0, 0), 91);
			}
			yield return WaitFrame(1);
		}
	}

	private IEnumerator AttackCombo03()
	{
		Dash dash = BeginDash(1, RotateTo(GetPosition() - new TSVector2(0, 0), 90), 12, 999, 999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		for (int i = 0; i < 9999; i++)
		{
			if (Distance(GetPosition(), new TSVector2(0, 0)) <= 8)
			{
				dash._direction = RotateTo(GetPosition() - new TSVector2(0, 0), 85);
			}
			else if (Distance(GetPosition(), new TSVector2(0, 0)) >= 8.5)
			{
				dash._direction = RotateTo(GetPosition() - new TSVector2(0, 0), 95);
			}
			else
			{
				dash._direction = RotateTo(GetPosition() - new TSVector2(0, 0), 91);
			}
			yield return WaitFrame(1);
		}
	}
}
