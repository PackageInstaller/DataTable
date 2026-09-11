using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("随机处理范围内实体", 0)]
[Category("Logic/PosAndRot")]
[Description("随机处理范围内实体")]
public class RandomProcessEntityByRangeCondition : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Do");
		FlowOutput nothingOutput = AddFlowOutput("No Target");
		ValueInput<Int3> originCenterPosVar = AddValueInput<Int3>("起始判定中心");
		ValueInput<Int3> centerPosOffsetVar = AddValueInput<Int3>("判定中心偏移量");
		ValueInput<Int3> forwardVar = AddValueInput<Int3>("朝向");
		ValueInput<RoleType> targetRoleTypeInput = AddValueInput<RoleType>("目标类型");
		ValueInput<RangeType> rangeTypeVar = AddValueInput<RangeType>("范围类型");
		ValueInput<int> radiusVar = AddValueInput<int>("半径(毫米)");
		ValueInput<int> angleVar = AddValueInput<int>("角度");
		ValueInput<int> lengthVar = AddValueInput<int>("长(毫米)");
		ValueInput<int> widthVar = AddValueInput<int>("宽(毫米)");
		ValueInput<int> heightVar = AddValueInput<int>("高(毫米)");
		ValueInput<HitHeight> heightInput = AddValueInput<HitHeight>("覆盖的高度标签").SetDefaultAndSerializedValue((HitHeight)(-1));
		Int3 practicalCenterPos = Int3.zero;
		int entityID = 0;
		AddFlowInput("In", delegate(Flow f)
		{
			entityID = 0;
			List<int> list = FrameListPool<int>.Claim();
			practicalCenterPos = originCenterPosVar.value;
			switch (rangeTypeVar.value)
			{
			case RangeType.Sector:
				practicalCenterPos = IntMath.Transform(centerPosOffsetVar.value, forwardVar.value, originCenterPosVar.value);
				SimPhysics.OverlapSector(practicalCenterPos, radiusVar.value, angleVar.value, forwardVar.value, list, (uint)targetRoleTypeInput.value);
				break;
			case RangeType.Roundness:
				practicalCenterPos = IntMath.Transform(centerPosOffsetVar.value, forwardVar.value, originCenterPosVar.value);
				SimPhysics.Overlap(practicalCenterPos, radiusVar.value, list, (uint)targetRoleTypeInput.value);
				break;
			case RangeType.Rectangle:
				practicalCenterPos = IntMath.Transform(centerPosOffsetVar.value, forwardVar.value, originCenterPosVar.value);
				SimPhysics.OverlapBox(originCenterPosVar.value, forwardVar.value, centerPosOffsetVar.value, new Int3(widthVar.value, heightVar.value, lengthVar.value), list, (uint)targetRoleTypeInput.value);
				break;
			}
			for (int num = list.Count - 1; num >= 0; num--)
			{
				HitHeight curHitHeight = ConfigProcessor.GetCurHitHeight(CommonProcessor.GetSimEntityByMultiColliders(list[num]));
				if (curHitHeight != HitHeight.None && !heightInput.value.HasFlag(curHitHeight))
				{
					list.RemoveAt(num);
				}
			}
			if (0 < list.Count)
			{
				int index = (int)DRandom.Random((uint)list.Count);
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(list[index]);
				if (simEntityByMultiColliders == null)
				{
					nothingOutput.Call(f);
				}
				else
				{
					entityID = simEntityByMultiColliders.creationIndex;
					output.Call(f);
				}
			}
			else
			{
				nothingOutput.Call(f);
			}
			FrameListPool<int>.Release(list);
		});
		AddValueOutput("结果：", () => entityID);
	}
}
