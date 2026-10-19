using System;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改行为Tree值", "Action", new string[] { "change", "behavior", "tree", "value", "ai", "bt", "behaviour" })]
public class ActionChangeBehaviorTreeValue : ConfigAction
{
	public string valueName;

	public bool isOwner;

	public ConfigFunction<EntityReference> targetEntity;

	public BTreeValeType valeType;

	public bool boolValue;

	public int intValue;

	public float floatValue;

	public string strValue;

	public ConfigFunction<float> floatFunction;

	public ModifyType modifyType;

	public override void Do(ActionMemory memory)
	{
		Entity entity = (isOwner ? memory.owner : memory.target.entity);
		float num = 0f;
		switch (valeType)
		{
		case BTreeValeType.vInt:
			num = ((floatFunction != null) ? intValue : ((int)(floatFunction?.Return(memory) ?? 0f)));
			break;
		case BTreeValeType.vFloat:
			num = floatFunction?.Return(memory) ?? floatValue;
			break;
		}
		ActBehaviorTree actBehaviorTree = entity.GetCompAI().ActBehaviorTree;
		if (modifyType == ModifyType.Set)
		{
			ActBehaviorTree actBehaviorTree2 = actBehaviorTree;
			string name = valueName;
			actBehaviorTree2.SetVariableValue(name, valeType switch
			{
				BTreeValeType.vInt => (object)num, 
				BTreeValeType.vFloat => num, 
				BTreeValeType.vBool => boolValue, 
				BTreeValeType.vString => strValue, 
				_ => throw new NotImplementedException(), 
			});
		}
		else
		{
			ActBehaviorTree actBehaviorTree2 = actBehaviorTree;
			string name = valueName;
			actBehaviorTree2.SetVariableValue(name, valeType switch
			{
				BTreeValeType.vInt => (object)(num + (float)(int)actBehaviorTree.GetVariable(valueName).GetValue()), 
				BTreeValeType.vFloat => num + (float)actBehaviorTree.GetVariable(valueName).GetValue(), 
				BTreeValeType.vBool => boolValue, 
				_ => throw new NotImplementedException(), 
			});
		}
	}
}
