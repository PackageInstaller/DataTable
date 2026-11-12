using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50521TiaoWuJi;

public class Skill_Tutti_LD : SkillSimpleBase
{
	private int branch;

	private FP randomValue01;

	private FP randomValue02;

	private const int diffTag1 = 505210000;

	private const int diffTag2 = 505210001;

	private const int diffTag3 = 505210002;

	private readonly string ActionCombo01 = "Tutti";

	private readonly int ActionIndex01 = 1;

	private readonly string FxAppear = "fx_m50521_base_ground_appear";

	private readonly List<string> Area_GroupList_Normal_A = new List<string> { "Area_Skill_Tutti_Normal_Green", "Area_Skill_Tutti_Normal_Yellow", "Area_Skill_Tutti_Normal_Red", "Area_Skill_Tutti_Normal_Purple" };

	private readonly List<string> Area_GroupList_Fast = new List<string> { "Area_Skill_Tutti_Normal_8_Red", "Area_Skill_Tutti_Normal_8_Purple", "Area_Empty", "Area_Empty" };

	private readonly List<string> Area_GroupList_Fast_02 = new List<string> { "Area_Skill_Tutti_Normal_8_Red_02", "Area_Skill_Tutti_Normal_8_Purple_02", "Area_Empty", "Area_Empty" };

	private readonly List<string> Area_GroupList_MUM = new List<string> { "Area_Skill_Advance_Normal_MUM_Green", "Area_Skill_Advance_Normal_MUM_Yellow", "Area_Skill_Advance_Normal_MUM_Red", "Area_Skill_Advance_Normal_MUM_Purple" };

	private readonly List<string> Area_GroupList_Star_MUM = new List<string> { "Area_Skill_Advance_Normal_Star_MUM_Green", "Area_Skill_Advance_Normal_Star_MUM_Yellow", "Area_Skill_Advance_Normal_Star_MUM_Red", "Area_Skill_Advance_Normal_MUM_Purple" };

	private readonly FP AreaINTR = 0.5;

	private readonly string FxAppearGround = "fx_m50521_base_ground_appear";

	private readonly int DebuffTag = CommonHelper.StringToHash("DeBuff");

