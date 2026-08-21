using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体周围固定一点(指向目标)", 0)]
[Category("Logic/Random")]
[Description("实体周围固定一点, 这一点会和实体在同一网格内, 范围必须大于0, 如果实体为空, 会报错\n若有输入【起始实体ID】，则直接获取起始实体的实体位置作为起始点，若【起始实体ID】为0，则读取输入的起始点坐标")]
public class GetTargetPointAroundEntityFromTargetID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("起始实体ID");
		ValueInput<Int3> startPosInput = AddValueInput<Int3>("起始点坐标");
		ValueInput<int> targetIDInput = AddValueInput<int>("目标实体ID");
		ValueInput<int> distanceInput = AddValueInput<int>("距离");
		ValueInput<bool> safePosInput = AddValueInput<bool>("安全位置");
		AddValueOutput("实体ID", () => entityIDInput.value);
		Int3 pos = Int3.zero;
		AddValueOutput("位置", () => pos);
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOutput = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			Int3 @int = startPosInput.value;
			if (entityWithEntityID != null && entityWithEntityID.hasEntityPositon)
			{
				@int = entityWithEntityID.entityPositon.mPosition;
			}
			SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(targetIDInput.value);
			if (entityWithEntityID2 != null && entityWithEntityID2.hasEntityPositon)
			{
				pos = @int + (entityWithEntityID2.entityPositon.mPosition - @int).NormalizeTo(distanceInput.value);
				if (safePosInput.value)
				{
					pos = CommonProcessor.GetPositionInGraphWithoutTangentMove(@int, pos);
				}
				output.Call(f);
			}
			else
			{
				pos = @int;
				errorOutput.Call(f);
			}
		});
	}
}
