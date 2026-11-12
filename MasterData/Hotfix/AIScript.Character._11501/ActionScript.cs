using System.Collections;
using TrueSync;

namespace AIScript.Character._11501;

public class ActionScript : ActorActionBase
{
	private CoroutineNode _transformStateCor;

	protected bool InTransformState
	{
		get
		{
			if (((PlayerAdventureActor)_actor).status == ActorStatus.Special)
			{
				return ((PlayerAdventureActor)_actor).specialStatusTime > 0;
			}
			return false;
		}
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
	}

	public override void OnStart()
	{
		base.OnStart();
		_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
	}

	public virtual void OnUpdate()
	{
	}

	protected void EnterTransformState(FP durationTime)
	{
		if (!(durationTime <= 0))
		{
			if (_transformStateCor != null)
			{
				_actor.StopLogicCoroutine(_transformStateCor);
			}
			_transformStateCor = _actor.StartLogicCoroutine(TransformStateLogic(durationTime), runImmediately: true);
		}
	}

	protected void ExitTransformState()
	{
		if (_transformStateCor != null)
		{
			_actor.StopLogicCoroutine(_transformStateCor);
		}
		_transformStateCor = null;
		if (InTransformState)
		{
			((PlayerAdventureActor)_actor).status = ActorStatus.Default;
			((PlayerAdventureActor)_actor).specialStatusTime = 0;
			OnExitTransformState(force: true);
		}
	}

	private IEnumerator TransformStateLogic(FP durationTime)
	{
		((PlayerAdventureActor)_actor).status = ActorStatus.Special;
		((PlayerAdventureActor)_actor).specialStatusTime = durationTime;
		OnEnterTransformState();
		while (((PlayerAdventureActor)_actor).specialStatusTime > 0)
		{
			((PlayerAdventureActor)_actor).specialStatusTime -= _actor.LogicDeltaTime;
			OnTransformLogicUpdate();
			yield return null;
		}
		((PlayerAdventureActor)_actor).status = ActorStatus.Default;
		((PlayerAdventureActor)_actor).specialStatusTime = 0;
		OnExitTransformState();
		while (!CastExitTransformStateSkill())
		{
			yield return null;
		}
		_transformStateCor = null;
	}

	protected virtual bool CastExitTransformStateSkill()
	{
		return true;
	}

	protected virtual void OnEnterTransformState()
	{
	}

	protected virtual void OnTransformLogicUpdate()
	{
	}

	protected virtual void OnExitTransformState(bool force = false)
	{
	}

	public override void OnStop()
	{
		base.OnStop();
		if (_transformStateCor != null)
		{
			_actor.StopLogicCoroutine(_transformStateCor);
		}
		_transformStateCor = null;
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
	}
}
