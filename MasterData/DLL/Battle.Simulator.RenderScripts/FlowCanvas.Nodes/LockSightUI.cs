using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("激活可换枪射击按钮", 0)]
[Category("Render/UI")]
[Description("激活自瞄射击按钮,预制体上需要挂载QTEAimShootWithListScript组件(脚本)")]
public class LockSightUI : FlowNode
{
	private GameObject ShootGo;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		ValueInput<string> QTEPathInput = AddValueInput<string>("射击按键预制体路径");
		ValueInput<List<string>> LockSightPathInput = AddValueInput<List<string>>("锁定图标");
		ValueInput<List<string>> UnLockSightPathInput = AddValueInput<List<string>>("非锁定图标");
		ValueInput<List<string>> LockSightGlassInPathInput = AddValueInput<List<string>>("进入锁定放大镜资源");
		ValueInput<List<string>> LockSightGlassOutPathInput = AddValueInput<List<string>>("退出锁定放大镜资源");
		ValueInput<string> BulletCountPathInput = AddValueInput<string>("子弹剩余数资源");
		ValueInput<float> LockSightDisInput = AddValueInput<float>("瞄准镜距离相机距离").SetDefaultAndSerializedValue(20f);
		ValueInput<string> QTEOnPathInput = AddValueInput<string>("挂载路径").SetDefaultAndSerializedValue("UICamera/Canvas/UIMain/BattlePanel");
		ValueInput<float> QTELockAreaSizeInput = AddValueInput<float>("自瞄区域百分比(直径占屏幕宽度百分比)").SetDefaultAndSerializedValue(0.5f);
		ValueInput<float> QTEAimTimeInput = AddValueInput<float>("瞄准时间").SetDefaultAndSerializedValue(10f);
		ValueInput<int> QTEAimMaxInput = AddValueInput<int>("最大瞄准个数").SetDefaultAndSerializedValue(3);
		ValueInput<int> LockSightChangeIndexInput = AddValueInput<int>("切换武器索引");
		ValueInput<int> BulletCountInput = AddValueInput<int>("剩余子弹数");
		ValueInput<int> ChargePercentInput = AddValueInput<int>("充能进度(千分比)");
		ValueInput<float> QTEAimToShootTimeInput = AddValueInput<float>("瞄准射击时间").SetDefaultAndSerializedValue(2f);
		ValueInput<bool> QTEAimShootEndInput = AddValueInput<bool>("退出瞄准状态是否射击").SetDefaultAndSerializedValue(v: true);
		ValueInput<string> EffectPathInput = AddValueInput<string>("锁定特效");
		ValueInput<Transform> QTECameraInput = AddValueInput<Transform>("瞄准相机");
		ValueInput<float> QTELockUpDownAngleInput = AddValueInput<float>("相机上下角度限制").SetDefaultAndSerializedValue(30f);
		ValueInput<float> QTELockLeftRightAngleInput = AddValueInput<float>("相机左右角度限制").SetDefaultAndSerializedValue(60f);
		ValueInput<float> QTELockUpSizeInput = AddValueInput<float>("锁定框上边缘限制").SetDefaultAndSerializedValue(0.3f);
		ValueInput<float> QTELockDownSizeInput = AddValueInput<float>("锁定框下边缘限制").SetDefaultAndSerializedValue(0.2f);
		ValueInput<float> QTELockLeftSizeInput = AddValueInput<float>("锁定框左边缘限制").SetDefaultAndSerializedValue(0.5f);
		ValueInput<float> QTELockRightSizeInput = AddValueInput<float>("锁定框右边缘限制").SetDefaultAndSerializedValue(0.5f);
		FlowOutput Output = AddFlowOutput("out");
		FlowOutput falseOut = AddFlowOutput("错误");
		AddFlowInput("初始化", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.battlePanelGameObject == null)
			{
				falseOut.Call(f);
			}
			else
			{
				if (ShootGo == null)
				{
					GameObject gameObject = GameObject.Find(QTEOnPathInput.value);
					ShootGo = Asset.InstantiateWithoutCache(QTEPathInput.value, gameObject.transform);
					ShootGo.GetComponent<QTEChangeWeaponShootScript>().Init(QTEAimTimeInput.value, QTEAimMaxInput.value, 20, QTEAimToShootTimeInput.value, QTELockAreaSizeInput.value, EffectPathInput.value, QTEAimShootEndInput.value, LockSightDisInput.value, QTECameraInput.value, QTELockLeftRightAngleInput.value, QTELockUpDownAngleInput.value, LockSightPathInput.value, UnLockSightPathInput.value, LockSightGlassInPathInput.value, LockSightGlassOutPathInput.value, BulletCountPathInput.value, QTELockUpSizeInput.value, QTELockDownSizeInput.value, QTELockLeftSizeInput.value, QTELockRightSizeInput.value);
				}
				Output.Call(f);
			}
		});
		AddFlowInput("切换武器", delegate(Flow f)
		{
			if (ShootGo != null)
			{
				ShootGo.GetComponent<QTEChangeWeaponShootScript>().SetSightIndex(LockSightChangeIndexInput.value, QTEAimMaxInput.value, QTEAimToShootTimeInput.value, BulletCountInput.value, QTEAimShootEndInput.value);
				Output.Call(f);
			}
		});
		AddFlowInput("开始瞄准", delegate(Flow f)
		{
			if (ShootGo != null)
			{
				ShootGo.GetComponent<QTEChangeWeaponShootScript>().ChangeSightType(IsInSight: true);
				Output.Call(f);
			}
		});
		AddFlowInput("隐藏瞄准", delegate(Flow f)
		{
			if (ShootGo != null)
			{
				ShootGo.GetComponent<QTEChangeWeaponShootScript>().ChangeSightType(IsInSight: false);
				Output.Call(f);
			}
		});
		AddFlowInput("修改子弹数", delegate(Flow f)
		{
			if (ShootGo != null)
			{
				ShootGo.GetComponent<QTEChangeWeaponShootScript>().ChangeShootCount(BulletCountInput.value);
				Output.Call(f);
			}
		});
		AddFlowInput("修改充能条", delegate(Flow f)
		{
			if (ShootGo != null)
			{
				ShootGo.GetComponent<QTEChangeWeaponShootScript>().ChangeChargePercent(ChargePercentInput.value);
				Output.Call(f);
			}
		});
	}
}
