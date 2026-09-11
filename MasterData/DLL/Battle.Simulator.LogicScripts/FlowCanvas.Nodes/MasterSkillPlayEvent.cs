using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("芯片技能执行事件", 0)]
[Category("Common/事件")]
[Description("芯片技能执行事件")]
public class MasterSkillPlayEvent : EventNode
{
	private int entityID;

	private int configID;

	private FlowOutput output;

	private ValueInput<bool> isRenderInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		AddValueOutput("实体ID", () => entityID);
		AddValueOutput("芯片ID", () => configID);
		output = AddFlowOutput("");
		isRenderInput = AddValueInput<bool>("是否渲染");
	}

	public override void OnGraphStarted()
	{
		if (!isRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<MasterSkillEvent>(OnUpdateEntityMasterSkill);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<MasterSkillEvent>(OnUpdateEntityMasterSkill);
		}
	}

	public override void OnGraphStoped()
	{
		entityID = 0;
		configID = 0;
	}

	private void OnUpdateEntityMasterSkill(MasterSkillEvent skillEvent)
	{
		entityID = skillEvent.mCasterID;
		configID = skillEvent.mConfigID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		output.Call(f);
	}
}
