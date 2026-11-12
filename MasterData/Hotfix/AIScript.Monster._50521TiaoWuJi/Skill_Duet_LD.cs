using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50521TiaoWuJi;

public class Skill_Duet_LD : SkillSimpleBase
{
	private readonly string ActionCombo01 = "Duet_Start";

	private readonly int ActionIndex01 = 1;

	private readonly string ActionCombo02 = "Duet_End";

	private readonly int ActionIndex02 = 2;

	private readonly List<string> Area_GroupList = new List<string> { "Area_Skill02_Normal_Green", "Area_Skill02_Normal_Yellow", "Area_Skill02_Normal_Red", "Area_Skill02_Normal_Purple" };

	private readonly FP AreaINTR = 0.5;

	private readonly int BuffID_Cir = 505210100;

	private readonly int BuffID_Ring = 505210110;

	private readonly int BuffID_Cro = 505210120;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(ActionIndex01, ActionCombo01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.55);
		BeginAttack(ActionIndex02, ActionCombo02, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.5);
		int num = ((GetBuffNum(_actor, BuffID_Cir) == 1) ? GetRandomValue(1, 3, isInt: true).AsInt() : ((GetBuffNum(_actor, BuffID_Ring) != 1) ? ((GetBuffNum(_actor, BuffID_Cro) != 1) ? GetRandomValue(0, 3, isInt: true).AsInt() : GetRandomValue(0, 2, isInt: true).AsInt()) : 0));
		int index = 0;
		switch (num)
		{
		case 0:
			while (index < 4)
			{
				PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[1, 1]);
				PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[1, 2]);
				PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[2, 1]);
				PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[2, 2]);
				index++;
				yield return WaitTime(AreaINTR);
			}
			AddBuffToTarget(_actor, BuffID_Cir);
			break;
		case 1:
			while (index < 4)
			{
				for (int k = 0; k < 4; k++)
				{
					PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[0, k]);
					PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[3, k]);
				}
				PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[1, 0]);
				PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[2, 0]);
				PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[1, 3]);
				PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[2, 3]);
				index++;
				yield return WaitTime(AreaINTR);
			}
			AddBuffToTarget(_actor, BuffID_Ring);
			break;
		case 2:
			while (index < 4)
			{
				for (int j = 0; j < 4; j++)
				{
					PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[j, j]);
					PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[j, Math.Abs(j - 3)]);
				}
				index++;
				yield return WaitTime(AreaINTR);
			}
			AddBuffToTarget(_actor, BuffID_Cro);
			break;
		default:
			while (index < 4)
			{
				for (int i = 0; i < 4; i++)
				{
					PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[i, i]);
					PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[i, Math.Abs(i - 3)]);
				}
				index++;
				yield return WaitTime(AreaINTR);
			}
			break;
		}
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(1);
		if (targetByTeammateIndex != null && targetByTeammateIndex.Count > 0)
		{
			for (int l = 0; l < targetByTeammateIndex.Count; l++)
			{
				SetLogicTagToggleValue(targetByTeammateIndex.get_Item(l), "SummonATK", value: true);
			}
		}
	}
}
