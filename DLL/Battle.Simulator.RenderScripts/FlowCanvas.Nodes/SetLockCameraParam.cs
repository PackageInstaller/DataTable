using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置锁定相机参数", 0)]
[Category("Render/Camera")]
[Description("设置相机参数")]
public class SetLockCameraParam : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<bool> lockTimeEnable = AddValueInput<bool>("锁定时间是否生效");
		ValueInput<float> lockTime = AddValueInput<float>("锁定时间").SetDefaultAndSerializedValue(5f);
		ValueInput<bool> radiusEnable = AddValueInput<bool>("锁定环绕半径是否生效");
		ValueInput<float> radiusInput = AddValueInput<float>("锁定环绕半径").SetDefaultAndSerializedValue(17.8f);
		ValueInput<bool> heightEnable = AddValueInput<bool>("锁定高度是否生效");
		ValueInput<float> heightInput = AddValueInput<float>("锁定高度").SetDefaultAndSerializedValue(2f);
		ValueInput<bool> LockSoftZoneDefaultXEnable = AddValueInput<bool>("锁定缓动框宽度是否生效");
		ValueInput<float> LockSoftZoneDefaultXInput = AddValueInput<float>("锁定缓动框宽度(X)").SetDefaultAndSerializedValue(0.016f);
		ValueInput<bool> LockDeadZoneHeightXEnable = AddValueInput<bool>("锁定缓动框宽度死区是否生效");
		ValueInput<float> LockDeadZoneHeightXInput = AddValueInput<float>("锁定缓动框宽度死区(X)").SetDefaultAndSerializedValue(0.016f);
		ValueInput<bool> LockSoftZoneDefaultYEnable = AddValueInput<bool>("锁定缓动框高度是否生效");
		ValueInput<float> LockSoftZoneDefaultYInput = AddValueInput<float>("锁定缓动框高度(Y)").SetDefaultAndSerializedValue(0f);
		ValueInput<bool> LockDeadZoneHeightYEnable = AddValueInput<bool>("锁定缓动框高度死区是否生效");
		ValueInput<float> LockDeadZoneHeightYInput = AddValueInput<float>("锁定缓动框高度死区(Y)").SetDefaultAndSerializedValue(0f);
		ValueInput<bool> LockScreenYEnable = AddValueInput<bool>("锁定镜头注视高度是否生效");
		ValueInput<float> LockScreenYDefaultInput = AddValueInput<float>("锁定镜头注视高度(Y)").SetDefaultAndSerializedValue(0.45f);
		ValueInput<bool> BiasXEnable = AddValueInput<bool>("BiasX是否生效");
		ValueInput<float> BiasXInput = AddValueInput<float>("BiasX").SetDefaultAndSerializedValue(0f);
		ValueInput<bool> BiasYEnable = AddValueInput<bool>("BiasY是否生效");
		ValueInput<float> BiasYInput = AddValueInput<float>("BiasY").SetDefaultAndSerializedValue(0f);
		ValueInput<bool> horizontalDampingEnable = AddValueInput<bool>("水平阻尼是否生效");
		ValueInput<float> horizontalDampingInput = AddValueInput<float>("水平阻尼").SetDefaultAndSerializedValue(12f);
		ValueInput<bool> verticalDampingEnable = AddValueInput<bool>("垂直阻尼是否生效");
		ValueInput<float> verticalDampingInput = AddValueInput<float>("垂直阻尼").SetDefaultAndSerializedValue(10f);
		ValueInput<bool> ChangeDistanceEnable = AddValueInput<bool>("ChangeDistance是否生效");
		ValueInput<float> ChangeDistanceInput = AddValueInput<float>("ChangeDistance").SetDefaultAndSerializedValue(8f);
		ValueInput<bool> FarMaxAngelEnable = AddValueInput<bool>("FarMaxAngel是否生效");
		ValueInput<float> FarMaxAngelInput = AddValueInput<float>("FarMaxAngel").SetDefaultAndSerializedValue(20f);
		ValueInput<bool> NearMaxAngelEnable = AddValueInput<bool>("NearMaxAngel是否生效");
		ValueInput<float> NearMaxAngelInput = AddValueInput<float>("NearMaxAngel").SetDefaultAndSerializedValue(150f);
		ValueInput<bool> DampingEnable = AddValueInput<bool>("Damping是否生效");
		ValueInput<float> DampingInput = AddValueInput<float>("Damping").SetDefaultAndSerializedValue(1.5f);
		ValueInput<bool> StartHeightEnable = AddValueInput<bool>("StartHeight是否生效");
		ValueInput<float> StartHeightInput = AddValueInput<float>("StartHeight").SetDefaultAndSerializedValue(5f);
		ValueInput<bool> MinHeightEnable = AddValueInput<bool>("MinHeight是否生效");
		ValueInput<float> MinHeightInput = AddValueInput<float>("MinHeight").SetDefaultAndSerializedValue(0.5f);
		ValueInput<bool> LookatDisWithFollowEnable = AddValueInput<bool>("LookatDisWithFollow是否生效");
		ValueInput<float> LookatDisWithFollowInput = AddValueInput<float>("LookatDisWithFollow").SetDefaultAndSerializedValue(5f);
		ValueInput<bool> LookatDampingEnable = AddValueInput<bool>("LookatDamping是否生效");
		ValueInput<float> LookatDampingInput = AddValueInput<float>("LookatDamping").SetDefaultAndSerializedValue(0.4f);
		ValueInput<bool> dirtyInput = AddValueInput<bool>("覆盖锁定表参数");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("", delegate(Flow f)
		{
			LockTargetCinemachine lockTargetCinemachine = (NScene.GetCurrentScene() as BattleScene).virtualCameraParam.lockTargetCinemachine;
			if (lockTargetCinemachine == null)
			{
				errorOut.Call(f);
			}
			else
			{
				if (lockTimeEnable.value)
				{
					lockTargetCinemachine.lockTime = lockTime.value;
				}
				if (radiusEnable.value)
				{
					lockTargetCinemachine.radiusLock = radiusInput.value;
				}
				if (heightEnable.value)
				{
					lockTargetCinemachine.followCameraLock = heightInput.value;
				}
				if (LockSoftZoneDefaultXEnable.value)
				{
					lockTargetCinemachine.softZoneLock = LockSoftZoneDefaultXInput.value;
				}
				if (LockSoftZoneDefaultYEnable.value)
				{
					lockTargetCinemachine.softYZoneLock = LockSoftZoneDefaultYInput.value;
				}
				if (LockDeadZoneHeightXEnable.value)
				{
					lockTargetCinemachine.deadZoneLock = LockDeadZoneHeightXInput.value;
				}
				if (LockDeadZoneHeightYEnable.value)
				{
					lockTargetCinemachine.deadYZoneLock = LockDeadZoneHeightYInput.value;
				}
				if (LockScreenYEnable.value)
				{
					lockTargetCinemachine.screenYLock = LockScreenYDefaultInput.value;
				}
				if (BiasXEnable.value)
				{
					lockTargetCinemachine.biasXLock = BiasXInput.value;
				}
				if (BiasYEnable.value)
				{
					lockTargetCinemachine.biasYLock = BiasYInput.value;
				}
				if (horizontalDampingEnable.value)
				{
					lockTargetCinemachine.horizontalDampingLock = horizontalDampingInput.value;
				}
				if (verticalDampingEnable.value)
				{
					lockTargetCinemachine.verticalDampingLock = verticalDampingInput.value;
				}
				if (ChangeDistanceEnable.value)
				{
					lockTargetCinemachine.changeDistance = ChangeDistanceInput.value;
				}
				if (FarMaxAngelEnable.value)
				{
					lockTargetCinemachine.farMaxAngle = FarMaxAngelInput.value;
				}
				if (NearMaxAngelEnable.value)
				{
					lockTargetCinemachine.nearMaxAngle = NearMaxAngelInput.value;
				}
				if (DampingEnable.value)
				{
					lockTargetCinemachine.damping = DampingInput.value;
					lockTargetCinemachine.originDamping = DampingInput.value;
				}
				if (StartHeightEnable.value)
				{
					lockTargetCinemachine.startHeight = StartHeightInput.value;
				}
				if (MinHeightEnable.value)
				{
					lockTargetCinemachine.minHeight = MinHeightInput.value;
				}
				if (LookatDisWithFollowEnable.value)
				{
					lockTargetCinemachine.lookatDisWithFollow = LookatDisWithFollowInput.value;
					lockTargetCinemachine.originLookatDisWithFollow = LookatDisWithFollowInput.value;
				}
				if (LookatDampingEnable.value)
				{
					lockTargetCinemachine.lookatDamping = LookatDampingInput.value;
					lockTargetCinemachine.originLookatDamping = LookatDampingInput.value;
				}
				if (dirtyInput.value)
				{
					lockTargetCinemachine.dirty = dirtyInput.value;
				}
				lockTargetCinemachine.ApplyCameraParam();
				output.Call(f);
			}
		});
	}
}