	protected override IEnumerator DoMainLogic()
	{
		List<BuffEntity> buffFromTarget = GetBuffFromTarget(_actor, 0, 505210000);
		if (buffFromTarget.Count != 0)
		{
			switch (buffFromTarget.get_Item(0).buffConfig.Id)
			{
			case 505210000:
				branch = 0;
				randomValue01 = 1.5f;
				randomValue02 = 1.5f;
				break;
			case 505210001:
				branch = 1;
				randomValue01 = 1.5f;
				randomValue02 = 2.5f;
				break;
			case 505210002:
				branch = 2;
				randomValue01 = 4.5f;
				randomValue02 = 1.5f;
				break;
			default:
				branch = 2;
				randomValue01 = 4.5f;
				randomValue02 = 1.5f;
				break;
			}
		}
		else
		{
			branch = 2;
		}
		BeginAttack(ActionIndex01, ActionCombo01);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		RemoveBuffFromTarget(_actor, 0, 0, DebuffTag);
		SetHideModelEnable();
		SetBattleOutEnable();
		SetCloseBlockEnable();
		yield return WaitTime(0.5);
		if (GetRandomValue(0, randomValue01, isInt: true) == 0)
		{
			yield return StartCor(TypeB());
		}
		else
		{
			yield return StartCor(TypeD());
			if (GetRandomValue(0, randomValue02, isInt: true) == 0)
			{
				yield return StartCor(TypeA());
			}
			else
			{
				yield return StartCor(TypeC());
			}
		}
		Teleport(new TSVector2(0, 0));
		yield return WaitTime(AreaINTR);
		CancelAttack();
		PlayEffect(FxAppear);
		SetHideModelDisable();
		SetBattleOutDisable();
		SetCloseBlockDisable();
		PlayEffect(FxAppearGround);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator TypeA()
	{
		PlayWwiseSound("mon_50521_TUTTI_short");
		for (int i = 0; i < 5; i++)
		{
			if (i > 0)
			{
				PlayAreaEffect(Area_GroupList_MUM.get_Item(3), Parallel.Area_Points[0, Math.Abs(i - 4)]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(3), Parallel.Area_Points[1, Math.Abs(i - 4)]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(3), Parallel.Area_Points[2, i - 1]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(3), Parallel.Area_Points[3, i - 1]);
			}
			if (i < 4)
			{
				PlayAreaEffect(Area_GroupList_MUM.get_Item(2), Parallel.Area_Points[0, Math.Abs(i - 3)]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(2), Parallel.Area_Points[1, Math.Abs(i - 3)]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(2), Parallel.Area_Points[2, i]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(2), Parallel.Area_Points[3, i]);
				yield return WaitTime(AreaINTR);
			}
		}
		for (int i = 0; i < 5; i++)
		{
			if (i > 0)
			{
				PlayAreaEffect(Area_GroupList_MUM.get_Item(3), Parallel.Area_Points[i - 1, 2]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(3), Parallel.Area_Points[i - 1, 3]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(3), Parallel.Area_Points[Math.Abs(i - 4), 0]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(3), Parallel.Area_Points[Math.Abs(i - 4), 1]);
			}
			if (i < 4)
			{
				PlayAreaEffect(Area_GroupList_MUM.get_Item(2), Parallel.Area_Points[i, 2]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(2), Parallel.Area_Points[i, 3]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(2), Parallel.Area_Points[Math.Abs(i - 3), 0]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(2), Parallel.Area_Points[Math.Abs(i - 3), 1]);
				yield return WaitTime(AreaINTR);
			}
		}
	}

	private IEnumerator TypeB()
	{
		PlayWwiseSound("mon_50521_Msc_ult2_0_part1");
		for (int i = 0; i < 4; i++)
		{
			if (i < 2)
			{
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[1, 2]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[1, 3]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[2, 2]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[2, 3]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[3, 3]);
			}
			else if (i == 2)
			{
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[1, 2]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[1, 3]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(2), Parallel.Area_Points[2, 2]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(2), Parallel.Area_Points[2, 3]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[3, 3]);
			}
			else
			{
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[1, 2]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[1, 3]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(3), Parallel.Area_Points[2, 2]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(3), Parallel.Area_Points[2, 3]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[3, 3]);
			}
			switch (i)
			{
			case 0:
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[0, 0]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[0, 1]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[1, 0]);
				break;
			case 1:
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[0, 0]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[1, 1]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[1, 0]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[2, 0]);
				break;
			case 2:
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[1, 0]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(2), Parallel.Area_Points[2, 1]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(2), Parallel.Area_Points[2, 0]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[3, 0]);
				if (branch > 0)
				{
					SummonTeammate(1, Parallel.Area_Points[2, 1], TSVector2.up);
					SummonTeammate(1, Parallel.Area_Points[2, 2], TSVector2.up);
				}
				break;
			default:
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[1, 0]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(3), Parallel.Area_Points[2, 1]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(3), Parallel.Area_Points[2, 0]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[3, 0]);
				break;
			}
			yield return WaitTime(AreaINTR);
		}
		PlayWwiseSound("mon_50521_Msc_ult2_0_part1");
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(1);
		if (targetByTeammateIndex != null && targetByTeammateIndex.Count > 0)
		{
			for (int j = 0; j < targetByTeammateIndex.Count; j++)
			{
				SetLogicTagToggleValue(targetByTeammateIndex.get_Item(j), "SummonATK", value: true);
			}
		}
		for (int i = 0; i < 4; i++)
		{
			if (i < 2)
			{
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[2, 0]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[3, 0]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[2, 2]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[2, 3]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[3, 3]);
			}
			else if (i == 2)
			{
				PlayAreaEffect(Area_GroupList_MUM.get_Item(2), Parallel.Area_Points[2, 0]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[3, 0]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(2), Parallel.Area_Points[2, 2]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(2), Parallel.Area_Points[2, 3]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[3, 3]);
			}
			else
			{
				PlayAreaEffect(Area_GroupList_MUM.get_Item(3), Parallel.Area_Points[2, 0]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[3, 0]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(3), Parallel.Area_Points[2, 2]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(3), Parallel.Area_Points[2, 3]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[3, 3]);
			}
			switch (i)
			{
			case 0:
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[0, 1]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[1, 1]);
				break;
			case 1:
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[0, 0]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[0, 1]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[1, 1]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[2, 1]);
				break;
			case 2:
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[1, 0]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[1, 1]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(2), Parallel.Area_Points[2, 1]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[3, 1]);
				if (branch > 0)
				{
					SummonTeammate(1, Parallel.Area_Points[2, 0], TSVector2.up);
					SummonTeammate(1, Parallel.Area_Points[2, 3], TSVector2.up);
				}
				break;
			default:
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[1, 0]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[1, 1]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(3), Parallel.Area_Points[2, 1]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[3, 1]);
				break;
			}
			yield return WaitTime(AreaINTR);
		}
		targetByTeammateIndex = GetTargetByTeammateIndex(1);
		if (targetByTeammateIndex != null && targetByTeammateIndex.Count > 0)
		{
			for (int k = 0; k < targetByTeammateIndex.Count; k++)
			{
				SetLogicTagToggleValue(targetByTeammateIndex.get_Item(k), "SummonATK", value: true);
			}
		}
		PlayWwiseSound("mon_50521_Msc_ult2_0_part1");
		for (int i = 0; i < 4; i++)
		{
			if (i < 2)
			{
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[2, 0]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[2, 1]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[3, 0]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[3, 1]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[3, 3]);
			}
			else if (i == 2)
			{
				PlayAreaEffect(Area_GroupList_MUM.get_Item(2), Parallel.Area_Points[2, 0]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(2), Parallel.Area_Points[2, 1]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(2), Parallel.Area_Points[3, 0]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(2), Parallel.Area_Points[3, 1]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(2), Parallel.Area_Points[3, 3]);
			}
			else
			{
				PlayAreaEffect(Area_GroupList_MUM.get_Item(3), Parallel.Area_Points[2, 0]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(3), Parallel.Area_Points[2, 1]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(3), Parallel.Area_Points[3, 0]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(3), Parallel.Area_Points[3, 1]);
				PlayAreaEffect(Area_GroupList_MUM.get_Item(3), Parallel.Area_Points[3, 3]);
			}
			switch (i)
			{
			case 0:
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[0, 2]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[0, 3]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[1, 2]);
				break;
			case 1:
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[0, 3]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[1, 2]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[1, 3]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[2, 2]);
				break;
			case 2:
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[1, 3]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(2), Parallel.Area_Points[2, 2]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(2), Parallel.Area_Points[2, 3]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(2), Parallel.Area_Points[3, 2]);
				if (branch > 0)
				{
					SummonTeammate(1, Parallel.Area_Points[3, 1], TSVector2.up);
					SummonTeammate(1, Parallel.Area_Points[3, 2], TSVector2.up);
				}
				break;
			default:
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[1, 3]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(3), Parallel.Area_Points[2, 2]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(3), Parallel.Area_Points[2, 3]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(3), Parallel.Area_Points[3, 2]);
				break;
			}
			yield return WaitTime(AreaINTR);
		}
		targetByTeammateIndex = GetTargetByTeammateIndex(1);
		if (targetByTeammateIndex != null && targetByTeammateIndex.Count > 0)
		{
			for (int l = 0; l < targetByTeammateIndex.Count; l++)
			{
				SetLogicTagToggleValue(targetByTeammateIndex.get_Item(l), "SummonATK", value: true);
			}
		}
		PlayWwiseSound("mon_50521_Msc_ult2_0_part1");
		for (int i = 0; i < 4; i++)
		{
			if (i < 2)
			{
				PlayAreaEffect(Area_GroupList_MUM.get_Item(0), Parallel.Area_Points[3, 3]);
			}
			else if (i == 2)
			{
				PlayAreaEffect(Area_GroupList_MUM.get_Item(2), Parallel.Area_Points[3, 3]);
			}
			else
			{
				PlayAreaEffect(Area_GroupList_MUM.get_Item(3), Parallel.Area_Points[3, 3]);
			}
			if (i < 2)
			{
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[Math.Abs(i + 1), 2]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[Math.Abs(i + 1), 1]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(1), Parallel.Area_Points[Math.Abs(i + 1), 0]);
			}
			else if (i == 2)
			{
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(2), Parallel.Area_Points[Math.Abs(i + 1), 2]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(2), Parallel.Area_Points[Math.Abs(i + 1), 1]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(2), Parallel.Area_Points[Math.Abs(i + 1), 0]);
			}
			else
			{
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(3), Parallel.Area_Points[3, 2]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(3), Parallel.Area_Points[3, 1]);
				PlayAreaEffect(Area_GroupList_Star_MUM.get_Item(3), Parallel.Area_Points[3, 0]);
			}
			yield return WaitTime(AreaINTR);
		}
		SetLogicTagToggleValue(_actor, "IsTetris", value: true);
	}

	private IEnumerator TypeC()
	{
		if (branch > 0)
		{
			SummonTeammate(1, Parallel.Area_Points[0, 0], TSVector2.right);
			SummonTeammate(1, Parallel.Area_Points[3, 3], TSVector2.left);
		}
		for (int i = 0; i < 3; i++)
		{
			PlayAreaEffect(Area_GroupList_Fast_02.get_Item(0), Parallel.Area_Points[0, i + 1]);
			PlayAreaEffect(Area_GroupList_Fast_02.get_Item(0), Parallel.Area_Points[3, Math.Abs(i - 2)]);
			PlayAreaEffect(Area_GroupList_Fast_02.get_Item(1), Parallel.Area_Points[0, i]);
			PlayAreaEffect(Area_GroupList_Fast_02.get_Item(1), Parallel.Area_Points[3, Math.Abs(i - 3)]);
			yield return WaitTime(AreaINTR);
		}
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(1);
		if (targetByTeammateIndex != null && targetByTeammateIndex.Count > 0)
		{
			for (int j = 0; j < targetByTeammateIndex.Count; j++)
			{
				SetLogicTagToggleValue(targetByTeammateIndex.get_Item(j), "SummonATK", value: true);
			}
		}
		PlayAreaEffect(Area_GroupList_Fast_02.get_Item(1), Parallel.Area_Points[0, 3]);
		PlayAreaEffect(Area_GroupList_Fast_02.get_Item(1), Parallel.Area_Points[3, 0]);
		for (int i = 0; i < 4; i++)
		{
			PlayAreaEffect(Area_GroupList_Fast_02.get_Item(0), Parallel.Area_Points[1, Math.Abs(i - 3)]);
			PlayAreaEffect(Area_GroupList_Fast_02.get_Item(0), Parallel.Area_Points[2, i]);
			if (i > 0)
			{
				PlayAreaEffect(Area_GroupList_Fast_02.get_Item(1), Parallel.Area_Points[1, Math.Abs(i - 3) + 1]);
				PlayAreaEffect(Area_GroupList_Fast_02.get_Item(1), Parallel.Area_Points[2, i - 1]);
				PlayAreaEffect(Area_GroupList_Fast_02.get_Item(1), Parallel.Area_Points[2, i - 1]);
			}
			yield return WaitTime(AreaINTR);
		}
		if (branch > 0)
		{
			SummonTeammate(1, Parallel.Area_Points[1, 3], TSVector2.left);
			SummonTeammate(1, Parallel.Area_Points[2, 0], TSVector2.right);
		}
		PlayAreaEffect(Area_GroupList_Fast_02.get_Item(1), Parallel.Area_Points[1, 0]);
		PlayAreaEffect(Area_GroupList_Fast_02.get_Item(1), Parallel.Area_Points[2, 3]);
		for (int i = 0; i < 4; i++)
		{
			PlayAreaEffect(Area_GroupList_Fast_02.get_Item(0), Parallel.Area_Points[2, i]);
			PlayAreaEffect(Area_GroupList_Fast_02.get_Item(0), Parallel.Area_Points[1, Math.Abs(i - 3)]);
			if (i > 0)
			{
				PlayAreaEffect(Area_GroupList_Fast_02.get_Item(1), Parallel.Area_Points[2, i - 1]);
				PlayAreaEffect(Area_GroupList_Fast_02.get_Item(1), Parallel.Area_Points[1, Math.Abs(i - 3) + 1]);
			}
			yield return WaitTime(AreaINTR);
		}
		targetByTeammateIndex = GetTargetByTeammateIndex(1);
		if (targetByTeammateIndex != null && targetByTeammateIndex.Count > 0)
		{
			for (int k = 0; k < targetByTeammateIndex.Count; k++)
			{
				SetLogicTagToggleValue(targetByTeammateIndex.get_Item(k), "SummonATK", value: true);
			}
		}
		PlayAreaEffect(Area_GroupList_Fast_02.get_Item(1), Parallel.Area_Points[2, 3]);
		PlayAreaEffect(Area_GroupList_Fast_02.get_Item(1), Parallel.Area_Points[1, 0]);
		for (int i = 0; i < 4; i++)
		{
			PlayAreaEffect(Area_GroupList_Fast_02.get_Item(0), Parallel.Area_Points[3, Math.Abs(i - 3)]);
			PlayAreaEffect(Area_GroupList_Fast_02.get_Item(0), Parallel.Area_Points[0, i]);
			if (i > 0)
			{
				PlayAreaEffect(Area_GroupList_Fast_02.get_Item(1), Parallel.Area_Points[3, Math.Abs(i - 3) + 1]);
				PlayAreaEffect(Area_GroupList_Fast_02.get_Item(1), Parallel.Area_Points[0, i - 1]);
			}
			yield return WaitTime(AreaINTR);
		}
		PlayAreaEffect(Area_GroupList_Fast_02.get_Item(1), Parallel.Area_Points[3, 0]);
		PlayAreaEffect(Area_GroupList_Fast_02.get_Item(1), Parallel.Area_Points[0, 3]);
	}

	private IEnumerator TypeD()
	{
		int index = 0;
		while (index < 4)
		{
			for (int i = 0; i < 4; i++)
			{
				PlayAreaEffect(Area_GroupList_Normal_A.get_Item(index), Parallel.Area_Points[i, 0]);
				PlayAreaEffect(Area_GroupList_Normal_A.get_Item(index), Parallel.Area_Points[i, 3]);
			}
			index++;
			yield return WaitTime(AreaINTR);
		}
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(1);
		if (targetByTeammateIndex != null && targetByTeammateIndex.Count > 0)
		{
			for (int j = 0; j < targetByTeammateIndex.Count; j++)
			{
				SetLogicTagToggleValue(targetByTeammateIndex.get_Item(j), "SummonATK", value: true);
			}
		}
		index = 0;
		while (index < 4)
		{
			for (int k = 0; k < 4; k++)
			{
				PlayAreaEffect(Area_GroupList_Normal_A.get_Item(index), Parallel.Area_Points[k, 1]);
				PlayAreaEffect(Area_GroupList_Normal_A.get_Item(index), Parallel.Area_Points[k, 2]);
			}
			index++;
			yield return WaitTime(AreaINTR);
		}
		index = 0;
		while (index < 2)
		{
			for (int l = 0; l < 4; l++)
			{
				PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[l, 1]);
				PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[l, 2]);
			}
			index++;
			yield return WaitTime(AreaINTR);
		}
		index = 0;
		while (index < 2)
		{
			for (int m = 0; m < 4; m++)
			{
				PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[m, 0]);
				PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[m, 3]);
			}
			index++;
			yield return WaitTime(AreaINTR);
		}
		for (int n = 0; n < 2; n++)
		{
			PlayAreaEffect(Area_GroupList_Fast.get_Item(n), Parallel.Area_Points[1, 1]);
			PlayAreaEffect(Area_GroupList_Fast.get_Item(n), Parallel.Area_Points[1, 2]);
			PlayAreaEffect(Area_GroupList_Fast.get_Item(n), Parallel.Area_Points[2, 1]);
			PlayAreaEffect(Area_GroupList_Fast.get_Item(n), Parallel.Area_Points[2, 2]);
			yield return WaitTime(AreaINTR);
		}
		index = 0;
		while (index < 2)
		{
			for (int num = 0; num < 4; num++)
			{
				PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[0, num]);
				PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[3, num]);
			}
			switch (index)
			{
			case 0:
				PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[1, 0]);
				PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[2, 0]);
				PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[1, 3]);
				PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[2, 3]);
				break;
			case 1:
				PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[1, 0]);
				PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[2, 0]);
				PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[1, 3]);
				PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[2, 3]);
				break;
			}
			index++;
			yield return WaitTime(AreaINTR);
		}
	}
}
