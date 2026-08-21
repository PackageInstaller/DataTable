using System.ComponentModel;

namespace Ase;

public enum WeaponStatEnum
{
	None,
	[Description("气刃值")]
	SwordLayer,
	[Description("开刃时间")]
	SwordKeennessTime,
	[Description("怒气获取总量")]
	Anger,
	[Description("怒气转化斗志次数")]
	AngerByFight,
	[Description("斗志消耗总量")]
	Fight,
	[Description("子弹消耗数据")]
	Bullet,
	[Description("灵能消耗总量")]
	HeroHeat,
	[Description("觉醒值总量")]
	Awaken,
	[Description("觉醒持续时间")]
	AwakenTime,
	[Description("蓄力值消耗总量")]
	Cast
}
