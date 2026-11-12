using System.Collections;
using TrueSync;

namespace AIScript.Monster._FanRong_None._10012FanRongZhiShiTi;

public class FanRong_None_Attack_01_Ex : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] Attack02 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1,
		ComboInputBuffer.ActionKey._2
	};

	private readonly ComboInputBuffer.ActionKey[] Attack03 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1,
		ComboInputBuffer.ActionKey._3
	};

	private readonly ComboInputBuffer.ActionKey[] Attack04 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1,
		ComboInputBuffer.ActionKey._4
	};

	private readonly ComboInputBuffer.ActionKey[] Attack13 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1600352851,
		(ComboInputBuffer.ActionKey)1718906696,
		(ComboInputBuffer.ActionKey)1415346281
	};

	private readonly string TurnToS = "TurnS";

	private readonly string TurnToE = "TurnE";

	private readonly string Combo1 = "C1";

	private readonly string Combo2 = "C2";

	private readonly string Combo3 = "C3";

	private readonly string Combo4 = "C4";

	private long AreaEffectID;

	protected override void OnInterrupt(int comboIndex)
	{
		StopAreaEffect(AreaEffectID);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("SpawnWave");
		AreaEffectID = PlayAreaEffect("AreaEffect_None_Skill01_Wave01", GetPosition() + TSVector2.Rotate(new TSVector2(0, 5f), _actor.tsTransform.Rotation));
		yield return WaitCustomEvent(Combo1);
		BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(Combo2);
		BeginAttack(3, Attack03, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(Combo3);
		BeginAttack(4, Attack04, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(Combo4);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == TurnToS)
		{
			LogicEntity logicEntity = GetAttackTarget();
			if (logicEntity == null)
			{
				logicEntity = GetCurrentPlayer();
			}
			BeginLookAt_NotWait(logicEntity, 1, 240, 0);
		}
		else if (eventName == TurnToE)
		{
			StopWaitLookAt();
		}
	}
}
