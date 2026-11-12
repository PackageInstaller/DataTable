#define LOG_DEBUG
using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12601;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private readonly FP bulletRandomRadius = 2.5;

	private readonly FP bulletOffestPos = 2;

	private readonly string bulletKey = "Bullet_12601_Ultra_Phoenix";

	private string key_1 = "Ultra_TL";

	private string key_2 = "Ultra_NoTL";

	private readonly string eventName_BeginShoot = "12601_ShootStart";

	private readonly int perkId_43 = 512643;

	private readonly string bulletKey_43 = "Bullet_12601_Ultra_Phoenix_Perk43";

	private PlayTimeline _playTimeline = new PlayTimeline();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	private void Clear()
	{
		_actor.DisableInvincible();
	}

	public void OnStart()
	{
		_playTimeline.Play(_actor, () =>
		{
			string actionTag = key_1;
			Action<string> onCustomEvent = OnCustomEvent;
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		}, () =>
		{
			string actionTag = key_2;
			Action<string> onCustomEvent = OnCustomEvent;
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		});
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("12601 Skill_Ultra onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("12601 Skill_Ultra OnInterrupt");
		_skill.Clear();
	}

	protected void OnCustomEvent(string eventName)
	{
		if (eventName == eventName_BeginShoot)
		{
			DoSkill();
		}
	}

	private void DoSkill()
	{
		LogicEntity logicEntity = null;
		logicEntity = ((!(_actor as PlayerAdventureActor).isAssist) ? _actor.attackTarget : CommonUtils.GetAssistantAttackTarget(_actor));
		TSVector2 tSVector = default;
		tSVector = ((!(logicEntity != null)) ? TrueSyncExtensions.RandomPointInsideRing(SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.tsTransform.Position, 2, bulletRandomRadius) : (logicEntity.tsTransform.Position + (_actor.tsTransform.Position - logicEntity.tsTransform.Position).normalized * bulletOffestPos));
		string bulletAlias = bulletKey;
		if (GetPerkLv(perkId_43, out var _))
		{
			bulletAlias = bulletKey_43;
		}
		TSVector2 position = tSVector;
		ILRuntimeAPI.Shoot(bulletAlias, _actor, 0, position, default, default, null, AimType.Default, BulletDirectionType.BulletToTarget);
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
