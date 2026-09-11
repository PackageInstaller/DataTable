using System;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[UsedByNativeCode]
public struct CameraProperties : IEquatable<CameraProperties>
{
	private Rect screenRect;

	private Vector3 viewDir;

	private float projectionNear;

	private float projectionFar;

	private float cameraNear;

	private float cameraFar;

	private float cameraAspect;

	private Matrix4x4 cameraToWorld;

	private Matrix4x4 actualWorldToClip;

	private Matrix4x4 cameraClipToWorld;

	private Matrix4x4 cameraWorldToClip;

	private Matrix4x4 implicitProjection;

	private Matrix4x4 stereoWorldToClipLeft;

	private Matrix4x4 stereoWorldToClipRight;

	private Matrix4x4 worldToCamera;

	private Vector3 up;

	private Vector3 right;

	private Vector3 transformDirection;

	private Vector3 cameraEuler;

	private Vector3 velocity;

	private float farPlaneWorldSpaceLength;

	private uint rendererCount;

	internal unsafe fixed byte m_ShadowCullPlanes[96];

	internal unsafe fixed byte m_CameraCullPlanes[96];

	private float baseFarDistance;

	private Vector3 shadowCullCenter;

	internal unsafe fixed float layerCullDistances[32];

	private int layerCullSpherical;

	private CoreCameraValues coreCameraValues;

	private uint cameraType;

	private int projectionIsOblique;

	private int isImplicitProjectionMatrix;

	public unsafe Plane GetShadowCullingPlane(int index)
	{
		if (index < 0 || index >= 6)
		{
			throw new ArgumentOutOfRangeException(string.Format("{0} was {1}, but must be at least 0 and less than {2}", "index", index, 6));
		}
		fixed (byte* shadowCullPlanes = m_ShadowCullPlanes)
		{
			Plane* ptr = (Plane*)shadowCullPlanes;
			return ptr[index];
		}
	}

	public unsafe Plane GetCameraCullingPlane(int index)
	{
		if (index < 0 || index >= 6)
		{
			throw new ArgumentOutOfRangeException(string.Format("{0} was {1}, but must be at least 0 and less than {2}", "index", index, 6));
		}
		fixed (byte* cameraCullPlanes = m_CameraCullPlanes)
		{
			Plane* ptr = (Plane*)cameraCullPlanes;
			return ptr[index];
		}
	}

	public unsafe bool Equals(CameraProperties other)
	{
		for (int i = 0; i < 6; i++)
		{
			if (!GetShadowCullingPlane(i).Equals(other.GetShadowCullingPlane(i)))
			{
				return false;
			}
		}
		for (int j = 0; j < 6; j++)
		{
			if (!GetCameraCullingPlane(j).Equals(other.GetCameraCullingPlane(j)))
			{
				return false;
			}
		}
		fixed (float* ptr = layerCullDistances)
		{
			for (int k = 0; k < 32; k++)
			{
				if (ptr[k] != other.layerCullDistances[k])
				{
					return false;
				}
			}
		}
		return screenRect.Equals(other.screenRect) && viewDir.Equals(other.viewDir) && projectionNear.Equals(other.projectionNear) && projectionFar.Equals(other.projectionFar) && cameraNear.Equals(other.cameraNear) && cameraFar.Equals(other.cameraFar) && cameraAspect.Equals(other.cameraAspect) && cameraToWorld.Equals(other.cameraToWorld) && actualWorldToClip.Equals(other.actualWorldToClip) && cameraClipToWorld.Equals(other.cameraClipToWorld) && cameraWorldToClip.Equals(other.cameraWorldToClip) && implicitProjection.Equals(other.implicitProjection) && stereoWorldToClipLeft.Equals(other.stereoWorldToClipLeft) && stereoWorldToClipRight.Equals(other.stereoWorldToClipRight) && worldToCamera.Equals(other.worldToCamera) && up.Equals(other.up) && right.Equals(other.right) && transformDirection.Equals(other.transformDirection) && cameraEuler.Equals(other.cameraEuler) && velocity.Equals(other.velocity) && farPlaneWorldSpaceLength.Equals(other.farPlaneWorldSpaceLength) && rendererCount == other.rendererCount && baseFarDistance.Equals(other.baseFarDistance) && shadowCullCenter.Equals(other.shadowCullCenter) && layerCullSpherical == other.layerCullSpherical && coreCameraValues.Equals(other.coreCameraValues) && cameraType == other.cameraType && projectionIsOblique == other.projectionIsOblique && isImplicitProjectionMatrix == other.isImplicitProjectionMatrix;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		return obj is CameraProperties && Equals((CameraProperties)obj);
	}

	public unsafe override int GetHashCode()
	{
		int hashCode = screenRect.GetHashCode();
		hashCode = (hashCode * 397) ^ viewDir.GetHashCode();
		hashCode = (hashCode * 397) ^ projectionNear.GetHashCode();
		hashCode = (hashCode * 397) ^ projectionFar.GetHashCode();
		hashCode = (hashCode * 397) ^ cameraNear.GetHashCode();
		hashCode = (hashCode * 397) ^ cameraFar.GetHashCode();
		hashCode = (hashCode * 397) ^ cameraAspect.GetHashCode();
		hashCode = (hashCode * 397) ^ cameraToWorld.GetHashCode();
		hashCode = (hashCode * 397) ^ actualWorldToClip.GetHashCode();
		hashCode = (hashCode * 397) ^ cameraClipToWorld.GetHashCode();
		hashCode = (hashCode * 397) ^ cameraWorldToClip.GetHashCode();
		hashCode = (hashCode * 397) ^ implicitProjection.GetHashCode();
		hashCode = (hashCode * 397) ^ stereoWorldToClipLeft.GetHashCode();
		hashCode = (hashCode * 397) ^ stereoWorldToClipRight.GetHashCode();
		hashCode = (hashCode * 397) ^ worldToCamera.GetHashCode();
		hashCode = (hashCode * 397) ^ up.GetHashCode();
		hashCode = (hashCode * 397) ^ right.GetHashCode();
		hashCode = (hashCode * 397) ^ transformDirection.GetHashCode();
		hashCode = (hashCode * 397) ^ cameraEuler.GetHashCode();
		hashCode = (hashCode * 397) ^ velocity.GetHashCode();
		hashCode = (hashCode * 397) ^ farPlaneWorldSpaceLength.GetHashCode();
		hashCode = (hashCode * 397) ^ (int)rendererCount;
		for (int i = 0; i < 6; i++)
		{
			hashCode = (hashCode * 397) ^ GetShadowCullingPlane(i).GetHashCode();
		}
		for (int j = 0; j < 6; j++)
		{
			hashCode = (hashCode * 397) ^ GetCameraCullingPlane(j).GetHashCode();
		}
		hashCode = (hashCode * 397) ^ baseFarDistance.GetHashCode();
		hashCode = (hashCode * 397) ^ shadowCullCenter.GetHashCode();
		fixed (float* ptr = layerCullDistances)
		{
			for (int k = 0; k < 32; k++)
			{
				hashCode = (hashCode * 397) ^ ptr[k].GetHashCode();
			}
		}
		hashCode = (hashCode * 397) ^ layerCullSpherical;
		hashCode = (hashCode * 397) ^ coreCameraValues.GetHashCode();
		hashCode = (hashCode * 397) ^ (int)cameraType;
		hashCode = (hashCode * 397) ^ projectionIsOblique;
		return (hashCode * 397) ^ isImplicitProjectionMatrix;
	}
}
