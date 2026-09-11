using System;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0WorldCaptureAniData
{
	public string aniName;

	public bool isUseSceneData;

	public Vector3 charaterPos;

	public Vector3 charaterRot;

	public bool isIndependentRig;

	public T0WorldCaptureRigParams rigParams;

	public float beginCameraX;

	public float beginCameraY;

	public Vector3 lookPosMin = Vector3.zero;

	public Vector3 lookPosMax = Vector3.zero;
}
