using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("通知芯片技能执行(逻辑)", 0)]
[Category("Logic/芯片技能")]
[Description("通知芯片技能执行")]
public class PostUseMasterSkill : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "实体ID");
		ValueInput<int> configIDInput = AddValueInput<int>("指定芯片ID", "configID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("成功", "true");
		FlowOutput outputFalse = AddFlowOutput("非指定芯片", "false");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				Debug.LogError($"PostUseMasterSkill: {base.graph.name} 中【芯片技能执行通知】的 {entityWithEntityID.creationIndex} 实体不存在");
				errorOut.Call(f);
			}
			else if (!entityWithEntityID.hasEntityMasterSkill)
			{
				errorOut.Call(f);
				Debug.LogError($"PostUseMasterSkill: {base.graph.name} 中【芯片技能执行通知】的 {entityWithEntityID.creationIndex} 没有芯片组件");
			}
			else
			{
				EntityMasterSkill entityMasterSkill = entityWithEntityID.entityMasterSkill;
				if (configIDInput.value != 0 && configIDInput.value != entityMasterSkill.mConfigID)
				{
					outputFalse.Call(f);
				}
				else
				{
					entityMasterSkill.mCD = entityMasterSkill.mMaxCD;
					base.graph.mSimContext.PostEvent(MasterSkillEvent.Claim(entityIDInput.value, entityMasterSkill.mConfigID));
					f.Call(output);
				}
			}
		});
	}
}
