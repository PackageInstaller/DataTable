using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("执行跳跃", 0)]
[Category("Logic/Abilities")]
[Description("执行跳跃")]
public class DoJumpAction : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		ValueInput<Int3> targetPosInput = AddValueInput<Int3>("目标点");
		ValueInput<int> maxHeightInput = AddValueInput<int>("最大高度");
		ValueInput<int> startReadyTimeInput = AddValueInput<int>("起跳准备时长");
		ValueInput<int> gInput = AddValueInput<int>("重力(毫米/帧/帧)").SetDefaultAndSerializedValue(10);
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityConfig)
			{
				errorOut.Call(f);
			}
			else if (entityWithEntityID.entityBlackboard.var.mJumpStartSlot == 0)
			{
				errorOut.Call(f);
			}
			else
			{
				if (entityWithEntityID.hasEntityActionJump)
				{
					entityWithEntityID.ReplaceEntityActionJump(targetPosInput.value, maxHeightInput.value, startReadyTimeInput.value, gInput.value, E_JumpActionStatus.None, Int3.zero, 0, newMUseTartgetPos: true);
				}
				else
				{
					entityWithEntityID.AddEntityActionJump(targetPosInput.value, maxHeightInput.value, startReadyTimeInput.value, gInput.value, E_JumpActionStatus.None, Int3.zero, 0, newMUseTartgetPos: true);
				}
				output.Call(f);
			}
		});
	}
}
