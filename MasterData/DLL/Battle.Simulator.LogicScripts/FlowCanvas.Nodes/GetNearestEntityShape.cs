using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取目标最近部位ID", 0)]
[Category("Logic/PosAndRot")]
[Description("获得最近的对象, 输入：自身ID,目标ID,对象类型; 输出：最近对象碰撞盒ID")]
public class GetNearestEntityShape : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> targetIDInput = AddValueInput<int>("目标实体ID");
		AddValueOutput("部位实体ID", delegate
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(targetIDInput.value);
			if (entityWithEntityID2 == null)
			{
				return 0;
			}
			List<EntityShape> list = FrameListPool<EntityShape>.Claim();
			SimShapeProcessor.GetAllShape(entityWithEntityID2, list);
			int num = -1;
			long num2 = long.MaxValue;
			for (int i = 0; i < list.Count; i++)
			{
				ISimShape mShape = list[i].mShape;
				if (mShape.IsEnable)
				{
					long num3 = MovementProcessor.SqrDistance(mShape.WorldPos, entityWithEntityID);
					if (num2 > num3)
					{
						num = i;
						num2 = num3;
					}
				}
			}
			if (num >= 0)
			{
				num = list[num].mShape.OwnerID;
			}
			FrameListPool<EntityShape>.Release(list);
			return num;
		});
	}
}
