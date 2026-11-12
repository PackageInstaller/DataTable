using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._10301;

public class SkillScript_B2_Skill : SkillAdvancedBase
{
	private string key_base = "B2_Skill";

	private string key_P1 = "B2P21_Skill_Loop";

	private string key_P2 = "B2P22_Skill_Big";

	private string key_P12 = "B2P21P22_Skill_BigLoop";

	private string key_P24 = "B2P24_EndShoot";

	private readonly FP duration = 1;

	private readonly FP distance = 0.01;

	private FP baseTime = 5;

	private FP traceStopDis = 2;

	private FP shakeOffset = 4;

	private int skillEndHit = CommonHelper.StringToHash("skillEndHit");

	private const int perkId_1 = 510321;

	private const int perkId_2 = 510325;

	private const int perkId_4 = 510324;

	private CoroutineNode corMain;

	private CoroutineNode corDodge;

	private CoroutineNode corDefault;

	private Dodge dodge = new Dodge();

	private string actionKey;

	private FP dTime;

	public PlayerSkillCd skillMgr;

	private CoroutineNode corShake;

	private bool isInShake;

	private LogicEntity lastTarget;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		isInShake = false;
		lastTarget = null;
		_actor.PauseMovementBlock();
		dTime = 0;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		StopCoroutine(ref corDodge);
		StopCoroutine(ref corDefault);
		StopShake();
		_actor.ResumeMovementBlock();
		_actor.CancelAiming();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	private void onFinishOrInterrupt()
	{
		_skill?.Clear();
	}

	private void DoMainLogic()
	{
		actionKey = key_base;
		if (_actor.logicVariable.GetLogicTagToggle("AutoSkill"))
		{
			StartCoroutine(ref corDefault, Skill_Default());
			return;
		}
		bool perkLv = GetPerkLv(510321, out var lv);
		bool perkLv2 = GetPerkLv(510325, out lv);
		if (perkLv & perkLv2)
		{
			actionKey = key_P12;
		}
		else
		{
			if (perkLv)
			{
				actionKey = key_P1;
			}
			if (perkLv2)
			{
				actionKey = key_P2;
			}
		}
		if (!perkLv)
		{
			StartCoroutine(ref corDodge, Skill_Dodge());
		}
		else
		{
			StartCoroutine(ref corMain, Skill_Rotate());
		}
	}

