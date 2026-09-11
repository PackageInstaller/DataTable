using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("AI执行Ability(后3位)", 0)]
[Category("Logic/AI")]
[Description("指定AI做指定动作,技能ID只填后3位,返回传进来的实体ID")]
public class AIDoAbility2 : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> abilityIDInput = AddValueInput<int>("技能ID(后三位)", "技能ID");
		ValueInput<bool> forceInput = AddValueInput<bool>("强制执行");
		ValueInput<int> frameInput = AddValueInput<int>("起始帧数", "frame").SetDefaultAndSerializedValue(0);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				Debug.LogError(base.graph.name + " : AI执行Ability(后3位) 这个节点传入了一个空的实体");
			}
			else
			{
				entityWithEntityID.entityBlackboard.var.mNewAbilityStartFrame = frameInput.value;
				int abilityID = entityWithEntityID.entityConfig.mId * 1000 + abilityIDInput.value;
				AIProcessor.AIStartAttack(entityIDInput.value, entityWithEntityID.entityPositon.mPosition, abilityID, forceInput.GetValue());
				f.Call(output);
			}
		});
	}
}
