using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("相对位置向量的角度区间", 0)]
[Description("相对位置向量角度区间, 出错的话, 也走false, 起始角度不能大于360")]
[Category("Logic/Control")]
public class PositionVectorRegion : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> baseEntityIDInput = AddValueInput<int>("基础实体ID");
		AddValueOutput("基础实体ID", () => baseEntityIDInput.value);
		ValueInput<int> targetEntityIDInput = AddValueInput<int>("目标实体ID");
		AddValueOutput("目标实体ID", () => targetEntityIDInput.value);
		ValueInput<Int> startAngleInput = AddValueInput<Int>("起始角度");
		ValueInput<Int> deltaAngleInput = AddValueInput<Int>("区间大小");
		FlowOutput trueOutput = AddFlowOutput("true");
		FlowOutput falseOutput = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(baseEntityIDInput.value);
			SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(targetEntityIDInput.value);
			if (entityWithEntityID == null || entityWithEntityID2 == null || !entityWithEntityID.hasEntityPositon || !entityWithEntityID2.hasEntityPositon)
			{
				falseOutput.Call(f);
			}
			else
			{
				Int obj = IntMath.AngleOfVector(entityWithEntityID2.entityPositon.mPosition - entityWithEntityID.entityPositon.mPosition);
				Int value = startAngleInput.value;
				Int obj2 = value + deltaAngleInput.value;
				bool flag = false;
				if ((obj2.i <= 360000) ? (obj >= value && obj < obj2) : (obj >= value || obj < obj2.i % 360000))
				{
					trueOutput.Call(f);
				}
				else
				{
					falseOutput.Call(f);
				}
			}
		});
	}
}
