using System;
using UnityEngine;

[Serializable]
public class CameraBaseData
{
	[Header("相机基础配置")]
	public string cameraName;

	public Vector3 cameraOffset;

	public int battleCameraProperty;

	public int cameraFov = 12;

	public Vector3 cameraRotate = new Vector3(45f, 0f, 0f);

	public float nearClipPlane = 0.1f;

	public int farClipPlane = 500;

	public int cameraDistance = 40;

	public Vector3 cameraDamp = new Vector3(1f, 1f, 1f);
}
