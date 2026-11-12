using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50582FeiXingDengPao;

public class Explode : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_1 = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] Attack_2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] Attack_3 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly ComboInputBuffer.ActionKey[] Attack_4 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	protected readonly FP dash_spd = 8f;

	protected readonly FP dash_angle = 90;

	protected readonly FP dash_angleLimit = 60;

	protected readonly string fx_dash = "fx_m50231_loop_Skill1_crush";

	protected FP dis;

	private string fxAlias = "AreaEffect_50582DengPao_Huan";

	private bool HasBuff;

	private PlayFX _playFx;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		SetBattleOutEnable();
		_actor.SendDeclareDeadEvent();
		BeginAttack(2, Attack_2, flushInputedKeys: true, forceInterruptAttack: true);
		FP explodetime = GetRandomValue(0, 1);
		while (explodetime > 0f)
		{
			explodetime -= (FP)0.03f;
			yield return WaitTime(0.03);
		}
		BeginAttack(3, Attack_3, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(2);
		CancelAttack();
		RemoveBuffFromTarget(_actor, 505810001);
		yield return WaitTime(0.05);
		SetHideModelEnable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		_actor.DestroySelf();
	}
}
