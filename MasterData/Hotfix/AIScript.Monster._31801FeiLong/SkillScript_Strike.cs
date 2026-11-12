using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31801FeiLong;

public class SkillScript_Strike : SkillScript_Base
{
	private List<TSVector2> _targetPointList;

	private CoroutineNode _dashGenerateBaoLinCor;

	protected override IEnumerator DoMainLogic()
	{
		if (FilterTargetPoint(out var targetPoint))
		{
			yield return BeginLookAtByPos(targetPoint, 0, Config.rotateSpeed_First_Strike);
			BeginAttack(0, SelectComboTag());
			FP distance = TSVector2.Distance(_actor.tsTransform.Position, targetPoint);
			BeginDashActorForward(0, Config.dashSpeed_Strike, distance, default, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			_dashGenerateBaoLinCor = StartCor(DashGenerateBaoLinLogic());
			yield return WaitDashFinish();
			StopCor(_dashGenerateBaoLinCor);
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			if (FilterTargetPoint(out targetPoint))
			{
				yield return BeginLookAtByPos(targetPoint, 0, Config.rotateSpeed_Second_Strike);
				BeginAttack(1, SelectComboTag());
				distance = TSVector2.Distance(_actor.tsTransform.Position, targetPoint);
				BeginDashActorForward(0, Config.dashSpeed_Strike, distance, default, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
				_dashGenerateBaoLinCor = StartCor(DashGenerateBaoLinLogic());
				yield return WaitDashFinish();
				StopCor(_dashGenerateBaoLinCor);
				CancelAttack();
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
		}
	}

	private bool FilterTargetPoint(out TSVector2 targetPoint)
	{
		targetPoint = default;
		if (_targetPointList == null)
		{
			_targetPointList = new List<TSVector2>();
		}
		else
		{
			_targetPointList.Clear();
		}
		foreach (TSVector2 item in Config.targetPointList_Strike)
		{
			if (TSVector2.Distance(_actor.tsTransform.Position, item) >= Config.distance_FilterTargetPoint_Strike)
			{
				_targetPointList.Add(item);
			}
		}
		TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
		TSVector2 vector = (entityPosition - _actor.tsTransform.Position).normalized;
		List<TSVector2> targetPointList = _targetPointList;
		if (targetPointList != null && targetPointList.Count > 0)
		{
			FP fP = TSVector2.Distance(_actor.tsTransform.Position, entityPosition);
			FP fP2 = TSMath.Clamp(TSMath.Asin(Config.hopeDistance_FilterTargetPoint_Strike / fP), Config.minAngle_FilterTargetPoint_Strike, Config.maxAngle_FilterTargetPoint_Strike);
			for (int num = _targetPointList.Count - 1; num >= 0; num--)
			{
				TSVector2 tSVector = _targetPointList.get_Item(num);
				if (TSVector2.Angle(vector, (tSVector - _actor.tsTransform.Position).normalized) < fP2)
				{
					_targetPointList.RemoveAt(num);
				}
			}
		}
		targetPointList = _targetPointList;
		if (targetPointList != null && targetPointList.Count > 0)
		{
			_targetPointList.Sort((TSVector2 x, TSVector2 y) =>
			{
				FP fP3 = TSVector2.Angle(vector, (x - _actor.tsTransform.Position).normalized);
				FP fP4 = TSVector2.Angle(vector, (y - _actor.tsTransform.Position).normalized);
				if (fP3 > fP4)
				{
					return 1;
				}
				return (!(fP3 == fP4)) ? (-1) : 0;
			});
			targetPoint = _targetPointList.get_Item(0);
			return true;
		}
		return false;
	}

	private string SelectComboTag()
	{
		FP fP = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
		if (fP > 0)
		{
			return "FlyDash_Left";
		}
		if (fP < 0)
		{
			return "FlyDash_Right";
		}
		if (TSRandom.Range(0, 2) == 0)
		{
			return "FlyDash_Left";
		}
		return "FlyDash_Right";
	}

	private IEnumerator DashGenerateBaoLinLogic()
	{
		while (true)
		{
			yield return WaitTime(Config.interval_GenerateBaoLin_Dash_Strike);
			SkillScript_Strike skillScript_Strike = this;
			SkillScript_Strike skillScript_Strike2 = this;
			SkillScript_Strike skillScript_Strike3 = this;
			TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Back * Config.offset_GenerateBaoLin_Dash_Strike;
			FP width_GenerateBaoLin_Dash_Strike = Config.width_GenerateBaoLin_Dash_Strike;
			FP length_GenerateBaoLin_Dash_Strike = Config.length_GenerateBaoLin_Dash_Strike;
			FP rotation = _actor.tsTransform.Rotation;
			yield return skillScript_Strike.StartCor(skillScript_Strike2.GenerateBaoLinLogic(skillScript_Strike3.GetShapeData(DeterministicShape.ShapeType.Rectangle, position, width_GenerateBaoLin_Dash_Strike, length_GenerateBaoLin_Dash_Strike, default, default, default, rotation), 2, 0));
		}
	}
}
