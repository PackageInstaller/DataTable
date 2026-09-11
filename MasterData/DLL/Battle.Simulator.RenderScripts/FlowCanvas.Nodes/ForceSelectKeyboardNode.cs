using P08.Gamepad;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("强制设置键盘模式(渲染)", 0)]
[Category("Render/Control")]
[Description("强制设置纯键盘模式, 键鼠模式或清楚强制状态(图结束时会自动恢复)")]
[ExposeAsDefinition]
public class ForceSelectKeyboardNode : FlowControlNode
{
	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		GamepadManager.Instance?.ForceSelectKeyboard(En_GamepadType.None);
		Debug.Log("恢复键盘强制状态");
	}

	protected override void RegisterPorts()
	{
		FlowOutput flowOut = AddFlowOutput("Out");
		ValueInput<En_GamepadType> type = AddValueInput<En_GamepadType>("输入类型").SetDefaultAndSerializedValue(En_GamepadType.Keyboard);
		AddFlowInput("In", delegate(Flow f)
		{
			GamepadManager.Instance?.ForceSelectKeyboard(type.GetValue());
			Debug.Log($"强制键盘模式为{type.GetValue()}");
			flowOut.Call(f);
		});
	}
}
