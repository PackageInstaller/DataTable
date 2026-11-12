using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._15501;

public class RelaxState_L : IState_UAV
{
	private CoroutineNode corMain;

	private CoroutineNode corExit;

	private FP timer;

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
		if (_actor.dataID == Config_L.uavAtkB_dataId)
		{
			playFx_Idle.Stop();
			playFx_Relax.Stop();
		}
		else
		{
			playFx_Idle2.Stop();
			playFx_Relax2.Stop();
		}
	}

	public override void ForceExit(bool keepAim = false)
	{
		Exit();
	}

	public void NormalExit()
	{
		Exit();
	}

	private IEnumerator DoMainLogic()
	{
		timer = 0;
		if (_actor.dataID == Config_L.uavAtkB_dataId)
		{
			if (!playFx_Idle.isPlaying)
			{
				playFx_Idle.Play(_summoner, Config_L.effectIdle_B, 1f, _summoner.transform.position, _summoner.transform.rotation);
			}
		}
		else if (!playFx_Idle2.isPlaying)
		{
			playFx_Idle2.Play(_summoner, Config_L.effectIdle_W, 1f, _summoner.transform.position, _summoner.transform.rotation);
		}
		bool finish = false;
		string actionTag = ((_actor.dataID == Config_L.uavAtkB_dataId) ? Config_L.keyHide_B_Rush : Config_L.keyHide_W_Rush);
		_actor.PlayComboByKey(actionTag, () =>
		{
			finish = true;
		}, () =>
		{
			finish = true;
		});
		yield return _actor.WaitTime(Config_L.hideTime);
		_actor.Hide();
	}

	public override void Update()
	{
		base.Update();
		if (_actor.monsterTarget != null)
		{
			NormalExit();
			return;
		}
		if (SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection() != TSVector2.zero || ModuleController<AdventureModuleController>.Instance.SemiAutoBattle)
		{
			StopRelaxAnimation();
			timer = 0;
		}
		timer += _actor.LogicDeltaTime;
		if (timer > Config_L.Interval_Relax_first)
		{
			timer = 0;
			PlayRelaxAnimation();
		}
	}

	private void PlayRelaxAnimation()
	{
		if (_actor.dataID == Config_L.uavAtkB_dataId)
		{
			playFx_Idle.Stop();
			if (!playFx_Relax.isPlaying)
			{
				playFx_Relax.Play(_summoner, Config_L.effectRelax_B, 1f, _summoner.transform.position, _summoner.transform.rotation);
				return;
			}
			playFx_Relax.Stop();
			playFx_Relax.Play(_summoner, Config_L.effectRelax_B, 1f, _summoner.transform.position, _summoner.transform.rotation);
		}
		else
		{
			playFx_Idle2.Stop();
			if (!playFx_Relax2.isPlaying)
			{
				playFx_Relax2.Play(_summoner, Config_L.effectRelax_W, 1f, _summoner.transform.position, _summoner.transform.rotation);
				return;
			}
			playFx_Relax2.Stop();
			playFx_Relax2.Play(_summoner, Config_L.effectRelax_W, 1f, _summoner.transform.position, _summoner.transform.rotation);
		}
	}

	private void StopRelaxAnimation()
	{
		if (_actor.dataID == Config_L.uavAtkB_dataId)
		{
			if (!playFx_Idle.isPlaying)
			{
				playFx_Idle.Play(_summoner, Config_L.effectIdle_B, 1f, _summoner.transform.position, _summoner.transform.rotation);
			}
			playFx_Relax.Stop();
		}
		else
		{
			if (!playFx_Idle2.isPlaying)
			{
				playFx_Idle2.Play(_summoner, Config_L.effectIdle_W, 1f, _summoner.transform.position, _summoner.transform.rotation);
			}
			playFx_Relax2.Stop();
		}
	}

	public void ForceExitBySkill()
	{
		StartCoroutine(ref corExit, DoExitLogic());
	}

	private IEnumerator DoExitLogic()
	{
		if (_actor.dataID == Config_L.uavAtkB_dataId)
		{
			playFx_Idle.Stop();
			playFx_Relax.Stop();
		}
		else
		{
			playFx_Idle2.Stop();
			playFx_Relax2.Stop();
		}
		TSVector2 randomPos = GetRandomPos();
		_actor.Teleport(randomPos);
		_actor.LookAtDir(_summoner.tsTransform.Forward, 0);
		_actor.Visible();
		bool finish = false;
		string actionTag = ((_actor.dataID == Config_L.uavAtkB_dataId) ? Config_L.keyShow_B_Rush : Config_L.keyShow_W_Rush);
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
