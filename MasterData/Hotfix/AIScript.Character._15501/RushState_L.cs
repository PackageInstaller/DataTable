using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._15501;

public class RushState_L : IState_UAV
{
	public TSVector2 localPos;

	public LogicEntity target;

	private CoroutineNode corMain;

	private CoroutineNode corExit;

	public override void Enter()
	{
		base.Enter();
		StartCoroutine(ref corMain, DoMainLogic());
	}

	public override void Exit()
	{
		base.Exit();
		StopCoroutine(ref corMain);
		StopCoroutine(ref corExit);
	}

	public override void ForceExit(bool keepAim = false)
	{
		StartCoroutine(ref corExit, DoExitLogic());
	}

	private IEnumerator DoMainLogic()
	{
		if (_actor.dataID == Config_L.uavAtkB_dataId)
		{
			playFx_Idle.Stop();
			if (!playFx_Rush.isPlaying)
			{
				playFx_Rush.Play(_summoner, Config_L.effectRush_B, 1f, _summoner.transform.position, _summoner.transform.rotation);
			}
		}
		else
		{
			playFx_Idle2.Stop();
			if (!playFx_Rush2.isPlaying)
			{
				playFx_Rush2.Play(_summoner, Config_L.effectRush_W, 1f, _summoner.transform.position, _summoner.transform.rotation);
			}
		}
		if (!_actor.isHide)
		{
			bool finish = false;
			bool interrupt = false;
			string actionTag = ((_actor.dataID == Config_L.uavAtkB_dataId) ? Config_L.keyHide_B_Rush : Config_L.keyHide_W_Rush);
			_actor.PlayComboByKey(actionTag, () =>
			{
				finish = true;
			}, () =>
			{
				interrupt = true;
			});
			yield return _actor.WaitTime(Config_L.hideTime);
			if (!interrupt)
			{
				_actor.Hide();
			}
		}
	}

	private IEnumerator DoExitLogic()
	{
		if (_actor.dataID == Config_L.uavAtkB_dataId)
		{
			playFx_Rush.Stop();
		}
		else
		{
			playFx_Rush2.Stop();
		}
		TSVector2 randomPos = GetRandomPos();
		_actor.Teleport(randomPos);
		_actor.LookAtDir(_summoner.tsTransform.Forward, 0);
		_actor.Visible();
		bool finish = false;
		string actionTag = ((_actor.dataID == Config_L.uavAtkB_dataId) ? Config_L.keyShow_B_Rush : Config_L.keyShow_W_Rush);
		_actor.InterruptAttack(force: true);
		_actor.PlayComboByKey(actionTag, () =>
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
		Exit();
	}
}
