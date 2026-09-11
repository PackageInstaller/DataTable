using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断和目标之间是否有实体", 0)]
[Category("Logic/PosAndRot")]
[Description("判断和目标之间是否有实体. 目标实体ID：默认为0，填0的话就取实体当前锁定的目标。阵营：默认为None，代表所有阵营都算，选了阵营的话就只有当和目标间有该阵营的实体时才走true")]
public class JudgeIsEntityBetweenTarget : FlowNode
{
	private List<int> collisions = new List<int>();

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> targetIDInput = AddValueInput<int>("目标实体ID");
		ValueInput<RoleType> campInput = AddValueInput<RoleType>("目标阵营");
		ValueInput<int> widthInput = AddValueInput<int>("宽度").SetDefaultAndSerializedValue(1000);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			int num = targetIDInput.value;
			if (num == 0)
			{
				num = entityWithEntityID.entityBlackboard.var.mAimTarget;
			}
			SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(num);
			if (simEntityByMultiColliders != null && simEntityByMultiColliders.hasEntityBlackboard)
			{
				uint num2 = (uint)campInput.value;
				if (num2 == 0)
				{
					num2 = uint.MaxValue;
				}
				Int3 @int = (simEntityByMultiColliders.entityPositon.mPosition + entityWithEntityID.entityPositon.mPosition) / 2f - entityWithEntityID.entityPositon.mPosition;
				Int3 origin = entityWithEntityID.entityPositon.mPosition + @int;
				Int3 int2 = @int;
				int2 = int2.NormalizeTo(1000);
				collisions.Clear();
				SimPhysics.OverlapBox(origin, int2, Int3.zero, new Int3(widthInput.value, 1000, @int.magnitude2D * 2), collisions, num2);
				bool flag = false;
				for (int i = 0; i < collisions.Count; i++)
				{
					SimEntity simEntityByMultiColliders2 = CommonProcessor.GetSimEntityByMultiColliders(collisions[i]);
					if (simEntityByMultiColliders2 != null && simEntityByMultiColliders2.creationIndex != entityWithEntityID.creationIndex && simEntityByMultiColliders2.creationIndex != simEntityByMultiColliders.creationIndex)
					{
						flag = true;
						break;
					}
				}
				if (flag)
				{
					f.Call(trueOut);
				}
				else
				{
					f.Call(falseOut);
				}
			}
		});
	}
}
