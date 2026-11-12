using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50521TiaoWuJi;

public class Skill_Advance_LD : SkillSimpleBase
{
	private readonly string ActionCombo01 = "Solo_Start_D";

	private readonly int ActionIndex01 = 1;

	private readonly string ActionCombo02 = "Solo_End_D";

	private readonly int ActionIndex02 = 2;

	private readonly List<string> Area_GroupList = new List<string> { "Area_Skill_Advance_Normal_MUM_Green", "Area_Skill_Advance_Normal_MUM_Yellow", "Area_Skill_Advance_Normal_MUM_Red", "Area_Skill_Advance_Normal_MUM_Purple" };

	private readonly List<string> Area_GroupList_Move = new List<string> { "Area_Skill_Advance_Normal_Move_Green", "Area_Empty", "Area_Empty", "Area_Empty" };

	private readonly List<string> Area_GroupList_Stop = new List<string> { "Area_Empty", "Area_Skill_Advance_Normal_Stop_Yellow", "Area_Skill_Advance_Normal_Red", "Area_Skill_Advance_Normal_Purple" };

	private readonly FP AreaINTR = 0.5;

	private readonly TSVector2 TargetPOS = new TSVector2(0, 0);

	private readonly int DebuffTag = CommonHelper.StringToHash("DeBuff");

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(ActionIndex01, ActionCombo01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.55);
		BeginAttack(ActionIndex02, ActionCombo02, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect("fx_m50521_base_skill3_start_LD", 1f, -0.3, GetPosition());
		yield return WaitTime(0.3);
		RemoveBuffFromTarget(_actor, 0, 0, DebuffTag);
		SetHideModelEnable();
		SetBattleOutEnable();
		SetCloseBlockEnable();
		yield return WaitTime(0.6);
		Teleport(TargetPOS);
		yield return WaitTime(0.1);
		PlayEffect("fx_m50521_base_skill3_start_LD", 1f, -0.3, GetPosition());
		yield return WaitTime(0.4);
		SetHideModelDisable();
		SetBattleOutDisable();
		SetCloseBlockDisable();
		yield return WaitTime(0.55);
		switch (GetRandomValue(0, 4, isInt: true).AsInt())
		{
		case 0:
			StartCor(UpperLeft());
			break;
		case 1:
			StartCor(UpperRight());
			break;
		case 2:
			StartCor(LeftLower());
			break;
		case 3:
			StartCor(RightLower());
			break;
		default:
			StartCor(RightLower());
			break;
		}
		yield return WaitTime(2);
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(1);
		if (targetByTeammateIndex != null && targetByTeammateIndex.Count > 0)
		{
			for (int i = 0; i < targetByTeammateIndex.Count; i++)
			{
				SetLogicTagToggleValue(targetByTeammateIndex.get_Item(i), "SummonATK", value: true);
			}
		}
	}

