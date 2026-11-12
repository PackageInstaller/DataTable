using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._13051GaoDa;

public class Action_Lv2 : AIBase
{
	private static readonly FP hpPercent_phase_change_1to2 = 75;

	private static readonly FP hpPercent_phase_change_2to3 = 40;

	private static readonly FP skill_castInterval = 0;

	private static readonly int ActWhenHandCastSkillId = 1305197;

	private readonly List<List<string>> skillGroupConfig_phase1 = new List<List<string>>
	{
		new List<string> { "A1", "A3", "A2" }
	};

	private readonly List<List<string>> skillGroupConfig_phase2 = new List<List<string>>
	{
		new List<string> { "C", "C", "C", "C", "C", "C" }
	};

	private readonly List<List<string>> skillGroupConfig_phase3 = new List<List<string>>
	{
		new List<string> { "D1", "C", "C", "D1", "C", "C" },
		new List<string> { "D2", "B1", "B3L", "D2", "B1", "B3R" }
	};

	private readonly List<string> skillGroupConfig_phase3_C = new List<string> { "C11", "C22", "C13", "C21", "C12", "C23" };

	private static readonly int skillId_hand_smashFloor = 1305201;

	private static readonly int skillId_hand_laser = 1305202;

	private static readonly int skillId_hand_rocket = 1305203;

	private static readonly int skillId_hand_rocket_smashFloor = 1305204;

	private static readonly int skillId_transform_1to2 = 1305190;

	private static readonly int skillId_transform_2to3 = 1305192;

	private static readonly int skillId_strafe = 1305102;

	private static readonly int skillId_laser = 1305101;

	private static readonly int skillId_strafe_laser = 1305103;

	private static readonly int skillId_aoe_laser = 1305104;

	private static readonly int skillId_ultimate_laser = 1305105;

	private int actionPhase;

	private int castSkillRC;

	private int skillIndex;

	private List<string> selectedSkillGroup;

	private AdventureMonsterGundamMessage messageEvent;

	private AdventureActor leftHand;

	private AdventureActor rightHand;

	private int handCount;

	private bool waitCastTransformSkill;

	private bool phase3Skill_alone;

	private List<string> phase2_3Skill_group;

	private int skillCIndex;

	private int hasTransformedPhase;

	private bool canCastSkill => castSkillRC == 0;

