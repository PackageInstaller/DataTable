using ParadoxNotion.Design;

namespace Ase;

public enum WeaponGunBulletOperationType
{
	None,
	[Name("添加子弹", 0)]
	Add,
	[Name("消耗子弹", 0)]
	Sub,
	[Name("清空子弹", 0)]
	Clear,
	[Name("获取子弹", 0)]
	Get,
	[Name("设置子弹", 0)]
	Set,
	[Name("随机子弹", 0)]
	Disrupted,
	[Name("设置灵能最大值", 0)]
	SetHeroHeatMax
}
