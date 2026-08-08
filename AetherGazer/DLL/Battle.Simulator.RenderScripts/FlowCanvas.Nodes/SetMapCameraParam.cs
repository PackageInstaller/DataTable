using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置相机参数", 0)]
[Category("Render/Camera")]
[Description("设置未锁定状态的相机参数")]
public class SetMapCameraParam : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<bool> isAlwaysLock = AddValueInput<bool>("禁用手动调整相机");
		ValueInput<bool> heightEnable = AddValueInput<bool>("高度是否生效");
		ValueInput<float> heightInput = AddValueInput<float>("高度").SetDefaultAndSerializedValue(3f);
		ValueInput<bool> radiusEnable = AddValueInput<bool>("环绕半径是否生效");
		ValueInput<float> radiusInput = AddValueInput<float>("环绕半径").SetDefaultAndSerializedValue(8f);
		ValueInput<bool> minHeightEnable = AddValueInput<bool>("最低高度(minHeightDefault)是否生效");
		ValueInput<float> minHeightInput = AddValueInput<float>("相机最低高度").SetDefaultAndSerializedValue(1f);
		ValueInput<bool> maxHeightEnable = AddValueInput<bool>("最高高度(maxHeightDefault)是否生效");
		ValueInput<float> maxHeightInput = AddValueInput<float>("相机最高高度").SetDefaultAndSerializedValue(6f);
		ValueInput<bool> minRadiusEnable = AddValueInput<bool>("最低环绕半径(minRadiusDefault)是否生效");
		ValueInput<float> minRadiusInput = AddValueInput<float>("相机最低环绕半径").SetDefaultAndSerializedValue(13f);
		ValueInput<bool> maxRadiusEnable = AddValueInput<bool>("最高环绕半径(maxRadiusDefault)是否生效");
		ValueInput<float> maxRadiusInput = AddValueInput<float>("相机最高环绕半径").SetDefaultAndSerializedValue(19f);
		ValueInput<bool> SoftZoneDefaultXEnable = AddValueInput<bool>("缓动框宽度是否生效");
		ValueInput<float> SoftZoneDefaultXInput = AddValueInput<float>("缓动框宽度(X)").SetDefaultAndSerializedValue(0.1463052f);
		ValueInput<bool> DeadZoneHeightXEnable = AddValueInput<bool>("缓动框宽度死区是否生效");
		ValueInput<float> DeadZoneHeightXInput = AddValueInput<float>("缓动框宽度死区(X)").SetDefaultAndSerializedValue(0.07126439f);
		ValueInput<bool> SoftZoneDefaultYEnable = AddValueInput<bool>("缓动框高度是否生效");
		ValueInput<float> SoftZoneDefaultYInput = AddValueInput<float>("缓动框高度(Y)").SetDefaultAndSerializedValue(0f);
		ValueInput<bool> DeadZoneHeightYEnable = AddValueInput<bool>("缓动框高度死区是否生效");
		ValueInput<float> DeadZoneHeightYInput = AddValueInput<float>("缓动框高度死区(Y)").SetDefaultAndSerializedValue(0f);
		ValueInput<bool> ScreenYEnable = AddValueInput<bool>("镜头注视高度是否生效");
		ValueInput<float> ScreenYDefaultInput = AddValueInput<float>("镜头注视高度(ScreenY)").SetDefaultAndSerializedValue(0.55f);
		ValueInput<bool> BiasXEnable = AddValueInput<bool>("BiasX是否生效");
		ValueInput<float> BiasXInput = AddValueInput<float>("BiasX").SetDefaultAndSerializedValue(0f);
		ValueInput<bool> BiasYEnable = AddValueInput<bool>("BiasY是否生效");
		ValueInput<float> BiasYInput = AddValueInput<float>("BiasY").SetDefaultAndSerializedValue(0f);
		ValueInput<bool> horizontalDampingEnable = AddValueInput<bool>("水平阻尼是否生效");
		ValueInput<float> horizontalDampingInput = AddValueInput<float>("水平阻尼").SetDefaultAndSerializedValue(12f);
		ValueInput<bool> verticalDampingEnable = AddValueInput<bool>("垂直阻尼是否生效");
		ValueInput<float> verticalDampingInput = AddValueInput<float>("垂直阻尼").SetDefaultAndSerializedValue(10f);
		FlowOutput output = AddFlowOutput("out");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			LockTargetCinemachine lockTargetCinemachine = (NScene.GetCurrentScene() as BattleScene).virtualCameraParam.lockTargetCinemachine;
			if (lockTargetCinemachine == null)
			{
				errorOut.Call(f);
			}
			else
			{
				P08BattleUICameraCtrl component = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject.transform.Find("ScreenAdjustContainer/FunctionButtons/CameraCtrl").GetComponent<P08BattleUICameraCtrl>();
				if (component != null)
				{
					component.enabled = !isAlwaysLock.value;
					component.ShowInputNotice(component.enabled);
				}
				if (heightEnable.value)
				{
					lockTargetCinemachine.curHeight = heightInput.value;
					lockTargetCinemachine.heightDefault = heightInput.value;
				}
				if (radiusEnable.value)
				{
					lockTargetCinemachine.curRadius = radiusInput.value;
					lockTargetCinemachine.radiusDefault = radiusInput.value;
				}
				if (minHeightEnable.value)
				{
					lockTargetCinemachine.minHeightDefault = minHeightInput.value;
				}
				if (maxHeightEnable.value)
				{
					lockTargetCinemachine.maxHeightDefault = maxHeightInput.value;
				}
				if (minRadiusEnable.value)
				{
					lockTargetCinemachine.minRadiusDefault = minRadiusInput.value;
				}
				if (maxRadiusEnable.value)
				{
					lockTargetCinemachine.maxRadiusDefault = maxRadiusInput.value;
				}
				if (SoftZoneDefaultXEnable.value)
				{
					lockTargetCinemachine.softZoneDefault = SoftZoneDefaultXInput.value;
				}
				if (DeadZoneHeightXEnable.value)
				{
					lockTargetCinemachine.deadZoneDefault = DeadZoneHeightXInput.value;
				}
				if (SoftZoneDefaultYEnable.value)
				{
					lockTargetCinemachine.softYZoneDefault = SoftZoneDefaultYInput.value;
				}
				if (DeadZoneHeightYEnable.value)
				{
					lockTargetCinemachine.deadYZoneDefault = DeadZoneHeightYInput.value;
				}
				if (ScreenYEnable.value)
				{
					lockTargetCinemachine.screenYDefault = ScreenYDefaultInput.value;
				}
				if (BiasXEnable.value)
				{
					lockTargetCinemachine.biasXDefault = BiasXInput.value;
				}
				if (BiasYEnable.value)
				{
					lockTargetCinemachine.biasYDefault = BiasYInput.value;
				}
				if (horizontalDampingEnable.value)
				{
					lockTargetCinemachine.horizontalDamping = horizontalDampingInput.value;
				}
				if (verticalDampingEnable.value)
				{
					lockTargetCinemachine.verticalDamping = verticalDampingInput.value;
				}
				lockTargetCinemachine.ApplyCameraParam();
				output.Call(f);
			}
		});
	}
}
