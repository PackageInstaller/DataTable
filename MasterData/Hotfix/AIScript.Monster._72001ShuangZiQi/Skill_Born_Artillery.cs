using System.Collections;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_Born_Artillery : SkillSimpleBase
{
	private bool isRed;

	private string Color;

	private string SpawnFXName;

	private string SelfAttackAreaName;

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
		PlayEffect(SpawnFXName);
		yield return WaitTime(0.5);
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
		SpawnFXName = "fx_m72004_base_Spawn_" + Color;
	}
}
