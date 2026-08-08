using System;
using System.Collections.Generic;
using Packages.BattleSimulator.Simulator.SimulatorUI;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("激活自瞄射击按钮", 0)]
[Category("Render/UI")]
[Description("激活自瞄射击按钮,预制体上需要挂载QTEAimShootWithListScript组件(脚本)")]
public class LockShootUI : FlowNode
{
	private GameObject ShootGo;

	private GameObject CancelGo;

	private GameObject LockAreaGo;

	private GameObject CameraGo;

	private GameObject TouchGo;

	private int entityID;

	private Vector3 cameraForward;

	private FlowOutput StartAimOut;

	private FlowOutput EndAimOut;

	private FlowOutput EndLockOut;

	private FlowOutput ShootOut;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		ValueInput<string> QTEPathInput = AddValueInput<string>("射击按键预制体路径");
		ValueInput<string> QTECancelPathInput = AddValueInput<string>("取消按键预制体路径");
		ValueInput<string> QTELockAreaPathInput = AddValueInput<string>("锁定区域预制体路径");
		ValueInput<string> QTEOnPathInput = AddValueInput<string>("挂载路径").SetDefaultAndSerializedValue("UICamera/Canvas/UIMain/BattlePanel");
		ValueInput<string> QTELockPathInput = AddValueInput<string>("锁定面板挂载路径").SetDefaultAndSerializedValue("UICamera/Canvas/UIMain/BattlePanel");
		ValueInput<float> QTELockAreaSizeInput = AddValueInput<float>("自瞄区域百分比(直径占屏幕宽度百分比)").SetDefaultAndSerializedValue(0.5f);
		ValueInput<float> QTEAimTimeInput = AddValueInput<float>("瞄准时间").SetDefaultAndSerializedValue(10f);
		ValueInput<int> QTEAimMaxInput = AddValueInput<int>("最大瞄准个数").SetDefaultAndSerializedValue(3);
		ValueInput<int> QTEAimShootCountInput = AddValueInput<int>("瞄准射击次数").SetDefaultAndSerializedValue(2);
		ValueInput<bool> QTEAimShootEndInput = AddValueInput<bool>("射击次数清空后是否自动退出瞄准状态").SetDefaultAndSerializedValue(v: true);
		ValueInput<float> QTEAimShootMaxDisInput = AddValueInput<float>("最大瞄准距离").SetDefaultAndSerializedValue(10f);
		ValueInput<string> EffectPathInput = AddValueInput<string>("锁定特效");
		ValueInput<string> QTELockCameraPathInput = AddValueInput<string>("相机预制体路径");
		ValueInput<Vector3> QTELockCameraPositionInput = AddValueInput<Vector3>("相机位置");
		ValueInput<Vector3> QTELockCameraForwardInput = AddValueInput<Vector3>("相机朝向");
		ValueInput<string> QTELockCameraTouchPathInput = AddValueInput<string>("相机触摸预制体路径");
		ValueInput<string> QTELockCameraOnPathInput = AddValueInput<string>("相机触摸面板挂载路径").SetDefaultAndSerializedValue("UICamera/Canvas/UIMain/BattlePanel");
		ValueInput<float> QTELockUpDownAngleInput = AddValueInput<float>("上下角度限制").SetDefaultAndSerializedValue(30f);
		ValueInput<float> QTELockLeftRightAngleInput = AddValueInput<float>("左右角度限制").SetDefaultAndSerializedValue(60f);
		ValueInput<GameObject> barbetteGoInput = AddValueInput<GameObject>("炮台预制体");
		ValueInput<string> barbetteXControllerInput = AddValueInput<string>("控制炮台上下转物件的路径");
		ValueInput<int> barbetteXAixsInput = AddValueInput<int>("上下转轴向(x-0,y-1,z-2)");
		ValueInput<bool> barbetteXAixsReverse = AddValueInput<bool>("上下旋转是否反向");
		ValueInput<string> barbetteYControllerInput = AddValueInput<string>("控制炮台左右转物件的路径");
		ValueInput<int> barbetteYAixsInput = AddValueInput<int>("左右转轴向(x-0,y-1,z-2)");
		ValueInput<bool> barbetteYAixsReverse = AddValueInput<bool>("左右旋转是否反向");
		ValueInput<float> pressTimeInput = AddValueInput<float>("长按射击间隔(小于0不启用)").SetDefaultAndSerializedValue(-1f);
		FlowOutput Output = AddFlowOutput("开始瞄准");
		StartAimOut = AddFlowOutput("开始锁定");
		EndAimOut = AddFlowOutput("结束锁定");
		EndLockOut = AddFlowOutput("结束瞄准");
		ShootOut = AddFlowOutput("射击事件");
		FlowOutput falseOut = AddFlowOutput("错误");
		AddValueOutput("相机预制体", () => CameraGo);
		AddValueOutput("开始/结束锁定实体", () => entityID);
		AddValueOutput("相机朝向", () => (!CameraGo) ? Vector3.forward : CameraGo.transform.forward);
		AddValueOutput("相机控制预制体", () => TouchGo);
		AddFlowInput("激活", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.battlePanelGameObject == null)
			{
				falseOut.Call(f);
			}
			else
			{
				if (CameraGo == null)
				{
					CameraGo = Asset.Instantiate(QTELockCameraPathInput.value);
				}
				else
				{
					CameraGo.SetActive(value: true);
				}
				if (TouchGo == null)
				{
					GameObject gameObject = GameObject.Find(QTELockCameraOnPathInput.value);
					TouchGo = Asset.InstantiateWithoutCache(QTELockCameraTouchPathInput.value, gameObject.transform);
				}
				else
				{
					TouchGo.SetActive(value: true);
				}
				if (ShootGo == null)
				{
					GameObject gameObject2 = GameObject.Find(QTEOnPathInput.value);
					ShootGo = Asset.InstantiateWithoutCache(QTEPathInput.value, gameObject2.transform);
				}
				else
				{
					ShootGo.SetActive(value: true);
				}
				if (CancelGo == null)
				{
					if (!string.IsNullOrEmpty(QTECancelPathInput.value))
					{
						GameObject gameObject3 = GameObject.Find(QTEOnPathInput.value);
						CancelGo = Asset.InstantiateWithoutCache(QTECancelPathInput.value, gameObject3.transform);
					}
				}
				else
				{
					CancelGo.SetActive(value: true);
				}
				CameraGo.transform.SetPosition(QTELockCameraPositionInput.value);
				CameraGo.transform.forward = QTELockCameraForwardInput.value;
				if (LockAreaGo == null)
				{
					GameObject gameObject4 = GameObject.Find(QTELockPathInput.value);
					LockAreaGo = Asset.InstantiateWithoutCache(QTELockAreaPathInput.value, gameObject4.transform);
				}
				else
				{
					LockAreaGo.SetActive(value: true);
				}
				(LockAreaGo.transform as RectTransform).sizeDelta = new Vector2((float)Screen.width * QTELockAreaSizeInput.value * 2f, (float)Screen.width * QTELockAreaSizeInput.value * 2f);
				GameObject value = barbetteGoInput.value;
				Transform upDownGo = null;
				Transform leftRightGo = null;
				if (value != null)
				{
					upDownGo = value.transform.Find(barbetteXControllerInput.value);
					leftRightGo = value.transform.Find(barbetteYControllerInput.value);
				}
				BattleScene battleScene2 = NScene.GetCurrentScene() as BattleScene;
				if (battleScene2 != null)
				{
					GameObject battlePanelGameObject = battleScene2.battlePanelGameObject;
					if (battlePanelGameObject != null)
					{
						BattleUI component = battlePanelGameObject.GetComponent<BattleUI>();
						if (component != null)
						{
							component.joystickController.Init(Vector3.zero, 0f, new P08JoystickWithRotateCamera(TouchGo.GetComponent<AimCameraCtrl>()));
							component.joystickController.SetBanInput(value: false);
						}
					}
				}
				TouchGo.GetComponent<AimCameraCtrl>().Init(CameraGo.transform, QTELockLeftRightAngleInput.value, QTELockUpDownAngleInput.value, leftRightGo, upDownGo, barbetteYAixsInput.value, barbetteXAixsInput.value, barbetteYAixsReverse.value, barbetteXAixsReverse.value);
				QTEAimShootWithListScript component2 = ShootGo.GetComponent<QTEAimShootWithListScript>();
				component2.Init(QTEAimTimeInput.value, QTEAimMaxInput.value, QTEAimShootCountInput.value, QTELockAreaSizeInput.value, QTEAimShootMaxDisInput.value, EffectPathInput.value, QTEAimShootEndInput.value, pressTimeInput.value);
				component2.mAddAimTargetEvent = (Action<int>)Delegate.Combine(component2.mAddAimTargetEvent, new Action<int>(OnAimAdd));
				component2.mRemoveAimTargetEvent = (Action<int>)Delegate.Combine(component2.mRemoveAimTargetEvent, new Action<int>(OnAimRemove));
				component2.mEndAimEvent = (Action)Delegate.Combine(component2.mEndAimEvent, new Action(OnEndAim));
				component2.mShootEvent = (Action)Delegate.Combine(component2.mShootEvent, new Action(OnShoot));
				if (CancelGo != null)
				{
					CancelGo.GetComponent<QTEAimShootCancelButton>().LockScript = component2;
				}
				Output.Call(f);
			}
		});
		AddFlowInput("隐藏", delegate(Flow f)
		{
			if (ShootGo != null)
			{
				ShootGo.SetActive(value: false);
				QTEAimShootWithListScript component = ShootGo.GetComponent<QTEAimShootWithListScript>();
				component.EndShoot();
				component.mAddAimTargetEvent = (Action<int>)Delegate.Remove(component.mAddAimTargetEvent, new Action<int>(OnAimAdd));
				component.mRemoveAimTargetEvent = (Action<int>)Delegate.Remove(component.mRemoveAimTargetEvent, new Action<int>(OnAimRemove));
				component.mEndAimEvent = (Action)Delegate.Remove(component.mEndAimEvent, new Action(OnEndAim));
				component.mShootEvent = (Action)Delegate.Remove(component.mShootEvent, new Action(OnShoot));
				EndProcess();
				EndLockOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
		AddFlowInput("关闭锁定特效", delegate
		{
			if (ShootGo != null)
			{
				ShootGo.GetComponent<QTEAimShootWithListScript>().mStopLock = true;
			}
		});
		AddFlowInput("开启锁定特效", delegate
		{
			if (ShootGo != null)
			{
				ShootGo.GetComponent<QTEAimShootWithListScript>().mStopLock = false;
			}
		});
		AddFlowInput("禁用输入", delegate(Flow f)
		{
			if (ShootGo == null || TouchGo == null)
			{
				falseOut.Call(f);
			}
			ShootGo.GetComponent<QTEAimShootWithListScript>().banInput = true;
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null)
			{
				GameObject battlePanelGameObject = battleScene.battlePanelGameObject;
				if (battlePanelGameObject != null)
				{
					BattleUI component = battlePanelGameObject.GetComponent<BattleUI>();
					if (component != null)
					{
						component.joystickController.SetBanInput(value: true);
					}
				}
			}
			TouchGo.GetComponent<AimCameraCtrl>().SetBanInput(banInput: true);
		});
		AddFlowInput("启用输入", delegate(Flow f)
		{
			if (ShootGo == null || TouchGo == null)
			{
				falseOut.Call(f);
			}
			ShootGo.GetComponent<QTEAimShootWithListScript>().banInput = false;
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null)
			{
				GameObject battlePanelGameObject = battleScene.battlePanelGameObject;
				if (battlePanelGameObject != null)
				{
					BattleUI component = battlePanelGameObject.GetComponent<BattleUI>();
					if (component != null)
					{
						component.joystickController.SetBanInput(value: false);
					}
				}
			}
			TouchGo.GetComponent<AimCameraCtrl>().SetBanInput(banInput: false);
		});
	}

	private void OnAimAdd(int entityID)
	{
		this.entityID = entityID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		StartAimOut.Call(f);
	}

	private void OnAimRemove(int entityID)
	{
		this.entityID = entityID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		EndAimOut.Call(f);
	}

	private void OnEndAim()
	{
		EndProcess();
		Flow f = new Flow
		{
			returnData = returnData
		};
		EndLockOut.Call(f);
	}

	private void OnShoot()
	{
		Flow f = new Flow
		{
			returnData = returnData
		};
		ShootOut.Call(f);
	}

	private void EndProcess()
	{
		ShootGo?.SetActive(value: false);
		CancelGo?.SetActive(value: false);
		LockAreaGo?.SetActive(value: false);
		CancelGo?.SetActive(value: false);
		TouchGo?.SetActive(value: false);
		CameraGo?.SetActive(value: false);
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (!(battleScene != null))
		{
			return;
		}
		GameObject battlePanelGameObject = battleScene.battlePanelGameObject;
		if (battlePanelGameObject != null)
		{
			BattleUI component = battlePanelGameObject.GetComponent<BattleUI>();
			if (component != null)
			{
				component.joystickController.Init(Vector3.zero, 0f, new P08StickControllerGameLogic());
				component.joystickController.SetBanInput(value: false);
			}
		}
	}
}
