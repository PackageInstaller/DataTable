using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("创建抛掷物-继承(TimelineId)", 0)]
[Category("Logic/抛掷物")]
[Description("根据输入的抛掷物Id，在该抛掷物位置创建指定的新抛掷物。\n除TimelineId以外，其余参数全部继承原抛掷物的信息\nOut:成功创建后\n找不到抛掷物:原抛掷物不存在\n原发起者不存在:抛掷物对应发起者不存在")]
public class InheritThrownTimelineId : FlowNode
{
	private ValueInput<int> vInThrownId;

	private ValueInput<int> vInTimelineId;

	private ValueOutput<int> vOutNewThrown;

	private int newThrownId;

	protected override void RegisterPorts()
	{
		vInThrownId = AddValueInput<int>("抛掷物唯一Id");
		vInTimelineId = AddValueInput<int>("新TimelineId");
		vOutNewThrown = AddValueOutput("新抛掷物唯一Id", () => newThrownId);
		FlowOutput fOut = AddFlowOutput("Out");
		FlowOutput fNoThrown = AddFlowOutput("找不到抛掷物");
		FlowOutput fError = AddFlowOutput("原发起者不存在");
		AddFlowInput("In", delegate(Flow f)
		{
			ThrownState thrownState = null;
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, vInThrownId.value, out thrownState))
			{
				fNoThrown.Call(f);
			}
			else if (base.mSimContext.GetEntityWithEntityID(thrownState.mCasterID) == null)
			{
				fError.Call(f);
			}
			else
			{
				newThrownId = ThrownProcessor.SpawnThrown(base.mSimContext, thrownState.mCasterID, 0, 0, thrownState.mPosition, thrownState.mForward, vInTimelineId.value, useCommon: true, thrownState.mProducerID, thrownState.mCreatedRootTimelineID, thrownState.mAttributeID, out var _);
				fOut.Call(f);
			}
		});
	}
}
