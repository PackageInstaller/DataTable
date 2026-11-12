#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class Skill_Crush_3_BossRush : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] actionKey_Left_Water = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	protected readonly ComboInputBuffer.ActionKey[] actionKey_Right_Water = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.S };

	protected readonly ComboInputBuffer.ActionKey[] actionKey_Left_Dark = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.P };

	protected readonly ComboInputBuffer.ActionKey[] actionKey_Right_Dark = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Q };

	private static readonly string Jumpto = "Jumpto";

	protected FP RotateSpeed = 150;

	protected ComboInputBuffer.ActionKey[] _actionKey;

	protected ComboInputBuffer.ActionKey[] _JumpKey;

	protected TSVector2 targetdir;

	protected FP dis;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		UpdateData();
	}

	protected void UpdateData()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		if (_actor.DistanceWithRadius(target) > 4.5)
		{
			BeginLookAt(target, 1, 240);
			yield return WaitTime(0.5);
			TSVector2 entityPosition = GetEntityPosition(target);
			Skill_Crush_3_BossRush skill_Crush_3_BossRush = this;
			Skill_Crush_3_BossRush skill_Crush_3_BossRush2 = this;
			TSVector2 position = entityPosition;
			FP radius = 6;
			FP innerRadius = 3;
			TSVector2 shapeRandomPoint = skill_Crush_3_BossRush.GetShapeRandomPoint(skill_Crush_3_BossRush2.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius), _actor, isReachable: true);
			NovaLogger.Debug($"目标点坐标: ({shapeRandomPoint.x}, {shapeRandomPoint.y})");
			NovaLogger.Debug($"玩家坐标: ({entityPosition.x}, {entityPosition.y})");
			BeginLookAtByPos(shapeRandomPoint, 2, 300);
			BeginAttack(1, Jumpto, flushInputedKeys: true, forceInterruptAttack: true);
			SetCloseBlockEnable();
			FP fP = Distance(GetPosition(), shapeRandomPoint);
			dis = fP + 2f;
			FP dash_spd = dis / 0.8;
			yield return WaitTime(0.1);
			doDash(dis, dash_spd);
			yield return WaitTime(1.1);
			CancelAttack();
			SetCloseBlockDisable();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield return WaitTime(0.2);
		}
		FP fP2 = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
		if (_actor.buffComponent.CheckBuffByBuffID(505010110))
		{
			if (fP2 > 0)
			{
				_actionKey = actionKey_Left_Dark;
				targetdir = RotateTo(GetForward(), fP2 - 90);
			}
			else
			{
				_actionKey = actionKey_Right_Dark;
				targetdir = RotateTo(GetForward(), fP2 + 90);
			}
		}
		else if (fP2 > 0)
		{
			_actionKey = actionKey_Left_Water;
			targetdir = RotateTo(GetForward(), fP2 - 90);
		}
		else
		{
			_actionKey = actionKey_Right_Water;
			targetdir = RotateTo(GetForward(), fP2 + 90);
		}
		NovaLogger.Debug($"按键: ({_actionKey})");
		BeginLookAtByDir_NotWait(targetdir, 1, 160);
		yield return WaitTime(0.5);
		BeginAttack(2, _actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void doDash(FP dis, FP dash_spd)
	{
		BeginDashActorForward(1, dash_spd, dis, 40, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
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
