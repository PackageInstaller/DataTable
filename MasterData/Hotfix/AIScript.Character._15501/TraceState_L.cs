using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15501;

public class TraceState_L : IState_UAV
{
	private FP moveStop = 0.1;

	public TSVector2 randomPos;

	public LogicEntity target;

	private TSVector2 lastTargetPos;

	private TSVector2 targetPos;

	public bool isTeleport;

	private CoroutineNode corMain;

	private PlayFX playFx_Move = new PlayFX();

	public override void Enter()
	{
		base.Enter();
		if (_actor.dataID == Config_L.uavAtkB_dataId)
		{
			_summoner.logicVariable.ToggleLogicTag("trace_b", value: true);
		}
		else
		{
			_summoner.logicVariable.ToggleLogicTag("trace_w", value: true);
		}
		StartCoroutine(ref corMain, DoMainLogic());
	}

	public override void Exit()
	{
		base.Exit();
		if (_actor.dataID == Config_L.uavAtkB_dataId)
		{
			_summoner.logicVariable.ToggleLogicTag("trace_b", value: false);
		}
		else
		{
			_summoner.logicVariable.ToggleLogicTag("trace_w", value: false);
		}
		StopCoroutine(ref corMain);
		playFx_Move.Stop();
	}

	private IEnumerator DoMainLogic()
	{
		if (isTeleport)
		{
			TSVector2 targetPos = GetRandomPos();
			bool finish = false;
			string actionTag = ((_actor.dataID == Config_L.uavAtkB_dataId) ? Config_L.keyHide_B : Config_L.keyHide_W);
			_actor.PlayComboByKey(actionTag, () =>
			{
				finish = true;
			}, () =>
			{
				finish = true;
			});
			yield return _actor.WaitTime(Config_L.hideTime);
			_actor.Hide();
			_actor.Teleport(targetPos);
			_actor.Visible();
			finish = false;
			string actionTag2 = ((_actor.dataID == Config_L.uavAtkB_dataId) ? Config_L.keyShow_B : Config_L.keyShow_W);
			_actor.PlayComboByKey(actionTag2, () =>
			{
				finish = true;
			}, () =>
			{
				finish = true;
			});
			while (!finish)
			{
				yield return null;
			}
			isTeleport = false;
		}
		else
		{
			isTeleport = false;
		}
	}

	public override void Update()
	{
		base.Update();
		if (!isTeleport)
		{
			if (target != null)
			{
				targetPos = GetRandomPos();
				lastTargetPos = targetPos;
			}
			else
			{
				targetPos = lastTargetPos;
			}
			_actor.MoveTo(targetPos, moveStop, enableNavigation: true, AdventureActor.MovementMode.Run, () =>
			{
				Exit();
			});
			if (!playFx_Move.isPlaying)
			{
				playFx_Move.Play(_actor, Config_L.effectMove, 1f, _actor.transform.position, _actor.transform.rotation);
			}
		}
	}

	public override void ForceExit(bool keepAim = false)
	{
		_actor.InterruptAttack(force: true);
		_actor.StandBy();
		Exit();
	}
}
