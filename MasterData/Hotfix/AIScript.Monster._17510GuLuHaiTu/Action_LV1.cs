using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._17510GuLuHaiTu;

public class Action_LV1 : ActionBaseGuLuHaiTu
{
	private Dictionary<int, bool> _dicSkill = new Dictionary<int, bool>();

	protected override Dictionary<int, bool> dicSkill => _dicSkill;

	protected override void OnActionEnable()
	{
		InitActionState();
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
		int id = idWanderAction;
		FP cd = 8;
		FP initCd = 0;
		OperateDelegate operateIEnumerator = WanderActionCondition;
		list2.Add(new PoolBranchInfo(actor, id, 0, cd, initCd, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		int id2 = idExhale;
		FP cd2 = 15;
		FP initCd2 = 2;
		operateIEnumerator = ExhaleCondition;
		list2.Add(new PoolBranchInfo(actor2, id2, 0, cd2, initCd2, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		int id3 = idWave;
		FP cd3 = 20;
		FP initCd3 = 10;
		operateIEnumerator = WaveAcrossCondition;
		list2.Add(new PoolBranchInfo(actor3, id3, 1, cd3, initCd3, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		int id4 = idEWCombo;
		FP cd4 = 35;
		FP initCd4 = 15;
		operateIEnumerator = EWComboCondition;
		list2.Add(new PoolBranchInfo(actor4, id4, 2, cd4, initCd4, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		int id5 = idFishShoot;
		FP cd5 = 45;
		FP initCd5 = 35;
		operateIEnumerator = fishShootCondition;
		list2.Add(new PoolBranchInfo(actor5, id5, 3, cd5, initCd5, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor6 = _actor;
		int id6 = idFrontalRepulse;
		FP cd6 = 50;
		FP initCd6 = 60;
		operateIEnumerator = FrontalRepulseCondition;
		list2.Add(new PoolBranchInfo(actor6, id6, 4, cd6, initCd6, active: false, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor7 = _actor;
		int id7 = idPointRepulse;
		FP cd7 = 60;
		FP initCd7 = 55;
		operateIEnumerator = POSRepulseCondition;
		list2.Add(new PoolBranchInfo(actor7, id7, 5, cd7, initCd7, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor8 = _actor;
		int id8 = idFloorBreakStrong;
		FP cd8 = 40;
		FP initCd8 = 25;
		operateIEnumerator = FloorBreakStrongCondition;
		list2.Add(new PoolBranchInfo(actor8, id8, 98, cd8, initCd8, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor9 = _actor;
		int id9 = idRepulse;
		FP cd9 = 70;
		FP initCd9 = 80;
		operateIEnumerator = RepulseCondition;
		list2.Add(new PoolBranchInfo(actor9, id9, 7, cd9, initCd9, active: false, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor10 = _actor;
		int id10 = idInitialization;
		FP cd10 = 10;
		FP initCd10 = 0;
		operateIEnumerator = InitializationCondition;
		list2.Add(new PoolBranchInfo(actor10, id10, 99, cd10, initCd10, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}
}