	private IEnumerator Skill_Default()
	{
		if (GetPerkLv(510324, out var _))
		{
			LogicEntity assistantAttackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
			if (assistantAttackTarget != null)
			{
				_actor.LookAt(assistantAttackTarget.tsTransform.Position, 0);
			}
			RequestComboAttack req = BeginAttack(actionKey, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, null, null, null, fadeOutAnim: true);
			while (!req.isRecoveryBegin)
			{
				yield return null;
			}
			PlayAddCombo();
			yield break;
		}
		LogicEntity assistantAttackTarget2 = CommonUtils.GetAssistantAttackTarget(_actor);
		if (assistantAttackTarget2 != null)
		{
			_actor.LookAt(assistantAttackTarget2.tsTransform.Position, 0);
		}
		SkillScript_B2_Skill skillScript_B2_Skill = this;
		string actionTag = actionKey;
		Action onComboFinish = onFinishOrInterrupt;
		Action onInterrupt = onFinishOrInterrupt;
		skillScript_B2_Skill.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private IEnumerator Skill_Dodge()
	{
		_actor.CancelAiming();
		TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		LogicEntity assistantAttackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
		if (assistantAttackTarget != null)
		{
			tSVector = assistantAttackTarget.tsTransform.Position - _actor.tsTransform.Position;
		}
		else if (tSVector == TSVector2.zero)
		{
			tSVector = _actor.tsTransform.Forward;
		}
		dodge.Begin(_actor, tSVector, distance, duration);
		if (GetPerkLv(510324, out var _))
		{
			RequestComboAttack req = BeginAttack(actionKey, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, null, null, null, fadeOutAnim: true);
			while (!req.isRecoveryBegin)
			{
				yield return null;
			}
			PlayAddCombo();
		}
		else
		{
			SkillScript_B2_Skill skillScript_B2_Skill = this;
			string actionTag = actionKey;
			Action onComboFinish = onFinishOrInterrupt;
			Action onInterrupt = onFinishOrInterrupt;
			skillScript_B2_Skill.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		}
	}

	private IEnumerator Skill_Rotate()
	{
		if (GetPerkLv(510324, out var lv))
		{
			RequestComboAttack req = BeginAttack(actionKey, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, null, null, null, fadeOutAnim: true);
			while (!req.isAnticipationEnd)
			{
				yield return null;
			}
		}
		else
		{
			SkillScript_B2_Skill skillScript_B2_Skill = this;
			string actionTag = actionKey;
			Action onInterrupt = onFinishOrInterrupt;
			Action onComboFinish = onFinishOrInterrupt;
			RequestComboAttack req = skillScript_B2_Skill.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
			while (!req.isAnticipationEnd)
			{
				yield return null;
			}
		}
		while (true)
		{
			LogicEntity assistantAttackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
			if (assistantAttackTarget != null && assistantAttackTarget is AdventureActor adventureActor)
			{
				if (lastTarget != null && lastTarget.Id != assistantAttackTarget.Id)
				{
					StopShake();
				}
				lastTarget = assistantAttackTarget;
				if (!isInShake)
				{
					if (adventureActor.movementState == ActorState.StandBy)
					{
						if (TSVector2.Distance(assistantAttackTarget.tsTransform.Position, _actor.tsTransform.Position) <= traceStopDis)
						{
							_actor.StandBy();
							StartCoroutine(ref corShake, ShakeMove(adventureActor));
						}
						else
						{
							_actor.TrackMove(assistantAttackTarget, traceStopDis, enableNavigation: false, NavAgentTypeNames.NavigationUpdateQualityLevel.LowQualityNavigationUpdate, AdventureActor.MovementMode.Walk);
						}
					}
					else
					{
						_actor.TrackMove(assistantAttackTarget, traceStopDis, enableNavigation: false, NavAgentTypeNames.NavigationUpdateQualityLevel.LowQualityNavigationUpdate, AdventureActor.MovementMode.Walk);
					}
				}
			}
			if (dTime > baseTime)
			{
				break;
			}
			dTime += _actor.LogicDeltaTime;
			yield return null;
		}
		StopShake();
		if (GetPerkLv(510324, out lv))
		{
			PlayAddCombo();
		}
		else
		{
			_actor.CancelAttack();
		}
	}

	public bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}

	private IEnumerator ShakeMove(AdventureActor target)
	{
		isInShake = true;
		TSVector2 normalized = (target.tsTransform.Position - _actor.tsTransform.Position).normalized;
		TSVector2 forwradPos = target.tsTransform.Position + normalized * shakeOffset;
		TSVector2 backPos = target.tsTransform.Position - normalized * shakeOffset;
		MoveTo(forward: true, forwradPos, backPos);
		while (!target.IsDead() && target.movementState == ActorState.StandBy)
		{
			yield return null;
		}
		_actor.StandBy();
		isInShake = false;
	}

	private void StopShake()
	{
		StopCoroutine(ref corShake);
		_actor.StandBy();
		isInShake = false;
	}

	private void MoveTo(bool forward, TSVector2 forwradPos, TSVector2 backPos)
	{
		_actor.MoveTo(forward ? forwradPos : backPos, 0.1, enableNavigation: false, AdventureActor.MovementMode.Walk, () =>
		{
			MoveTo(!forward, forwradPos, backPos);
		});
	}

	private void PlayAddCombo()
	{
		LogicEntity assistantAttackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
		if (assistantAttackTarget != null)
		{
			_actor.LookAt(assistantAttackTarget.tsTransform.Position, 0);
		}
		string actionTag = key_P24;
		Action onComboFinish = onFinishOrInterrupt;
		Action onInterrupt = onFinishOrInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, null, fadeOutAnim: true);
	}
}
