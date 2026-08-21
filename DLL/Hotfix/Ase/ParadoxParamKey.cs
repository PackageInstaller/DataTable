using System.Runtime.InteropServices;

namespace Ase;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public struct ParadoxParamKey
{
	public const string ParadoxOwnerId = "entity";

	public const string ParadoxOwner = "BaseEntity";

	public const string EnableTree = "s_EnableTree";

	public const string IsRescued = "IsRescued";

	public const string HitTrigger = "s_hit";

	public const string AlertHitTrigger = "s_alertHit";

	public const string SafeDirectAfterAlert = "s_safeDirect";

	public const string BornPos = "s_bornPos";

	public const string HitDirect = "s_bulletDirection";

	public const string EntityState = "s_entityState";

	public const string EntityCtrlAbnormalState = "s_EntityCtrlAbnormalState";

	public const string EntityAbnormalState = "s_EntityAbnormalState";

	public const string IsAi = "IsAi";

	public const string HeroFreedomBattleMode = "HeroFreedomBattleMode";

	public const string ClientCommand = "s_inputCommand";

	public const string ClientCommandState = "s_inputCommandState";

	public const string MoveInputJoystick = "UnSync_moveJoystickInput";

	public const string SkillInputJoystick = "SkillInputJoystick";

	public const string AiButtonReleaseSkill = "AiButtonReleaseSkill";

	public const string BattlePropId = "BattlePropId";

	public const string BattlePropLevel = "BattlePropLevel";

	public const string PropSkillPosition = "PropSkillPosition";

	public const string PropSkillStartPlay = "PropSkillStartPlay";

	public const string OpenWeakness = "s_OpenWeakness";

	public const string WeaknessAttackPower = "s_WeaknessAttackPower";
}
