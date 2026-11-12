#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._10501BanShenShu;

public class Skill_CallMonster_CloneActor : SkillSimpleBase
{
	private enum EMasterLevelTag
	{
		Easy,
		Normal,
		Hard
	}

	private const string aiTypeEasy = "Easy";

	private const string aiTypeNormal = "Normal";

	private const string aiTypeHard = "Hard";

	private LogicEntity masterEntity;

	private readonly string FxAlias = "fx_m10501_loop_Skill5_ground";

	private readonly FP SpawnINTR = 3;

	private readonly int MonsterID01 = 1;

	private readonly int MonsterID02 = 2;

	private readonly int MonsterID03 = 3;

	private TSVector2 OriginPOS = new TSVector2(0, 0);

	private List<long> FxSpawn = new List<long>();

	private List<TSVector2> SpawnPOS = new List<TSVector2>
	{
		new TSVector2(-9, 10.6),
		new TSVector2(9, 10.6),
		new TSVector2(-9.8, -0.45),
		new TSVector2(10.5, -0.45)
	};

	protected override void OnSkillEnable()
	{
		masterEntity = GetMonsterCloner();
	}

	protected override void OnSkillDisable()
	{
		if (masterEntity != null)
		{
			SetLogicTagToggleValue(masterEntity, "skillIsRunning", value: false);
		}
		for (int i = 0; i < FxSpawn.Count; i++)
		{
			StopEffect(FxSpawn.get_Item(i));
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		switch (GetAiType())
		{
		case 0:
			SetLogicTagToggleValue(masterEntity, "skillIsRunning", value: true);
			yield return StartCor(SummonEasy());
			break;
		case 1:
			SetLogicTagToggleValue(masterEntity, "skillIsRunning", value: true);
			yield return StartCor(SummonNormal());
			break;
		case 2:
			SetLogicTagToggleValue(masterEntity, "skillIsRunning", value: true);
			yield return StartCor(SummonHard());
			break;
		default:
			yield return StartCor(SummonEasy());
			break;
		}
	}

	protected IEnumerator SummonEasy()
	{
		for (int i = 0; i < 2; i++)
		{
			FxSpawn.Add(PlayEffect(FxAlias, 1f, default, SpawnPOS.get_Item(i), GetTSVectToAngle(OriginPOS - SpawnPOS.get_Item(i), 0)));
		}
		yield return WaitTime(1);
		for (int j = 0; j < 3; j++)
		{
			switch (j)
			{
			case 0:
			{
				for (int l = 0; l < 2; l++)
				{
					CommonUtils_MonsterAPI.SummonTeammate(masterEntity as MonsterAdventureActor, MonsterID03, SpawnPOS.get_Item(l), OriginPOS - SpawnPOS.get_Item(l));
				}
				break;
			}
			case 1:
			{
				for (int m = 0; m < 2; m++)
				{
					CommonUtils_MonsterAPI.SummonTeammate(masterEntity as MonsterAdventureActor, MonsterID02, SpawnPOS.get_Item(m), OriginPOS - SpawnPOS.get_Item(m));
				}
				break;
			}
			default:
			{
				for (int k = 0; k < 2; k++)
				{
					CommonUtils_MonsterAPI.SummonTeammate(masterEntity as MonsterAdventureActor, MonsterID03, SpawnPOS.get_Item(k), OriginPOS - SpawnPOS.get_Item(k));
				}
				break;
			}
			}
			yield return WaitTime(SpawnINTR);
		}
		yield return WaitTime(1);
		for (int n = 0; n < FxSpawn.Count; n++)
		{
			StopEffect(FxSpawn.get_Item(n));
		}
		NovaLogger.Debug("刷怪结束");
		yield return WaitTime(0.5);
	}

	protected IEnumerator SummonNormal()
	{
		for (int i = 0; i < 4; i++)
		{
			FxSpawn.Add(PlayEffect(FxAlias, 1f, default, SpawnPOS.get_Item(i), GetTSVectToAngle(OriginPOS - SpawnPOS.get_Item(i), 0)));
		}
		yield return WaitTime(1);
		for (int j = 0; j < 4; j++)
		{
			switch (j)
			{
			case 0:
			{
				for (int n = 0; n < 4; n++)
				{
					CommonUtils_MonsterAPI.SummonTeammate(masterEntity as MonsterAdventureActor, MonsterID01, SpawnPOS.get_Item(n), OriginPOS - SpawnPOS.get_Item(n));
				}
				break;
			}
			case 1:
			{
				for (int l = 0; l < 2; l++)
				{
					CommonUtils_MonsterAPI.SummonTeammate(masterEntity as MonsterAdventureActor, MonsterID03, SpawnPOS.get_Item(l), OriginPOS - SpawnPOS.get_Item(l));
				}
				break;
			}
			case 2:
			{
				for (int m = 0; m < 2; m++)
				{
					CommonUtils_MonsterAPI.SummonTeammate(masterEntity as MonsterAdventureActor, MonsterID02, SpawnPOS.get_Item(m), OriginPOS - SpawnPOS.get_Item(m));
				}
				break;
			}
			default:
			{
				for (int k = 0; k < 4; k++)
				{
					CommonUtils_MonsterAPI.SummonTeammate(masterEntity as MonsterAdventureActor, MonsterID03, SpawnPOS.get_Item(k), OriginPOS - SpawnPOS.get_Item(k));
				}
				break;
			}
			}
			yield return WaitTime(SpawnINTR);
		}
		yield return WaitTime(1);
		for (int num = 0; num < FxSpawn.Count; num++)
		{
			StopEffect(FxSpawn.get_Item(num));
		}
		NovaLogger.Debug("刷怪结束");
		yield return WaitTime(0.5);
	}

	protected IEnumerator SummonHard()
	{
		for (int i = 0; i < 4; i++)
		{
			FxSpawn.Add(PlayEffect(FxAlias, 1f, default, SpawnPOS.get_Item(i), GetTSVectToAngle(OriginPOS - SpawnPOS.get_Item(i), 0)));
		}
		yield return WaitTime(1);
		for (int j = 0; j < 3; j++)
		{
			switch (j)
			{
			case 0:
			{
				for (int l = 0; l < 4; l++)
				{
					CommonUtils_MonsterAPI.SummonTeammate(masterEntity as MonsterAdventureActor, MonsterID03, SpawnPOS.get_Item(l), OriginPOS - SpawnPOS.get_Item(l));
				}
				break;
			}
			case 1:
			{
				for (int m = 0; m < 2; m++)
				{
					CommonUtils_MonsterAPI.SummonTeammate(masterEntity as MonsterAdventureActor, MonsterID01, SpawnPOS.get_Item(m), OriginPOS - SpawnPOS.get_Item(m));
				}
				break;
			}
			default:
			{
				for (int k = 0; k < 2; k++)
				{
					CommonUtils_MonsterAPI.SummonTeammate(masterEntity as MonsterAdventureActor, MonsterID02, SpawnPOS.get_Item(k), OriginPOS - SpawnPOS.get_Item(k));
				}
				break;
			}
			}
			yield return WaitTime(SpawnINTR);
		}
		yield return WaitTime(1);
		for (int n = 0; n < FxSpawn.Count; n++)
		{
			StopEffect(FxSpawn.get_Item(n));
		}
		NovaLogger.Debug("刷怪结束");
		yield return WaitTime(0.5);
	}

	protected int GetAiType()
	{
		int num = 0;
		AdventureActor monsterCloner = GetMonsterCloner();
		switch (GetMonsterTagValue(monsterCloner, 1))
		{
		case "Easy":
			return 0;
		case "Normal":
			return 1;
		case "Hard":
			return 2;
		default:
			NovaLogger.Debug("半身树.获取AI类型异常,默认为简单");
			return 0;
		}
	}
}
