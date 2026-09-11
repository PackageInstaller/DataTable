using System;
using UnityEngine;

public class WaterFloaterControl : MonoBehaviour
{
	private struct WaveInfo
	{
		public Vector3 offset;

		public Vector3 normal;
	}

	public Transform _waterTrans;

	private WaterFloaterManager _water;

	public float timeDelay;

	public float yOffset;

	[NonSerialized]
	[Min(0f)]
	public float horizontalScale;

	[Min(0f)]
	public float verticalScale = 1f;

	public bool shakeEnable;

	[Min(0f)]
	public float shakeScale = 1f;

	public float moveLerpSpeed = 0.1f;

	public float rotateLerpSpeed = 0.001f;

	private float _WaveSpeed;

	private float _WaveHeight;

	private float _WaveSteepness;

	private float _WaveCount;

	private Vector4 _WaveDirection;

	private float _WaveNormalStr;

	private float _WaveDistance;

	private Vector3 originPos;

	private Vector3 originUP;

	private Quaternion originRot;

	private Vector2 lastPosXZ;

	private float offsetTarget;

	private float lastOffsetTarget;

	private float lastTime;

	private float deltaTime;

	private Vector3 normalTarget;

	private readonly Vector4 ampVec = new Vector4(0.3f, 0.35f, 0.25f, 0.25f);

	private readonly Vector4 fraqVec = new Vector4(1.3f, 1.35f, 1.25f, 1.25f);

	private readonly Vector4 dir1Vec = new Vector4(0.3f, 0.85f, 0.85f, 0.25f);

	private readonly Vector4 dir2Vec = new Vector4(0.1f, 0.9f, -0.5f, -0.5f);

	private readonly Vector4 steepnessVec = new Vector4(12f, 12f, 12f, 12f);

	private Vector3 GerstnerOffset4(Vector2 xzVtx, Vector4 steepness, Vector4 amp, Vector4 freq, Vector4 speed, Vector4 dirAB, Vector4 dirCD)
	{
		Vector4 zero = Vector4.zero;
		Vector4 zero2 = Vector4.zero;
		Vector4 zero3 = Vector4.zero;
		Vector4 zero4 = Vector4.zero;
		Vector4 zero5 = Vector4.zero;
		Vector3 zero6 = Vector3.zero;
		zero.x = steepness.x * amp.x * dirAB.x;
		zero.y = steepness.x * amp.x * dirAB.y;
		zero.z = steepness.y * amp.y * dirAB.z;
		zero.w = steepness.y * amp.y * dirAB.w;
		zero2.x = steepness.z * amp.z * dirCD.x;
		zero2.y = steepness.z * amp.z * dirCD.y;
		zero2.z = steepness.w * amp.w * dirCD.z;
		zero2.w = steepness.w * amp.w * dirCD.w;
		zero3.x = freq.x * Vector2.Dot(new Vector2(dirAB.x, dirAB.y), xzVtx);
		zero3.y = freq.y * Vector2.Dot(new Vector2(dirAB.z, dirAB.w), xzVtx);
		zero3.z = freq.z * Vector2.Dot(new Vector2(dirCD.x, dirAB.y), xzVtx);
		zero3.w = freq.w * Vector2.Dot(new Vector2(dirCD.z, dirAB.w), xzVtx);
		zero3 += speed;
		zero4.x = Mathf.Cos(zero3.x);
		zero4.y = Mathf.Cos(zero3.y);
		zero4.z = Mathf.Cos(zero3.z);
		zero4.w = Mathf.Cos(zero3.w);
		zero5.x = Mathf.Sin(zero3.x);
		zero5.y = Mathf.Sin(zero3.y);
		zero5.z = Mathf.Sin(zero3.z);
		zero5.w = Mathf.Sin(zero3.w);
		zero6.x = Vector4.Dot(zero4, new Vector4(zero.x, zero.z, zero2.x, zero2.z));
		zero6.z = Vector4.Dot(zero4, new Vector4(zero.y, zero.w, zero2.y, zero2.w));
		zero6.y = Vector4.Dot(zero5, amp);
		return zero6;
	}

	private Vector3 GerstnerNormal4(Vector2 xzVtx, Vector4 amp, Vector4 freq, Vector4 speed, Vector4 dirAB, Vector4 dirCD)
	{
		Vector3 value = new Vector3(0f, 2f, 0f);
		Vector4 zero = Vector4.zero;
		Vector4 zero2 = Vector4.zero;
		Vector4 zero3 = Vector4.zero;
		Vector4 zero4 = Vector4.zero;
		zero.x = freq.x * amp.x * dirAB.x;
		zero.y = freq.x * amp.x * dirAB.y;
		zero.z = freq.y * amp.y * dirAB.z;
		zero.w = freq.y * amp.y * dirAB.w;
		zero2.x = freq.z * amp.z * dirCD.x;
		zero2.y = freq.z * amp.z * dirCD.y;
		zero2.z = freq.w * amp.w * dirCD.z;
		zero2.w = freq.w * amp.w * dirCD.w;
		zero3.x = freq.x * Vector2.Dot(new Vector2(dirAB.x, dirAB.y), xzVtx);
		zero3.y = freq.y * Vector2.Dot(new Vector2(dirAB.z, dirAB.w), xzVtx);
		zero3.z = freq.z * Vector2.Dot(new Vector2(dirCD.x, dirAB.y), xzVtx);
		zero3.w = freq.w * Vector2.Dot(new Vector2(dirCD.z, dirAB.w), xzVtx);
		zero3 += speed;
		zero4.x = Mathf.Cos(zero3.x);
		zero4.y = Mathf.Cos(zero3.y);
		zero4.z = Mathf.Cos(zero3.z);
		zero4.w = Mathf.Cos(zero3.w);
		value.x -= Vector4.Dot(zero4, new Vector4(zero.x, zero.z, zero2.x, zero2.z));
		value.z -= Vector4.Dot(zero4, new Vector4(zero.y, zero.w, zero2.y, zero2.w));
		value.x *= _WaveNormalStr;
		value.z *= _WaveNormalStr;
		return Vector3.Normalize(value);
	}

