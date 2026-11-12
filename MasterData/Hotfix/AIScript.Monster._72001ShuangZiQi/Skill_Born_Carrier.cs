using System.Collections;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_Born_Carrier : SkillSimpleBase
{
	private bool isRed;

	private string Color;

	private string SpawnFXName1;

	private string SpawnFXName2;

	private string SpawnFXName3;

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
		BeginAttack(1, "Spawn", flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect(SpawnFXName1);
		Skill_Born_Carrier skill_Born_Carrier = this;
		string spawnFXName = SpawnFXName2;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_Born_Carrier.PlayEffect(spawnFXName, 1f, default, position, rotation);
		Skill_Born_Carrier skill_Born_Carrier2 = this;
		string spawnFXName2 = SpawnFXName3;
		position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2.5));
		skill_Born_Carrier2.PlayEffect(spawnFXName2, 1f, default, position);
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
		SpawnFXName1 = "fx_m72005_base_Spawn_" + Color + "_1";
		SpawnFXName2 = "fx_m72005_base_Spawn_" + Color + "_2";
		SpawnFXName3 = "fx_m72005_base_Spawn_" + Color + "_3";
	}
}
