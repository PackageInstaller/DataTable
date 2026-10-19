using ACT.MultiPlayer;
using UnityEngine;

namespace ACT.Utility;

public static class QuaternionUtility
{
	public static Quaternion ProjectRotationOnXZPlane(Quaternion quaternion)
	{
		return ProjectRotationOnPlane(quaternion, Vector3.up);
	}

	public static float ProjectRotationOnXZPlaneEulerY(Quaternion quaternion)
	{
		return ProjectRotationOnPlane(quaternion, Vector3.up).eulerAngles.y;
	}

	public static Quaternion ProjectRotationOnPlane(Quaternion quaternion, Vector3 normal)
	{
		return Quaternion.FromToRotation(quaternion * normal, normal) * quaternion;
	}

	public static Quaternion FaceRotation(FaceDir faceDir)
	{
		return Quaternion.Euler(0f, FaceYAngle(faceDir), 0f);
	}

	public static float FaceYAngle(FaceDir faceDir)
	{
		return faceDir switch
		{
			FaceDir.Left => 270f, 
			FaceDir.Forward => 0f, 
			FaceDir.Back => 180f, 
			_ => 90f, 
		};
	}

	public static Quaternion FaceLocalRotation(FaceDir faceDir)
	{
		return Quaternion.Euler(0f, FaceLocalYAngle(faceDir), 0f);
	}

	public static float FaceLocalYAngle(FaceDir faceDir)
	{
		return FaceYAngle(faceDir) - 90f;
	}

	public static FaceDir LocalYToFaceDir(float eulerY)
	{
		while (eulerY < 0f)
		{
			eulerY += 360f;
		}
		if (eulerY >= 270f || eulerY < 90f)
		{
			return FaceDir.Right;
		}
		return FaceDir.Left;
	}
}
