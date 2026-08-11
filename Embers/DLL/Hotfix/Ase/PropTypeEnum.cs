using System.ComponentModel;

namespace Ase;

public enum PropTypeEnum
{
	[Description("道具")]
	Prop = 1,
	[Description("明饰")]
	Equipment,
	[Description("货币")]
	Coin,
	[Description("角色")]
	Hero,
	[Description("武器")]
	Weapon,
	[Description("体力")]
	Energy,
	[Description("账户经验")]
	AccountExp,
	[Description("角色经验")]
	HeroExp,
	[Description("活跃度")]
	ActivePoint,
	[Description("任务道具")]
	PropTask,
	[Description("称号")]
	Title,
	[Description("头像框")]
	HeadDecorate,
	[Description("背景")]
	Background,
	[Description("战斗道具图纸")]
	BattlePropDrawing,
	[Description("家园余温熔炉种子")]
	FarmSeed,
	[Description("护石")]
	SuitBox,
	[Description("公会个人资金")]
	UnionMoney,
	[Description("礼包")]
	GiftPack,
	[Description("战斗道具")]
	BattleProp,
	[Description("烬天使皮肤")]
	HeroSkin,
	[Description("月卡执照")]
	Passport,
	[Description("聊天表情包")]
	ChatEmoji,
	[Description("头像")]
	Avatar,
	[Description("聊天气泡")]
	ChatBubble,
	[Description("名片框")]
	CardFrame,
	[Description("战斗表情")]
	BattleEmoji,
	[Description("自选明饰")]
	ArmourCustom,
	[Description("指示器")]
	Indicator,
	[Description("角色技能皮肤")]
	HeroSkillSkinProp,
	None
}
