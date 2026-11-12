using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11301;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private string key_1 = "UltraTimelineOn";

	private string key_2 = "UltraTimelineOff";

	private string key_S1 = "Ultra_S1";

	private string key_S1_1 = "Ultra_S1_1";

	private string key_S1_P41 = "Ultra_S1_P41";

	private string key_S1_P41_1 = "Ultra_S1_1_P41";

	private string key_S2 = "Ultra_S2";

	private string key_End = "UltraEndLanding";

	private FP circle = 10;

	private int minCount = 15;

	private string evt_finger_up = "evt_finger_up";

	private string evt_finger_down = "evt_finger_down";

	private string upEffect = "fx_11301_loop_Ultra_Skill_3";

	private FP upEffect_DelayTime = 0.03f;

	private FP upEffect_LoopTime = 1f;

	private string upAreaEffect = "AreaEffect_11301_Ultra_FingerDown";

	private int evt_EnterUltra = CommonHelper.StringToHash("EnterUltra");

	private int evt_ExitUltra = CommonHelper.StringToHash("ExitUltra");

	private int evt_TriggerP43 = CommonHelper.StringToHash("TriggerP43");

	private const int perkId_41 = 511341;

	private CoroutineNode corMain;

	private PlayTimeline _playTimeline = new PlayTimeline();

	private List<PlayFX> playFxes = new List<PlayFX>();

	private readonly List<CoroutineNode> corList = new List<CoroutineNode>();

	private List<TSVector2> posList = new List<TSVector2>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		_actor.CancelAiming();
		_actor.DisableInvincible();
		foreach (CoroutineNode cor in corList)
		{
			_actor.StopLogicCoroutine(cor);
		}
		corList.Clear();
		foreach (PlayFX playFx in playFxes)
		{
			playFx.Stop();
		}
		playFxes.Clear();
	}

	public void OnStart()
	{
		_playTimeline.Play(_actor, () =>
		{
			StartCoroutine(ref corMain, DoMainLogic(timeline: true));
		}, () =>
		{
			StartCoroutine(ref corMain, DoMainLogic(timeline: false));
		});
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	private IEnumerator DoMainLogic(bool timeline)
	{
		bool perk_41 = GetPerkLv(511341, out var _);
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		PlayerAdventureActor player = _actor as PlayerAdventureActor;
		if (!player.isAssist)
		{
			adventureActorCustomEvent.eventHashCode = evt_EnterUltra;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
		string actionTag = (timeline ? key_1 : key_2);
		RequestComboAttack req = BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, null, null, null, fadeOutAnim: true);
		while (!req.isRecoveryBegin)
		{
			yield return null;
		}
		actionTag = (perk_41 ? key_S1_P41 : key_S1);
		req = BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, null, null, null, null, fadeOutAnim: true);
		while (!req.isRecoveryBegin)
		{
			yield return null;
		}
		actionTag = (perk_41 ? key_S1_P41_1 : key_S1_1);
		req = BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, null, null, null, null, fadeOutAnim: true);
		if (!player.isAssist)
		{
			while (!req.isRecoveryBegin)
			{
				yield return null;
			}
		}
		else
		{
			while (!req.isComboFinish)
			{
				yield return null;
			}
		}
		adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.eventHashCode = evt_TriggerP43;
		_actor.DispatchEvent(adventureActorCustomEvent);
		if (!player.isAssist)
		{
			adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventHashCode = evt_ExitUltra;
			_actor.DispatchEvent(adventureActorCustomEvent);
			req = BeginAttack(key_End, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, null, null, null, null, fadeOutAnim: true);
			while (!req.isComboFinish)
			{
				yield return null;
			}
		}
		else if (_actor.logicVariable.GetLogicTagToggle("AIEnd"))
		{
			adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventHashCode = evt_ExitUltra;
			_actor.DispatchEvent(adventureActorCustomEvent);
			req = BeginAttack(key_End, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, null, null, null, null, fadeOutAnim: true);
			while (!req.isComboFinish)
			{
				yield return null;
			}
		}
		OnFinish();
	}

	private void onCustomEvent(string evtName)
	{
	}

	private void UpHit()
	{
		posList.Clear();
		List<LogicEntity> list = new List<LogicEntity>();
		TSVector2 center;
		if (_actor.attackTarget != null)
		{
			center = _actor.attackTarget.tsTransform.Position;
			CommonUtils.SearchNearTargetsByCircle(_actor, center, circle, isConfront: true, includeSelf: false, list);
		}
		else
		{
			center = _actor.tsTransform.Position + circle * _actor.tsTransform.Forward;
			CommonUtils.SearchNearTargetsByCircle(_actor, center, circle, isConfront: true, includeSelf: false, list);
		}
		int num = ((list.Count > minCount) ? list.Count : minCount);
		for (int i = 0; i < num; i++)
		{
			TSVector2 tSVector = ((i >= list.Count) ? TrueSyncExtensions.RandomPointInsideRing(center, 0, circle) : list.get_Item(i).tsTransform.Position);
			posList.Add(tSVector);
			CoroutineNode item = _actor.StartLogicCoroutine(PlayPreEffect(tSVector, i));
			corList.Add(item);
		}
	}

	private void DownHit()
	{
		foreach (TSVector2 pos in posList)
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, upAreaEffect, pos);
		}
	}

	private IEnumerator PlayPreEffect(TSVector2 pos, int index)
	{
		PlayFX playFX = new PlayFX();
		playFxes.Add(playFX);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(upEffect_DelayTime * index));
		playFX.Play(_actor, _skill, upEffect, 0, pos, default);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(upEffect_LoopTime - upEffect_DelayTime * index));
		playFX.Stop();
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
