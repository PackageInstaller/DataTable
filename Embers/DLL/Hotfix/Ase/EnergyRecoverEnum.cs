using System.ComponentModel;

namespace Ase;

public enum EnergyRecoverEnum
{
	None,
	[Description("自然回复")]
	Normal,
	[Description("技能")]
	Skill,
	[Description("怪物击倒")]
	MonsterKonckDown,
	[Description("击杀怪物")]
	KillMonster,
	[Description("子弹机制")]
	Bullet
}