	private IEnumerator UpperLeft()
	{
		int index = 0;
		while (index < 4)
		{
			PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[0, 0]);
			for (int i = 1; i < 4; i++)
			{
				PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[i, 0]);
				PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[0, i]);
			}
			PlayAreaEffect(Area_GroupList_Move.get_Item(index), Parallel.Area_Points[3, 1]);
			PlayAreaEffect(Area_GroupList_Move.get_Item(index), Parallel.Area_Points[3, 2]);
			PlayAreaEffect(Area_GroupList_Move.get_Item(index), Parallel.Area_Points[3, 3]);
			PlayAreaEffect(Area_GroupList_Move.get_Item(index), Parallel.Area_Points[2, 3]);
			PlayAreaEffect(Area_GroupList_Move.get_Item(index), Parallel.Area_Points[1, 3]);
			PlayAreaEffect(Area_GroupList_Stop.get_Item(index), Parallel.Area_Points[2, 1]);
			PlayAreaEffect(Area_GroupList_Stop.get_Item(index), Parallel.Area_Points[2, 2]);
			PlayAreaEffect(Area_GroupList_Stop.get_Item(index), Parallel.Area_Points[1, 2]);
			index++;
			yield return WaitTime(AreaINTR);
		}
	}

	private IEnumerator UpperRight()
	{
		int index = 0;
		while (index < 4)
		{
			PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[0, 0]);
			for (int i = 1; i < 4; i++)
			{
				PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[0, i]);
				PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[i, 3]);
			}
			PlayAreaEffect(Area_GroupList_Move.get_Item(index), Parallel.Area_Points[1, 0]);
			PlayAreaEffect(Area_GroupList_Move.get_Item(index), Parallel.Area_Points[2, 0]);
			PlayAreaEffect(Area_GroupList_Move.get_Item(index), Parallel.Area_Points[3, 0]);
			PlayAreaEffect(Area_GroupList_Move.get_Item(index), Parallel.Area_Points[3, 1]);
			PlayAreaEffect(Area_GroupList_Move.get_Item(index), Parallel.Area_Points[3, 2]);
			PlayAreaEffect(Area_GroupList_Stop.get_Item(index), Parallel.Area_Points[1, 1]);
			PlayAreaEffect(Area_GroupList_Stop.get_Item(index), Parallel.Area_Points[2, 1]);
			PlayAreaEffect(Area_GroupList_Stop.get_Item(index), Parallel.Area_Points[2, 2]);
			index++;
			yield return WaitTime(AreaINTR);
		}
	}

	private IEnumerator LeftLower()
	{
		int index = 0;
		while (index < 4)
		{
			PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[3, 3]);
			for (int i = 0; i < 3; i++)
			{
				PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[i, 0]);
				PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[3, i]);
			}
			PlayAreaEffect(Area_GroupList_Move.get_Item(index), Parallel.Area_Points[0, 1]);
			PlayAreaEffect(Area_GroupList_Move.get_Item(index), Parallel.Area_Points[0, 2]);
			PlayAreaEffect(Area_GroupList_Move.get_Item(index), Parallel.Area_Points[0, 3]);
			PlayAreaEffect(Area_GroupList_Move.get_Item(index), Parallel.Area_Points[1, 3]);
			PlayAreaEffect(Area_GroupList_Move.get_Item(index), Parallel.Area_Points[2, 3]);
			PlayAreaEffect(Area_GroupList_Stop.get_Item(index), Parallel.Area_Points[1, 1]);
			PlayAreaEffect(Area_GroupList_Stop.get_Item(index), Parallel.Area_Points[1, 2]);
			PlayAreaEffect(Area_GroupList_Stop.get_Item(index), Parallel.Area_Points[2, 2]);
			index++;
			yield return WaitTime(AreaINTR);
		}
	}

	private IEnumerator RightLower()
	{
		int index = 0;
		while (index < 4)
		{
			PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[3, 3]);
			for (int i = 0; i < 3; i++)
			{
				PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[i, 3]);
				PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[3, i]);
			}
			PlayAreaEffect(Area_GroupList_Move.get_Item(index), Parallel.Area_Points[0, 0]);
			PlayAreaEffect(Area_GroupList_Move.get_Item(index), Parallel.Area_Points[1, 0]);
			PlayAreaEffect(Area_GroupList_Move.get_Item(index), Parallel.Area_Points[2, 0]);
			PlayAreaEffect(Area_GroupList_Move.get_Item(index), Parallel.Area_Points[0, 1]);
			PlayAreaEffect(Area_GroupList_Move.get_Item(index), Parallel.Area_Points[0, 2]);
			PlayAreaEffect(Area_GroupList_Stop.get_Item(index), Parallel.Area_Points[1, 1]);
			PlayAreaEffect(Area_GroupList_Stop.get_Item(index), Parallel.Area_Points[1, 2]);
			PlayAreaEffect(Area_GroupList_Stop.get_Item(index), Parallel.Area_Points[2, 1]);
			index++;
			yield return WaitTime(AreaINTR);
		}
	}
}
