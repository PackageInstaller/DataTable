#define LOG_DEBUG
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._10001TuBoShu;

public class Skill_SimpleAttack : SkillAdvancedBase
{
	protected CoroutineNode _actionCoroutine;

	protected CoroutineNode _dashCoroutine;

	protected CoroutineNode _finishCoroutine;

	protected LookAtTarget _lookAtTarget;

	protected ComboAttack _comboAttack;

	protected Dash _dash;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		NovaLogger.Debug("SimpleAttack OnDisable");
		_comboAttack?.Clear();
		_lookAtTarget?.Clear();
		_dash?.Clear();
		if (_actionCoroutine != null)
		{
			_actor.StopLogicCoroutine(_actionCoroutine);
			_actionCoroutine = null;
		}
		if (_dashCoroutine != null)
		{
			_actor.StopLogicCoroutine(_dashCoroutine);
			_dashCoroutine = null;
		}
		if (_finishCoroutine != null)
		{
			_actor.StopLogicCoroutine(_finishCoroutine);
			_finishCoroutine = null;
		}
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		NovaLogger.Debug("SimpleAttack OnEnable");
	}

	public void OnStart()
	{
		NovaLogger.Debug("SimpleAttack OnStart");
		_skill.SetCountdownForMonster();
		_actionCoroutine = _actor.StartLogicCoroutine(Action());
	}

	private IEnumerator Action()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(0.1));
		string text = _actor.logicVariable?.GetLogicTagStringValue("Target");
		LogicEntity logicEntity = null;
		if (text != "none")
		{
			CommonUtils.TryParseStringParamToInt(text, out var intValue);
			logicEntity = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(intValue);
			if (logicEntity == null)
			{
				logicEntity = ModuleController<AdventureModuleController>.Instance.QueryPlayerEntityByID(intValue);
			}
		}
		if (logicEntity != null)
		{
			if (_lookAtTarget == null)
			{
				_lookAtTarget = new LookAtTarget();
			}
			bool lookAtFinish = false;
			_lookAtTarget.BeginLookAt(_actor, logicEntity, 0, 180, () =>
			{
				lookAtFinish = true;
			});
			while (!lookAtFinish)
			{
				yield return null;
			}
			if (_comboAttack == null)
			{
				_comboAttack = new ComboAttack();
			}
			bool attackFinish = false;
			ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };
			_comboAttack.BeginAttack(_actor, _skill, actionKeys, flushInputedKeys: true, (_skill != null) ? _skill.skillId : 0, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, () =>
			{
				attackFinish = true;
				_finishCoroutine = _actor.StartLogicCoroutine(Finish(0.5));
			});
			_dashCoroutine = _actor.StartLogicCoroutine(Dash());
			while (!attackFinish)
			{
				yield return null;
			}
		}
		else
		{
			_skill.Clear();
		}
	}

	private IEnumerator Dash()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(1));
		if (_dash == null)
		{
			_dash = new Dash();
		}
		_dash.BeginDash(_actor, _actor.tsTransform.Forward, 5, 2, 1, null, null, null, comboWithAttack: true);
	}
}
