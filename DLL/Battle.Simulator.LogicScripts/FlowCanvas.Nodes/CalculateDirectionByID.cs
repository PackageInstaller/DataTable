using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("计算朝向(实体ID)(逻辑)", 0)]
[Category("Logic/Math")]
[Description("结果为 A实体 指向 B实体 的单位长度向量\n当【使用A目标】为true时，将使用实体A所瞄准的目标实体作为终点（即A朝向A的瞄准目标），此时实体B输入无效\n当【反向】为true时，计算获得的向量为原向量的反向向量（B朝向A，或A的瞄准目标朝向A）\n没有目标：当【使用A目标】为true，实体A所瞄准的实体不存在时\nError：当【使用A目标】为true且实体A不存在时；或【使用A目标】为false且实体A或B其中之一不存在时")]
public class CalculateDirectionByID : FlowNode
{
	private Int3 direction = Int3.forward;

	protected override void RegisterPorts()
	{
		ValueInput<int> vInA = AddValueInput<int>("实体A", "entA");
		ValueInput<int> vInB = AddValueInput<int>("实体B", "entB");
		ValueInput<bool> vInUseTarget = AddValueInput<bool>("使用A目标", "useTarget");
		ValueInput<bool> vInReverse = AddValueInput<bool>("反向");
		FlowOutput fOut = AddFlowOutput("Out");
		FlowOutput fNoTarget = AddFlowOutput("没有目标", "noTarget");
		FlowOutput fError = AddFlowOutput("Error");
		AddFlowInput("In", delegate(Flow f)
		{
			if (vInUseTarget.value)
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(vInA.value);
				if (entityWithEntityID != null)
				{
					SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID.entityBlackboard.var.mAimTarget);
					if (simEntityByMultiColliders != null)
					{
						Int3 mPosition = entityWithEntityID.entityPositon.mPosition;
						Int3 mPosition2 = simEntityByMultiColliders.entityPositon.mPosition;
						if (vInReverse.value)
						{
							direction = (mPosition - mPosition2).NormalizeTo(1000);
							fOut.Call(f);
						}
						else
						{
							direction = (mPosition2 - mPosition).NormalizeTo(1000);
							fOut.Call(f);
						}
					}
					else
					{
						fNoTarget.Call(f);
					}
				}
				else
				{
					fError.Call(f);
				}
			}
			else
			{
				SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(vInA.value);
				if (entityWithEntityID2 != null)
				{
					SimEntity entityWithEntityID3 = base.mSimContext.GetEntityWithEntityID(vInB.value);
					if (entityWithEntityID3 != null)
					{
						Int3 mPosition3 = entityWithEntityID2.entityPositon.mPosition;
						Int3 mPosition4 = entityWithEntityID3.entityPositon.mPosition;
						if (vInReverse.value)
						{
							direction = (mPosition3 - mPosition4).NormalizeTo(1000);
							fOut.Call(f);
						}
						else
						{
							direction = (mPosition4 - mPosition3).NormalizeTo(1000);
							fOut.Call(f);
						}
						return;
					}
				}
				fError.Call(f);
			}
		});
		AddValueOutput("实体A", () => vInA.value);
		AddValueOutput("实体B", () => vInB.value);
		AddValueOutput("朝向", () => direction);
	}
}
