using System.Collections;
using TrueSync;

namespace AIScript.Monster._FanRong_Wind._10012FanRongZhiShiTi;

public class FanRong_Wind_Attack_01 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._0,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] Attack02 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._0,
		ComboInputBuffer.ActionKey._2
	};

	private readonly ComboInputBuffer.ActionKey[] Attack03 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._0,
		ComboInputBuffer.ActionKey._3
	};

	private readonly string Combo01 = "Combo1";

	private readonly string Combo02 = "Combo2";

	private readonly string TurnToS = "TurnS";

	private readonly string TurnToE = "TurnE";

	private long AreaEffectID;

	private LogicEntity Targetenemy;

	protected override void OnInterrupt(int comboIndex)
	{
		StopAreaEffect(AreaEffectID);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("TurnS");
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 1, 200, 0);
		yield return WaitCustomEvent("SpawnWave");
		StopWaitLookAt();
		AreaEffectID = PlayAreaEffect("AreaEffect_Wind_Skill01_Wave01", GetPosition() + TSVector2.Rotate(new TSVector2(0, 5f), _actor.tsTransform.Rotation));
		yield return WaitCustomEvent(Combo01);
		BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(Combo02);
		BeginAttack(3, Attack03, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(TurnToS);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 1, 200, 0);
		yield return WaitCustomEvent(TurnToE);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
