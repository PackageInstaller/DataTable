#define LOG_DEBUG
using System;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._12301;

public class SkillScript_Zhukong_Skill : SkillAdvancedBase
{
	private readonly string SkillTag = "B1_Skill";

	private string evt_summon = "杏子风豚召唤";

	private FP _leftTime = 20;

	private int monsterId = 12301111;

	private Vector2 offsetBorn = new Vector2(0.5f, -0.5f);

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_12301 SkillScript_Zhukong_Skill OnDisable");
		base.OnSkillDisable();
		_actor.CancelAiming();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_12301 SkillScript_Zhukong_Skill OnEnable");
		_actor.logicVariable.SetLogicTagValue("normalCount", 0);
		base.OnSkillEnable();
	}

	public void aimDirec()
	{
		TSVector2 movementInputDirection = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (movementInputDirection != TSVector2.zero)
		{
			_actor.CancelAiming();
			_actor.Aim(movementInputDirection);
		}
	}

	public void OnStart()
	{
		NovaLogger.Debug("===================_12301 SkillScript_Zhukong_Skill OnStart");
		aimDirec();
		string skillTag = SkillTag;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onAnticipationEnd = OnAnticipationEnd;
		System.Action onInterrupt = OnInterrupt;
		System.Action onComboFinish = OnFinish;
		BeginAttack(skillTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnAnticipationEnd()
	{
	}

	protected void OnCustomEvent(string evt)
	{
		NovaLogger.Debug("_12301 SkillScript_Zhukong_Skill OnCustomEvent: " + evt);
		if (!string.Equals(evt, evt_summon))
		{
			return;
		}
		long num = (long)_actor.logicVariable.GetLogicTagValue("summonId");
		if (num != 0L)
		{
			LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(num);
			if (logicEntity != null)
			{
				(logicEntity as AdventureActor).DestroySelf();
			}
		}
		SummonCfg summonCfg = new SummonCfg();
		summonCfg.summonFollowType = SummonFollowType.NotFollow;
		summonCfg.summonAttrType = SummonAttrType.InheritByInitialSnapshot;
		summonCfg.summonRelation = SummonRelation.Coexisted;
		summonCfg.attrPercent = 100;
		summonCfg.leftTime = _leftTime;
		summonCfg.retainWhenCrossLevel = true;
		Vector3 vector = _actor.transform.TransformPoint(new Vector3(offsetBorn.x, 0f, offsetBorn.y));
		ILRuntimeAPI.SummonMonster(_actor, 0, monsterId, new TSVector2(vector.x, vector.z), _actor.tsTransform.Forward, summonCfg, null, (MonsterAdventureActor monster) =>
		{
			_actor.logicVariable.SetLogicTagValue("summonId", monster.Id);
		});
		int currentBindSkillId = (_actor as PlayerAdventureActor).playerSkillCd.GetCurrentBindSkillId(ActionKey.B);
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintStart", currentBindSkillId, _leftTime.AsFloat(), a3: true);
	}

	protected virtual void OnFinish()
	{
		NovaLogger.Debug("===================SkillScript_Zhukong_Skill Skill_1 onFinish");
		_skill.Clear();
	}

	protected virtual void OnInterrupt()
	{
		NovaLogger.Debug("===================_12301 SkillScript_Zhukong_Skill onInterrupt");
		_skill.Clear();
	}
}
