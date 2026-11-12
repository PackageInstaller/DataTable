using System.Collections;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_Born_General : SkillSimpleBase
{
	private bool isRed;

	private string Color;

	private string SpawnFXName1;

	private string SpawnFXName2;

	protected override IEnumerator DoMainLogic()
	{
		SetHideModelEnable();
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		yield return null;
		SetHideModelDisable();
		TransparentFadeIn(0.7f, 0f);
		isRed = GetLogicTagToggleValue(_actor, "Red");
		ChessInitialize();
		ShowBlood(isShow: false);
		SetLogicTagTSVector2Value(_actor, "NextTargetPosition", GetPosition());
		BeginAttack(1, "Spawn", flushInputedKeys: true, forceInterruptAttack: true);
		Skill_Born_General skill_Born_General = this;
		string spawnFXName = SpawnFXName1;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_Born_General.PlayEffect(spawnFXName, 1f, default, position, rotation);
		yield return WaitTime(0.5);
		Skill_Born_General skill_Born_General2 = this;
		string spawnFXName2 = SpawnFXName2;
		position = GetPosition();
		rotation = GetRotation();
		skill_Born_General2.PlayEffect(spawnFXName2, 1f, default, position, rotation);
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
		SpawnFXName1 = "fx_m72006_base_Spawn_" + Color + "_1";
		SpawnFXName2 = "fx_m72006_base_Spawn_" + Color + "_2";
	}
}
