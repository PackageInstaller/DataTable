using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._17510GuLuHaiTu;

public class Action_LD : ActionBaseGuLuHaiTu
{
	private Dictionary<int, bool> _dicSkill = new Dictionary<int, bool>();

	protected override Dictionary<int, bool> dicSkill => _dicSkill;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
	}

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		_thinkInterval = 0.05;
		List<PoolBranchesInfo> list = new List<PoolBranchesInfo>();
		PoolBranchesInfo poolBranchesInfo = new PoolBranchesInfo
		{
			index = 1
		};
		List<PoolBranchInfo> list2 = new List<PoolBranchInfo>();
		AdventureActor actor = _actor;
		int id = idExhale;
		FP cd = 13;
		FP initCd = 2;
		OperateDelegate operateIEnumerator = ExhaleCondition;
		list2.Add(new PoolBranchInfo(actor, id, 0, cd, initCd, active: false, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		int id2 = idWave;
		FP cd2 = 20;
		FP initCd2 = 5;
		operateIEnumerator = WaveAcrossCondition;
		list2.Add(new PoolBranchInfo(actor2, id2, 1, cd2, initCd2, active: false, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		int id3 = idEWCombo;
		FP cd3 = 30;
		FP initCd3 = 10;
		operateIEnumerator = EWComboCondition;
		list2.Add(new PoolBranchInfo(actor3, id3, 2, cd3, initCd3, active: false, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		int id4 = idFishShoot;
		FP cd4 = 45;
		FP initCd4 = 15;
		operateIEnumerator = fishShootCondition;
		list2.Add(new PoolBranchInfo(actor4, id4, 3, cd4, initCd4, active: false, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		int id5 = idFrontalRepulse;
		FP cd5 = 50;
		FP initCd5 = 60;
		operateIEnumerator = FrontalRepulseCondition;
		list2.Add(new PoolBranchInfo(actor5, id5, 4, cd5, initCd5, active: false, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor6 = _actor;
		int id6 = idPointRepulse;
		FP cd6 = 60;
		FP initCd6 = 65;
		operateIEnumerator = POSRepulseCondition;
		list2.Add(new PoolBranchInfo(actor6, id6, 5, cd6, initCd6, active: false, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor7 = _actor;
		int id7 = idFloorBreak;
		FP cd7 = 40;
		FP initCd7 = 35;
		operateIEnumerator = FloorBreakCondition;
		list2.Add(new PoolBranchInfo(actor7, id7, 98, cd7, initCd7, active: false, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor8 = _actor;
		int id8 = idRepulse;
		FP cd8 = 70;
		FP initCd8 = 80;
		operateIEnumerator = RepulseCondition;
		list2.Add(new PoolBranchInfo(actor8, id8, 7, cd8, initCd8, active: false, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor9 = _actor;
		int id9 = idInitialization;
		FP cd9 = 10;
		FP initCd9 = 0;
		operateIEnumerator = InitializationCondition;
		list2.Add(new PoolBranchInfo(actor9, id9, 99, cd9, initCd9, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}
}
