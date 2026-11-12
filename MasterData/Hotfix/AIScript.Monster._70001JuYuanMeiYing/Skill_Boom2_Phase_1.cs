using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Boom2_Phase_1 : SkillSimpleBase
{
	private string key_Base1 = "Stage2_Skill09_1";

	private string key_Base2 = "Stage2_Skill09_2";

	private string evt_CastSkill = "evt_Boom";

	private List<TSVector2> SquareCenters = new List<TSVector2>();

	private TSVector2 ClosePos = new TSVector2(0, 0);

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, key_Base1);
		MapCutSquare();
		yield return WaitFrame(20);
		SingleAreaBoom();
		yield return WaitFrame(42);
		CancelAttack();
		yield return WaitFrame(15);
		LongAreaBoom();
		yield return WaitFrame(17);
		BeginAttack(2, key_Base2, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(46);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void MapCutSquare()
	{
		for (int i = 0; i < 3; i++)
		{
			for (int j = 0; j < 6; j++)
			{
				int num = -12 + j * 4 + 2;
				int num2 = -12 + i * 4 + 2;
				SquareCenters.Add(new TSVector2(num, num2));
			}
		}
	}

	private void SingleAreaBoom()
	{
		ClosePos = SquareCenters.get_Item(0);
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		TSVector2 entityPosition = GetEntityPosition(logicEntity);
		FP fP = Distance(entityPosition, ClosePos);
		for (int i = 0; i < SquareCenters.Count; i++)
		{
			FP fP2 = Distance(entityPosition, SquareCenters.get_Item(i));
			if (fP2 < fP)
			{
				fP = fP2;
				ClosePos = SquareCenters.get_Item(i);
			}
		}
		PlayAreaEffect("Area_70001_Skill09_Boom", ClosePos);
	}

	private void LongAreaBoom()
	{
		TSVector2 position = new TSVector2(0, ClosePos.y);
		TSVector2 position2 = new TSVector2(ClosePos.x, -6);
		PlayAreaEffect("Area_70001_Skill09_Boom_Row", position);
		PlayAreaEffect("Area_70001_Skill09_Boom_Col", position2);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName.Equals(evt_CastSkill))
		{
			DispatchCustomEvent(evt_CastSkill, isSelfEvent: false);
		}
	}
}
