using Cinemachine;
using FlowCanvas;
using ParadoxNotion.Design;
using UnityEngine;

[Name("设置第一人称模式(渲染)", 0)]
[Category("Render/Camera")]
[Description("更换第一人称模式")]
public class SetPovMoveMode : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		FlowOutput error = AddFlowOutput("Error");
		ValueInput<string> cameraPathInput = AddValueInput<string>("相机预制体路径").SetDefaultAndSerializedValue("Camera/CameraMode/POVModeCamera");
		ValueInput<string> cameraFollowPathInput = AddValueInput<string>("相机跟随点路径").SetDefaultAndSerializedValue("root/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Spine2/Bip001 Neck/Bip001 Head");
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
						AgentManager agentManager = AgentManager.GetAgentManager();
						if (agentManager == null)
						{
							error.Call(f);
						}
						else
						{
							NAgent playerAgent = agentManager.GetPlayerAgent();
							if (playerAgent == null)
							{
								error.Call(f);
							}
							else
							{
								if (component.joystickController != null)
								{
									component.joystickController.Init(Vector3.zero, 0f, new P08JoystickPOVMove());
								}
								if (component.cameraCtrl != null)
								{
									P08CameraPOVCtrlGameLogic p08CameraPOVCtrlGameLogic = new P08CameraPOVCtrlGameLogic();
									GameObject gameObject = Asset.InstantiateAutoUnloadWhileDestroy(cameraPathInput.value);
									if (gameObject != null)
									{
										CinemachineVirtualCamera component2 = gameObject.GetComponent<CinemachineVirtualCamera>();
										if (component2 == null)
										{
											error.Call(f);
											return;
										}
										component2.Follow = playerAgent.transform;
										string value = cameraFollowPathInput.value;
										if (!string.IsNullOrEmpty(value))
										{
											Transform transform = playerAgent.transform.Find(value);
											if (transform != null)
											{
												component2.Follow = transform;
											}
										}
										CinemachinePOV cinemachinePOV = component2.GetCinemachineComponent(CinemachineCore.Stage.Aim) as CinemachinePOV;
										if (cinemachinePOV == null)
										{
											error.Call(f);
											return;
										}
										cinemachinePOV.m_HorizontalAxis.Value = playerAgent.transform.rotation.eulerAngles.y;
										p08CameraPOVCtrlGameLogic.composer = cinemachinePOV;
										p08CameraPOVCtrlGameLogic.rotateY = playerAgent.transform.rotation.eulerAngles.y;
									}
									component.cameraCtrl.Init(p08CameraPOVCtrlGameLogic);
								}
								output.Call(f);
							}
						}
					}
				}
			}
		});
	}
}
