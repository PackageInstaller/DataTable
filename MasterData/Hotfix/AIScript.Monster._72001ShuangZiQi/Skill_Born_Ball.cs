using System.Collections;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_Born_Ball : SkillSimpleBase
{
	private bool isRed;

	private string Color;

	private string SpawnFXName;

	protected override IEnumerator DoMainLogic()
	{
		SetHideModelEnable();
		SetImmuneControlEnable(autoDisableWhenSkillDisable: false);
		yield return null;
		isRed = GetLogicTagToggleValue(_actor, "Red");
		ChessInitialize();
		Skill_Born_Ball skill_Born_Ball = this;
		string spawnFXName = SpawnFXName;
		TSVector2 position = GetPosition();
		FP angle = 0;
		skill_Born_Ball.PlayEffect(spawnFXName, 1f, default, position, angle);
		yield return WaitTime(0.45);
		SetHideModelDisable();
		if (GetLogicTagToggleValue(_actor, "IsSneak"))
		{
			SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
			TransparentFadeIn(0.7f, 0f);
		}
	}

	private void ChessInitialize()
	{
		if (isRed)
		{
			Color = "Red";
		}
		else
		{
			Color = "Green";
		}
		SpawnFXName = "fx_m72007_base_" + Color + "_Born";
	}
}
