using System.Collections;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_IceStab : SkillSimpleBase
{
	private static readonly string combo_IceStab = "IceStab";

	private static readonly string combo_Turn_Left = "Turn_Left";

	private static readonly string combo_Turn_Right = "Turn_Right";

	private static readonly string evt_IceStabSpawn = "IceStabSpawn";

	private static readonly string areaFx_IceStab = "Area_31301JiJuXie_BingCi";

	private readonly string tag1 = "Boss";

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		SetLogicTagToggleValue(_actor, Config.Skill_IceStab_Finish, value: true);
	}

	protected override IEnumerator DoMainLogic()
	{
		string actionKey = ((CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > 0) ? combo_Turn_Left : combo_Turn_Right);
		BeginAttack(1, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		TSVector2 entityPosition = GetEntityPosition(logicEntity);
		BeginLookAtByPos(entityPosition, 0.66, (FP)90 / (FP)0.66);
		yield return WaitTime(0.66);
		BeginAttack(2, combo_IceStab, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(evt_IceStabSpawn);
		PlayFeedbackEffect("CameraShake_Down");
		if (GetMonsterTagValue(_actor, 1) == tag1)
		{
			SpawnIceStabs1();
		}
		else
		{
			SpawnIceStabs();
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void SpawnIceStabs()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		TSVector2 entityPosition = GetEntityPosition(logicEntity);
		PlayAreaEffect(areaFx_IceStab, entityPosition, GetRotation());
		PlayAreaEffect(areaFx_IceStab, entityPosition + new TSVector2(-4, 0), GetRotation());
		PlayAreaEffect(areaFx_IceStab, entityPosition + new TSVector2(4, 0), GetRotation());
		PlayAreaEffect(areaFx_IceStab, entityPosition + new TSVector2(0, -4), GetRotation());
		PlayAreaEffect(areaFx_IceStab, entityPosition + new TSVector2(0, 4), GetRotation());
	}

	private void SpawnIceStabs1()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		TSVector2 entityPosition = GetEntityPosition(logicEntity);
		PlayAreaEffect(areaFx_IceStab, entityPosition, GetRotation());
		PlayAreaEffect(areaFx_IceStab, entityPosition + new TSVector2(-4, 0), GetRotation());
		PlayAreaEffect(areaFx_IceStab, entityPosition + new TSVector2(4, 0), GetRotation());
		PlayAreaEffect(areaFx_IceStab, entityPosition + new TSVector2(0, -4), GetRotation());
		PlayAreaEffect(areaFx_IceStab, entityPosition + new TSVector2(0, 4), GetRotation());
	}
}
