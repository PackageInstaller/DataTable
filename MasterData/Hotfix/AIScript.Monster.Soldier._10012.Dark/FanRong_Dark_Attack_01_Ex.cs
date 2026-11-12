using System.Collections;
using TrueSync;

namespace AIScript.Monster.Soldier._10012.Dark;

public class FanRong_Dark_Attack_01_Ex : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] FireAttack01 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] FireAttack02 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1,
		ComboInputBuffer.ActionKey._2
	};

	private readonly ComboInputBuffer.ActionKey[] FireAttack03 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1,
		ComboInputBuffer.ActionKey._3
	};

	private readonly string Combo01 = "ComboTo1";

	private readonly string Combo02 = "ComboTo2";

	private readonly string TurnToTarget1 = "TurnTo1";

	private readonly string TurnToTarget2 = "TurnTo2";

	private readonly string StartPlayEffect = "EffectStart";

	private long AreaEffectID;

	private LogicEntity Targetenemy;

	protected override void OnInterrupt(int comboIndex)
	{
		StopAreaEffect(AreaEffectID);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, FireAttack01, flushInputedKeys: true, forceInterruptAttack: true);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.2, 225);
		yield return WaitCustomEvent(Combo01);
		BeginAttack(2, FireAttack02, flushInputedKeys: true, forceInterruptAttack: true);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.25, 240);
		yield return WaitCustomEvent(Combo02);
		BeginAttack(3, FireAttack03, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(TurnToTarget1);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.33, 360);
		yield return WaitCustomEvent(StartPlayEffect);
		yield return WaitCustomEvent("SpawnWave");
		AreaEffectID = PlayAreaEffect("AreaEffect_Dark_Attack01_Wave", GetPosition() + TSVector2.Rotate(new TSVector2(0, 6f), _actor.tsTransform.Rotation));
		yield return WaitFrame(35);
		CancelAttack();
		yield return WaitCustomEvent(TurnToTarget2);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.6, 145);
		yield return WaitFrame(30);
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
