using System;
using System.Collections.Generic;
using AIScript.DynamicLevel;
using AdventureBehaviour;

namespace AIScript.Monster.TowerDefense;

public class TowerCharacterBaseAI : AIBase
{
	private string fxPlace = "fx_td_base_actor_place";

	private IState curState;

	private NormalAttackState normalAttackState = new NormalAttackState();

	private SkillState skillState = new SkillState();

	private List<TowerSkillInfo> tempSkillInfos = new List<TowerSkillInfo>();

	private PlayFX playFX_place = new PlayFX();

	public virtual int Skill_Normal { get; set; }

	public virtual List<TowerSkillInfo> SkillInfos { get; set; }

	public virtual Dictionary<int, Func<bool>> SkillCondition { get; }

	public TowerDefenseCharacterActor actor => _actor as TowerDefenseCharacterActor;

	public virtual void OnEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TOWERDEFENSE_SET_ROLE_ON_STAGE_EVT", OnActorActive);
		normalAttackState.Init(actor);
		skillState.Init(actor);
		Skill_Normal = actor.normalSkillId;
		SkillInfos = new List<TowerSkillInfo>();
		TowerSkillInfo towerSkillInfo = new TowerSkillInfo(actor.mainSkillId, actor.maxEnergy, actor.startEnergy);
		if (SkillCondition != null && SkillCondition.TryGetValue(actor.mainSkillId, out var value))
		{
			towerSkillInfo.CheckCondition = value;
		}
		SkillInfos.Add(towerSkillInfo);
		actor.skillMgr.RegisterAllSkill(SkillInfos);
	}

	public virtual void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TOWERDEFENSE_SET_ROLE_ON_STAGE_EVT", OnActorActive);
		actor.skillMgr.UnRegisterAllSkill();
		playFX_place.Stop();
		SkillInfos?.Clear();
		SkillCondition?.Clear();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	public void OnUpdate()
	{
		MainLoop();
	}

	private void DoMainLogic()
	{
	}

	private void MainLoop()
	{
		_actor.attackTarget = actor.SearchTarget();
		if (curState == null || curState.IsEnd)
		{
			curState = GetNextState();
			curState?.Enter();
		}
		else
		{
			curState.Update();
		}
	}

	private IState GetNextState()
	{
		if (actor.forceControl)
		{
			return null;
		}
		if (actor.skillMgr.GetAllCastSkill(ref tempSkillInfos))
		{
			TowerSkillInfo towerSkillInfo = tempSkillInfos.get_Item(0);
			skillState.skillId = towerSkillInfo.skillId;
			return skillState;
		}
		if (_actor.attackTarget != null)
		{
			normalAttackState.skillId = Skill_Normal;
			return normalAttackState;
		}
		return null;
	}

	private void OnActorActive(IEvent evt)
	{
		if (evt is TowerDefenseSetRoleOnStageEvent towerDefenseSetRoleOnStageEvent && towerDefenseSetRoleOnStageEvent.entityID == _actor.Id)
		{
			playFX_place.Play(_actor, fxPlace, 1f, _actor.transform.position, _actor.transform.rotation);
		}
	}
}
