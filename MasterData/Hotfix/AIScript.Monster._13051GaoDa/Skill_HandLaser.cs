using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._13051GaoDa;

public class Skill_HandLaser : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	private string hitFxAlias1 = "HandLaser";

	private string hitFxAlias2 = "HandLaser2";

	private string hitFxAlias3 = "HandLaser3";

	private string customEventName_FlyDown = "FlyDown";

	private FP FXTime1 = 1.6;

	private FP FXTime2 = 3.9;

	private FP FXTime3 = 2.4;

	private FP Time1 = 0.15;

	private FP Time2 = 0.6;

	private FP Time3 = 3.25;

	private FP Time4 = 3.7;

	private FP moveSpeedMax = 7f / 30f;

	private FP hitDelay = 1.67;

	private FP hitDuration = 4;

	private int hitDamgeId = 13052021;

	private FP laserWidth = 30;

	private FP laserLength = 1;

	private TSVector2 origianlPosition = new TSVector2(0, -18.3);

	private TSVector2 effectPosition = new TSVector2(0, -24);

	private FP SkillStartDelay = 0.5;

	private FP SkillStartDelay_Strafe = 1.5;

	private FP SkillStartDelay_Laser = 1;

	private int skillType;

	private int cooperateType;

	private CoroutineNode hitCoroutineNode;

	private FP _hitDuration;

	private FP hitPositionY;

	private PlayFX fx1;

	private PlayFX fx2;

	private PlayFX fx3;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		skillType = (int)(long)_actor.logicVariable.GetLogicTagValue("skillType");
		cooperateType = (int)(long)_actor.logicVariable.GetLogicTagValue("cooperateType");
		if (GetMonsterTagValue(_actor, 1) == "ChenShaAct")
		{
			origianlPosition = GetPlaceHolderPosition("OriginalPosition");
			effectPosition = GetPlaceHolderPosition("EffectPosition");
		}
		_hitDuration = hitDuration;
		hitPositionY = origianlPosition.y;
		if (cooperateType == 1)
		{
			SkillStartDelay = SkillStartDelay_Strafe;
		}
		else if (cooperateType == 2)
		{
			SkillStartDelay = SkillStartDelay_Laser;
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (skillType == 1)
		{
			StopCoroutine(ref hitCoroutineNode);
			fx1?.Stop();
			fx1?.Clear();
			fx2?.Stop();
			fx2?.Clear();
			fx3?.Stop();
			fx3?.Clear();
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(SkillStartDelay);
		if (GetTargetByTeammateIndexes(new List<int> { 1, 2 }).Count >= 2)
		{
			SetHideModelEnable();
			SetBattleOutEnable();
			if (skillType == 1)
			{
				fx1 = PlayFxForNeedStop(hitFxAlias1, 1f, 0, effectPosition, 180);
				StartCoroutine(ref hitCoroutineNode, ContinueHit());
				yield return WaitTime(FXTime1);
				fx2 = PlayFxForNeedStop(hitFxAlias2, 1f, 0, effectPosition, 180);
				yield return WaitTime(FXTime2);
				fx3 = PlayFxForNeedStop(hitFxAlias3, 1f, 0, effectPosition, 180);
				yield return WaitTime(FXTime3 - 1.5);
			}
			else
			{
				yield return WaitTime(FXTime1 + FXTime2 + FXTime3 - 1.5);
			}
			BeginAttack(1, actionKeys_1);
			SetHideModelDisable();
			yield return WaitCustomEvent(customEventName_FlyDown);
			SetBattleOutDisable();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			if (GetLogicTagFpValue(GetTargetByID((long)GetLogicTagFpValue(_actor, "bodyId")), "Difficulty") == 1)
			{
				yield return WaitTime(2);
			}
			else
			{
				yield return WaitTime(1);
			}
		}
	}

	private IEnumerator ContinueHit()
	{
		yield return WaitTime(hitDelay);
		FP speed = 0;
		FP moveSpeedPlus = 0.158 / (Time2 - Time1);
		FP moveSpeedMinus = 0.158 / (Time4 - Time3);
		while (_hitDuration > 0)
		{
			hitPositionY -= speed;
			Hit(hitPositionY);
			_hitDuration -= _actor.LogicDeltaTime;
			FP fP = hitDuration - _hitDuration;
			if (fP <= Time1)
			{
				speed = 0;
			}
			else if ((fP > Time1) & (fP < Time2))
			{
				speed = 0 + moveSpeedPlus * (fP - Time1);
				if (speed > moveSpeedMax)
				{
					speed = moveSpeedMax;
				}
			}
			else if ((fP > Time2) & (fP < Time3))
			{
				speed = moveSpeedMax;
			}
			else if (fP > Time3)
			{
				speed -= moveSpeedMinus * (fP - Time3);
				if (speed < 0)
				{
					speed = 0;
				}
			}
			yield return null;
		}
	}

	private void Hit(FP positionY)
	{
		TSVector2 position = new TSVector2(origianlPosition.x, positionY);
		FP width = laserWidth;
		FP length = laserLength;
		FP rotation = 0;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, position, width, length, default, default, default, rotation);
		HitFeatureData hitFeatureData = GetHitFeatureData();
		AreaHit_Simple(_actor, shapeData, hitFeatureData, hitDamgeId, 1, HitBox.HurtAnimType.Small, "HitByHandLaser");
	}
}
