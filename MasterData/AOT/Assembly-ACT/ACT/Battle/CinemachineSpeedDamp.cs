using System;
using Bamboo.ECS;
using Cinemachine;
using UnityEngine;

namespace ACT.Battle;

[AddComponentMenu("")]
[SaveDuringPlay]
public class CinemachineSpeedDamp : CinemachineExtension
{
	[Serializable]
	public struct VDampData
	{
		public enum DampType
		{
			X,
			Y,
			Z,
			Pitch,
			Yaw,
			Roll,
			Angular
		}

		public enum VelocityType
		{
			X,
			Y,
			Value
		}

		public VelocityType velocityType;

		public DampType dampType;

		public AnimationCurve curve;
	}

	public VDampData[] dampDatas;

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
		if (MonoECS.instance == null)
		{
			return;
		}
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (!mainEntity.IsLogicAvailable())
		{
			return;
		}
		CompPhysics? compPhysics = mainEntity.GetCompPhysics();
		float num = Mathf.Abs(compPhysics.rawVelocity.z);
		float num2 = Mathf.Abs(compPhysics.rawVelocity.y);
		float magnitude = compPhysics.rawVelocity.magnitude;
		if (stage != CinemachineCore.Stage.Body)
		{
			return;
		}
		CinemachineVirtualCamera cinemachineVirtualCamera = vcam as CinemachineVirtualCamera;
		if (!(cinemachineVirtualCamera != null))
		{
			return;
		}
		CinemachineTransposer cinemachineComponent = cinemachineVirtualCamera.GetCinemachineComponent<CinemachineTransposer>();
		VDampData[] array;
		if (cinemachineComponent != null)
		{
			array = dampDatas;
			for (int i = 0; i < array.Length; i++)
			{
				VDampData vDampData = array[i];
				float time = 0f;
				switch (vDampData.velocityType)
				{
				case VDampData.VelocityType.X:
					time = num;
					break;
				case VDampData.VelocityType.Y:
					time = num2;
					break;
				case VDampData.VelocityType.Value:
					time = magnitude;
					break;
				}
				float num3 = vDampData.curve.Evaluate(time);
				switch (vDampData.dampType)
				{
				case VDampData.DampType.X:
					cinemachineComponent.m_XDamping = num3;
					break;
				case VDampData.DampType.Y:
					cinemachineComponent.m_YDamping = num3;
					break;
				case VDampData.DampType.Z:
					cinemachineComponent.m_ZDamping = num3;
					break;
				case VDampData.DampType.Pitch:
					cinemachineComponent.m_PitchDamping = num3;
					break;
				case VDampData.DampType.Yaw:
					cinemachineComponent.m_YawDamping = num3;
					break;
				case VDampData.DampType.Roll:
					cinemachineComponent.m_RollDamping = num3;
					break;
				case VDampData.DampType.Angular:
					cinemachineComponent.m_AngularDamping = num3;
					break;
				}
			}
		}
		CinemachineFramingTransposerACT cinemachineComponent2 = cinemachineVirtualCamera.GetCinemachineComponent<CinemachineFramingTransposerACT>();
		if (!cinemachineComponent2)
		{
			return;
		}
		array = dampDatas;
		for (int i = 0; i < array.Length; i++)
		{
			VDampData vDampData2 = array[i];
			float time2 = 0f;
			switch (vDampData2.velocityType)
			{
			case VDampData.VelocityType.X:
				time2 = num;
				break;
			case VDampData.VelocityType.Y:
				time2 = num2;
				break;
			case VDampData.VelocityType.Value:
				time2 = magnitude;
				break;
			}
			float num4 = vDampData2.curve.Evaluate(time2);
			switch (vDampData2.dampType)
			{
			case VDampData.DampType.X:
				cinemachineComponent2.m_XDamping = num4;
				break;
			case VDampData.DampType.Y:
				cinemachineComponent2.m_YDamping = num4;
				break;
			case VDampData.DampType.Z:
				cinemachineComponent2.m_ZDamping = num4;
				break;
			}
		}
	}
}
