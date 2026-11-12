using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._10301;

public class SkillScript_B1_Skill : SkillAdvancedBase
{
	private Dictionary<int, string> dicKey = new Dictionary<int, string>
	{
		[0] = "B1_Skill",
		[1] = "B1_Skill_S2",
		[2] = "B1_Skill_S3"
	};

	private Dictionary<int, string> dicKey_P9 = new Dictionary<int, string>
	{
		[0] = "B1P09_Skill",
		[1] = "B1P09_Skill_S2",
		[2] = "B1P09_Skill_S3"
	};

	private FP rotateSpd = 100;

	private FP rotateAcc = 30;

	private string evt_shoot = "shoot";

	private readonly FP radius = 10;

	private const int perkId_3 = 510303;

	private const int perkId_9 = 510309;

	private CoroutineNode corMain;

	private LookAtTarget lookAtTarget = new LookAtTarget();

	private FP orginRotateSpd;

	private FP orginRotateAcc;

	private ActorSearchTarget actorSearchInfo;

	private List<LogicEntity> entities = new List<LogicEntity>();

	private List<DeterministicCollider> colliders = new List<DeterministicCollider>();

	private bool isReBind;

	private int skillSections;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		actorSearchInfo = _actor.GetLogicComponent<ActorSearchTarget>();
		orginRotateSpd = _actor.actorInfo.moveRotationSpeed;
		orginRotateAcc = _actor.actorInfo.moveAcceleration;
		_actor.actorInfo.moveRotationSpeed = rotateSpd;
		_actor.actorInfo.moveAcceleration = rotateAcc;
		_actor.RefreshMovementRotationSpeed();
		_actor.RefreshMovementAcc();
		isReBind = false;
		skillSections = (GetPerkLv(510309, out var _) ? 3 : 3);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.actorInfo.moveRotationSpeed = orginRotateSpd;
		_actor.actorInfo.moveAcceleration = orginRotateAcc;
		_actor.RefreshMovementRotationSpeed();
		_actor.RefreshMovementAcc();
		StopCoroutine(ref corMain);
		lookAtTarget.Clear();
		_actor.CancelAiming();
		entities.Clear();
		colliders.Clear();
		if (_actor.logicVariable.GetLogicTagValue("lastSkillPhase").AsInt() == 0)
		{
			ReBindS2(isInterrupt: true);
		}
		else
		{
			_actor.GetLogicComponent<PlayerSkillCd>().SetSkillStopResume(Parallel_B1.skillId_S1);
		}
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

	private void DoMainLogic()
	{
		_actor.attackTarget = SearchTarget();
		aimDirec();
		int key = _actor.logicVariable.GetLogicTagValue("lastSkillPhase").AsInt();
		string text = dicKey.get_Item(key);
		if (GetPerkLv(510309, out var _))
		{
			text = dicKey_P9.get_Item(key);
		}
		string actionTag = text;
		Action<string> action = onCustomEvent;
		Action action2 = onRecoveryBegin;
		Action onComboFinish = SkillFinish;
		Action onInterrupt = SkillInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, action2, onComboFinish, onInterrupt, action);
	}

	public void aimDirec()
	{
		if (_actor.attackTarget != null)
		{
			_actor.Aim(_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position);
			return;
		}
		TSVector2 movementInputDirection = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (movementInputDirection != TSVector2.zero)
		{
			_actor.Aim(movementInputDirection);
		}
		else
		{
			_actor.Aim(_actor.tsTransform.Forward);
		}
	}

	public virtual void onCustomEvent(string eventName)
	{
		if (eventName.Equals(evt_shoot))
		{
			int num = _actor.logicVariable.GetLogicTagValue("lastSkillPhase").AsInt();
			num = ++num % skillSections;
			_actor.logicVariable.SetLogicTagValue("lastSkillPhase", num);
		}
	}

	private void onRecoveryBegin()
	{
		if (_actor.attackTarget == null)
		{
			_actor.CancelAiming();
		}
		ReBindS2(isInterrupt: false);
	}

	private LogicEntity SearchTarget()
	{
		if (!(_actor.attackTarget != null))
		{
			return CommonUtils.SearchNearTargetByCircle(_actor, radius);
		}
		return _actor.attackTarget;
	}

	private void ReBindS2(bool isInterrupt)
	{
		if (GetPerkLv(510303, out var _) && !isReBind)
		{
			isReBind = true;
			AdventurRebindSkill adventurRebindSkill = AdventurRebindSkill.Generate();
			adventurRebindSkill.sender = _actor;
			adventurRebindSkill.slotKey = ActionKey.B;
			adventurRebindSkill.skillId = Parallel_B1.skillId_S2;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurRebindSkill);
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