	public void OnEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_HP_CHANGED", OnHpChanged);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("MONSTER_GAMDAM_MESSAGE", OnReceiveMessage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_BE_CONTROLLED", OnActorBeControlled);
		actionPhase = 1;
		skillIndex = 0;
		castSkillRC = 1;
		handCount = 0;
		waitCastTransformSkill = false;
		hasTransformedPhase = 1;
		_actor.logicVariable.SetLogicTagValue("Difficulty", 2);
		StartCoroutine(WaitForStart());
	}

	private IEnumerator WaitForStart()
	{
		while (handCount < 2)
		{
			if (leftHand == null)
			{
				List<LogicEntity> list = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(CommonUtils_MonsterAPI.GetTeammateIdByIndex(_actor as MonsterAdventureActor, 1));
				leftHand = ((list.Count > 0) ? (list.get_Item(0) as AdventureActor) : null);
				if (leftHand != null)
				{
					_actor.logicVariable.SetLogicTagValue("leftHandId", leftHand.Id);
					SendOperateMessage(leftHand.Id, "masterInAction");
					handCount++;
				}
			}
			if (rightHand == null)
			{
				List<LogicEntity> list2 = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(CommonUtils_MonsterAPI.GetTeammateIdByIndex(_actor as MonsterAdventureActor, 2));
				rightHand = ((list2.Count > 0) ? (list2.get_Item(0) as AdventureActor) : null);
				if (rightHand != null)
				{
					_actor.logicVariable.SetLogicTagValue("rightHandId", rightHand.Id);
					SendOperateMessage(rightHand.Id, "masterInAction");
					handCount++;
				}
			}
			yield return null;
		}
		castSkillRC = 0;
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_HP_CHANGED", OnHpChanged);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_GAMDAM_MESSAGE", OnReceiveMessage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_BE_CONTROLLED", OnActorBeControlled);
	}

	private void OnActorBeControlled(IEvent evt)
	{
		if (_actor != null && evt is AdventureActorBeControlledEvent adventureActorBeControlledEvent && _actor == adventureActorBeControlledEvent.actor)
		{
			if (rightHand != null && rightHand.actorHealthInfo.isAlive)
			{
				SendOperateMessage(rightHand.Id, "masterBeControl");
			}
			if (leftHand != null && leftHand.actorHealthInfo.isAlive)
			{
				SendOperateMessage(leftHand.Id, "masterBeControl");
			}
		}
	}

	private void OnActorDied(IEvent evt)
	{
		if (evt is AdventureActorDiedEvent adventureActorDiedEvent && (!(adventureActorDiedEvent.actor != leftHand) || !(adventureActorDiedEvent.actor != rightHand)))
		{
			handCount--;
		}
	}

	private void OnReceiveMessage(IEvent evt)
	{
		if (!(evt is AdventureMonsterGundamMessage adventureMonsterGundamMessage))
		{
			return;
		}
		if (adventureMonsterGundamMessage.operationType == "skillFinish")
		{
			StartCoroutine(CastSkillCountDown());
		}
		else if (messageEvent.operationType == "handPlayFx")
		{
			if (rightHand != null && rightHand.actorHealthInfo.isAlive)
			{
				SendOperateMessage(rightHand.Id, "playFx");
			}
			if (leftHand != null && leftHand.actorHealthInfo.isAlive)
			{
				SendOperateMessage(leftHand.Id, "playFx");
			}
		}
	}

	private void OnHpChanged(IEvent evt)
	{
		if (actionPhase == 3)
		{
			return;
		}
		AdventureActorHpChangedEvent adventureActorHpChangedEvent = (AdventureActorHpChangedEvent)evt;
		if (!(adventureActorHpChangedEvent.sender as AdventureActor != _actor))
		{
			int num = (int)(long)(adventureActorHpChangedEvent.currentHp / adventureActorHpChangedEvent.maxHp * 100);
			if (num < hpPercent_phase_change_1to2 && actionPhase == 1)
			{
				actionPhase = 2;
				skillIndex = 0;
				waitCastTransformSkill = true;
				phase2_3Skill_group = skillGroupConfig_phase2.get_Item(0);
				skillCIndex = 0;
			}
			else if (num < hpPercent_phase_change_2to3)
			{
				actionPhase = 3;
				skillIndex = 0;
				waitCastTransformSkill = true;
				phase3Skill_alone = false;
				phase2_3Skill_group = skillGroupConfig_phase3.get_Item(0);
				skillCIndex = 0;
			}
		}
	}

	public void OnUpdate()
	{
		if (!canCastSkill)
		{
			return;
		}
		if (waitCastTransformSkill)
		{
			waitCastTransformSkill = false;
			if (hasTransformedPhase == 1)
			{
				hasTransformedPhase = 2;
				CastSkill(skillId_transform_1to2, waitForInterval: false);
				if (actionPhase == 3)
				{
					waitCastTransformSkill = true;
				}
			}
			else if (hasTransformedPhase == 2)
			{
				hasTransformedPhase = 3;
				CastSkill(skillId_transform_2to3, waitForInterval: false);
			}
		}
		else if (actionPhase == 1)
		{
			if (skillIndex == 0)
			{
				int index = TSRandom.Range(0, skillGroupConfig_phase1.Count);
				selectedSkillGroup = skillGroupConfig_phase1.get_Item(index);
			}
			if (skillIndex == 3)
			{
				skillIndex = 0;
			}
			if (handCount != 1 || !(selectedSkillGroup.get_Item(skillIndex) == "A2"))
			{
				int item = GetSkillIdByAlias(selectedSkillGroup.get_Item(skillIndex)).skillId;
				CastHandSkill(item);
				skillIndex++;
			}
		}
		else
		{
			if (actionPhase != 2 && actionPhase != 3)
			{
				return;
			}
			if (!phase3Skill_alone && handCount == 0)
			{
				phase3Skill_alone = true;
				phase2_3Skill_group = skillGroupConfig_phase3.get_Item(1);
			}
			string text = phase2_3Skill_group.get_Item(skillIndex);
			skillIndex++;
			if (skillIndex == 6)
			{
				skillIndex = 0;
			}
			string text2 = "";
			int cooperateType = 0;
			int num = 0;
			if (text.Equals("C"))
			{
				text = skillGroupConfig_phase3_C.get_Item(skillCIndex);
				skillCIndex++;
				if (skillCIndex == 6)
				{
					skillCIndex = 0;
				}
				switch (text)
				{
				case "C11":
					text = "B1";
					text2 = "A1";
					cooperateType = 1;
					num = 1;
					break;
				case "C12":
					text = "B1";
					text2 = "A2";
					cooperateType = 1;
					num = 2;
					break;
				case "C13":
					text = "B1";
					text2 = "A3";
					cooperateType = 1;
					num = 3;
					break;
				case "C21":
					text = "B2";
					text2 = "A1";
					cooperateType = 2;
					num = 1;
					break;
				case "C22":
					text = "B2";
					text2 = "A2";
					cooperateType = 2;
					num = 2;
					break;
				case "C23":
					text = "B2";
					text2 = "A3";
					cooperateType = 2;
					num = 3;
					break;
				}
			}
			else if (text.Equals("D1"))
			{
				text2 = "A4";
			}
			if (handCount < 2 && text2 == "A2")
			{
				text2 = "A1";
			}
			var (flag, skillId, num2) = GetSkillIdByAlias(text);
			if (flag)
			{
				CastHandSkill(skillId, brokenOthers: false, isNextHandSkill: false, cooperateType);
			}
			else
			{
				_actor.logicVariable.SetLogicTagValue("skillType", num2);
				_actor.logicVariable.SetLogicTagValue("cooperateType", num);
				CastSkill(skillId);
			}
			if (string.IsNullOrEmpty(text2) || (handCount == 1 && text2 == "A2"))
			{
				return;
			}
			if (handCount == 0)
			{
				switch (text2)
				{
				case "A2":
					return;
				case "A3":
					return;
				case "A4":
					return;
				}
			}
			var (flag2, skillId2, num3) = GetSkillIdByAlias(text2);
			if (flag2)
			{
				CastHandSkill(skillId2, brokenOthers: false, isNextHandSkill: false, cooperateType);
				return;
			}
			_actor.logicVariable.SetLogicTagValue("skillType", num3);
			_actor.logicVariable.SetLogicTagValue("cooperateType", num);
			CastSkill(skillId2);
		}
	}

	private void CastHandSkill(int skillId, bool brokenOthers = false, bool isNextHandSkill = false, int cooperateType = 0)
	{
		_actor.monsterTarget = _actor.actorSearchTargetInfo.GetMonsterAttackTarget();
		if (handCount > 0)
		{
			ILRuntimeAPI.CreateSkill(ActWhenHandCastSkillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false);
		}
		int num = 1;
		if (rightHand != null && rightHand.actorHealthInfo.isAlive)
		{
			castSkillRC++;
			SendOperateMessage(rightHand.Id, "castSkill", skillId, num, brokenOthers, isNextHandSkill, cooperateType);
			num++;
		}
		if (leftHand != null && leftHand.actorHealthInfo.isAlive)
		{
			castSkillRC++;
			SendOperateMessage(leftHand.Id, "castSkill", skillId, num, brokenOthers, isNextHandSkill, cooperateType);
		}
	}

	private void CastSkill(int skillId, bool waitForInterval = true)
	{
		castSkillRC++;
		_actor.monsterTarget = _actor.actorSearchTargetInfo.GetMonsterAttackTarget();
		ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false, SkillCountdownTiming.Start, (bool result) =>
		{
			if (waitForInterval & result)
			{
				StartCoroutine(CastSkillCountDown());
			}
			else
			{
				castSkillRC--;
			}
		});
	}

	private void SendOperateMessage(long monsterId, string message, int skillId = 0, int skillType = 0, bool brokenOthers = false, bool isNextHandSkill = false, int cooperateType = 0)
	{
		messageEvent = AdventureMonsterGundamMessage.Generate();
		messageEvent.monsterId = monsterId;
		messageEvent.operationType = message;
		messageEvent.skillId = skillId;
		messageEvent.skillType = skillType;
		messageEvent.brokenOthers = brokenOthers;
		messageEvent.isNextHandSkill = isNextHandSkill;
		messageEvent.handCount = handCount;
		messageEvent.bodyId = _actor.Id;
		messageEvent.actionPhase = actionPhase;
		messageEvent.cooperateType = cooperateType;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(messageEvent);
	}

	private IEnumerator CastSkillCountDown()
	{
		FP count = 0;
		while (count < skill_castInterval)
		{
			count += _actor.LogicDeltaTime;
			yield return null;
		}
		castSkillRC--;
	}

	private (bool handSkill, int skillId, int skillType) GetSkillIdByAlias(string alias)
	{
		bool item = false;
		int item2 = 0;
		int item3 = 0;
		switch (alias)
		{
		case "A1":
			item = true;
			item2 = skillId_hand_smashFloor;
			break;
		case "A2":
			item = true;
			item2 = skillId_hand_laser;
			break;
		case "A3":
			item = true;
			item2 = skillId_hand_rocket;
			break;
		case "A4":
			item = true;
			item2 = skillId_hand_rocket_smashFloor;
			break;
		case "B1":
			item2 = skillId_strafe;
			break;
		case "B1L":
			item3 = 1;
			item2 = skillId_strafe;
			break;
		case "B1R":
			item3 = 2;
			item2 = skillId_strafe;
			break;
		case "B2":
			item2 = skillId_laser;
			break;
		case "B3L":
			item3 = 1;
			item2 = skillId_strafe_laser;
			break;
		case "B3R":
			item3 = 2;
			item2 = skillId_strafe_laser;
			break;
		case "D1":
			item2 = skillId_aoe_laser;
			break;
		case "D2":
			item2 = skillId_ultimate_laser;
			break;
		}
		return (handSkill: item, skillId: item2, skillType: item3);
	}
}
