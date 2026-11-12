#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._17510GuLuHaiTu;

public class Skill_WaveAcross_Clone : SkillScript_Base
{
	private List<TSVector2> spwanPOS;

	private List<LogicEntity> mateList = new List<LogicEntity>();

	private CoroutineNode WaveCor;

	private List<long> warningFxList = new List<long>();

	private List<TSVector2> spawnPOS01 = new List<TSVector2>
	{
		new TSVector2(-8, 8),
		new TSVector2(-8, 0),
		new TSVector2(-8, -8)
	};

	private List<TSVector2> spawnPOS02 = new List<TSVector2>
	{
		new TSVector2(8, 8),
		new TSVector2(8, 0),
		new TSVector2(8, -8)
	};

	private List<TSVector2> spawnPOS03 = new List<TSVector2>
	{
		new TSVector2(-12.5, 8),
		new TSVector2(-12.5, 0),
		new TSVector2(-12.5, -8)
	};

	private List<TSVector2> spawnPOS04 = new List<TSVector2>
	{
		new TSVector2(12.5, 8),
		new TSVector2(12.5, 0),
		new TSVector2(12.5, -8)
	};

	private List<TSVector2> fishSpawnPOS01 = new List<TSVector2>
	{
		new TSVector2(-16.75, 8),
		new TSVector2(-16.75, 0),
		new TSVector2(-16.75, -8)
	};

	private List<TSVector2> fishSpawnPOS02 = new List<TSVector2>
	{
		new TSVector2(16.75, 8),
		new TSVector2(16.75, 0),
		new TSVector2(16.75, -8)
	};

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("咕噜海兔分身.潮汐.开始");
	}

	protected override void OnSkillDisable()
	{
		if (warningFxList != null && warningFxList.Count > 0)
		{
			for (int i = 0; i < warningFxList.Count; i++)
			{
				StopEffect(warningFxList.get_Item(i));
			}
			warningFxList.Clear();
		}
		if (spwanPOS != null && spwanPOS.Count > 0)
		{
			spwanPOS.Clear();
		}
		else
		{
			spwanPOS = null;
		}
		if (mateList != null && mateList.Count > 0)
		{
			mateList.Clear();
		}
		StopCor(WaveCor);
		NovaLogger.Debug("咕噜海兔分身.潮汐.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		StartCor(EndCondition());
		TSVector2 beginPOS = new TSVector2(-8, 8);
		yield return StartCor(WaveAttack(beginPOS, TSVector2.down));
	}

	protected IEnumerator EndCondition()
	{
		for (int i = 0; i < 20; i++)
		{
			mateList = GetTargetsByFaction(isFriend: true);
			if (mateList == null || mateList.Count == 0)
			{
				break;
			}
			yield return WaitTime(0.5);
		}
		InterruptSkill();
	}

	protected IEnumerator FishMove(List<TSVector2> initialPOS, TSVector2 forward)
	{
		FP waitTime = 0.2;
		TSVector2 positionOffset01 = new TSVector2(0, 0.7);
		TSVector2 positionOffset2 = new TSVector2(0, -1.3);
		for (int i = 0; i < initialPOS.Count; i++)
		{
			CommonUtils_MonsterAPI.SummonTeammate(spawnPosition: (i != 1) ? TransLocalPosToWorldPos(initialPOS.get_Item(i), forward, positionOffset2) : TransLocalPosToWorldPos(initialPOS.get_Item(i), forward, positionOffset01), actor: GetMonsterCloner() as MonsterAdventureActor, index: 1, spawnDirection: forward, maxAmount: 10);
		}
		yield return WaitTime(waitTime);
		for (int j = 0; j < initialPOS.Count; j++)
		{
			TSVector2 csPOS = ((j != 1) ? TransLocalPosToWorldPos(initialPOS.get_Item(j), forward, new TSVector2(0 + positionOffset01.x, 17 * waitTime + positionOffset01.y)) : TransLocalPosToWorldPos(initialPOS.get_Item(j), forward, new TSVector2(0 + positionOffset2.x, 17 * waitTime + positionOffset2.y)));
			yield return StartCor(SummonFish(csPOS, forward));
		}
	}

	protected IEnumerator SummonFish(TSVector2 csPOS, TSVector2 forward)
	{
		FP waititmg = 0.1;
		CommonUtils_MonsterAPI.SummonTeammate(GetMonsterCloner() as MonsterAdventureActor, 2, new TSVector2(csPOS.x, csPOS.y + 2.25), forward, 10);
		yield return WaitTime(waititmg);
		csPOS = TransLocalPosToWorldPos(csPOS, forward, new TSVector2(0, 17 * waititmg));
		CommonUtils_MonsterAPI.SummonTeammate(GetMonsterCloner() as MonsterAdventureActor, 2, new TSVector2(csPOS.x, csPOS.y - 2.25), forward, 10);
	}
}
