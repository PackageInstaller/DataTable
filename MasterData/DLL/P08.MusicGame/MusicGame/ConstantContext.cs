using System;
using UnityEngine;

namespace MusicGame;

public class ConstantContext
{
	private float theta = MathF.PI / 6f;

	private float distance = 27.647875f;

	private float y_zero = -10.5358925f;

	private float phi = MathF.PI / 6f;

	private float c = -0.53f;

	private float speed = 1f;

	public float tMin = 0.4f;

	private float cosTh;

	private float sinTh;

	private float tanPhi;

	private float cosThDividedByTanPhi;

	private float y_zeroDividedByTanPhi;

	public void InitValue()
	{
		Camera main = Camera.main;
		theta = (0f - main.transform.localEulerAngles.x) * (MathF.PI / 180f);
		phi = main.fieldOfView / 2f * (MathF.PI / 180f);
		GameObject.Find("UICamera/Canvas").GetComponent<RectTransform>();
		GameObject gameObject = GameObject.Find("Music/background/frame");
		c = main.WorldToViewportPoint(gameObject.transform.position).y * 2f - 1f;
		y_zero = main.transform.InverseTransformPoint(gameObject.transform.position).y;
		distance = main.transform.InverseTransformPoint(gameObject.transform.position).z;
	}

	public void Init(MusicDataForExchange config)
	{
		InitValue();
		cosTh = Mathf.Cos(theta);
		sinTh = Mathf.Sin(theta);
		tanPhi = Mathf.Tan(phi);
		cosThDividedByTanPhi = cosTh / tanPhi;
		y_zeroDividedByTanPhi = y_zero / tanPhi;
		float num = 1f - c;
		float constantSpeed = config.constantSpeed;
		speed = num * constantSpeed * constantSpeed / 16f + num * constantSpeed / 2f - num / 16f;
		tMin = (1f / Mathf.Tan(theta) / tanPhi - c) / speed;
	}

	public float GetPositionConstant(int currentTime, int reachTime, out bool isMeetConstant)
	{
		MusicGameTiming timing = MusicController.GetTiming(currentTime);
		timing = ((currentTime > 0 && reachTime > 0) ? MusicController.GetTiming(currentTime) : MusicGameTiming.y_zero);
		MusicGameTiming timing2 = MusicController.GetTiming(reachTime);
		float num = (float)(currentTime - timing.startTime) * (float)timing.speed + (float)timing.constant;
		float num2 = ((float)(reachTime - timing2.startTime) * (float)timing2.speed + (float)timing2.constant - num) * 0.001f;
		float num3 = distance * (speed * num2 + c) - y_zeroDividedByTanPhi;
		float num4 = -1f * sinTh * (speed * num2 + c) + cosThDividedByTanPhi;
		float num5 = num3 / num4;
		isMeetConstant = num5 >= 0f && num2 < tMin;
		return num5;
	}
}
