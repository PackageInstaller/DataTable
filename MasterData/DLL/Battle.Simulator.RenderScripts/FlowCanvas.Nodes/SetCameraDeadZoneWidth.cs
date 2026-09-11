using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置默认相机缓动宽度", 0)]
[Category("Render/Camera")]
[Description("设置默认相机缓动宽度")]
public class SetCameraDeadZoneWidth : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<float> valueInput = AddValueInput<float>("宽度");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			CameraParamComponent virtualCameraParam = (NScene.GetCurrentScene() as BattleScene).virtualCameraParam;
			CameraParam currentCameraParam = virtualCameraParam.GetCurrentCameraParam();
			currentCameraParam.softZoneWidth = valueInput.value;
			virtualCameraParam.SetCameraParam(currentCameraParam, 0.1f);
			Debug.Log("设置相机宽度");
			output.Call(f);
		});
	}
}
