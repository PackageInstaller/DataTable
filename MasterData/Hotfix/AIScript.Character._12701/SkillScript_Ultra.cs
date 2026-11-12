using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12701;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private string key_1 = "127_Ultra_TL";

	private string key_2 = "127_Ultra_NoTL";

	private string bullut_base = "Bullet_127_Ultra_Branch";

	private string evt_shoot = "127BranchBullet";

	private string evt_area = "127WaterArea";

	private string evt_lookAt = "127_LookAtTarget";

	private FP shootOffset = 7.8;

	private FP visionAttackRng = 18;

	private FP hearAttackRng = 18;

	private const int perkId_41 = 512741;

	private const int buff_41_1 = 12754111;

	private const int buff_41_2 = 12754112;

	private PlayerAdventureActor mainCtrActor;

	private CoroutineNode corMain;

	private CoroutineNode corSupport;

	private string actionKey;

	private PlayTimeline _playTimeline = new PlayTimeline();

	private FP orgVisionAttackRng;

	private FP orgHearAttackRng;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
		mainCtrActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		orgVisionAttackRng = _actor.actorSearchTargetInfo.visionRange;
		orgHearAttackRng = _actor.actorSearchTargetInfo.hearRange;
		_actor.actorSearchTargetInfo.visionRange = visionAttackRng;
		_actor.actorSearchTargetInfo.hearRange = hearAttackRng;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.DisableInvincible();
		_actor.actorSearchTargetInfo.visionRange = orgVisionAttackRng;
		_actor.actorSearchTargetInfo.hearRange = orgHearAttackRng;
		StopCoroutine(ref corMain);
		StopCoroutine(ref corSupport);
	}

	public void OnStart()
	{
		if ((_actor as PlayerAdventureActor).isAssist)
		{
			DoSupportSkill();
		}
		else
		{
			DoMainSkill();
		}
	}

	protected void onFinishOrInterrupt()
	{
		_skill.Clear();
	}

	private void DoMainSkill()
	{
		_playTimeline.Play(_actor, () =>
		{
			ParseKey(timeline: true);
			StartCoroutine(ref corMain, DoMainLogic());
		}, () =>
		{
			ParseKey(timeline: false);
			StartCoroutine(ref corMain, DoMainLogic());
		});
	}

	private void ParseKey(bool timeline)
	{
		actionKey = (timeline ? key_1 : key_2);
	}

	private IEnumerator DoMainLogic()
	{
		SkillScript_Ultra skillScript_Ultra = this;
		string actionTag = actionKey;
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = onFinishOrInterrupt;
		System.Action onInterrupt = onFinishOrInterrupt;
		skillScript_Ultra.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, action);
		yield break;
	}

	private void DoSupportSkill()
	{
		_playTimeline.Play(_actor, () =>
		{
			ParseKey(timeline: true);
			StartCoroutine(ref corSupport, DoSupportLogic());
		}, () =>
		{
			ParseKey(timeline: false);
			StartCoroutine(ref corSupport, DoSupportLogic());
		});
	}

	private IEnumerator DoSupportLogic()
	{
		LogicEntity assistantAttackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
		SkillScript_Ultra skillScript_Ultra = this;
		string actionTag = actionKey;
		Action<string> action = onCustomEvent;
		System.Action onInterrupt = onFinishOrInterrupt;
		System.Action onComboFinish = onFinishOrInterrupt;
		skillScript_Ultra.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, assistantAttackTarget, null, default, null, null, onComboFinish, onInterrupt, action);
		yield break;
	}

	private void onCustomEvent(string eventName)
	{
		if (eventName.Equals(evt_shoot))
		{
			Shoot(_actor.tsTransform.Left);
			Shoot(_actor.tsTransform.Right);
		}
		else if (eventName.Equals(evt_lookAt) && _actor.attackTarget != null)
		{
			_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
		}
	}

	private void Shoot(TSVector2 shootDir)
	{
		WeaponFeatureBuffTrigger weaponFeatureBuffTrigger = ILRuntimeAPI.ShootByDirection(bullut_base, _actor, 0, shootDir, _actor.tsTransform.Position + _actor.tsTransform.Forward * shootOffset)?.GetComponent<WeaponFeatureBuffTrigger>();
		if (weaponFeatureBuffTrigger != null)
		{
			weaponFeatureBuffTrigger.buffConfigs.Clear();
			if (GetPerkLv(512741, out var _))
			{
				BuffConfig buffConfig = new BuffConfig();
				buffConfig.buffList = new List<int> { 12754111 };
				buffConfig.isRemove = false;
				buffConfig.buffTargetType = TargetType.Enemy;
				weaponFeatureBuffTrigger.buffConfigs.Add(buffConfig);
				buffConfig = new BuffConfig();
				buffConfig.buffList = new List<int> { 12754112 };
				buffConfig.isRemove = false;
				buffConfig.buffTargetType = TargetType.Friend;
				weaponFeatureBuffTrigger.buffConfigs.Add(buffConfig);
			}
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
