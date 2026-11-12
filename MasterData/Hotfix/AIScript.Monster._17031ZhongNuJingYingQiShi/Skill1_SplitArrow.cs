using System.Collections;
using TrueSync;

namespace AIScript.Monster._17031ZhongNuJingYingQiShi;

public class Skill1_SplitArrow : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	private static readonly string windbullet = "Weapon_16011YuanChengFengCao_throw";

	private static readonly string prfx = "fx_common_base_Wind_YuJing_circular_4";

	private static readonly string Startfx_Ex = "fx_17031_base_xuli_3_EX";

	private static readonly string Startfx = "fx_17031_base_xuli_3";

	private ComboInputBuffer.ActionKey[] _actionkey;

	private static readonly string startevent = "Fx_Start";

	private string fx_choose;

	private bool breakOff;

	private long fxWarningLine;

	private long fx_start;

	private readonly int checkbuff = 170210010;

	private readonly FP combotime = 1.2f;

	private readonly FP aimtime = 0.4f;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		if (breakOff)
		{
			StopEffect(fx_start);
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
			yield return WaitTime(0.3f);
			AimAtTarget(GetAttackTarget(isUpToDate: true), 120);
			yield return WaitCustomEvent(startevent);
			fx_start = PlayEffect(fx_choose, 1f, 1, default, default, 1f, actorScale: true);
			yield return WaitTime(aimtime);
			CancelAim();
			yield return WaitTime(combotime - aimtime);
			CancelAttack();
			breakOff = false;
			StopEffect(fx_start);
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
