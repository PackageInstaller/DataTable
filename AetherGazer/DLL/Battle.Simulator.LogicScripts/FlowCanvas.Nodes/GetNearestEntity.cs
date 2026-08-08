using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("获得半径内最近的对象", 0)]
[Category("Logic/PosAndRot")]
[Description("获得最近的对象, 输入：自身ID,距离(int),对象类型; 输出：最近对象ID")]
[ExposeAsDefinition]
public class GetNearestEntity : FlowControlNode
{
	private int mNearestEntityID;

	public bool Invoke(int entityID, int range, RoleType entityType, out int nearestID)
	{
		nearestID = 0;
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			Debug.LogError(base.graph.name + " 获得半径内最近的对象 传进来的实体为空");
			return false;
		}
		Int3 mPosition = entityWithEntityID.entityPositon.mPosition;
		List<int> list = FrameListPool<int>.Claim();
		SimPhysics.Overlap(mPosition, range, list, (uint)entityType);
		bool flag = list.Count > 0;
		if (flag)
		{
			long num = long.MaxValue;
			for (int i = 0; i < list.Count; i++)
			{
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(list[i]);
				if (simEntityByMultiColliders != null && simEntityByMultiColliders.hasEntityBlackboard && simEntityByMultiColliders.entityBlackboard.var.mHP > 0)
				{
					long sqrMagnitudeLong = (simEntityByMultiColliders.entityPositon.mPosition - mPosition).sqrMagnitudeLong;
					if (sqrMagnitudeLong <= num && simEntityByMultiColliders.creationIndex != entityWithEntityID.creationIndex)
					{
						nearestID = simEntityByMultiColliders.creationIndex;
						num = sqrMagnitudeLong;
					}
				}
			}
		}
		FrameListPool<int>.Release(list);
		return flag;
	}

	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("True");
		FlowOutput falseOut = AddFlowOutput("false");
		ValueInput<int> p1 = AddValueInput<int>("自身ID");
		ValueInput<int> p2 = AddValueInput<int>("距离");
		ValueInput<RoleType> p3 = AddValueInput<RoleType>("对象类型");
		AddFlowInput(" ", delegate(Flow f)
		{
			if (Invoke(p1.value, p2.value, p3.value, out mNearestEntityID))
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
		AddValueOutput("最近对象ID: ", () => mNearestEntityID);
	}
}
