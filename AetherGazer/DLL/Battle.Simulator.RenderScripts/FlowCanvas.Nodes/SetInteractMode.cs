using Cinemachine;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置交互模式UI", 0)]
[Category("Render/Camera")]
[Description("设置交互模式, ui会直接挂在战斗面板下面, 可以调节点关闭, 也可以在ui里关闭")]
public class SetInteractMode : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<string> uiPathInput = AddValueInput<string>("UI路径").SetDefaultAndSerializedValue("UI/BattlePanelVariant/BattlePanel_Camera_Interact");
		ValueInput<string> uiInstInput = AddValueInput<string>("UI实例名").SetDefaultAndSerializedValue("BattlePanel_Camera_Interact");
		ValueInput<GameObject> gameObjectInput = AddValueInput<GameObject>("初始相机");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("error");
		FlowOutput closeOut = AddFlowOutput("关闭行为");
		FlowOutput startScanOut = AddFlowOutput("开始扫描");
		FlowOutput finishScanOut = AddFlowOutput("扫描结束");
		AddFlowInput("开", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.battlePanelGameObject == null)
			{
				errorOut.Call(f);
			}
			else
			{
				Transform transform = battleScene.battlePanelGameObject.transform;
				Transform uiTrans = transform.Find(uiInstInput.value);
				if (uiTrans == null)
				{
					GameObject gameObject = Asset.InstantiateWithoutCache(uiPathInput.value, transform.transform);
					if (gameObject != null)
					{
						gameObject.name = uiInstInput.value;
						uiTrans = gameObject.transform;
					}
				}
				if (uiTrans == null)
				{
					errorOut.Call(f);
				}
				else
				{
					CameraInteractUI com = uiTrans.GetComponent(typeof(CameraInteractUI)) as CameraInteractUI;
					if (com == null)
					{
						errorOut.Call(f);
					}
					else
					{
						GameObject value = gameObjectInput.value;
						if (value == null)
						{
							errorOut.Call(f);
						}
						else
						{
							CameraInteractItem cameraInteractItem = value.GetComponent(typeof(CameraInteractItem)) as CameraInteractItem;
							if (cameraInteractItem == null || cameraInteractItem.virtualCamera == null)
							{
								errorOut.Call(f);
							}
							else
							{
								CinemachinePOV cinemachinePOV = cameraInteractItem.virtualCamera.GetCinemachineComponent(CinemachineCore.Stage.Aim) as CinemachinePOV;
								if (cinemachinePOV == null)
								{
									errorOut.Call(f);
								}
								else
								{
									com.Composer = cinemachinePOV;
									if (!uiTrans.gameObject.activeSelf)
									{
										uiTrans.gameObject.SetActive(value: true);
									}
									else
									{
										com.OnEnable();
									}
									if (com.exitButton != null)
									{
										com.exitButton.RemoveAllListener();
										com.exitButton.AddListener(delegate
										{
											com.exitButton.RemoveAllListener();
											if (uiTrans != null)
											{
												uiTrans.gameObject.SetActive(value: false);
											}
											closeOut.Call(f);
										});
									}
									com.SetScanAction(f, startScanOut, finishScanOut, delegate(Flow flow, FlowOutput port)
									{
										flow.Call(port);
									}, delegate(Flow flow, FlowOutput port)
									{
										flow.Call(port);
									});
									output.Call(f);
								}
							}
						}
					}
				}
			}
		});
		AddFlowInput("关", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.battlePanelGameObject == null)
			{
				errorOut.Call(f);
			}
			else
			{
				Transform transform = battleScene.battlePanelGameObject.transform.Find(uiInstInput.value);
				if (transform != null)
				{
					transform.gameObject.SetActive(value: false);
				}
				closeOut.Call(f);
			}
		});
	}
}
