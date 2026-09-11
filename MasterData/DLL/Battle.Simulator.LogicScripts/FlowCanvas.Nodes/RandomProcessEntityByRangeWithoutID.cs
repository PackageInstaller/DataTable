using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("随机处理范围内实体(排除ID)", 0)]
[Category("Logic/PosAndRot")]
[Description("随机处理范围内实体")]
public class RandomProcessEntityByRangeWithoutID : FlowControlNode
{
	private FlowOutput _Output;

	private FlowOutput _IgnoreOut;

	private FlowOutput _NothingOutput;

	private ValueInput<Int3> _CenterPosInput;

	private ValueInput<Int3> _OffsetInput;

	private ValueInput<Int3> _ForwardInput;

	private ValueInput<RoleType> _TargetRoleTypeInput;

	private ValueInput<RangeType> _RangeTypeInput;

	private ValueInput<int> _RadiusInput;

	private ValueInput<int> _AngleInput;

	private ValueInput<int> _LengthInput;

	private ValueInput<int> _WidthInput;

	private ValueInput<int> _HeightInput;

	private ValueInput<int> _IgnoreIDInput;

	private int _EntityID;

	protected override void RegisterPorts()
	{
		_Output = AddFlowOutput("Out", "output");
		_IgnoreOut = AddFlowOutput("被忽略", "ignore");
		_NothingOutput = AddFlowOutput("无目标", "NoTarget");
		_CenterPosInput = AddValueInput<Int3>("起始判定中心", "centerPos");
		_OffsetInput = AddValueInput<Int3>("判定中心偏移量", "offset");
		_ForwardInput = AddValueInput<Int3>("朝向", "forward");
		_TargetRoleTypeInput = AddValueInput<RoleType>("目标类型", "targetType");
		_RangeTypeInput = AddValueInput<RangeType>("范围类型", "rangeType");
		_RadiusInput = AddValueInput<int>("半径(毫米)", "radius");
		_AngleInput = AddValueInput<int>("角度", "angle");
		_LengthInput = AddValueInput<int>("长(毫米)", "length");
		_WidthInput = AddValueInput<int>("宽(毫米)", "width");
		_HeightInput = AddValueInput<int>("高(毫米)", "height");
		_IgnoreIDInput = AddValueInput<int>("忽略实体ID", "ignoreID");
		ValueInput<HitHeight> heightInput = AddValueInput<HitHeight>("覆盖的高度标签").SetDefaultAndSerializedValue((HitHeight)(-1));
		_EntityID = 0;
		AddFlowInput("In", delegate(Flow f)
		{
			_EntityID = 0;
			List<int> list = FrameListPool<int>.Claim();
			if (CommonProcessor.TryGetCollisions(base.mSimContext, _RangeTypeInput.GetValue(), _CenterPosInput.GetValue(), _ForwardInput.GetValue(), _OffsetInput.GetValue(), _RadiusInput.GetValue(), _AngleInput.GetValue(), new Int3(_WidthInput.value, _HeightInput.value, _LengthInput.value), list, (uint)_TargetRoleTypeInput.value))
			{
				bool flag = list.Count > 0;
				int value = _IgnoreIDInput.value;
				for (int num = list.Count - 1; num >= 0; num--)
				{
					SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(list[num]);
					if (simEntityByMultiColliders == null)
					{
						list.RemoveAt(num);
					}
					else if (simEntityByMultiColliders.creationIndex == value)
					{
						list.RemoveAt(num);
					}
					else
					{
						HitHeight curHitHeight = ConfigProcessor.GetCurHitHeight(simEntityByMultiColliders);
						if (curHitHeight != HitHeight.None && !heightInput.value.HasFlag(curHitHeight))
						{
							list.RemoveAt(num);
						}
					}
				}
				if (list.Count == 0)
				{
					if (flag)
					{
						_IgnoreOut.Call(f);
					}
					else
					{
						_NothingOutput.Call(f);
					}
				}
				else
				{
					int index = (int)DRandom.Random((uint)list.Count);
					SimEntity simEntityByMultiColliders2 = CommonProcessor.GetSimEntityByMultiColliders(list[index]);
					_EntityID = simEntityByMultiColliders2.creationIndex;
					_Output.Call(f);
				}
			}
			FrameListPool<int>.Release(list);
		});
		AddValueOutput("结果", "entityID", () => _EntityID);
	}
}
