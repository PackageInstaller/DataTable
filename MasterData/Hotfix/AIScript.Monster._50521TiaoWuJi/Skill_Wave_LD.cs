#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50521TiaoWuJi;

public class Skill_Wave_LD : SkillSimpleBase
{
	private int branch;

	private const int diffTag1 = 505210000;

	private const int diffTag2 = 505210001;

	private const int diffTag3 = 505210002;

	private readonly string ActionCombo01 = "Solo_Start_D";

	private readonly int ActionIndex01 = 1;

	private readonly string ActionCombo02 = "Solo_End_D";

	private readonly int ActionIndex02 = 2;

	private readonly List<string> Area_GroupList = new List<string> { "Area_Skill_Wave_Normal_Red_Circle", "Area_Skill_Wave_Normal_Purple", "Area_Empty", "Area_Empty" };

	private readonly List<string> Area_GroupList_Fast = new List<string> { "Area_Skill_Wave_Normal_Purple_Only", "Area_Empty", "Area_Empty", "Area_Empty" };

	private readonly FP AreaINTR = 0.5;

	private readonly TSVector2 MovePOS01 = new TSVector2(-5, 0);

	private readonly TSVector2 MovePOS02 = new TSVector2(5, 0);

	private bool summonSwitch;

	private TSVector2 TargetPOS;

	protected override void OnSkillEnable()
	{
		summonSwitch = false;
	}

	protected override IEnumerator DoMainLogic()
	{
		List<BuffEntity> buffFromTarget = GetBuffFromTarget(_actor, 0, 505210000);
		if (buffFromTarget.Count != 0)
		{
			switch (buffFromTarget.get_Item(0).buffConfig.Id)
			{
			case 505210000:
				branch = 0;
				break;
			case 505210001:
				branch = 1;
				break;
			case 505210002:
				branch = 2;
				break;
			default:
				branch = 2;
				break;
			}
		}
		else
		{
			branch = 2;
		}
		TSVector2 position = GetPosition();
		if (Distance(position, MovePOS01) > Distance(position, MovePOS02))
		{
			TargetPOS = MovePOS01;
		}
		else
		{
			TargetPOS = MovePOS02;
		}
		BeginAttack(ActionIndex01, ActionCombo01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.55);
		BeginAttack(ActionIndex02, ActionCombo02, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect("fx_m50521_base_skill3_start_LD", 1f, -0.3, GetPosition());
		yield return WaitTime(0.3);
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("DeBuff"));
		SetHideModelEnable();
		SetBattleOutEnable();
		SetCloseBlockEnable();
		yield return WaitTime(0.6);
		Teleport(TargetPOS);
		if (TargetPOS == MovePOS01)
		{
			BeginLookAtByPos_NotWait(MovePOS02, 0, 360);
		}
		else
		{
			BeginLookAtByPos_NotWait(MovePOS01, 0, 360);
		}
		yield return WaitTime(0.1);
		PlayEffect("fx_m50521_base_skill3_start_LD", 1f, -0.3, GetPosition());
		yield return WaitTime(0.4);
		SetHideModelDisable();
		SetBattleOutDisable();
		SetCloseBlockDisable();
		yield return WaitTime(0.55);
		StartCor(FirstWave_Normal());
		yield return WaitTime(1);
		StartCor(SecondWave_Normal());
		yield return WaitTime(1);
		StartCor(ThirdWave_Normal());
		yield return WaitTime(1);
		StartCor(FourthWave_Normal());
		yield return WaitTime(1);
		for (int i = 0; i < 2; i++)
		{
			if (i == 1 && branch == 2)
			{
				summonSwitch = true;
			}
			StartCor(FirstWave_Fast());
			yield return WaitTime(0.5);
			StartCor(SecondWave_Fast());
			yield return WaitTime(0.5);
			StartCor(ThirdWave_Fast());
			yield return WaitTime(0.5);
			StartCor(FourthWave_Fast());
			yield return WaitTime(0.5);
		}
	}

	private IEnumerator FirstWave_Normal()
	{
		int index = 0;
		while (index < 4)
		{
			for (int i = 0; i < 4; i++)
			{
				if (TargetPOS == MovePOS01)
				{
					PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[i, 0]);
				}
				else
				{
					PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[i, 3]);
				}
			}
			index++;
			yield return WaitTime(AreaINTR);
		}
	}

	private IEnumerator SecondWave_Normal()
	{
		int index = 0;
		while (index < 4)
		{
			for (int i = 0; i < 4; i++)
			{
				if (TargetPOS == MovePOS01)
				{
					PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[i, 1]);
				}
				else
				{
					PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[i, 2]);
				}
			}
			index++;
			yield return WaitTime(AreaINTR);
		}
	}

	private IEnumerator ThirdWave_Normal()
	{
		int index = 0;
		while (index <= 3)
		{
			for (int i = 0; i < 4; i++)
			{
				if (TargetPOS == MovePOS01)
				{
					PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[i, 2]);
				}
				else
				{
					PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[i, 1]);
				}
			}
			index++;
			yield return WaitTime(AreaINTR);
		}
	}

	private IEnumerator FourthWave_Normal()
	{
		int index = 0;
		while (index <= 3)
		{
			for (int i = 0; i < 4; i++)
			{
				if (TargetPOS == MovePOS01)
				{
					PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[i, 3]);
				}
				else
				{
					PlayAreaEffect(Area_GroupList.get_Item(index), Parallel.Area_Points[i, 0]);
				}
			}
			index++;
			yield return WaitTime(AreaINTR);
		}
	}

	private IEnumerator FirstWave_Fast()
	{
		int index = 0;
		while (index <= 3)
		{
			for (int i = 0; i < 4; i++)
			{
				if (TargetPOS == MovePOS01)
				{
					PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[i, 3]);
				}
				else
				{
					PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[i, 0]);
				}
			}
			index++;
			yield return WaitTime(AreaINTR);
		}
	}

	private IEnumerator SecondWave_Fast()
	{
		int index = 0;
		while (index <= 3)
		{
			for (int i = 0; i < 4; i++)
			{
				if (TargetPOS == MovePOS01)
				{
					PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[i, 2]);
				}
				else
				{
					PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[i, 1]);
				}
			}
			index++;
			yield return WaitTime(AreaINTR);
		}
	}

	private IEnumerator ThirdWave_Fast()
	{
		int index = 0;
		while (index <= 3)
		{
			for (int i = 0; i < 4; i++)
			{
				if (TargetPOS == MovePOS01)
				{
					PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[i, 1]);
				}
				else
				{
					PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[i, 2]);
				}
			}
			index++;
			yield return WaitTime(AreaINTR);
		}
	}

	private IEnumerator FourthWave_Fast()
	{
		int index = 0;
		while (index <= 3)
		{
			for (int i = 0; i < 4; i++)
			{
				if (TargetPOS == MovePOS01)
				{
					PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[i, 0]);
				}
				else
				{
					PlayAreaEffect(Area_GroupList_Fast.get_Item(index), Parallel.Area_Points[i, 3]);
				}
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
		int count = GetTargetByTeammateIndex(1).Count;
		int num = 4;
		if (!summonSwitch || count >= 4)
		{
			yield break;
		}
		NovaLogger.Debug("跳舞机.进入召唤怪物");
		for (int k = 0; k < num - count; k++)
		{
			if (TargetPOS == MovePOS01)
			{
				SummonTeammate(1, Parallel.Area_Points[k, 0], TSVector2.right);
			}
			else
			{
				SummonTeammate(1, Parallel.Area_Points[k, 3], TSVector2.left);
			}
		}
	}
}