	private WaveInfo GetWaveInfo(Vector2 position, Vector2 time, float height, float mask)
	{
		WaveInfo result = default(WaveInfo);
		Vector4 amp = ampVec;
		Vector4 freq = (1f - _WaveDistance) * 3f * fraqVec;
		Vector4 speed = new Vector4(1.2f * time.x, 1.375f * time.y, 1.1f * time.x, time.y);
		Vector4 dirAB = Vector4.Scale(dir1Vec, _WaveDirection);
		Vector4 dirCD = Vector4.Scale(dir2Vec, _WaveDirection);
		Vector4 steepness = _WaveSteepness * Mathf.Lerp(1f, 5f, 1f / _WaveCount) * steepnessVec;
		result.offset = Vector3.zero;
		for (uint num = 0u; (float)num <= _WaveCount; num++)
		{
			float num2 = 1f + (float)num / _WaveCount;
			freq *= num2;
			result.offset += GerstnerOffset4(position, steepness, amp, freq, speed, dirAB, dirCD);
			if (shakeEnable)
			{
				result.normal += GerstnerNormal4(position, amp, freq, speed, dirAB, dirCD);
			}
		}
		result.normal.x *= shakeScale;
		result.normal.z *= shakeScale;
		result.normal = Vector3.Normalize(result.normal);
		result.offset.y /= _WaveCount;
		result.offset.x *= 0.01f * horizontalScale * height * mask;
		result.offset.z *= 0.01f * horizontalScale * height * mask;
		result.offset.y *= verticalScale * height * mask;
		return result;
	}

	public void Init(Transform waterTrans = null)
	{
		if (waterTrans != null)
		{
			_waterTrans = waterTrans;
		}
		if (_waterTrans == null)
		{
			Debug.LogError("没有添加WaterFloaterParams脚本的水面！");
			return;
		}
		_water = _waterTrans.GetComponent<WaterFloaterManager>();
		if (_water == null)
		{
			Debug.LogError("请给水面添加WaterFloaterParams脚本！");
			return;
		}
		originPos = base.transform.position;
		originUP = base.transform.up;
		originRot = base.transform.rotation;
		lastTime = Time.deltaTime;
		lastOffsetTarget = 0f;
	}

	private void Start()
	{
		Init();
	}

	private void LateUpdate()
	{
		if (!(_waterTrans == null) && !(_water == null))
		{
			_WaveSpeed = _water.WaveSpeed;
			_WaveHeight = _water.WaveHeight;
			_WaveSteepness = _water.WaveSteepness;
			_WaveCount = _water.WaveCount;
			_WaveDirection = _water.WaveDirection;
			_WaveNormalStr = _water.WaveNormalStr;
			_WaveDistance = _water.WaveDistance;
			Vector3 position = base.transform.position;
			deltaTime = Time.time - lastTime;
			lastTime = Time.time;
			Vector2 vector = new Vector2(position.x, position.z);
			float num = Time.time + timeDelay;
			float num2 = Mathf.Floor(num) % 18000f + (num - Mathf.Floor(num));
			Vector2 time = new Vector2(num2 * _WaveSpeed, num2 * _WaveSpeed);
			float mask = 1f;
			WaveInfo waveInfo = GetWaveInfo(vector, time, _WaveHeight, mask);
			bool flag = Vector2.Distance(vector, lastPosXZ) > 0.01f;
			if (flag)
			{
				offsetTarget = 0f;
			}
			else
			{
				offsetTarget = LerpValue(offsetTarget, waveInfo.offset.y, moveLerpSpeed, moveLerpSpeed);
				offsetTarget = LerpValue(offsetTarget, waveInfo.offset.y, moveLerpSpeed * deltaTime);
			}
			base.transform.position = new Vector3(vector.x, originPos.y + offsetTarget + yOffset, vector.y);
			lastPosXZ = vector;
			if (shakeEnable && !flag)
			{
				normalTarget = LerpVector(normalTarget, waveInfo.normal, rotateLerpSpeed * deltaTime);
				Quaternion quaternion = Quaternion.FromToRotation(base.transform.up, normalTarget);
				base.transform.rotation = quaternion * base.transform.rotation;
			}
			else
			{
				normalTarget = originUP;
				base.transform.rotation = originRot;
			}
		}
	}

	private float LerpValue(float value, float target, float rate)
	{
		if (Mathf.Abs(value - target) <= 0.001f)
		{
			return target;
		}
		return Mathf.Lerp(value, target, rate);
	}

	private float LerpValue(float value, float target, float increaseSpeed, float decreaseSpeed)
	{
		if (Mathf.Abs(value - target) <= 0.001f)
		{
			return target;
		}
		if (value < target)
		{
			return Mathf.Clamp(value + Time.deltaTime * increaseSpeed, float.NegativeInfinity, target);
		}
		return Mathf.Clamp(value - Time.deltaTime * decreaseSpeed, target, float.PositiveInfinity);
	}

	private Vector3 LerpVector(Vector3 value, Vector3 target, float rate)
	{
		if (Vector3.Dot(value, target) >= 0.99f)
		{
			return target;
		}
		return Vector3.Lerp(value, target, rate);
	}
}
