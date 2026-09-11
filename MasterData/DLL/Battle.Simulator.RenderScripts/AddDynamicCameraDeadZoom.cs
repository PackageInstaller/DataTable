using FlowCanvas;
using FlowCanvas.Nodes;
using ParadoxNotion.Design;
using UnityEngine;

[Name("添加动态调整死区脚本(FramingTransposer)(渲染)", 0)]
[Category("Render/UI")]
[Description("为body为FramingTransposer的相机添加根据摇杆上下幅度动态调整死区大小(上大下小，使用Mathf.Lerp做插值)")]
public class AddDynamicCameraDeadZoom : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		ValueInput<GameObject> goInput = AddValueInput<GameObject>("目标相机预制体");
		ValueInput<float> minInput = AddValueInput<float>("最低死区", "moveAreaRadius").SetDefaultAndSerializedValue(0f);
		ValueInput<float> maxInput = AddValueInput<float>("最高死区", "moveAreaDeadRadius").SetDefaultAndSerializedValue(2f);
		ValueInput<float> lerpInput = AddValueInput<float>("缓动参数", "moveAreaIndex").SetDefaultAndSerializedValue(0.5f);
		AddFlowInput("In", "input", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			GameObject value = goInput.value;
			if (battleScene == null || value == null)
			{
				error.Call(f);
			}
			else
			{
				GameObject battlePanelGameObject = battleScene.battlePanelGameObject;
				if (battlePanelGameObject == null)
				{
					error.Call(f);
				}
				else
				{
					BattleUI component = battlePanelGameObject.GetComponent<BattleUI>();
					if (component == null)
					{
						error.Call(f);
					}
					else
					{
						if (component.joystickController != null)
						{
							U3DUtil.Get<DynamicCameraDeadZoom>(value).Init(minInput.value, maxInput.value, lerpInput.value, component.joystickController);
						}
						output.Call(f);
					}
				}
			}
		});
	}
}
