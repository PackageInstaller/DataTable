using System.Collections;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_AreaAttack : SkillSimpleBase
{
	private FP BlastCountDown;

	private bool isRed;

	private string AttackAreaName;

	private string Color;

	private string ChargeFX;

	private string ChargeFX_Ground;

	protected override void OnSkillEnable()
	{
		isRed = GetLogicTagToggleValue(_actor, "Red");
		BlastCountDown = GetLogicTagFpValue(_actor, "BlastCountDown");
		ChessInitialize();
	}

	protected override IEnumerator DoMainLogic()
	{
		Skill_AreaAttack skill_AreaAttack = this;
		string chargeFX = ChargeFX;
		TSVector2 position = GetPosition();
		skill_AreaAttack.PlayEffect(chargeFX, 1f, default, position);
		Skill_AreaAttack skill_AreaAttack2 = this;
		string chargeFX_Ground = ChargeFX_Ground;
		position = GetPosition();
		skill_AreaAttack2.PlayEffect(chargeFX_Ground, 1f, default, position);
		Skill_AreaAttack skill_AreaAttack3 = this;
		position = GetPosition();
		skill_AreaAttack3.PlayEarlyWarningEffect("fx_warning_square_4side_15x15", 8f, default, position);
		yield return WaitTime(8);
		if (isRed)
		{
			AttackAreaName = "AreaEffect_72007_SelfAttack_RedBall";
		}
		else
		{
			AttackAreaName = "AreaEffect_72007_SelfAttack_GreenBall";
		}
		PlayAreaEffect(AttackAreaName, GetPosition());
		SetSearchedImmunityEnable();
		yield return null;
		SetSearchedImmunityDisable();
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
		ChargeFX = "fx_m72007_loop_skill06_" + Color + "_charge";
		ChargeFX_Ground = "fx_m72007_loop_skill06_" + Color + "_charge_ground";
	}
}
