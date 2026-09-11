using System.Collections.Generic;
using Cinemachine;
using UnityEngine;

public class CameraChangeFOVWithScreenSize : MonoBehaviour
{
	public List<float> rate = new List<float>();

	public List<float> fov = new List<float>();

	public CinemachineVirtualCamera VirtualCamera;

	public void Start()
	{
		if (rate.Count <= 0 || fov.Count <= 0 || rate.Count != fov.Count)
		{
			Debug.LogError("屏幕比例没配置或者fov没配置或者两者数量不匹配", base.gameObject);
			return;
		}
		if (VirtualCamera == null)
		{
			Debug.LogError("相机未配置");
			return;
		}
		float num = (float)Screen.width / (float)Screen.height;
		int num2 = 0;
		for (num2 = 0; num2 < rate.Count && !(num <= rate[num2]); num2++)
		{
		}
		VirtualCamera.m_Lens.FieldOfView = fov[num2];
	}
}
