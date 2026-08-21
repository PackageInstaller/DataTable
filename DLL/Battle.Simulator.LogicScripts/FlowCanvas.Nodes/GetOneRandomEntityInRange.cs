using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("范围内随机得到一个目标", 0)]
[Category("Logic/PosAndRot")]
[Description("对指定范围进行检查,随机得到一个目标")]
public class GetOneRandomEntityInRange : FlowControlNode
{
	private bool m_hadTarget;

	private int m_targetEntityID;

	protected override void RegisterPorts()
	{
		FlowOutput succeedOutput = AddFlowOutput("成功", "succeedOutput");
		FlowOutput failedOutput = AddFlowOutput("失败", "failedOutput");
		ValueInput<RoleType> targetRoleTypeInput = AddValueInput<RoleType>("目标类型", "targetRoleTypeInput");
		ValueInput<Int3> originCenterPosVar = AddValueInput<Int3>("起始判定中心", "originCenterPosVar");
		ValueInput<Int3> centerPosOffsetVar = AddValueInput<Int3>("判定中心偏移量", "centerPosOffsetVar");
		ValueInput<Int3> forwardVar = AddValueInput<Int3>("朝向", "forwardVar").SetDefaultAndSerializedValue(Int3.forward);
		ValueInput<RangeType> rangeTypeVar = AddValueInput<RangeType>("范围类型", "rangeTypeVar");
		ValueInput<int> radiusVar = AddValueInput<int>("半径(毫米)", "radiusVar");
		ValueInput<int> angleVar = AddValueInput<int>("角度", "angleVar");
		ValueInput<int> lengthVar = AddValueInput<int>("长(毫米)", "lengthVar");
		ValueInput<int> widthVar = AddValueInput<int>("宽(毫米)", "widthVar");
		ValueInput<int> heightVar = AddValueInput<int>("高(毫米)", "heightVar");
		ValueInput<HitHeight> heightInput = AddValueInput<HitHeight>("覆盖的高度标签").SetDefaultAndSerializedValue((HitHeight)(-1));
		ValueInput<bool> checkLockInput = AddValueInput<bool>("仅可锁定", "checkLock").SetDefaultAndSerializedValue(v: false);
		AddFlowInput("In", delegate(Flow f)
		{
			m_hadTarget = false;
			m_targetEntityID = 0;
			List<int> list = FrameListPool<int>.Claim();
			if (CommonProcessor.TryGetCollisions(base.mSimContext, rangeTypeVar.GetValue(), originCenterPosVar.GetValue(), forwardVar.GetValue(), centerPosOffsetVar.GetValue(), radiusVar.GetValue(), angleVar.GetValue(), new Int3(widthVar.GetValue(), heightVar.GetValue(), lengthVar.GetValue()), list, (uint)targetRoleTypeInput.GetValue()))
			{
				for (int num = list.Count - 1; num >= 0; num--)
				{
					SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(list[num]);
					HitHeight curHitHeight = ConfigProcessor.GetCurHitHeight(simEntityByMultiColliders);
					if (curHitHeight != HitHeight.None && !heightInput.value.HasFlag(curHitHeight))
					{
						list.RemoveAt(num);
					}
					if (checkLockInput.value && !AIProcessor.CanLockOfEntity(simEntityByMultiColliders))
					{
						list.RemoveAt(num);
					}
				}
				List<int> list2 = FrameListPool<int>.Claim();
				if (CommonProcessor.TryFilterCollisions(base.mSimContext, originCenterPosVar.GetValue(), list, TargetSelectType.Random, 1, list2) && list2.Count > 0)
				{
					SimEntity simEntityByMultiColliders2 = CommonProcessor.GetSimEntityByMultiColliders(list2[0]);
					if (simEntityByMultiColliders2 != null)
					{
						m_targetEntityID = simEntityByMultiColliders2.creationIndex;
						m_hadTarget = true;
					}
				}
				FrameListPool<int>.Release(list2);
			}
			FrameListPool<int>.Release(list);
			if (m_hadTarget)
			{
				succeedOutput.Call(f);
			}
			else
			{
				failedOutput.Call(f);
			}
		});
		AddValueOutput("目标实体ID", "targetEntityID", () => m_targetEntityID);
	}
}
