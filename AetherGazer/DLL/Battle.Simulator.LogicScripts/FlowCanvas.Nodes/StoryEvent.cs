using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("剧情事件(逻辑)", 0)]
[Category("Logic/事件")]
[Description("剧情事件,可选监听分类,为空则全部监听/n当监听分类为boss apopear时,参数为Boss出场节点的<创建出来的Agent ID>")]
public class StoryEvent : EventNode
{
	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	private FlowOutput enterOutput;

	private FlowOutput exitOutput;

	private ValueInput<StoryType> _StoryTypeInput;

	private int _EntityID;

	private StoryType storyType;

	private int _Param;

	protected override void RegisterPorts()
	{
		enterOutput = AddFlowOutput("开始");
		exitOutput = AddFlowOutput("结束");
		_StoryTypeInput = AddValueInput<StoryType>("监听类型", "storyType");
		AddValueOutput("实体ID", "entityID", () => _EntityID);
		AddValueOutput("类型", () => storyType);
		AddValueOutput("参数", "param", () => _Param);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mOnEnterStory = (Action<int, StoryType, int>)Delegate.Combine(simInterface.mOnEnterStory, new Action<int, StoryType, int>(OnEnterStoryEventHandler));
		ISimulatorInferface simInterface2 = base.mSimContext.GetSimInterface();
		simInterface2.mOnExitStory = (Action<int, StoryType, int>)Delegate.Combine(simInterface2.mOnExitStory, new Action<int, StoryType, int>(OnExitStoryEventHandler));
	}

	private void OnEnterStoryEventHandler(int entityID, StoryType type, int param)
	{
		storyType = _StoryTypeInput.GetValue();
		if ((storyType & type) == type)
		{
			_EntityID = entityID;
			storyType = type;
			_Param = param;
			Flow f = new Flow
			{
				returnData = returnData
			};
			enterOutput.Call(f);
		}
	}

	private void OnExitStoryEventHandler(int entityID, StoryType type, int param)
	{
		storyType = _StoryTypeInput.GetValue();
		if ((storyType & type) == type)
		{
			_EntityID = entityID;
			storyType = type;
			_Param = param;
			Flow f = new Flow
			{
				returnData = returnData
			};
			exitOutput.Call(f);
		}
	}
}
