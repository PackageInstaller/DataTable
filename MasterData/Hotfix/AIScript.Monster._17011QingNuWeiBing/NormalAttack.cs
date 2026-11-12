using System.Collections;
using TrueSync;

namespace AIScript.Monster._17011QingNuWeiBing;

public class NormalAttack : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly string Startfx_Ex = "fx_m17011_loop_atk1_2_start";

	private static readonly string Startfx = "fx_m17011_base_atk1_1_start";

	private ComboInputBuffer.ActionKey[] _actionkey;

	private string fx_choose;

	private bool breakOff;

	private long fxWarningLine;

	private long fx_start;

	private readonly int checkbuff = 170210010;

	private readonly FP combotime = 1.8f;

	private readonly FP aimtime = 1.2f;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		breakOff = false;
		fx_start = 0L;
		fxWarningLine = 0L;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (breakOff)
		{
			StopEffect(fxWarningLine);
			StopEffect(fx_start);
			fx_start = 0L;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
		if (!(attackTarget == null))
		{
			BeginLookAt_NotWait(attackTarget, 0.4, 240);
			yield return WaitTime(0.4);
			if (GetBuffNum(_actor, checkbuff) != 0)
			{
				_actionkey = Attack_Combo2;
				fx_choose = Startfx_Ex;
			}
			else
			{
				_actionkey = Attack_Combo;
				fx_choose = Startfx;
			}
			BeginAttack(1, _actionkey, flushInputedKeys: true, forceInterruptAttack: true);
			fx_start = PlayEffect(fx_choose);
			fxWarningLine = WarningLine();
			AimAtTarget(GetAttackTarget(isUpToDate: true), 120);
			yield return WaitTime(aimtime);
			CancelAim();
			yield return WaitTime(combotime - aimtime);
			StopEffect(fxWarningLine);
			breakOff = false;
			yield return WaitTime(0.05);
			StopEffect(fx_start);
			fx_start = 0L;
			yield return WaitTime(0.6f);
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	private long WarningLine()
	{
		long result = PlayEffect("fx_m50551cancha_loop_redline_common");
		breakOff = true;
		return result;
	}
}
