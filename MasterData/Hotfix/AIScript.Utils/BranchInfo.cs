using Nova.Hotfix;
using TrueSync;

namespace AIScript.Utils;

public class BranchInfo
{
	public readonly MonsterActionBranch baseInfo;

	public FP aiCdExpireTime;

	public FP skillCdExpireTime;

	public bool immBondage;

	public int weightStartIndex;

	public int weightEndIndex;

	public bool actived;

	public bool closed;

	public bool isRunning;

	private AdventureActor actor;

	public BranchInfo(MonsterActionBranch monsterActionBranch, FP currentTime, AdventureActor _actor)
	{
		immBondage = false;
		baseInfo = monsterActionBranch;
		actor = _actor;
		ResetRandomAiCd();
		actived = baseInfo.Activate;
	}

	public void ResetRandomAiCd()
	{
		if (!(actor == null))
		{
			FP fP = 0;
			if (baseInfo.InitialCDPool.Count > 0)
			{
				int index = TSRandom.Range(0, baseInfo.InitialCDPool.Count);
				fP = FP.FromMyriad(baseInfo.InitialCDPool.get_Item(index));
			}
			aiCdExpireTime = actor.LogicTime + fP;
		}
	}

	public void ResetAiCdExpireTime(FP currentTime)
	{
		if (actor is MonsterAdventureActor monsterAdventureActor)
		{
			if (baseInfo.FixedCD)
			{
				aiCdExpireTime = currentTime + FP.FromMyriad(baseInfo.CD) * (FP)monsterAdventureActor.aiBranchCDRatio;
			}
			else
			{
				aiCdExpireTime = currentTime + FP.FromMyriad(baseInfo.CD);
			}
		}
		else if (actor is TrapAdventureActor)
		{
			if (baseInfo.FixedCD)
			{
				aiCdExpireTime = currentTime + FP.FromMyriad(baseInfo.CD) * 1;
			}
			else
			{
				aiCdExpireTime = currentTime + FP.FromMyriad(baseInfo.CD);
			}
		}
	}

	public void ClearAiCdExpireTime(FP currentTime)
	{
		if (baseInfo.FixedCD)
		{
			aiCdExpireTime = currentTime;
		}
	}

	public void SetSkillCdExpireTime(FP cd, FP currentTime)
	{
		skillCdExpireTime = cd + currentTime;
	}
}
