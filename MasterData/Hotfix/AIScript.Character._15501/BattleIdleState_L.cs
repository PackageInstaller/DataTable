using System.Collections;
using TrueSync;

namespace AIScript.Character._15501;

public class BattleIdleState_L : IState_UAV
{
	private CoroutineNode corMain;

	public override void Enter()
	{
		base.Enter();
		StartCoroutine(ref corMain, DoMainLogic());
	}

	public override void Exit()
	{
		base.Exit();
		StopCoroutine(ref corMain);
	}

	public override void ForceExit(bool keepAim = false)
	{
		if (!keepAim)
		{
			_aimTarget.Cancel();
		}
		Exit();
	}

	private IEnumerator DoMainLogic()
	{
		if (_actor.isHide)
		{
			TSVector2 randomPos = GetRandomPos();
			_actor.Teleport(randomPos);
			_actor.Visible();
			bool finish = false;
			string actionTag = ((_actor.dataID == Config_L.uavAtkB_dataId) ? Config_L.keyShow_B : Config_L.keyShow_W);
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
		}
		_aimTarget.Aim(_actor, _actor.monsterTarget as AdventureActor);
	}

	public override void Update()
	{
		if (_actor.monsterTarget == null)
		{
			_aimTarget.Cancel();
			Exit();
		}
		else if (_summoner != null && TSVector2.Distance(_actor.tsTransform.Position, _summoner.tsTransform.Position) > Config_L.trace_first)
		{
			_aimTarget.Cancel();
			Exit();
		}
	}
}
