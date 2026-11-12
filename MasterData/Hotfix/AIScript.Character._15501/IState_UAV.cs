using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15501;

public class IState_UAV
{
	private fsmStatus fsmStatus;

	public AdventureActor _actor;

	public AdventureActor _summoner;

	public AimTarget _aimTarget;

	public PlayFX playFx_Rush = new PlayFX();

	public PlayFX playFx_Rush2 = new PlayFX();

	public PlayFX playFx_Idle = new PlayFX();

	public PlayFX playFx_Idle2 = new PlayFX();

	public PlayFX playFx_Relax = new PlayFX();

	public PlayFX playFx_Relax2 = new PlayFX();

	public bool IsEnd => fsmStatus == fsmStatus.Exit;

	public void Init(AdventureActor actor, AdventureActor summoner, AimTarget aimTarget, PlayFX playRush = null, PlayFX playRush2 = null, PlayFX playIdle = null, PlayFX playIdle2 = null, PlayFX playRelax = null, PlayFX playRelax2 = null)
	{
		_actor = actor;
		_summoner = summoner;
		_aimTarget = aimTarget;
		playFx_Rush = playRush;
		playFx_Rush2 = playRush2;
		playFx_Idle = playIdle;
		playFx_Idle2 = playIdle2;
		playFx_Relax = playRelax;
		playFx_Relax2 = playRelax2;
	}

	public virtual void Enter()
	{
		fsmStatus = fsmStatus.Enter;
	}

	public virtual void Update()
	{
	}

	public virtual void Exit()
	{
		fsmStatus = fsmStatus.Exit;
	}

	public virtual void ForceExit(bool keepAim = false)
	{
	}

	protected void StartCoroutine(ref CoroutineNode coroutineNode, IEnumerator enumerator)
	{
		if (!(_actor == null))
		{
			if (coroutineNode != null)
			{
				_actor.StopLogicCoroutine(coroutineNode);
			}
			coroutineNode = _actor.StartLogicCoroutine(enumerator, runImmediately: true);
		}
	}

	protected void StopCoroutine(ref CoroutineNode coroutineNode)
	{
		if (!(_actor == null))
		{
			if (coroutineNode != null)
			{
				_actor.StopLogicCoroutine(coroutineNode);
			}
			coroutineNode = null;
		}
	}

	protected TSVector2 GetRandomPos()
	{
		bool flag = Config_L.uavAtkB_dataId == _actor.dataID;
		TSVector2 tSVector = _summoner.tsTransform.TransformLocalPointToWorldSpace(flag ? Config_L.leftLocalPos : Config_L.rightLocalPos);
		if (_actor.QueryPositionReachable(tSVector))
		{
			return tSVector;
		}
		if (_actor.LinecastNavmeshGraph(_summoner.tsTransform.Position, tSVector, out var linecastHitPoint))
		{
			return linecastHitPoint;
		}
		return _actor.RandomActorReachablePointInsideLine(_summoner.tsTransform.Position, flag ? _summoner.tsTransform.Left : _summoner.tsTransform.Right, Config_L.leftLocalPos.magnitude);
	}
}
