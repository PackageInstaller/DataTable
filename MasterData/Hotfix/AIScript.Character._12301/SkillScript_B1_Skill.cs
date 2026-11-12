using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12301;

public class SkillScript_B1_Skill : SkillAdvancedBase
{
	private string _actionKey = "B1_Skill";

	private string evt_summon = "summon";

	private FP _leftTime = 60;

	private FP _leftTime_B1T1 = 60;

	private int monsterId = 20012301;

	private FP summonInnerRadius = 1.5;

	private FP summonOuterRadius = 3;

	private Dictionary<int, int> summonInheritPercentDic = new Dictionary<int, int>
	{
		[0] = 80,
		[1] = 90,
		[2] = 100,
		[3] = 110,
		[4] = 120,
		[5] = 130,
		[6] = 140,
		[7] = 150,
		[8] = 160,
		[9] = 170
	};

	private CoroutineNode corMain;

	private PlayerSkillCd skillMgr;

	private PlayerTalentGroupType talentGroupType;

	private string actionKey;

	private FP leftTime;

	private int talentLv;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		talentGroupType = (_actor as PlayerAdventureActor).GetTalentGroupType();
		talentLv = (_actor as PlayerAdventureActor).GetTalentGroupLevel();
		leftTime = 0;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	private void Clear()
	{
		StopCoroutine(ref corMain);
	}

	public void SkillFinish()
	{
		_skill?.Clear();
	}

	public void SkillInterrupt()
	{
		_skill?.Clear();
	}

	public void ParseKey()
	{
		actionKey = _actionKey;
		leftTime = _leftTime;
		if (talentGroupType == PlayerTalentGroupType.Group1)
		{
			leftTime = _leftTime_B1T1;
		}
	}

	public void DoMainLogic()
	{
		ParseKey();
		string actionTag = actionKey;
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = SkillFinish;
		System.Action onInterrupt = SkillInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
		onCustomEvent(evt_summon);
		_skill.Clear();
	}

	private void onCustomEvent(string evt)
	{
		if (string.Equals(evt, evt_summon))
		{
			long num = (long)_actor.logicVariable.GetLogicTagValue("summonId");
			if (num != 0L)
			{
				(ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(num) as AdventureActor).DestroySelf();
			}
			SummonCfg summonCfg = new SummonCfg();
			summonCfg.summonAttrType = SummonAttrType.Inherit;
			summonCfg.summonRelation = SummonRelation.Independent;
			summonCfg.attrPercent = summonInheritPercentDic.get_Item(0);
			summonCfg.leftTime = leftTime;
			summonCfg.summonType = SummonType.None;
			TSVector2 pos = _actor.RandomActorReachablePointInsideRing(_actor.tsTransform.Position, summonInnerRadius, summonOuterRadius);
			ILRuntimeAPI.SummonMonster(_actor, 0, monsterId, pos, _actor.tsTransform.Forward, summonCfg, null, (MonsterAdventureActor monster) =>
			{
				_actor.logicVariable.SetLogicTagValue("summonId", monster.Id);
			});
		}
	}
}
