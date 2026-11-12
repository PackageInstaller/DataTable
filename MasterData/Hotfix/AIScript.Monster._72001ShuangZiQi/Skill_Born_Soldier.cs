using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_Born_Soldier : SkillSimpleBase
{
	private readonly FP HitFrameTime = 47;

	private FP AttackRadius;

	private FP ScaleLevel;

	private string Color;

	private string SpawnFXName;

	private string AttackFXName;

	private string HitFXName;

	private string WarningEffectName;

	private bool isRed;

	protected override void OnSkillEnable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		SetHideModelEnable();
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		yield return null;
		isRed = GetLogicTagToggleValue(_actor, "Red");
		ScaleLevel = GetLogicTagFpValue(_actor, "InitialScaleLevel");
		AttackRadius = ScaleLevel + 1;
		ChessInitialize();
		Skill_Born_Soldier skill_Born_Soldier = this;
		string spawnFXName = SpawnFXName;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_Born_Soldier.PlayEffect(spawnFXName, 1f, default, position, rotation);
		yield return WaitFrame(5);
		Skill_Born_Soldier skill_Born_Soldier2 = this;
		string warningEffectName = WarningEffectName;
		float duration = (float)(HitFrameTime + 13) / 60f;
		position = GetPosition();
		skill_Born_Soldier2.PlayEarlyWarningEffect(warningEffectName, duration, default, position);
		yield return WaitFrame(13);
		BeginAttack(1, "Spawn", flushInputedKeys: true, forceInterruptAttack: true);
		SetHideModelDisable();
		TransparentFadeIn(0.7f, 0f);
		ShowBlood(isShow: false);
		yield return WaitCustomEvent("HitFrame");
		Skill_Born_Soldier skill_Born_Soldier3 = this;
		TSVector2 position2 = GetPosition();
		rotation = AttackRadius - 0.25;
		DeterministicShape shapeData = skill_Born_Soldier3.GetShapeData(DeterministicShape.ShapeType.Circle, position2, default, default, rotation);
		Skill_Born_Soldier skill_Born_Soldier4 = this;
		FP knockBackForce = 15;
		FP knockBackDistance = 4;
		rotation = 4;
		HitFeatureData hitFeatureData = skill_Born_Soldier4.GetHitFeatureData(HitBox.FeatureFlag.KnockBack, knockBackForce, knockBackDistance, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, rotation, UseHitBoxPosition: true);
		Skill_Born_Soldier skill_Born_Soldier5 = this;
		string attackFXName = AttackFXName;
		position = GetPosition();
		skill_Born_Soldier5.PlayEffect(attackFXName, 1f, default, position);
		AreaHit_Simple(_actor, shapeData, hitFeatureData, 72003011, 0, HitBox.HurtAnimType.Large, HitFXName);
		if (GetLogicTagToggleValue(_actor, "SpawnRanse"))
		{
			RanSe(Config.GetCurIndexByPos(GetPosition()));
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void ChessInitialize()
	{
		if (isRed)
		{
			Color = "red";
		}
		else
		{
			Color = "green";
		}
		SpawnFXName = "fx_m72003_base_Spawn_" + Color;
		AttackFXName = "fx_m72003_base_Attack_hit_R" + AttackRadius.ToString() + "m_" + Color;
		HitFXName = "fx_common_hit_" + Color;
		WarningEffectName = "fx_common_base_Fire_YuJing_circular_" + AttackRadius.ToString();
	}

	private void RanSe(TSVector2 Index)
	{
		List<int> intParamList = new List<int> { Config.GetCellIndexByIndex(Index) };
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.eventHashCode = Config.ranseEvt;
		adventureActorCustomEvent.intParamList = intParamList;
		adventureActorCustomEvent.intParam = (isRed ? 1 : 2);
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
	}
}
