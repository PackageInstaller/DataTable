using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("执行击退(pos->b)", 0)]
[Category("Logic/Abilities")]
[Description("从起点向终点方向击退一定距离,一帧执行完毕;\n如果击退方向为zero,则设置计算pos到b的方向作为击退方向")]
[ExposeAsDefinition]
public class DoKnockback2 : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput abnormal = AddFlowOutput("异常退出");
		FlowOutput output = AddFlowOutput("Out");
		AddFlowOutput("自身");
		ValueInput<Int3> StartPosVar = AddValueInput<Int3>("起点坐标", "DoKnockback2_FromEntityIDVar");
		ValueInput<int> ToEntityIDVar = AddValueInput<int>("作用实体ID", "DoKnockback2_ToEntityIDVar");
		ValueInput<int> KnockbackDistanceVar = AddValueInput<int>("击退距离(毫米)", "DoKnockback2_KnockbackDistanceVar");
		ValueInput<Int3> KnockBackDirectionVar = AddValueInput<Int3>("击退方向(可为空)", "DoKnockback2_KnockBackDirectionVar").SetDefaultAndSerializedValue(Int3.zero);
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(ToEntityIDVar.GetValue());
			if (entityWithEntityID == null)
			{
				abnormal.Call(f);
			}
			else if (StartPosVar.GetValue() == entityWithEntityID.entityPositon.mPosition)
			{
				abnormal.Call(f);
			}
			else
			{
				Int3 @int = KnockBackDirectionVar.GetValue();
				if (@int == Int3.zero)
				{
					@int = Int3.ProjectionToY(entityWithEntityID.entityPositon.mPosition - StartPosVar.GetValue()).NormalizeTo(1000);
				}
				KnockbackHelper.KnockbackTo(entityWithEntityID, @int, KnockbackDistanceVar.GetValue());
				output.Call(f);
			}
		});
	}
}
