#define LOG_DEBUG
using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class Skill_Sweep_3_BossRush : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] actionKey_Left_Water = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	protected readonly ComboInputBuffer.ActionKey[] actionKey_Right_Water = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected readonly ComboInputBuffer.ActionKey[] actionKey_Left_Dark = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	protected readonly ComboInputBuffer.ActionKey[] actionKey_Right_Dark = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	private static readonly string Jumpto = "Jumpto";

	protected readonly FP RotateSpeed = 90;

	protected ComboInputBuffer.ActionKey[] _actionKey;

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
		if (_actor.DistanceWithRadius(target) >= 9)
		{
			BeginLookAt(target, 1, 240);
			yield return WaitTime(0.5);
			TSVector2 entityPosition = GetEntityPosition(target);
			Skill_Sweep_3_BossRush skill_Sweep_3_BossRush = this;
			Skill_Sweep_3_BossRush skill_Sweep_3_BossRush2 = this;
			TSVector2 position = entityPosition;
			FP radius = 6;
			FP innerRadius = 3;
			TSVector2 shapeRandomPoint = skill_Sweep_3_BossRush.GetShapeRandomPoint(skill_Sweep_3_BossRush2.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius), _actor, isReachable: true);
			NovaLogger.Debug($"目标点坐标: ({shapeRandomPoint.x}, {shapeRandomPoint.y})");
			NovaLogger.Debug($"玩家坐标: ({entityPosition.x}, {entityPosition.y})");
			BeginLookAtByPos(shapeRandomPoint, 2, 300);
			BeginAttack(1, Jumpto, flushInputedKeys: true, forceInterruptAttack: true);
			SetCloseBlockEnable();
			FP fP = Distance(GetPosition(), shapeRandomPoint);
			dis = fP - 4f;
			FP dash_spd = dis / 0.8;
			yield return WaitTime(0.1);
			doDash(dis, dash_spd);
			yield return WaitTime(1.1);
			CancelAttack();
			SetCloseBlockDisable();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield return WaitTime(0.2);
		}
		if (_actor.DistanceWithRadius(target) > 4)
		{
			BeginTrace(target, 4, -1, 4);
			yield return WaitTraceFinish();
		}
		if (CommonUtils.CheckTargetIsValid(target, 0L))
		{
			TSVector2 forward = _actor.tsTransform.Forward;
			TSVector2 b = target.tsTransform.Position - _actor.tsTransform.Position;
			bool flag = TSVector2.SignedAngle(forward, b) >= 0;
			if (_actor.buffComponent.CheckBuffByBuffID(505010110))
			{
				_actionKey = (flag ? actionKey_Left_Dark : actionKey_Right_Dark);
			}
			else
			{
				_actionKey = (flag ? actionKey_Left_Water : actionKey_Right_Water);
			}
		}
		else if (_actor.buffComponent.CheckBuffByBuffID(505010110))
		{
			_actionKey = actionKey_Left_Dark;
		}
		else
		{
			_actionKey = actionKey_Left_Water;
		}
		BeginLookAt_NotWait(target, 0.5, 300);
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
