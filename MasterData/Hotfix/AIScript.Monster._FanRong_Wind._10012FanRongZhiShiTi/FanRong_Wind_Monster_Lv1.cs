using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._FanRong_Wind._10012FanRongZhiShiTi;

public class FanRong_Wind_Monster_Lv1 : MonsterActionBase
{
	private readonly int Skill_Attack01 = 1001259;

	private FP BossStage;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		BossStage = 1;
		List<PoolBranchesInfo> list = new List<PoolBranchesInfo>();
		PoolBranchesInfo poolBranchesInfo = new PoolBranchesInfo
		{
			index = 1
		};
		List<PoolBranchInfo> list2 = new List<PoolBranchInfo>();
		AdventureActor actor = _actor;
		FP cd = 6;
		FP initCd = 10;
		FP releaseDistance = 60;
		FP releaseAngle = 90;
		OperateDelegate operateIEnumerator = ZDAttackCast;
		list2.Add(new PoolBranchInfo(actor, 2004, 30, cd, initCd, active: true, releaseDistance, releaseAngle, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private IEnumerator ZDAttackCast()
	{
		GotoCastskill(Skill_Attack01);
		yield return WaitSkillFinish();
	}

	private void GotoCastskill(int id)
	{
		CastSkill(id);
	}
}
