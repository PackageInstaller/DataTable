using System;
using System.Collections.Generic;
using Cinemachine;
using UnityEngine;
using UnityEngine.UI;

namespace ACT;

public class TestView_Scene : MonoBehaviour
{
	public Canvas canvas;

	public GameObject bandingTarget;

	public Animator bindingAnimator;

	public Image bg;

	public List<CinemachineVirtualCameraBase> vCams = new List<CinemachineVirtualCameraBase>();

	public void SetCamera(int index)
	{
		for (int i = 0; i < vCams.Count; i++)
		{
			vCams[i].gameObject.SetActive(i == index);
		}
	}

	public void Update()
	{
		if (!(canvas != null))
		{
			return;
		}
		Camera worldCamera = canvas.worldCamera;
		if (worldCamera != null)
		{
			float fieldOfView = worldCamera.fieldOfView;
			float num = Vector3.Distance(canvas.transform.position, worldCamera.transform.position);
			float num2 = 2f * num * Mathf.Tan(fieldOfView * 0.5f * (MathF.PI / 180f));
			float x = num2 * worldCamera.aspect;
			RectTransform component = canvas.GetComponent<RectTransform>();
			if (component != null)
			{
				component.sizeDelta = new Vector2(x, num2);
				canvas.transform.position = worldCamera.transform.position + worldCamera.transform.forward * num;
				canvas.transform.rotation = worldCamera.transform.rotation;
			}
		}
	}
}
