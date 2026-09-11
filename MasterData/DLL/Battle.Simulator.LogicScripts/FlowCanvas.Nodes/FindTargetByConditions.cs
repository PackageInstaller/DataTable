using System.Collections.Generic;
using Config;

namespace FlowCanvas.Nodes;

public class FindTargetByConditions : FlowNode
{
	protected bool _hadTarget;

	protected int _targetEntity;

	protected virtual bool FindAction(List<int> collisions, out int targetID)
	{
		targetID = 0;
		return false;
	}

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
		AddValueOutput("目标实体ID", "targetEntityID", () => _targetEntity);
		AddFlowInput("In", delegate(Flow f)
		{
			_hadTarget = false;
			_targetEntity = 0;
			List<int> list = FrameListPool<int>.Claim();
			if (CommonProcessor.TryGetCollisions(base.mSimContext, rangeTypeVar.GetValue(), originCenterPosVar.GetValue(), forwardVar.GetValue(), centerPosOffsetVar.GetValue(), radiusVar.GetValue(), angleVar.GetValue(), new Int3(widthVar.GetValue(), heightVar.GetValue(), lengthVar.GetValue()), list, (uint)targetRoleTypeInput.GetValue()))
			{
				_hadTarget = FindAction(list, out _targetEntity);
			}
			FrameListPool<int>.Release(list);
			if (_hadTarget)
			{
				succeedOutput.Call(f);
			}
			else
			{
				failedOutput.Call(f);
			}
		});
	}
}
