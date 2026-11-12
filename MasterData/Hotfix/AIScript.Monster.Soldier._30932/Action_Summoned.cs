using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._30932;

public class Action_Summoned : AIBase
{
	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.ShaXieYongBingTuan;

	private const int levelThreshold_Skill2 = 3;

	private const int levelThreshold_BuffTick = 4;

	private readonly int skillId_SummonSkill1 = 103093201;

	private readonly int skillId_SummonSkill2 = 103093202;

	private readonly FP skill2Cooldown = 12;

	public int[] shaxieDataIds = new int[4] { 1551000935, 1851877698, 1766028627, 1866687819 };

	private readonly FP buffTickInterval = 3;

	private const int BUFF_ID_TICK = 260112211;

	private readonly List<LogicEntity> _searchBuffer = new List<LogicEntity>();

	private int _nextSkillIdx;

	private FP _buffTickTimer;

	private FP _skill2CdTimer;

	public void OnStart()
	{
		_nextSkillIdx = 2;
		_buffTickTimer = 0;
		_skill2CdTimer = 0;
	}

	public void OnUpdate()
	{
		if (_skill2CdTimer > 0)
		{
			_skill2CdTimer -= _actor.LogicDeltaTime;
		}
		TryCastNextSkill();
		TryTickBuff();
	}

	public void OnStop()
	{
		_nextSkillIdx = 0;
		_buffTickTimer = 0;
		_skill2CdTimer = 0;
	}

	private void TryCastNextSkill()
	{
		if ((_actor is SoldierActor { spawnSkillSkillId: not 0 } soldierActor && _actor.actorSkillManage.HaveSkill(soldierActor.spawnSkillSkillId)) || (skillId_SummonSkill1 != 0 && _actor.actorSkillManage.HaveSkill(skillId_SummonSkill1)) || (skillId_SummonSkill2 != 0 && _actor.actorSkillManage.HaveSkill(skillId_SummonSkill2)))
		{
			return;
		}
		_actor.attackTarget = FindNearestEnemy();
		if (_actor.attackTarget != null && _actor.attackTarget.tsTransform != null)
		{
			_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
		}
		if (GetPartnerLevel() < 3 || skillId_SummonSkill2 == 0 || !(_skill2CdTimer <= 0))
		{
			CreateSummonSkill(skillId_SummonSkill1);
			return;
		}
		int num = ((_nextSkillIdx == 2) ? skillId_SummonSkill2 : skillId_SummonSkill1);
		int num2 = ((_nextSkillIdx == 2) ? skillId_SummonSkill1 : skillId_SummonSkill2);
		if (CreateSummonSkill(num))
		{
			if (num == skillId_SummonSkill2)
			{
				_skill2CdTimer = skill2Cooldown;
			}
			_nextSkillIdx = ((_nextSkillIdx == 2) ? 1 : 2);
		}
		else if (CreateSummonSkill(num2))
		{
			if (num2 == skillId_SummonSkill2)
			{
				_skill2CdTimer = skill2Cooldown;
			}
			_nextSkillIdx = ((_nextSkillIdx == 2) ? 1 : 2);
		}
	}

	private bool CreateSummonSkill(int skillId)
	{
		if (skillId == 0)
		{
			return false;
		}
		return ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.DynamicActor, isInterruptAttack: true, isBreakable: false);
	}

	private void TryTickBuff()
	{
		if (GetPartnerLevel() >= 4 && shaxieDataIds != null && shaxieDataIds.Length != 0)
		{
			_buffTickTimer -= _actor.LogicDeltaTime;
			if (!(_buffTickTimer > 0))
			{
				ApplyBuffToShaxieUnits();
				_buffTickTimer = buffTickInterval;
			}
		}
	}

	private void ApplyBuffToShaxieUnits()
	{
		SoldierLevelController soldierLevelController = ModuleController<AdventureModuleController>.Instance?.levelInstance as SoldierLevelController;
		if (soldierLevelController == null)
		{
			return;
		}
		List<SoldierActor> allActorsAllCamp = soldierLevelController.GetAllActorsAllCamp();
		if (allActorsAllCamp == null)
		{
			return;
		}
		for (int i = 0; i < allActorsAllCamp.Count; i++)
		{
			SoldierActor soldierActor = allActorsAllCamp.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && IsShaxieDataId(soldierActor.dataID) && !(soldierActor.buffComponent == null))
			{
				soldierActor.buffComponent.AddBuff(260112211, _actor);
			}
		}
	}

	private bool IsShaxieDataId(int dataId)
	{
		for (int i = 0; i < shaxieDataIds.Length; i++)
		{
			if (shaxieDataIds[i] == dataId)
			{
				return true;
			}
		}
		return false;
	}

	private LogicEntity FindNearestEnemy()
	{
		_searchBuffer.Clear();
		CommonUtils.SearchNearTargetsByCircle(_actor, _actor.actorSearchTargetInfo.monsterSearchRange, isConfront: true, includeSelf: false, _searchBuffer);
		for (int i = 0; i < _searchBuffer.Count; i++)
		{
			if (_searchBuffer.get_Item(i) is AdventureActor { actorHealthInfo: { isAlive: not false } } adventureActor && !adventureActor.IsSearchedImmunity() && !(adventureActor is SoldierActor { isSupport: not false }))
			{
				return _searchBuffer.get_Item(i);
			}
		}
		return _actor.attackTarget;
	}

	private int GetPartnerLevel()
	{
		SoldierLevelController soldierLevelController = ModuleController<AdventureModuleController>.Instance?.levelInstance as SoldierLevelController;
		if (soldierLevelController == null)
		{
			return 0;
		}
		return soldierLevelController.GetPartnerLv(partnerTypes);
	}
}
