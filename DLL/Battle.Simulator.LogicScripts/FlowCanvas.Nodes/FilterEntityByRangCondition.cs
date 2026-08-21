using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取指定范围内实体", 0)]
[Category("Logic/抛掷物")]
[Description("获取指定范围内实体")]
public class FilterEntityByRangCondition : FlowControlNode
{
	private Int3 practicalCenterPos;

	private List<int> res = new List<int>();

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		ValueInput<Int3> originCenterPosVar = AddValueInput<Int3>("起始判定中心");
		ValueInput<Int3> centerPosOffsetVar = AddValueInput<Int3>("判定中心偏移量");
		ValueInput<Int3> forwardVar = AddValueInput<Int3>("朝向");
		ValueInput<uint> targetLayerMaskVar = AddValueInput<uint>("目标LayerMask");
		ValueInput<RangeType> rangeTypeVar = AddValueInput<RangeType>("范围类型");
		ValueInput<int> radiusVar = AddValueInput<int>("半径(毫米)", "半径(厘米)");
		ValueInput<int> angleVar = AddValueInput<int>("角度");
		ValueInput<int> lengthVar = AddValueInput<int>("长(毫米)", "长(厘米)");
		ValueInput<int> widthVar = AddValueInput<int>("宽(毫米)", "宽(厘米)");
		ValueInput<int> heightVar = AddValueInput<int>("高(毫米)", "高(厘米)");
		ValueInput<HitHeight> heightInput = AddValueInput<HitHeight>("覆盖的高度标签").SetDefaultAndSerializedValue((HitHeight)(-1));
		ValueInput<List<int>> collisions = AddValueInput<List<int>>("存放目标EntityID的List");
		AddFlowInput("In", delegate(Flow f)
		{
			practicalCenterPos = originCenterPosVar.value;
			res.Clear();
			switch (rangeTypeVar.value)
			{
			case RangeType.Sector:
				practicalCenterPos = IntMath.Transform(centerPosOffsetVar.value, forwardVar.value, originCenterPosVar.value);
				SimPhysics.OverlapSector(practicalCenterPos, radiusVar.value, angleVar.value, forwardVar.value, res, targetLayerMaskVar.value);
				break;
			case RangeType.Roundness:
				practicalCenterPos = IntMath.Transform(centerPosOffsetVar.value, forwardVar.value, originCenterPosVar.value);
				SimPhysics.Overlap(practicalCenterPos, radiusVar.value, res, targetLayerMaskVar.value);
				break;
			case RangeType.Rectangle:
				practicalCenterPos = IntMath.Transform(centerPosOffsetVar.value, forwardVar.value, originCenterPosVar.value);
				SimPhysics.OverlapBox(originCenterPosVar.value, forwardVar.value, centerPosOffsetVar.value, new Int3(widthVar.value, heightVar.value, lengthVar.value), res, targetLayerMaskVar.value);
				break;
			}
			List<int> value = collisions.value;
			value.Clear();
			for (int i = 0; i < res.Count; i++)
			{
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(res[i]);
				if (simEntityByMultiColliders != null)
				{
					HitHeight curHitHeight = ConfigProcessor.GetCurHitHeight(simEntityByMultiColliders);
					if ((curHitHeight == HitHeight.None || heightInput.value.HasFlag(curHitHeight)) && !value.Contains(simEntityByMultiColliders.creationIndex))
					{
						value.Add(simEntityByMultiColliders.creationIndex);
					}
				}
			}
			output.Call(f);
		});
		AddValueOutput("结果：", () => collisions.value);
		AddValueOutput("起始判定中心：", () => originCenterPosVar.value);
		AddValueOutput("判定中心偏移量：", () => centerPosOffsetVar.value);
		AddValueOutput("实际判定中心：", () => practicalCenterPos);
	}
}
