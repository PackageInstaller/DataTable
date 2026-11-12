using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._10801;

public class ActionScript_MainControl : ActorActionBase
{
	private const int skillId_DefaultNormalAttack = 10810000;

	private const int skillId_SpecialNormalAttack = 10812000;

	private const int ammoCountMax_SpecialAmmo = 10;

	private AimTarget _aimTarget;

	private bool _lockSkill;

	private bool LockSkill
	{
		get
		{
			return _lockSkill;
		}
		set
		{
			if (_lockSkill != value)
			{
				_lockSkill = value;
				MonoSingleton<LuaManager>.Instance.FireEntityEvent("SkillUseableByActionKey", _actor.Id, 2, !_lockSkill);
			}
		}
	}

	protected override void OnActionEnable()
	{
		PlayerAdventureActor playerAdventureActor = _actor as PlayerAdventureActor;
		playerAdventureActor.ammoInfo.SetOriginIntValue(HotfixEnum.AmmoType.Special1, 10, 1);
		if (playerAdventureActor.status == ActorStatus.Default)
		{
			_playerSkillCd.BindSkillIdToButton(ActionKey.Normal, 10810000);
			MonoSingleton<LuaManager>.Instance?.FireEvent("PlayerSwitchGun", 3);
			playerAdventureActor.ammoInfo.ammoType = HotfixEnum.AmmoType.Main;
			_actor.ammoInfo.bulletT = HotfixEnum.bulletType.Shotgun;
			playerAdventureActor.enableReload = true;
		}
		else
		{
			_playerSkillCd.BindSkillIdToButton(ActionKey.Normal, 10812000);
			MonoSingleton<LuaManager>.Instance?.FireEvent("PlayerSwitchGun", 4);
			playerAdventureActor.ammoInfo.ammoType = HotfixEnum.AmmoType.Special1;
			_actor.ammoInfo.bulletT = HotfixEnum.bulletType.FireShotgun;
			playerAdventureActor.enableReload = false;
		}
		if (_aimTarget == null)
		{
			_aimTarget = new AimTarget();
		}
		else
		{
			_aimTarget.Clear();
		}
		LockSkill = false;
	}

	protected override void OnButtonAPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.A), _actor, SkillPhaseFeatureFlag.Dodge, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
	}

	protected override void OnButtonBPress()
	{
		if (!LockSkill)
		{
			ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
		}
	}

	protected override void OnButtonDPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
	}

	public void OnUpdate()
	{
		if (_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal) == 10812000 && _actor.ammoInfo.ammoCount >= _actor.ammoInfo.ammoCountMax)
		{
			LockSkill = true;
		}
		else
		{
			LockSkill = false;
		}
		_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
		if (_actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Ultimate))
		{
			return;
		}
		if (_actor.attackTarget == null || _actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Skill2 | SkillPhaseFeatureFlag.Dodge) || IsObstacleBetweenActorAndTargetAndPreventNormalAttack)
		{
			if (_actor.aimMode != AdventureActor.AimMode.Forward)
			{
				_aimTarget.Cancel();
			}
			return;
		}
		FP fP = _actor.DistanceWithRadius(_actor.attackTarget);
		if (fP < CommonUtils.GetAimRange(_actor))
		{
			if (_actor.aimMode != AdventureActor.AimMode.AimAtAttackTarget)
			{
				_aimTarget.Aim(_actor, (AdventureActor)_actor.attackTarget, default, playStartAnim: true);
			}
			if (fP <= CommonUtils.GetAttackRange(_actor) && _actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget && _actor.ammoInfo.ammoCount > 0)
			{
				ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
			}
		}
		else if (_actor.aimMode != AdventureActor.AimMode.Forward)
		{
			_aimTarget.Cancel();
		}
	}

	protected override void OnActionDisable()
	{
		LockSkill = false;
		_aimTarget?.Cancel();
		_aimTarget?.Clear();
	}
}
