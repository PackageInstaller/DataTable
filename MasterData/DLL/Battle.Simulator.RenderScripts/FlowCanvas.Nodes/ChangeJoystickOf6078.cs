using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("更换6078定制摇杆(渲染)", 0)]
[Category("Render/UI")]
[Description("更换6078专属摇杆,本摇杆为夏日活动的6078使用,用于处理俯视角逻辑")]
public class ChangeJoystickOf6078 : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<string> assetPathInput = AddValueInput<string>("资源路径", "assetPath").SetDefaultAndSerializedValue("UI/DPadOf6078");
		ValueInput<bool> isOverlookInput = AddValueInput<bool>("俯视角", "isOverlook").SetDefaultAndSerializedValue(v: false);
		ValueInput<bool> sendStopInput = AddValueInput<bool>("发送停止命令", "sendStop").SetDefaultAndSerializedValue(v: false);
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
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
						GameObject gameObject = Asset.InstantiateWithoutCache(assetPathInput.value);
						if (gameObject != null)
						{
							gameObject.transform.SetParent(component.transform, worldPositionStays: false);
							P08JoystickController component2 = gameObject.GetComponent<P08JoystickController>();
							if (component2 != null)
							{
								if (component.joystickController != null)
								{
									component2.transform.localPosition = component.joystickController.transform.localPosition;
									component2.transform.localScale = component.joystickController.transform.localScale;
									component.joystickController.gameObject.SetActive(value: false);
								}
								component2.moveable = false;
								component2.lockJoystickMoveable = true;
								component.joystickController = component2;
								CanvasGroup component3 = component2.GetComponent<CanvasGroup>();
								if (component3 != null)
								{
									component3.alpha = 0f;
									component.canvasGroupStick = component3;
								}
							}
						}
						component.joystickController.Init(Vector3.zero, 0f, new P08DPadControllerOf6078(isOverlookInput.value, sendStopInput.value));
						output.Call(f);
					}
				}
			}
		});
	}
}
