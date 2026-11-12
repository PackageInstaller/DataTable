using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._160;

public class MainSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Skill_1";

	private readonly string eventName_GenerateAreaEffect = "Fire";

	private readonly string areaEffectKey = "AreaEffect_Skill_1";

	private readonly string comboTag1_Potential = "Skill_2_1";

	private readonly string comboTag2_Potential = "Skill_2_2";

	private readonly string comboTag3_Potential = "Skill_2_3";

	private readonly int useTimes_ComboTag2_Potential = 5;

	private readonly string eventName_Teleport_Potential = "Teleport";

	private readonly List<TSVector2> offsetList_Teleport_Potential = new List<TSVector2>
	{
		new TSVector2(3, 3),
		new TSVector2(3, -3),
		new TSVector2(-3, 3),
		new TSVector2(-3, -3)
	};

	private readonly string eventName_RemoveState_Potential = "Clear";

	private int _potentialLv;

	private SoldierActor _lastTarget;

	private List<SoldierActor> _targetList;

	private TSVector2 _targetPosition;

	private int _useTimes_ComboTag2_Potential;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
		_useTimes_ComboTag2_Potential = 0;
	}

	public void OnStart()
	{
		if (_potentialLv >= 3)
		{
			string actionTag = comboTag1_Potential;
			Action<string> onCustomEvent = OnCustomEvent;
			Action onComboFinish = OnFirstStageFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
			_actor.ReplaceAnimationGroup();
		}
		else
		{
			string actionTag2 = comboTag;
			Action<string> onCustomEvent = OnCustomEvent;
			Action onInterrupt = OnFinish;
			Action onComboFinish = OnInterrupt;
			BeginAttack(actionTag2, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onInterrupt, onComboFinish, onCustomEvent);
		}
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, eventName_GenerateAreaEffect))
		{
			TSVector2 position = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : _actor.tsTransform.Position);
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectKey, position);
		}
		else if (string.Equals(eventName, eventName_Teleport_Potential))
		{
			_actor.EnableUnparalleled();
			_actor.EnableSearchedImmunity();
			_actor.Teleport(_targetPosition);
		}
		else if (string.Equals(eventName, eventName_RemoveState_Potential))
		{
			_actor.DisableUnparalleled();
			_actor.DisableSearchedImmunity();
		}
	}

	private void OnFirstStageFinish()
	{
		if (CheckTarget())
		{
			string actionTag = comboTag2_Potential;
			Action<string> onCustomEvent = OnCustomEvent;
			Action onComboFinish = OnSeconStageFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		}
		else
		{
			string actionTag2 = comboTag3_Potential;
			Action<string> onCustomEvent = OnCustomEvent;
			Action onInterrupt = OnFinish;
			Action onComboFinish = OnInterrupt;
			BeginAttack(actionTag2, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onInterrupt, onComboFinish, onCustomEvent);
			_actor.ResumeAnimationGroup();
		}
	}

	private void OnSeconStageFinish()
	{
		_useTimes_ComboTag2_Potential++;
		if (_useTimes_ComboTag2_Potential >= useTimes_ComboTag2_Potential || !CheckTarget())
		{
			string actionTag = comboTag3_Potential;
			Action<string> onCustomEvent = OnCustomEvent;
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
			_actor.ResumeAnimationGroup();
		}
		else
		{
			string actionTag2 = comboTag2_Potential;
			Action<string> onCustomEvent = OnCustomEvent;
			Action onInterrupt = OnSeconStageFinish;
			Action onComboFinish = OnInterrupt;
			BeginAttack(actionTag2, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onInterrupt, onComboFinish, onCustomEvent);
		}
	}

	private bool CheckTarget()
	{
		if (ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController && _actor.attackTarget is SoldierActor self)
		{
			if (_targetList == null)
			{
				_targetList = new List<SoldierActor>();
			}
			soldierLevelController.GetBattleActors(self, _targetList);
			if (_lastTarget != null)
			{
				_targetList.Remove(_lastTarget);
			}
			List<SoldierActor> targetList = _targetList;
			if (targetList != null && targetList.Count > 0)
			{
				TSVector2 tSVector = _targetList.get_Item(TSRandom.Range(0, _targetList.Count)).tsTransform.Position + offsetList_Teleport_Potential.get_Item(TSRandom.Range(0, offsetList_Teleport_Potential.Count));
				if (_actor.QueryPositionWalkable(tSVector))
				{
					_targetPosition = tSVector;
				}
				else
				{
					_actor.QueryClosestPositionWalkable(tSVector, out _targetPosition);
				}
				return true;
			}
		}
		return false;
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.ResumeAnimationGroup();
		_actor.InterruptUnparalleled();
		_actor.InterruptSearchedImmunity();
		_useTimes_ComboTag2_Potential = 0;
		_lastTarget = null;
		_targetList?.Clear();
	}
}
