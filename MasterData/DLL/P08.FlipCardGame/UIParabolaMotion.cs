using System;
using System.Collections;
using UnityEngine;

public class UIParabolaMotion : MonoBehaviour
{
	[Header("运动参数")]
	public float parabolaHeight = 1f;

	public float duration = 2f;

	public float stayTime;

	public float offsetY;

	[Header("旋转参数")]
	public bool enableRotation = true;

	public float rotationOffset;

	public RectTransform movingObject;

	public float ratateProp = 0.8f;

	private Vector3 startPos;

	private Vector3 endPos;

	private Vector3 controlPoint;

	private float startTime;

	private Action nextEffectCallback;

	private Action moveEndCallback;

	public float rotateProp = 0.8f;

	private float speedMultiplier = 1f;

	private float nextEffectProp = 0.8f;

	private bool isNextEffect;

	private bool isExecuteCallbck;

	private void Start()
	{
	}

	public void StartMotion(GameObject startPoint, GameObject endPoint, float speed, float prop, Action nextCallback = null, Action endCallback = null)
	{
		if (!(startPoint == null) && !(endPoint == null) && !(movingObject == null))
		{
			startPos = startPoint.transform.position + new Vector3(0f, offsetY, 0f);
			endPos = endPoint.transform.position + new Vector3(0f, offsetY, 0f);
			speedMultiplier = Mathf.Max(speed, 0.1f);
			nextEffectProp = prop;
			isExecuteCallbck = false;
			nextEffectCallback = nextCallback;
			moveEndCallback = endCallback;
			movingObject.position = startPos;
			CalculateControlPoint();
			startTime = Time.time;
			StopAllCoroutines();
			StartCoroutine(ParabolaRoutine());
		}
	}

	private void CalculateControlPoint()
	{
		Vector3 vector = (startPos + endPos) / 2f;
		controlPoint = vector + Vector3.up * parabolaHeight;
	}

	private IEnumerator ParabolaRoutine()
	{
		while (true)
		{
			if (speedMultiplier <= 0f)
			{
				yield return null;
				continue;
			}
			float num = duration / speedMultiplier;
			float num2 = Time.time - startTime;
			float num3 = Mathf.Clamp01(num2 / num);
			isNextEffect = num2 >= num * nextEffectProp;
			if (isNextEffect)
			{
				ExecuteNextEffectCallback();
			}
			movingObject.position = CalculateBezierPoint(num3);
			if (enableRotation && num2 < num * ratateProp)
			{
				Vector3 vector = CalculateBezierPoint(num3 + 0.01f) - movingObject.position;
				float z = Mathf.Atan2(vector.y, vector.x) * 57.29578f + rotationOffset;
				Quaternion rotation = Quaternion.Euler(0f, 0f, z);
				movingObject.rotation = rotation;
			}
			if (num3 >= 1f)
			{
				break;
			}
			yield return null;
		}
		movingObject.position = endPos;
		if (stayTime > 0f)
		{
			yield return new WaitForSeconds(stayTime);
		}
		moveEndCallback?.Invoke();
	}

	private Vector3 CalculateBezierPoint(float t)
	{
		float num = 1f - t;
		float num2 = t * t;
		return num * num * startPos + 2f * num * t * controlPoint + num2 * endPos;
	}

	public void SetSpeedMultiplier(float multiplier)
	{
		speedMultiplier = Mathf.Max(multiplier, 0.1f);
	}

	private void ExecuteNextEffectCallback()
	{
		if (!isExecuteCallbck)
		{
			isExecuteCallbck = true;
			nextEffectCallback?.Invoke();
		}
	}
}
