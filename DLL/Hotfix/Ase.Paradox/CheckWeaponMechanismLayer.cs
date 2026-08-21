using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检查武器机制层数（英雄）", 0)]
[Category("✫ DragonLost/Movement")]
[Description("检查英雄的武器机制层数是否满足指定条件。")]
public class CheckWeaponMechanismLayer : ConditionTaskBase
{
	[Name("比较方式", 0)]
	[Description("用于比较武器机制层数的方法。")]
	public CompareMethod checkType;

	[Name("目标层数", 0)]
	[Description("要比较的目标武器机制层数值。")]
	public BBParameter<int> valueB;

	protected override string info => "检查武器机制层数" + OperationTools.GetCompareString(checkType) + valueB;

	protected override bool OnCheck()
	{
		base.OnCheck();
		if (ownerEntity is HeroEntity heroEntity)
		{
			return OperationTools.Compare((int)heroEntity.BattleHeroData.GetPropertyData("KeennessLayer").CurValue, valueB.value, checkType);
		}
		return false;
	}
}
