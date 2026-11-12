#define LOG_DEBUG
using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11801.Old;

public class Skill : SkillAdvancedBase
{
	protected ComboAttack _comboAttack;

	protected Dodge _dodge;

	protected AimTarget _aimTarget;

	protected FP _moveSpeed = 20;

	protected readonly int _moveLevel = 99;

	protected FP _strength = 4;

	protected readonly int _certainBuffId = 11801;

	protected FP _switchComboDistance = 6.5;

	protected CoroutineNode _waitForPullEndCoroutine;

	protected readonly List<AdventureActor> _targets = new List<AdventureActor>();

	protected bool _beginPull;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("11801 Skill OnDisable");
		base.OnSkillDisable();
		Clear();
		_comboAttack?.Clear();
		_aimTarget?.Clear();
		_targets.Clear();
		_beginPull = false;
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("11801 Skill OnEnable");
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		NovaLogger.Debug("11801 Skill OnStart");
		if (_skill != null)
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.None, null, SkillPhaseFeatureFlag.None, null);
			ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[2]
			{
				ComboInputBuffer.ActionKey.B,
				ComboInputBuffer.ActionKey.A
			};
			if ((bool)_actor.attackTarget && _actor.DistanceWithRadius(_actor.attackTarget) < _switchComboDistance)
			{
				array = new ComboInputBuffer.ActionKey[2]
				{
					ComboInputBuffer.ActionKey.B,
					ComboInputBuffer.ActionKey.I
				};
			}
			if (_comboAttack == null)
			{
				_comboAttack = new ComboAttack();
			}
			ComboAttack comboAttack = _comboAttack;
			AdventureActor actor = _actor;
			AdventureSkill skill = _skill;
			ComboInputBuffer.ActionKey[] actionKeys = array;
			int skillId = ((_skill != null) ? _skill.skillId : 0);
			Action<string> onCustomEvent = OnCustomEvent;
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: false, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent);
			if (_actor.attackTarget != null)
			{
				_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0f);
			}
			_actor.EnableImmuneControl();
			if (_aimTarget == null)
			{
				_aimTarget = new AimTarget();
			}
			_aimTarget.Aim(_actor, null, _actor.tsTransform.Forward);
		}
	}

	protected void OnCustomEvent(string eventName)
	{
		NovaLogger.Debug("11801 Skill OnCustomEvent:" + eventName);
		if (!(eventName == "addEffect"))
		{
			if (!(eventName == "checkForceMoveTarget"))
			{
				return;
			}
			List<FP> list = new List<FP>();
			FP fP = 0;
			_targets.Clear();
			for (int i = 0; i < ModuleController<AdventureModuleController>.Instance.monsterActors.Count; i++)
			{
				MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.monsterActors.get_Item(i) as MonsterAdventureActor;
				if (monsterAdventureActor.buffComponent.CheckBuffByBuffID(_certainBuffId))
				{
					_targets.Add(monsterAdventureActor);
					FP fP2 = ILRuntimeAPI.CalcDistanceBetweenMonsterAndPlayer(monsterAdventureActor);
					list.Add(fP2);
					FP fP3 = fP2 / _moveSpeed;
					if (fP3 > fP)
					{
						fP = fP3;
					}
				}
			}
			if (_targets.Count > 0)
			{
				ILRuntimeAPI.ForceMove(_actor, _targets, _moveSpeed, list, isCoExist: true, isChangeForward: true, _moveLevel, _strength);
				_actor.logicVariable.ToggleLogicTag("WaitForPullEnd", value: true);
				_actor.logicVariable.SetLogicTagValue("PullDuration", fP);
				_beginPull = true;
			}
		}
		else
		{
			_actor.logicVariable.ToggleLogicTag("playEffect", value: true);
		}
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("11801 Skill onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("11801 Skill onInterrupt");
		OnFinish();
	}

	protected void Clear()
	{
		_actor.DisableImmuneControl();
		_aimTarget?.Cancel();
		if (!_beginPull)
		{
			_actor.logicVariable.ToggleLogicTag("removeBuffAndEffect", value: true);
		}
	}
}
