using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到最近我方单位", 0)]
[Category("Logic/Spawn")]
[Description("得到最近我方单位")]
public class GetCurrentNeareatWeUnits : FlowControlNode
{
	private int m_nearestEntityID;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID", "entityIDVar");
		ValueInput<int> radiusVar = AddValueInput<int>("半径(毫米)", "radiusVar").SetDefaultAndSerializedValue(10000);
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			m_nearestEntityID = 0;
			int value = entityIDVar.GetValue();
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(value);
			if (entityWithEntityID == null && !entityWithEntityID.hasEntityCamp)
			{
				error.Call(f);
			}
			else
			{
				List<int> list = FrameListPool<int>.Claim();
				List<int> list2 = FrameListPool<int>.Claim();
				list2.Add(value);
				if (!CommonProcessor.TryGetTargets(base.mSimContext, list, list2, value, TargetCampType.We, RangeType.Roundness, Int3.zero, radiusVar.GetValue(), 0, 0, 0, 0, TargetSelectType.Nearest, 1))
				{
					FrameListPool<int>.Release(list);
					FrameListPool<int>.Release(list2);
					error.Call(f);
				}
				else
				{
					for (int i = 0; i < list.Count; i++)
					{
						SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(list[i]);
						if (simEntityByMultiColliders != null)
						{
							m_nearestEntityID = simEntityByMultiColliders.creationIndex;
							break;
						}
					}
					FrameListPool<int>.Release(list);
					FrameListPool<int>.Release(list2);
					output.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDVar.GetValue());
		AddValueOutput("目标实体ID", "targetEntityID", () => m_nearestEntityID);
	}
}
