using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历处理范围内实体", 0)]
[Category("Logic/PosAndRot")]
[Description("遍历处理范围内实体")]
public class GetEntityByRangeCondition : FlowControlNode
{
	private int m_count;

	private HashSet<int> mEntityIDs = new HashSet<int>();

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Do");
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
		ValueInput<bool> checkAlive = AddValueInput<bool>("仅处理存活目标").SetDefaultAndSerializedValue(v: false);
		ValueInput<HitHeight> heightInput = AddValueInput<HitHeight>("覆盖的高度标签").SetDefaultAndSerializedValue((HitHeight)(-1));
		Int3 practicalCenterPos = Int3.zero;
		int entityID = 0;
		FlowOutput doneOutput = AddFlowOutput("Done");
		AddFlowInput("In", delegate(Flow f)
		{
			m_count = 0;
			mEntityIDs.Clear();
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
			for (int i = 0; i < list.Count; i++)
			{
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(list[i]);
				if (simEntityByMultiColliders != null && !mEntityIDs.Contains(simEntityByMultiColliders.creationIndex) && (!checkAlive.value || CommonProcessor.IsAliveRole(simEntityByMultiColliders)))
				{
					HitHeight curHitHeight = ConfigProcessor.GetCurHitHeight(simEntityByMultiColliders);
					if (curHitHeight == HitHeight.None || heightInput.value.HasFlag(curHitHeight))
					{
						mEntityIDs.Add(simEntityByMultiColliders.creationIndex);
					}
				}
			}
			m_count = mEntityIDs.Count;
			foreach (int mEntityID in mEntityIDs)
			{
				entityID = mEntityID;
				output.Call(f);
			}
			FrameListPool<int>.Release(list);
			doneOutput.Call(f);
		});
		AddValueOutput("结果：", () => entityID);
		AddValueOutput("起始判定中心：", () => originCenterPosVar.value);
		AddValueOutput("判定中心偏移量：", () => centerPosOffsetVar.value);
		AddValueOutput("实际判定中心：", () => practicalCenterPos);
		AddValueOutput("数量：", "count", () => m_count);
	}
}
