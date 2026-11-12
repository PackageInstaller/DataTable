using System.Collections;
using TrueSync;

namespace AIScript.Monster._FanRong_Fire._10012FanRongZhiShiTi;

public class FanRong_Fire_Attack_01 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] FireAttack01 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._0,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] FireAttack02 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._0,
		ComboInputBuffer.ActionKey._2
	};

	private readonly ComboInputBuffer.ActionKey[] FireAttack03 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._0,
		ComboInputBuffer.ActionKey._3
	};

	private readonly string TurnToTarget = "TurnTo";

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
		BeginLookAt_NotWait(Targetenemy, 0.5, 270);
		yield return WaitCustomEvent("SpawnWave");
		StopWaitLookAt();
		AreaEffectID = PlayAreaEffect("AreaEffect_Fire_Skill01_Wave01", GetPosition() + TSVector2.Rotate(new TSVector2(0, 5f), _actor.tsTransform.Rotation));
		yield return WaitFrame(10);
		BeginAttack(2, FireAttack02, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(30);
		BeginAttack(3, FireAttack03, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(TurnToTarget);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.66, 120);
		yield return WaitFrame(22);
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
