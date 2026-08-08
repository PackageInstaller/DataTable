using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("执行击退(a->b)", 0)]
[Category("Logic/Abilities")]
[Description("从起点向终点方向击退一定距离,一帧执行完毕")]
[ExposeAsDefinition]
public class DoKnockback : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput abnormal = AddFlowOutput("异常退出");
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput selfOutput = AddFlowOutput("自身");
		ValueInput<int> FromEntityIDVar = AddValueInput<int>("起点实体ID", "DoKnockback_FromEntityIDVar");
		ValueInput<int> ToEntityIDVar = AddValueInput<int>("终点实体ID", "DoKnockback_ToEntityIDVar");
		ValueInput<int> KnockbackDistanceVar = AddValueInput<int>("击退距离(毫米)", "DoKnockback_KnockbackDistanceVar");
		ValueInput<bool> KnockBackDirectionVar = AddValueInput<bool>("使用起点朝向", "DoKnockback_KnockBackDirection");
		AddFlowInput("In", delegate(Flow f)
		{
			if (FromEntityIDVar.GetValue() == ToEntityIDVar.GetValue())
			{
				selfOutput.Call(f);
			}
			else
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(FromEntityIDVar.GetValue());
				if (entityWithEntityID == null)
				{
					abnormal.Call(f);
				}
				else
				{
					SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(ToEntityIDVar.GetValue());
					if (entityWithEntityID2 == null)
					{
						abnormal.Call(f);
					}
					else if (entityWithEntityID.entityPositon.mPosition == entityWithEntityID2.entityPositon.mPosition)
					{
						abnormal.Call(f);
					}
					else
					{
						Int3 direction = entityWithEntityID.entityPositon.mForward;
						if (!KnockBackDirectionVar.GetValue())
						{
							direction = Int3.ProjectionToY(entityWithEntityID2.entityPositon.mPosition - entityWithEntityID.entityPositon.mPosition).NormalizeTo(1000);
						}
						KnockbackHelper.KnockbackTo(entityWithEntityID2, direction, KnockbackDistanceVar.GetValue());
						output.Call(f);
					}
				}
			}
		});
	}
}
