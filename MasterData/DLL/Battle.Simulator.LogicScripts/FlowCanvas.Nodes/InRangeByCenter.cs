using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体是否在指定范围内", 0)]
[Category("Logic/AI")]
[Description("指定中心及半径，判断实体是否在指定范围内")]
public class InRangeByCenter : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("entityID");
		ValueInput<Int3> centerInput = AddValueInput<Int3>("center");
		ValueInput<int> rangeInput = AddValueInput<int>("range");
		ValueInput<HitHeight> heightInput = AddValueInput<HitHeight>("覆盖的高度标签").SetDefaultAndSerializedValue((HitHeight)(-1));
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				falseOut.Call(f);
			}
			else if (MovementProcessor.SqrDistance(centerInput.value, entityWithEntityID) <= rangeInput.value * rangeInput.value)
			{
				HitHeight curHitHeight = ConfigProcessor.GetCurHitHeight(entityWithEntityID);
				if (curHitHeight != HitHeight.None && !heightInput.value.HasFlag(curHitHeight))
				{
					falseOut.Call(f);
				}
				else
				{
					trueOut.Call(f);
				}
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
