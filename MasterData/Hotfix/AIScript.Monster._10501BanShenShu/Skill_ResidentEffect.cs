#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._10501BanShenShu;

public class Skill_ResidentEffect : SkillSimpleBase
{
	private readonly FP INTR = 15;

	private CoroutineNode endCondition;

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

	private readonly int flowerCount = 2;

	private static readonly int MonsterID = 4;

	private static readonly List<TSVector2> SummonPOS = new List<TSVector2>
	{
		new TSVector2(-10, 3),
		new TSVector2(10.5, 3)
	};

	private LogicEntity Master;

	private List<int> masterDateIDList = new List<int> { 91050100, 91050101, 91050102 };

	private const int stateID01 = 105010000;

	private const int stateID02 = 105010001;

	private const int stateID03 = 105010002;

	private int stateID;

	private int masterDateID;

	private LogicEntity masterEntity;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("半身树.场中常驻效果分身.开始释放技能");
	}

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("半身树.场中常驻效果分身.技能结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		endCondition = StartCor(EndCondition());
		for (int i = 0; i < 500; i++)
		{
			yield return StartCor(Summon());
			yield return WaitTime(INTR);
			yield return StartCor(Flower());
			yield return WaitTime(INTR);
		}
	}

	protected IEnumerator Summon()
	{
		SetLogicTagToggleValue(GetMonsterCloner(), "skillIsRunning", value: true);
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
					CommonUtils_MonsterAPI.SummonTeammate(GetMonsterCloner() as MonsterAdventureActor, MonsterID03, SpawnPOS.get_Item(l), OriginPOS - SpawnPOS.get_Item(l), 10);
				}
				break;
			}
			case 1:
			{
				for (int m = 0; m < 2; m++)
				{
					CommonUtils_MonsterAPI.SummonTeammate(GetMonsterCloner() as MonsterAdventureActor, MonsterID01, SpawnPOS.get_Item(m), OriginPOS - SpawnPOS.get_Item(m), 10);
				}
				break;
			}
			default:
			{
				for (int k = 0; k < 2; k++)
				{
					CommonUtils_MonsterAPI.SummonTeammate(GetMonsterCloner() as MonsterAdventureActor, MonsterID02, SpawnPOS.get_Item(k), OriginPOS - SpawnPOS.get_Item(k), 10);
				}
				break;
			}
			}
			SetLogicTagToggleValue(masterEntity, "skillIsRunning", value: false);
			yield return WaitTime(SpawnINTR);
		}
		yield return WaitTime(1);
		for (int n = 0; n < FxSpawn.Count; n++)
		{
			StopEffect(FxSpawn.get_Item(n));
		}
		NovaLogger.Debug("刷怪结束");
	}

	protected IEnumerator CheckMasterState()
	{
		GetTargetsByFaction(isFriend: true);
		for (int i = 0; i < 500; i++)
		{
			List<LogicEntity> teammatelist = GetTargetsByFaction(isFriend: true);
			if (teammatelist == null)
			{
				InterruptSkill();
				yield return null;
			}
			yield return WaitTime(1);
			teammatelist.Clear();
		}
	}

	protected IEnumerator Flower()
	{
		for (int i = 0; i < flowerCount; i++)
		{
			CommonUtils_MonsterAPI.SummonTeammate(GetMonsterCloner() as MonsterAdventureActor, MonsterID, SummonPOS.get_Item(i), default, 10);
		}
		yield return null;
	}

	protected IEnumerator EndCondition()
	{
		AdventureActor master = GetMonsterCloner();
		List<LogicEntity> friendlyEntity = new List<LogicEntity>();
		while (true)
		{
			friendlyEntity.Clear();
			friendlyEntity.AddRange(GetTargetsByFaction(isFriend: true));
			if (!friendlyEntity.Contains(master))
			{
				InterruptSkill();
			}
			yield return WaitTime(0.5);
		}
	}
}
