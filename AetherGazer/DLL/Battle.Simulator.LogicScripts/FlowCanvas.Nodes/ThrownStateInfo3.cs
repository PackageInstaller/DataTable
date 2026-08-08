using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物数据(ID)", 0)]
[Category("Logic/抛掷物")]
[Description("得到指定id的抛掷物数据，并根据其生命周期输出指定控制流。\n【Out】：正常获取\n【待销毁】：该抛掷物已被标记为待销毁，但仍可获取数据\n【无数据】：该抛掷物已彻底销毁，无法得到数据。")]
public class ThrownStateInfo3 : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput successOut = AddFlowOutput("有数据");
		FlowOutput destroyOut = AddFlowOutput("待销毁");
		FlowOutput failOut = AddFlowOutput("无数据");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		ThrownState thrownState = null;
		AddFlowInput("In", delegate(Flow f)
		{
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDVar.GetValue(), out thrownState))
			{
				failOut.Call(f);
			}
			else if (CommonProcessor.GetWorldState().mDestoryThrowns.Contains(thrownState.mCreationIndex))
			{
				destroyOut.Call(f);
			}
			else
			{
				successOut.Call(f);
			}
		});
		AddValueOutput("抛掷物ID：", () => thrownState.mCreationIndex);
		AddValueOutput("TimelineID：", () => thrownState.mAbilityID);
		AddValueOutput("释放者ID：", () => thrownState.mCasterID);
		AddValueOutput("阵营：", () => thrownState.mCamp);
		AddValueOutput("坐标", () => thrownState.mPosition);
		AddValueOutput("朝向", () => thrownState.mForward);
		AddValueOutput("当前逻辑时间", () => (uint)thrownState.mLogicTime);
		AddValueOutput("根源TimelineID", "RootTimelineID", () => thrownState.mCreatedRootTimelineID);
	}
}
