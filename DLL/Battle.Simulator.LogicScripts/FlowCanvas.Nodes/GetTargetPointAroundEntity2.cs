using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体周围固定一点(直角坐标)(逻辑)", 0)]
[Category("Logic")]
[Description("根据实体朝向，在该实体的坐标系中偏移指定位置，所得点会在网格内朝向覆盖：若实体Id为0，则使用本项作为坐标系朝向参考\n起点覆盖：若实体Id为0，则使用本项作为坐标系的0,0点参考Error：实体Id不为0，以实体为参考，但实体不存在时")]
public class GetTargetPointAroundEntity2 : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "out");
		FlowOutput error = AddFlowOutput("Error", "error");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<Int3> ForwardInput = AddValueInput<Int3>("朝向覆盖").SetDefaultAndSerializedValue(Int3.forward);
		ValueInput<Int3> StartInput = AddValueInput<Int3>("起点覆盖");
		ValueInput<Int3> offsetInput = AddValueInput<Int3>("偏移量");
		AddValueOutput("实体ID", () => entityIDInput.value);
		Int3 pos = Int3.zero;
		AddValueOutput("坐标", () => pos);
		AddFlowInput("In", "in", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityIDInput.value != 0 && entityWithEntityID == null)
			{
				error.Call(f);
			}
			else
			{
				Int3 @int = StartInput.value;
				Int3 int2 = ForwardInput.value;
				if (entityIDInput.value != 0)
				{
					@int = entityWithEntityID.entityPositon.mPosition;
					int2 = entityWithEntityID.entityPositon.mForward;
				}
				if (int2 == Int3.zero)
				{
					error.Call(f);
				}
				else
				{
					pos = IntMath.Transform(offsetInput.value, int2, @int);
					pos = CommonProcessor.GetPositionInGraphWithoutTangentMove(@int, pos);
					output.Call(f);
				}
			}
		});
	}
}
