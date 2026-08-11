using System.ComponentModel;

namespace Ase;

public enum PropUseTypeEnum
{
	[Description("无")]
	None,
	[Description("烬天使经验")]
	HeroExp,
	[Description("装备升级")]
	ArmourUpgradeExp,
	[Description("武器升级")]
	WeaponUpgradeExp,
	[Description("装备铸造")]
	ArmourCasting,
	[Description("武器铸造")]
	WeaponCasting,
	[Description("烬天使碎片")]
	HeroPiece,
	[Description("烬天使经验返还")]
	HeroExpReturn,
	[Description("装备经验返还")]
	ArmourExpReturn,
	[Description("武器经验返还")]
	WeaponExpReturn,
	[Description("查看任务信息")]
	TaskInfo,
	[Description("体力恢复")]
	Energy,
	[Description("烬天使好感度")]
	HeroTrust,
	[Description("农场加速道具")]
	FarmSpeed,
	[Description("护石打造道具")]
	SuitboxMake,
	[Description("礼包")]
	Packs,
	[Description("头像")]
	HeadIcon,
	[Description("角色框")]
	HeroFrame,
	[Description("聊天气泡")]
	ChatBox,
	[Description("战斗表情")]
	BattleEmoji,
	[Description("聊天表情包")]
	ChatEmoji,
	[Description("自选明饰")]
	ArmourCustom,
	[Description("指示器")]
	Indicator,
	[Description("角色技能皮肤")]
	HeroSkillSkin
}
