using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._10801;

public class SkillScript_MainControl_NormalAttack : SkillScript_NormalAttack
{
	private const string actionTag = "Attack_MainControl";

	private const int skillId_DefaultNormalAttack = 10810000;

	private const int perkId_1 = 510801;

	private const string actionTag_1 = "Attack_MainControl_P1_First";

	private const int perkId_2 = 510802;

	private const string actionTag_2 = "Attack_MainControl_P2_Penetrate";

	private const string actionTag_1_2 = "Attack_MainControl_P1P2_FirstPenetrate";

	private const int perkId_4 = 510804;

	private readonly FP triggerPercent_4 = 25;

	private const string triggerFxPath_4 = "";

	private const int perkId_9 = 510809;

	private const int buffId_9 = 10850901;

	private PlayerSkillCd _playerSkillCd;

	private PlayFX _playFX;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_isSpecial = true;
		_playerSkillCd = _actor.GetLogicComponent<PlayerSkillCd>();
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510804, out var perkLevel) && TSRandom.Range(FP.Zero, 100) <= triggerPercent_4)
		{
			_actor.ammoInfo.isNoCostAmmo = true;
			if (!string.IsNullOrEmpty(""))
			{
				if (_playFX == null)
				{
					_playFX = new PlayFX();
				}
				else
				{
					_playFX.Clear();
				}
				_playFX.Play(_actor, null, "", default, _actor.tsTransform.Position, default);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510809, out perkLevel))
		{
			_actor.buffComponent.AddBuff(10850901, _actor);
		}
	}

	protected override string GetActionTag()
	{
		bool flag = ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510801, out var perkLevel) && _actor.logicVariable.GetLogicTagToggle("TriggerPerk_1");
		bool personalPerkLevel = ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510802, out perkLevel);
		if (flag & personalPerkLevel)
		{
			return "Attack_MainControl_P1P2_FirstPenetrate";
		}
		if (flag)
		{
			return "Attack_MainControl_P1_First";
		}
		if (personalPerkLevel)
		{
			return "Attack_MainControl_P2_Penetrate";
		}
		return "Attack_MainControl";
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.ammoInfo.isNoCostAmmo = false;
		if (_actor.ammoInfo.ammoCount <= 0)
		{
			_actor.ammoInfo.ammoType = HotfixEnum.AmmoType.Main;
			_actor.ammoInfo.bulletT = HotfixEnum.bulletType.Shotgun;
			_actor.ammoInfo.ammoCount = 0;
			(_actor as PlayerAdventureActor).enableReload = true;
			(_actor as PlayerAdventureActor).status = ActorStatus.Default;
			_playerSkillCd.BindSkillIdToButton(ActionKey.Normal, 10810000);
			MonoSingleton<LuaManager>.Instance?.FireEvent("PlayerSwitchGun", 3);
		}
	}
}
