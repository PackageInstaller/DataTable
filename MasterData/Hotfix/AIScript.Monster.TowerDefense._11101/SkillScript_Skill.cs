using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._11101;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private string key = "Skill_Base";

	private string key_P4 = "Skill_AddStunArea";

	private string evt_area_p4 = "StartAttack";

	private string evt_area = "StartWave";

	private FP aoe_offset = 3;

	private int evt_CastArea = CommonHelper.StringToHash("CastArea");

	private Dictionary<int, string> dicArea = new Dictionary<int, string>
	{
		[0] = "AreaEffect_8011101_Skill_IceWave_Base",
		[2] = "AreaEffect_8011101_Skill_IceWave_Quick",
		[1] = "AreaEffect_8011101_Skill_IceWave_Large",
		[3] = "AreaEffect_8011101_Skill_IceWave_LargeQuick"
	};

	private const int perkId_1 = 1110101;

	private const int perkId_3 = 1110103;

	private const int perkId_4 = 1110104;

	private CoroutineNode corMain;

	private List<LogicEntity> targets = new List<LogicEntity>();

	private TSVector2 targetPos;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		targetPos = TSVector2.zero;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		targets.Clear();
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

	private void DoMainLogic()
	{
		LogicEntity attackTarget = _actor.attackTarget;
		if (GetPerk(1110104))
		{
			key = key_P4;
		}
		string actionTag = key;
		Action<string> action = onCustomEvent;
		Action onComboFinish = SkillFinish;
		Action onInterrupt = SkillInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, attackTarget, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_area_p4))
		{
			LogicEntity attackTarget = _actor.attackTarget;
			if (targetPos == TSVector2.zero)
			{
				targetPos = ((attackTarget != null) ? attackTarget.tsTransform.Position : (_actor.tsTransform.Position + _actor.tsTransform.Forward * aoe_offset));
			}
			if (GetPerk(1110104))
			{
				AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent.eventHashCode = evt_CastArea;
				adventureActorCustomEvent.tsVector2ParamList = new List<TSVector2> { targetPos };
				_actor.DispatchEvent(adventureActorCustomEvent);
			}
		}
		else if (evt.Equals(evt_area))
		{
			LogicEntity attackTarget2 = _actor.attackTarget;
			if (targetPos == TSVector2.zero)
			{
				targetPos = ((attackTarget2 != null) ? attackTarget2.tsTransform.Position : (_actor.tsTransform.Position + _actor.tsTransform.Forward * aoe_offset));
			}
			int num = (GetPerk(1110101) ? 2 : 0);
			int num2 = (GetPerk(1110103) ? 1 : 0);
			int num3 = num | num2;
			ILRuntimeAPI.PlayAreaEffect(_actor, dicArea.get_Item(num3), targetPos, _actor.tsTransform.Rotation);
		}
	}
}
