using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物数据(ID)(过时)", 0)]
[Category("Logic/抛掷物")]
[Description("得到指定id抛掷物的数据，抛掷物处于待销毁状态时也能得到数据。仅当抛掷物彻底销毁后才会输出无数据")]
public class ThrownStateInfo2 : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput successOut = AddFlowOutput("有数据");
		FlowOutput failOut = AddFlowOutput("无数据");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		ThrownState thrownState = null;
		AddFlowInput("In", delegate(Flow f)
		{
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDVar.GetValue(), out thrownState))
			{
				failOut.Call(f);
			}
			else
			{
				successOut.Call(f);
			}
		});
		AddValueOutput("抛掷物ID：", () => thrownState.mCreationIndex);
		AddValueOutput("抛掷物ID：", () => thrownState.mCreationIndex);
		AddValueOutput("TimelineID：", () => thrownState.mAbilityID);
		AddValueOutput("释放者ID：", () => thrownState.mCasterID);
		AddValueOutput("阵营：", () => thrownState.mCamp);
		AddValueOutput("坐标", () => thrownState.mPosition);
		AddValueOutput("朝向", () => thrownState.mForward);
		AddValueOutput("当前帧号", () => thrownState.mCurFrame);
		AddValueOutput("根源TimelineID", "RootTimelineID", () => thrownState.mCreatedRootTimelineID);
	}
}
