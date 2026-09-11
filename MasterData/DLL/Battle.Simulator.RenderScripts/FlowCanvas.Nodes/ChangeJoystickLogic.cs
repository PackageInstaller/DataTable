using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("更换摇杆为十字键(渲染)", 0)]
[Category("Render/UI")]
[Description("将摇杆更换为十字键样式(本质还是摇杆)")]
public class ChangeJoystickLogic : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<string> assetPathInput = AddValueInput<string>("资源路径", "assetPath").SetDefaultAndSerializedValue("UI/DPad");
		ValueInput<En_DPadType> isEnDPadTypeInput = AddValueInput<En_DPadType>("十字键类型", "four").SetDefaultAndSerializedValue(En_DPadType.EightDirections);
		ValueInput<bool> hideOnLoad = AddValueInput<bool>("隐藏", "hideOnLoad").SetDefaultAndSerializedValue(v: true);
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
									component3.alpha = ((!hideOnLoad.value) ? 1 : 0);
									component.canvasGroupStick = component3;
								}
							}
						}
						component.joystickController.Init(Vector3.zero, 0f, new P08DPadControllerGameLogic(isEnDPadTypeInput.value));
						output.Call(f);
					}
				}
			}
		});
	}
}
