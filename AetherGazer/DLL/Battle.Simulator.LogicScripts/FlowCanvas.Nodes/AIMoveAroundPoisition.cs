using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI圆形移动指令(逻辑)", 0)]
[Category("Logic/AI")]
[Description("标准俯视角(上z正,右x正);\n正数顺时针,负数逆时针;\n内部从流中获取AI实体\n速度默认取 RoleConfig 表的 Speed;")]
public class AIMoveAroundPoisition : FlowControlNode
{
	private ValueInput<int> _CommandSetIDInput;

	private ValueInput<int> _ActionIDInput;

	private ValueInput<int> _TimeOutInput;

	private ValueInput<Int3> _CenterInput;

	private ValueInput<int> _RadiusInput;

	private ValueInput<int> _SpeedInput;

	private ValueInput<int> _DirectionInput;

	private ValueInput<bool> _StopInput;

	private FlowOutput _Out;

	protected override void RegisterPorts()
	{
		_CommandSetIDInput = AddValueInput<int>("指令集ID", "commandSetID");
		_ActionIDInput = AddValueInput<int>("指令ID", "commandID");
		_TimeOutInput = AddValueInput<int>("超时时间", "timeOut");
		_CenterInput = AddValueInput<Int3>("中心", "center");
		_RadiusInput = AddValueInput<int>("半径(毫米)", "radius");
		_DirectionInput = AddValueInput<int>("方向(1顺,-1逆)", "direction").SetDefaultAndSerializedValue(1);
		_SpeedInput = AddValueInput<int>("速度(毫米)(看备注)", "speed").SetDefaultAndSerializedValue(-1);
		_StopInput = AddValueInput<bool>("结束时是否停止").SetDefaultAndSerializedValue(v: true);
		_Out = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (((SimEntity)f.userData).entityAIThink.mAICommandSet.TryGetValue(_CommandSetIDInput.value, out var value))
			{
				AICommandSet aICommandSet = (AICommandSet)value;
				if (aICommandSet.mCommands == null)
				{
					aICommandSet.mCommands = new List<AICommand>();
				}
				aICommandSet.mCommands.Add(new AIMoveAroundPositionCommand
				{
					mParent = aICommandSet,
					mID = _ActionIDInput.value,
					mTimeout = _TimeOutInput.value,
					mCenter = _CenterInput.GetValue(),
					mRadius = _RadiusInput.GetValue(),
					mDirection = _DirectionInput.GetValue(),
					mSpeed = _SpeedInput.GetValue(),
					mStopWhenFinished = _StopInput.GetValue()
				});
				_Out.Call(f);
			}
		});
		AddValueOutput("指令集ID", "commandSetID", () => _CommandSetIDInput.GetValue());
		AddValueOutput("指令ID", () => _ActionIDInput.GetValue());
	}
}
