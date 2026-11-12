#define LOG_DEBUG
using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50011XingXing;

public class Skill_3 : SkillAdvancedBase
{
	private readonly FP _waitTime = 1;

	private readonly FP _waitTime_2 = 0.7;

	private readonly int buffID1 = 990013100;

	private readonly int buffID2 = 990021100;

	private readonly FP _radius = 3;

	private readonly FP _innerRadius = 2;

	protected readonly string _eventName = "End01";

	protected readonly string _eventName1 = "DropStart";

	protected readonly string _eventName2 = "DropEnd";

	protected readonly string selfFxPath = "fx_m50011_base_atk_end_warning";

	private DeterministicShape _shape;

	protected ComboAttack _comboAttack;

	private CoroutineNode corMain;

	protected PlayFX _playFXSelf;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_50011XingXing Skill_3 OnDisable");
		base.OnSkillDisable();
		_comboAttack?.Clear();
		_playFXSelf?.Clear();
		StopCoroutine(ref corMain);
		_actor.buffComponent.RemoveBuffByBuffId(buffID1);
		_actor.buffComponent.RemoveBuffByBuffId(buffID2);
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_50011XingXing Skill_3 OnEnable");
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		NovaLogger.Debug("_50011XingXing Skill_3 OnStart");
		if (_skill != null)
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.None, null, SkillPhaseFeatureFlag.None, null);
			_actor.buffComponent.AddBuff(buffID1, _actor);
			_actor.buffComponent.AddBuff(buffID2, _actor);
			if (_comboAttack == null)
			{
				_comboAttack = new ComboAttack();
			}
			ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };
			ComboAttack comboAttack = _comboAttack;
			AdventureActor actor = _actor;
			AdventureSkill skill = _skill;
			int skillId = ((_skill != null) ? _skill.skillId : 0);
			Action onInterrupt = OnInterrupt;
			Action<string> onCustomEvent = OnCustomEvent;
			comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, null, onInterrupt, onCustomEvent);
			StartCoroutine(ref corMain, DoMainLogic());
		}
	}

	private IEnumerator DoMainLogic()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_waitTime));
		if (!CommonUtils.CheckTargetIsValid(_actor.monsterTarget, 0L))
		{
			OnFinish();
			yield break;
		}
		_shape.shapeType = DeterministicShape.ShapeType.Circle;
		_shape.angle = 360;
		_shape.radius = _radius;
		_shape.innerRadius = _innerRadius;
		_shape.position = _actor.monsterTarget.tsTransform.Position;
		TSVector2 targetPosition = _actor.RandomActorReachablePointInsideShape(_shape);
		_actor.Teleport(targetPosition);
		if (_playFXSelf == null)
		{
			_playFXSelf = new PlayFX();
		}
		_playFXSelf.Play(_actor, _skill, selfFxPath, 0, _actor.tsTransform.Position, _actor.tsTransform.Forward);
		_actor.LookAt(_actor.monsterTarget.tsTransform.Position, 0);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_waitTime_2));
		ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[2]
		{
			ComboInputBuffer.ActionKey.B,
			ComboInputBuffer.ActionKey.A
		};
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		Action<string> onCustomEvent = OnCustomEvent;
		comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnCustomEvent(string eventName)
	{
		NovaLogger.Debug("_50011XingXing Skill_3" + eventName);
		if (_eventName.Equals(eventName))
		{
			_actor.buffComponent.RemoveBuffByBuffId(buffID1);
			_actor.buffComponent.RemoveBuffByBuffId(buffID2);
		}
		if (_eventName1.Equals(eventName))
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("MonsterAdvShow", _actor.Id, a2: false);
		}
		if (_eventName2.Equals(eventName))
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("MonsterAdvShow", _actor.Id, a2: true);
		}
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("_50011XingXing Skill_3 onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("_50011XingXing Skill_3 onInterrupt");
		_skill.Clear();
	}
}
