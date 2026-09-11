using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI获取当前指令和指令集ID", 0)]
[Category("Logic/AI")]
[Description("AI获取当前指令和指令集ID")]
public class GetCurrentAction : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		int entityID = 0;
		AddValueOutput("实体ID", () => entityID);
		int parentID = 0;
		AddValueOutput("指令集ID", () => parentID);
		int commandID = 0;
		AddValueOutput("指令ID", () => commandID);
		int step = 0;
		AddValueOutput("index", () => step);
		AIProcessor.AICommandStatus status = AIProcessor.AICommandStatus.None;
		AddValueOutput("状态", () => status);
		FlowOutput output = AddFlowOutput("");
		FlowOutput noCommandOut = AddFlowOutput("没有指令");
		AddFlowInput("", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityAIThink)
			{
				AICommand mCurrentCommand = entityWithEntityID.entityAIThink.mCurrentCommand;
				if (mCurrentCommand == null)
				{
					noCommandOut.Call(f);
				}
				else
				{
					if (!(mCurrentCommand is AICommandSet aICommandSet))
					{
						parentID = 0;
						step = 0;
						commandID = mCurrentCommand.mID;
						status = AIProcessor.AICommandStatus.None;
					}
					else
					{
						parentID = mCurrentCommand.mID;
						step = aICommandSet.mCurrent;
						commandID = aICommandSet.mCommands[step].mID;
						status = aICommandSet.mCommands[step].mStatus;
					}
					output.Call(f);
				}
			}
		});
	}
}
