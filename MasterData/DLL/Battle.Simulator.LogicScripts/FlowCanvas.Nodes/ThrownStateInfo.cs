using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物数据", 0)]
[Category("Logic/抛掷物")]
[Description("抛掷物数据")]
public class ThrownStateInfo : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		AddFlowInput("In", delegate(Flow f)
		{
			output.Call(f);
		});
		ValueInput<ThrownState> thrownState = AddValueInput<ThrownState>("抛掷物数据");
		AddValueOutput("抛掷物ID：", () => thrownState.value.mCreationIndex);
		AddValueOutput("TimelineID：", () => thrownState.value.mAbilityID);
		AddValueOutput("释放者ID：", () => thrownState.value.mCasterID);
		AddValueOutput("阵营：", () => thrownState.value.mCamp);
		AddValueOutput("坐标", () => thrownState.value.mPosition);
		AddValueOutput("朝向", () => thrownState.value.mForward);
		AddValueOutput("当前帧号", () => thrownState.value.mCurFrame);
		AddValueOutput("根源TimelineID", "RootTimelineID", () => thrownState.value.mCreatedRootTimelineID);
	}
}
