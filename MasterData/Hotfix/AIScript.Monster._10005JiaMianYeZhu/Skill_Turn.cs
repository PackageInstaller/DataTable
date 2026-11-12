using System.Collections;
using TrueSync;

namespace AIScript.Monster._10005JiaMianYeZhu;

public class Skill_Turn : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Turn_Combo_Speed1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.U };

	private static readonly ComboInputBuffer.ActionKey[] Turn_Combo_Speed2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.V };

	private static readonly ComboInputBuffer.ActionKey[] Turn_Combo_Speed3 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.W };

	private FP TurnSpeed;

	private ComboInputBuffer.ActionKey[] Turn_Combo;

	private FP Angle;

	private TSVector2 Position;

	private FP TurnTime;

	private bool NeedTurnCombo;

	protected override void OnSkillEnable()
	{
		NeedTurnCombo = true;
		if (GetBuffNum(_actor, 100050110) > 0)
		{
			TurnSpeed = 400;
		}
		else
		{
			TurnSpeed = 200;
		}
	}

	protected override void OnSkillDisable()
	{
		StopWaitLookAt();
	}

	protected override IEnumerator DoMainLogic()
	{
		Position = GetEntityPositionObsoleted(GetAttackTarget());
		Angle = CalcAngleBetweenSelfAndAttackTarget();
		TurnTime = Angle / TurnSpeed;
		if (TurnTime < 0.2)
		{
			NeedTurnCombo = false;
		}
		else if (TurnTime >= 0.2 && TurnTime < 0.4)
		{
			Turn_Combo = Turn_Combo_Speed1;
		}
		else if (TurnTime >= 0.4 && TurnTime < 0.6)
		{
			Turn_Combo = Turn_Combo_Speed2;
		}
		else if (TurnTime >= 0.6)
		{
			Turn_Combo = Turn_Combo_Speed3;
		}
		if (NeedTurnCombo)
		{
			BeginAttack(1, Turn_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		}
		yield return BeginLookAtByPos(Position, 0, TurnSpeed);
	}
}
