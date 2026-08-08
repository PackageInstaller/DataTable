using System.Collections.Generic;
using ParadoxNotion.Design;
using Pathfinding.Util;

namespace FlowCanvas.Nodes;

[Name("将敌人往指定位置聚集", 0)]
[Category("Logic/Control")]
[Description("将敌人往指定位置聚集")]
[ExposeAsDefinition]
public class GatheredUnit : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Int3> gatheredPosInput = AddValueInput<Int3>("聚集位置");
		ValueInput<int> gatheredRangeInput = AddValueInput<int>("聚集范围");
		ValueInput<int> gatheredSpeedInput = AddValueInput<int>("聚集速度");
		ValueInput<int> stopGatheredRangeInput = AddValueInput<int>("停止范围");
		ValueInput<int> layerMaskInput = AddValueInput<int>("LayerMask");
		FlowOutput output = AddFlowOutput("Out", "output");
		AddFlowInput("In", delegate(Flow f)
		{
			List<int> list = ListPool<int>.Claim();
			int value = stopGatheredRangeInput.value;
			VFactor vFactor = new VFactor(gatheredSpeedInput.value * CommonProcessor.GetLogicConstTick(), 1000000L);
			Int3 value2 = gatheredPosInput.value;
			SimPhysics.Overlap(value2, gatheredRangeInput.value, list, (uint)layerMaskInput.value);
			for (int i = 0; i < list.Count; i++)
			{
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(list[i]);
				if (simEntityByMultiColliders != null)
				{
					long num = MovementProcessor.SqrDistance(value2, simEntityByMultiColliders);
					if (num > value * value)
					{
						Int3 @int = (value2 - simEntityByMultiColliders.entityPositon.mPosition).NormalizeTo(1000);
						VFactor vFactor2 = new VFactor(IntMath.Sqrt(num) - value, 1000L);
						if (vFactor2 > vFactor)
						{
							MovementProcessor.PathfindingMove(simEntityByMultiColliders, @int * vFactor);
						}
						else
						{
							MovementProcessor.PathfindingMove(simEntityByMultiColliders, @int * vFactor2);
						}
					}
				}
			}
			ListPool<int>.Release(list);
			output.Call(f);
		});
	}
}
