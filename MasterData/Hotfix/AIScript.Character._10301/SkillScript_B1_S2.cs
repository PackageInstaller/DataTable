using System;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._10301;

public class SkillScript_B1_S2 : SkillAdvancedBase
{
	private string key_Base = "B1_Skill_P03_Base";

	private string key_Strong = "B1_Skill_P03";

	private readonly FP radius = 10;

	private const int perkId_3 = 510303;

	private const int buffId_3 = 10303011;

	private ActorSearchTarget actorSearchInfo;

	private List<LogicEntity> entities = new List<LogicEntity>();

	private List<DeterministicCollider> colliders = new List<DeterministicCollider>();

	private bool isReBind;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		actorSearchInfo = _actor.GetLogicComponent<ActorSearchTarget>();
		isReBind = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.buffComponent.RemoveBuffByBuffId(10303011);
		_actor.CancelAiming();
		entities.Clear();
		colliders.Clear();
		ReBindS1(isInterrupt: true);
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}

	public void OnUpdate()
	{
		actorSearchInfo.GetEnterVisionAlertActors(entities, colliders);
		if (entities.Count == 0)
		{
			LogicEntity logicEntity = SearchTarget();
			if (logicEntity != null)
			{
				_actor.CancelAiming();
				_actor.Aim(logicEntity.tsTransform.Position - _actor.tsTransform.Position);
			}
		}
	}

	private LogicEntity SearchTarget()
	{
		if (!(_actor.attackTarget != null))
		{
			return CommonUtils.SearchNearTargetByCircle(_actor, radius);
		}
		return _actor.attackTarget;
	}

	private void DoMainLogic()
	{
		string actionTag = ((GetPerkLv(510303, out var _) && _actor.buffComponent.CheckBuffByBuffID(10303011)) ? key_Strong : key_Base);
		LogicEntity attackTarget = _actor.attackTarget;
		Action action = onRecoveryBegin;
		Action onComboFinish = SkillFinish;
		Action onInterrupt = SkillInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, attackTarget, null, default, null, action, onComboFinish, onInterrupt);
	}

	private void onRecoveryBegin()
	{
		ReBindS1(isInterrupt: false);
	}

	private void ReBindS1(bool isInterrupt)
	{
		if (!isReBind)
		{
			isReBind = true;
			AdventurRebindSkill adventurRebindSkill = AdventurRebindSkill.Generate();
			adventurRebindSkill.sender = _actor;
			adventurRebindSkill.slotKey = ActionKey.B;
			adventurRebindSkill.skillId = Parallel_B1.skillId_S1;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurRebindSkill);
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
