#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._50551CanCha;

public class Skill_TeamShooting_Clone_LD : SkillBaseCanCha
{
	private LogicEntity master;

	private List<LogicEntity> teamMateList = new List<LogicEntity>();

	private List<LogicEntity> _killMateList = new List<LogicEntity>();

	private LogicEntity[,] _summonArray;

	private TSVector2 summonPOS_Ori = new TSVector2(7.5, 6);

	private readonly int row = 3;

	private readonly int column = 9;

	private int attackTimes;

	protected override void OnSkillEnable()
	{
		master = GetMonsterCloner();
		SetLogicTagToggleValue(master, "TeamShooting", value: true);
		attackTimes = 0;
		_summonArray = new LogicEntity[3, column];
		NovaLogger.Debug("MiniBoss餐叉猪分身.射击矩阵技能.开始");
	}

	protected override void OnSkillDisable()
	{
		SetLogicTagToggleValue(master, "TeamShooting", value: false);
		_killMateList.Clear();
		_summonArray = null;
		teamMateList.Clear();
		NovaLogger.Debug("MiniBoss餐叉猪分身.射击矩阵技能.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		StartCor(EndCondition());
		yield return StartCor(SummonTheTeam(6, 3));
		yield return StartCor(SummonAction());
	}

	protected IEnumerator SummonTheTeam(int horizontalCount, int verticalCount)
	{
		for (int m = 0; m < verticalCount; m++)
		{
			int randomIndex = (int)(long)GetRandomValue(0, horizontalCount - 1, isInt: true);
			int vacancy = 2;
			bool cointinueCondition = ((horizontalCount >= randomIndex + vacancy) ? true : false);
			for (int i = 0; i < horizontalCount; i++)
			{
				if (cointinueCondition)
				{
					if (i >= randomIndex && i <= randomIndex + vacancy - 1)
					{
						continue;
					}
				}
				else if (i >= horizontalCount - vacancy && i <= horizontalCount)
				{
					continue;
				}
				yield return WaitTime(0.05);
				FP fP = 0.3;
				NovaLogger.Debug("餐叉猪分身.召唤队友");
				if (m > 0 && m % 2 != 0)
				{
					CommonUtils_MonsterAPI.SummonTeammate(master as MonsterAdventureActor, 3, new TSVector2(-summonPOS_Ori.x + (summonPOS_Ori.x * 2 / horizontalCount + fP) * i, summonPOS_Ori.y + 3 * m), TSVector2.down);
				}
				else
				{
					CommonUtils_MonsterAPI.SummonTeammate(master as MonsterAdventureActor, 3, new TSVector2(summonPOS_Ori.x - (summonPOS_Ori.x * 2 / horizontalCount + fP) * i, summonPOS_Ori.y + 3 * m), TSVector2.down);
				}
				yield return WaitTime(0.05);
				teamMateList = GetTargetsByFaction(isFriend: true);
				NovaLogger.Debug("餐叉猪分身.队友标签数量" + teamMateList.Count);
				for (int j = 0; j < teamMateList.Count; j++)
				{
					if (!GetLogicTagToggleValue(teamMateList.get_Item(j), "IsMaster") && !GetLogicTagToggleValue(teamMateList.get_Item(j), "IsSummon"))
					{
						SetLogicTagToggleValue(teamMateList.get_Item(j), "IsSummon", value: true);
						_summonArray[m, i] = teamMateList.get_Item(j);
					}
				}
				teamMateList.Clear();
			}
		}
		yield return WaitTime(1);
	}

	protected IEnumerator KillTheTeam()
	{
		for (int i = 0; i < _summonArray.GetLength(1); i++)
		{
			if (_summonArray[attackTimes, i] != null)
			{
				_killMateList.Add(_summonArray[attackTimes, i]);
			}
		}
		KillActors(_killMateList);
		yield return null;
	}

	protected IEnumerator ATKOrder()
	{
		NovaLogger.Debug("MiniBoss餐叉猪分身.射击矩阵技能.设置攻击标签.开始");
		for (int i = 0; i < _summonArray.GetLength(1); i++)
		{
			if (_summonArray[attackTimes, i] != null)
			{
				SetLogicTagToggleValue(_summonArray[attackTimes, i], "ATKOrder", value: true);
				NovaLogger.Debug("MiniBoss餐叉猪分身.射击矩阵技能.设置攻击标签.对象为" + _summonArray[attackTimes, i]);
			}
		}
		NovaLogger.Debug("MiniBoss餐叉猪分身.射击矩阵技能.设置攻击标签.结束");
		yield return null;
	}

	protected IEnumerator MoveToPOS()
	{
		for (int i = 0; i < _summonArray.GetLength(1); i++)
		{
			SetLogicTagToggleValue(_summonArray[attackTimes, i], "MoveToPOS", value: true);
		}
		yield return null;
	}

	protected IEnumerator EndCondition()
	{
		for (int i = 0; i < 40; i++)
		{
			if (master.IsDead())
			{
				break;
			}
			yield return WaitTime(0.5);
		}
		InterruptSkill();
	}

	private IEnumerator SummonAction()
	{
		for (int i = 0; i < 3; i++)
		{
			NovaLogger.Debug("餐叉猪分身.同步攻击.轮次" + i);
			StartCor(ATKOrder());
			yield return WaitTime(3);
			yield return StartCor(KillTheTeam());
			if (i == 2)
			{
				break;
			}
			attackTimes++;
			yield return WaitTime(0.6);
			StartCor(MoveToPOS());
			yield return WaitTime(1.2);
		}
		InterruptSkill();
	}
}
