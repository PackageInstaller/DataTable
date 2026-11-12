using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11401;

public class SkillScript_Support : SkillAdvancedBase
{
	private Dictionary<int, string> dicKey_1 = new Dictionary<int, string>
	{
		[0] = "B2_Skill_Forward",
		[1] = "B2_Skill_Back",
		[2] = "B2_Skill_Left",
		[3] = "B2_Skill_Right"
	};

	private Dictionary<int, string> dicKey_P23 = new Dictionary<int, string>
	{
		[0] = "B2_Skill_Forward_P23",
		[1] = "B2_Skill_Back_P23",
		[2] = "B2_Skill_Left_P23",
		[3] = "B2_Skill_Right_P23"
	};

	private int paramId_shootCount = 11432000;

	private FP angleRange = 60;

	private FP radius = 5;

	private FP dis_threashold_1 = 3;

	private FP dis_threashold_2 = 10;

	private const int perkId_23 = 511423;

	private const int perkId_28 = 511428;

	private string evt_Shoot_P28 = "114_Shoot_P28";

	private int shootEvt_P28 = CommonHelper.StringToHash("shootEvt_P28");

	private int evt_Counter = CommonHelper.StringToHash("evt_Counter");

	private LookAtTarget lookAtTarget = new LookAtTarget();

	private CoroutineNode corMain;

	private CoroutineNode corMain_P1;

	private LogicEntity lastTarget;

	private AimTarget aimTarget = new AimTarget();

	private List<CoroutineNode> corList = new List<CoroutineNode>();

	private int lastIndex;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		StopCoroutine(ref corMain_P1);
		lookAtTarget.Clear();
		aimTarget.Clear();
		lastTarget = null;
		for (int i = 0; i < corList.Count; i++)
		{
			StopCoroutine(corList.get_Item(i));
		}
		corList.Clear();
		_actor.movementFSM.DisableRootMotionForceDir();
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	private void SkillFinishOrInterrupt()
	{
		_skill?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		lastIndex = -1;
		int shootCount = CommonUtils.GetScriptValue(_actor, paramId_shootCount).AsInt();
		for (int i = 0; i < shootCount; i++)
		{
			CoroutineNode coroutineNode = StartCoroutine(DOSkillOnce(i + 1));
			corList.Add(coroutineNode);
			yield return coroutineNode;
		}
		int num = (int)(long)_actor.logicVariable.GetLogicTagValue("skillCount");
		for (int i = 0; i < num; i++)
		{
			CoroutineNode coroutineNode2 = StartCoroutine(DOSkillOnce(shootCount + 1 + i));
			corList.Add(coroutineNode2);
			yield return coroutineNode2;
			num = (int)(long)_actor.logicVariable.GetLogicTagValue("skillCount");
		}
		_skill.Clear();
	}

	private IEnumerator DOSkillOnce(int index)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.eventHashCode = evt_Counter;
		adventureActorCustomEvent.intParam = index;
		_actor.DispatchEvent(adventureActorCustomEvent);
		LogicEntity target = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
		bool reset = target == null;
		int num;
		if (lastTarget != target)
		{
			lastIndex = -1;
			reset = true;
			bool disCheck = target != null && TSVector2.Distance(_actor.tsTransform.Position, target.tsTransform.Position) <= dis_threashold_1;
			bool disCheck2 = target != null && TSVector2.Distance(_actor.tsTransform.Position, target.tsTransform.Position) > dis_threashold_2;
			num = RandomIndex(reset, disCheck, disCheck2, lastIndex);
		}
		else
		{
			bool disCheck3 = target != null && TSVector2.Distance(_actor.tsTransform.Position, target.tsTransform.Position) <= dis_threashold_1;
			bool disCheck4 = target != null && TSVector2.Distance(_actor.tsTransform.Position, target.tsTransform.Position) > dis_threashold_2;
			num = RandomIndex(reset, disCheck3, disCheck4, lastIndex);
		}
		lastIndex = num;
		lastTarget = target;
		FP angle = TSVector2.Rotate(TSVector2.Rotate((target == null) ? _actor.tsTransform.Forward : (target.tsTransform.Position - _actor.tsTransform.Position), -45), num * 90).GetAngle();
		TSVector2 tSVector = TrueSyncExtensions.RandomPointInsideFan(_actor.tsTransform.Position, radius, radius, angle, angleRange);
		TSVector2 normalized = (tSVector - _actor.tsTransform.Position).normalized;
		_actor.LookAtDir(normalized, 0);
		TSVector2 lastMonsterPos = target?.tsTransform.Position ?? tSVector;
		_actor.PauseMovementBlock();
		string actionTag = (GetPerk(511423) ? dicKey_P23.get_Item(num) : dicKey_1.get_Item(num));
		SkillScript_Support skillScript_Support = this;
		Action<string> action = onCustomEvent;
		Action onInterrupt = SkillFinishOrInterrupt;
		RequestComboAttack req = skillScript_Support.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, null, onInterrupt, action, null, fadeOutAnim: true);
		while (!req.isRecoveryBegin)
		{
			lookAtTarget.BeginLookAt(_actor, target, 0, 3600, null);
			yield return null;
		}
		normalized = ((target?.tsTransform.Position ?? lastMonsterPos) - _actor.tsTransform.Position).normalized;
		_actor.LookAtDir(normalized, 0);
		_actor.ResumeMovementBlock();
	}

	private int RandomIndex(bool reset, bool disCheck1, bool disCheck2, int lastIndex)
	{
		if (reset || lastIndex == -1)
		{
			if (disCheck1)
			{
				return 2;
			}
			if (disCheck2)
			{
				return 0;
			}
			List<int> list = new List<int> { 0, 1, 2, 3 };
			int index = TSRandom.instance.Next(0, list.Count);
			return list.get_Item(index);
		}
		if (disCheck1)
		{
			return 2;
		}
		if (disCheck2)
		{
			return 0;
		}
		List<int> list2 = new List<int>();
		int item = (lastIndex + 1) % 4;
		list2.Add(item);
		int item2 = (lastIndex - 1 + 4) % 4;
		list2.Add(item2);
		int index2 = TSRandom.instance.Next(0, list2.Count);
		return list2.get_Item(index2);
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_Shoot_P28) && GetPerk(511428))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventHashCode = shootEvt_P28;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}
}
