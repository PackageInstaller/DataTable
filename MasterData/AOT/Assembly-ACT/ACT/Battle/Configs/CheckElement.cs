using ACT.Core;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断元素", "Predicate", new string[] { "check", "element", "predicate", "condition" })]
public class CheckElement : ConfigPredicate
{
	public ElementBitmask element;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is IGetAttackData getAttackData)
		{
			int num = (int)getAttackData.GetAttackData().element;
			int num2 = 1 << num;
			int num3 = (int)element;
			return (num2 & num3) > 0;
		}
		return false;
	}
}
