using System.Collections;
using TrueSync;

namespace AIScript.Monster._50581DuoBiTaiDeng;

public class Skill6_GeZi : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Q };

	protected ComboInputBuffer.ActionKey[] _actionKey;

	private static readonly string Groundlight = "AreaEffect_50581_Ground_Light";

	protected FP rolltime;

	protected readonly (TSVector2, TSVector2)[] effectPositions1 = new (TSVector2, TSVector2)[8]
	{
		(new TSVector2(7.5f, 7.5f), new TSVector2(-7.5f, -7.5f)),
		(new TSVector2(7.5f, 2.5f), new TSVector2(-7.5f, -2.5f)),
		(new TSVector2(7.5f, -2.5f), new TSVector2(-7.5f, 2.5f)),
		(new TSVector2(7.5f, -7.5f), new TSVector2(-7.5f, 7.5f)),
		(new TSVector2(2.5f, -7.5f), new TSVector2(-2.5f, 7.5f)),
		(new TSVector2(-2.5f, -7.5f), new TSVector2(2.5f, 7.5f)),
		(new TSVector2(-2.5f, -2.5f), new TSVector2(2.5f, 2.5f)),
		(new TSVector2(2.5f, -2.5f), new TSVector2(-2.5f, 2.5f))
	};

	protected readonly (TSVector2, TSVector2)[] effectPositions2 = new (TSVector2, TSVector2)[9]
	{
		(new TSVector2(2.5f, -2.5f), new TSVector2(-2.5f, 2.5f)),
		(new TSVector2(2.5f, -7.5f), new TSVector2(-2.5f, 7.5f)),
		(new TSVector2(7.5f, -7.5f), new TSVector2(-7.5f, 7.5f)),
		(new TSVector2(7.5f, -2.5f), new TSVector2(-7.5f, 2.5f)),
		(new TSVector2(7.5f, 2.5f), new TSVector2(-7.5f, -2.5f)),
		(new TSVector2(7.5f, 7.5f), new TSVector2(-7.5f, -7.5f)),
		(new TSVector2(2.5f, 7.5f), new TSVector2(-2.5f, -7.5f)),
		(new TSVector2(2.5f, 2.5f), new TSVector2(-2.5f, -2.5f)),
		(new TSVector2(2.5f, -2.5f), new TSVector2(-2.5f, 2.5f))
	};

	protected readonly (TSVector2, TSVector2)[] effectPositions3 = new (TSVector2, TSVector2)[8]
	{
		(new TSVector2(7.5f, -7.5f), new TSVector2(-7.5f, 7.5f)),
		(new TSVector2(2.5f, -7.5f), new TSVector2(-2.5f, 7.5f)),
		(new TSVector2(-2.5f, -7.5f), new TSVector2(2.5f, 7.5f)),
		(new TSVector2(-7.5f, -7.5f), new TSVector2(7.5f, 7.5f)),
		(new TSVector2(-7.5f, -2.5f), new TSVector2(7.5f, 2.5f)),
		(new TSVector2(-7.5f, 2.5f), new TSVector2(7.5f, -2.5f)),
		(new TSVector2(-2.5f, 2.5f), new TSVector2(2.5f, -2.5f)),
		(new TSVector2(2.5f, 2.5f), new TSVector2(-2.5f, -2.5f))
	};

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAtByPos(new TSVector2(0, -1), 1, 700);
		yield return WaitTime(0.2f);
		AddBuffToTarget(_actor, 505810099);
		BeginAttack(1, Attack_1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.8);
		_ = effectPositions1;
		(TSVector2, TSVector2)[] array = TSRandom.Range(0, 3) switch
		{
			0 => effectPositions1, 
			1 => effectPositions2, 
			_ => effectPositions3, 
		};
		for (int i = 0; i < array.Length; i++)
		{
			(TSVector2, TSVector2) tuple = array[i];
			PlayAreaEffect(Groundlight, tuple.Item1);
			PlayAreaEffect(Groundlight, tuple.Item2);
			yield return WaitTime(0.6f);
		}
		yield return WaitTime(1.4f);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
