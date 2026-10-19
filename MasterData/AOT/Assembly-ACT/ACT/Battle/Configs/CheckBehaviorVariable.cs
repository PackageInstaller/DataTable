using Bamboo.ECS;
using BehaviorDesigner.Runtime;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断行为Variable", "Predicate", new string[] { "check", "behavior", "variable", "predicate", "condition" })]
public class CheckBehaviorVariable : ConfigPredicate
{
	public BTreeValeType valeType;

	public string valueName;

	public ConfigFunction<bool> boolValue;

	public ConfigFunction<float> intValue;

	public ConfigFunction<float> floatValue;

	public string stringValue;

	public override bool Check(ActionMemory memory)
	{
		ActBehaviorTree actBehaviorTree = memory.owner.GetCompAI().ActBehaviorTree;
		if (actBehaviorTree == null)
		{
			return false;
		}
		return valeType switch
		{
			BTreeValeType.vBool => (actBehaviorTree.GetVariable(valueName) as SharedBool)?.Value == boolValue.Return(memory), 
			BTreeValeType.vInt => (float?)(actBehaviorTree.GetVariable(valueName) as SharedInt)?.Value == intValue.Return(memory), 
			BTreeValeType.vFloat => (actBehaviorTree.GetVariable(valueName) as SharedFloat)?.Value == floatValue.Return(memory), 
			BTreeValeType.vString => (actBehaviorTree.GetVariable(valueName) as SharedString)?.Value == stringValue, 
			_ => false, 
		};
	}
}
