using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置自瞄射击相机朝向", 0)]
[Category("Render/UI")]
[Description("设置自瞄射击相机朝向,输入预制体是控制相机朝向的预制体,预制体上需要挂载AimCameraCtrl组件(脚本)")]
public class SetCameraForward : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<GameObject> touchGoInput = AddValueInput<GameObject>("相机控制预制体");
		ValueInput<Vector3> forwardInput = AddValueInput<Vector3>("目标朝向");
		FlowOutput outPut = AddFlowOutput("out");
		AddFlowInput("In", delegate(Flow f)
		{
			GameObject value = touchGoInput.value;
			if (value != null)
			{
				AimCameraCtrl component = value.GetComponent<AimCameraCtrl>();
				if (component != null)
				{
					component.SetCameraForward(forwardInput.value);
				}
			}
			outPut.Call(f);
		});
	}
}
