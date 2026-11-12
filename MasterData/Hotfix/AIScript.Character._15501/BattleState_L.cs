using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15501;

public class BattleState_L : IState_UAV
{
	public bool CanCast;

	public int skillId;

	private bool forceInterrupt;

	private CoroutineNode corMain;

	private LogicEntity target;

	private bool isBlink;

	private PlayFX playFx_Atk = new PlayFX();

	public override void Enter()
	{
		base.Enter();
		forceInterrupt = false;
		isBlink = false;
		target = _actor.attackTarget;
		StartCoroutine(ref corMain, DoMainLogic());
	}

	public override void ForceExit(bool keepAim = false)
	{
		forceInterrupt = true;
		_actor.InterruptAttack(force: true);
		Exit();
	}

	public override void Exit()
	{
		StopCoroutine(ref corMain);
		base.Exit();
		playFx_Atk.Stop();
	}

	private IEnumerator DoMainLogic()
	{
		playFx_Atk.Play(_actor, Config_L.effectAtk, 1f, _actor.transform.position, _actor.transform.rotation);
		if (TSVector2.Distance(_actor.tsTransform.Position, _summoner.tsTransform.Position) > Config_L.blinkRange)
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
		}
		CanCast = ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
		{
			Exit();
		});
	}
}
