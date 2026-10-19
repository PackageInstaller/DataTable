using System.Collections.Generic;
using UnityEngine;

namespace ACT.LocalLoader;

public class StratificationComponent : MonoBehaviour
{
	[Header("视差层设置")]
	public List<ParallaxLayer> parallaxLayers = new List<ParallaxLayer>();

	[Header("视差效果设置，越大阻力越大")]
	[Range(0f, 2f)]
	public float dampingCoefficient = 1f;

	[Header("UI元素的最大移动的像素范围的基准值")]
	public float maxMovementRange = 50f;

	[Range(1f, 20f)]
	public float smoothSpeed = 5f;

	[Header("禁用时是否重置位置")]
	public bool resetOnDisable = true;

	[Header("输入设置")]
	public float gyroSensitivity = 2f;

	public float mouseSensitivity = 0.5f;

	private Vector2 targetPosition;

	private Vector2 currentPosition;

	private bool isUsingGyroscope;

	private Quaternion baseRotation;

	private bool hasInitialized;

	private bool gyroInitialized;

	private const float gyroScopeRange = 45f;

	private void Start()
	{
		foreach (ParallaxLayer parallaxLayer in parallaxLayers)
		{
			parallaxLayer.Initialize();
		}
	}

	private void OnEnable()
	{
	}

	private void OnDisable()
	{
		if (resetOnDisable)
		{
			ResetAllLayers();
		}
	}

	private void ResetAllLayers()
	{
		foreach (ParallaxLayer parallaxLayer in parallaxLayers)
		{
			if (parallaxLayer.layerTransform != null)
			{
				parallaxLayer.UpdatePosition(Vector2.zero, 0f);
			}
		}
	}

	public void InitializeSystem()
	{
		hasInitialized = true;
		gameObject.SetActive(value: true);
		isUsingGyroscope = SystemInfo.supportsGyroscope && Application.isMobilePlatform;
		if (isUsingGyroscope && !gyroInitialized)
		{
			Input.gyro.enabled = true;
			Invoke("CalibrateGyroscope", 1f);
		}
	}

	private void CalibrateGyroscope()
	{
		baseRotation = Input.gyro.attitude;
		gyroInitialized = true;
		currentPosition = Vector2.zero;
		targetPosition = Vector2.zero;
	}

	private void Update()
	{
		if (!hasInitialized)
		{
			return;
		}
		UpdateTargetPosition();
		currentPosition = Vector2.Lerp(currentPosition, targetPosition, Time.deltaTime * smoothSpeed);
		Vector2 input = currentPosition * dampingCoefficient;
		foreach (ParallaxLayer parallaxLayer in parallaxLayers)
		{
			parallaxLayer.UpdatePosition(input, maxMovementRange);
		}
	}

	private void UpdateTargetPosition()
	{
		if (isUsingGyroscope && gyroInitialized)
		{
			Vector3 gravity = Input.gyro.gravity;
			targetPosition.x = Mathf.Clamp(gravity.x * gyroSensitivity, -1f, 1f);
			targetPosition.y = Mathf.Clamp(gravity.y * gyroSensitivity, -1f, 1f);
		}
		else
		{
			Vector2 vector = Input.mousePosition;
			Vector2 vector2 = new Vector2((float)Screen.width * 0.5f, (float)Screen.height * 0.5f);
			targetPosition.x = Mathf.Clamp((vector.x - vector2.x) / vector2.x * mouseSensitivity, -1f, 1f);
			targetPosition.y = Mathf.Clamp((vector.y - vector2.y) / vector2.y * mouseSensitivity, -1f, 1f);
		}
	}

	private void UpdateGyroTargetPonsition(Vector3 gravity)
	{
		switch (Screen.orientation)
		{
		case ScreenOrientation.LandscapeLeft:
			targetPosition.x = Mathf.Clamp((0f - gravity.y) * gyroSensitivity, -1f, 1f);
			targetPosition.y = Mathf.Clamp((0f - gravity.x) * gyroSensitivity, -1f, 1f);
			break;
		case ScreenOrientation.LandscapeRight:
			targetPosition.x = Mathf.Clamp(gravity.y * gyroSensitivity, -1f, 1f);
			targetPosition.y = Mathf.Clamp(gravity.x * gyroSensitivity, -1f, 1f);
			break;
		default:
			targetPosition.x = Mathf.Clamp((0f - gravity.y) * gyroSensitivity, -1f, 1f);
			targetPosition.y = Mathf.Clamp((0f - gravity.x) * gyroSensitivity, -1f, 1f);
			break;
		}
	}

	public void ResetGyroscope()
	{
		if (isUsingGyroscope)
		{
			CalibrateGyroscope();
		}
	}
}
