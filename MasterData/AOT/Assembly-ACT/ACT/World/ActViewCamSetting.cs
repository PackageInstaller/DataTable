using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.World;

[Serializable]
public class ActViewCamSetting
{
	[SerializeField]
	protected bool _orthographic;

	[SerializeField]
	[Range(0.1f, 100f)]
	protected float _orthographicSize;

	[SerializeField]
	[Range(1f, 179f)]
	protected float _fieldOfView;

	[SerializeField]
	[Range(0.5f, 2f)]
	protected float _aspect;

	[SerializeField]
	[Range(0.001f, 200f)]
	protected float _nearClipPlane;

	[SerializeField]
	[Range(10f, 3000f)]
	protected float _farClipPlane;

	[SerializeField]
	protected Rect _rect;

	[NonSerialized]
	private List<Vector3> _cachedFOVPositions;

	[NonSerialized]
	private static HashSet<string> _cachedFOVPositionKeys;

	public virtual bool orthographic
	{
		get
		{
			return _orthographic;
		}
		set
		{
			_orthographic = value;
		}
	}

	public virtual float orthographicSize
	{
		get
		{
			return _orthographicSize;
		}
		set
		{
			_orthographicSize = value;
		}
	}

	public virtual Rect rect
	{
		get
		{
			return _rect;
		}
		set
		{
			_rect = value;
		}
	}

	public virtual float aspect
	{
		get
		{
			return _aspect;
		}
		set
		{
			_aspect = value;
		}
	}

	public virtual float fieldOfView
	{
		get
		{
			return _fieldOfView;
		}
		set
		{
			_fieldOfView = value;
		}
	}

	public virtual float nearClipPlane
	{
		get
		{
			return _nearClipPlane;
		}
		set
		{
			_nearClipPlane = value;
		}
	}

	public virtual float farClipPlane
	{
		get
		{
			return _farClipPlane;
		}
		set
		{
			_farClipPlane = value;
		}
	}

	public ActViewCamSetting()
	{
		_orthographic = false;
		_orthographicSize = 5f;
		_fieldOfView = 32f;
		_aspect = 1.7777778f;
		_nearClipPlane = 0.3f;
		_farClipPlane = 50f;
		_rect = new Rect(0f, 0f, 1f, 1f);
	}

	public ActViewCamSetting CopyFrom(ActViewCamSetting setting)
	{
		orthographic = setting.orthographic;
		orthographicSize = setting.orthographicSize;
		rect = setting.rect;
		aspect = setting.aspect;
		fieldOfView = setting.fieldOfView;
		nearClipPlane = setting.nearClipPlane;
		farClipPlane = setting.farClipPlane;
		return this;
	}

	public ActViewCamSetting CopyFrom(Camera camera)
	{
		orthographic = camera.orthographic;
		orthographicSize = camera.orthographicSize;
		rect = camera.rect;
		aspect = camera.aspect;
		fieldOfView = camera.fieldOfView;
		nearClipPlane = camera.nearClipPlane;
		farClipPlane = camera.farClipPlane;
		return this;
	}

	public void CalculateFrustumCorners(float z, in Vector3[] outCorners)
	{
		CalculateFrustumCorners(this, z, in outCorners);
	}

	public List<Vector3> SweepFrustumAreaPoints(float step)
	{
		List<Vector3> list = _cachedFOVPositions ?? (_cachedFOVPositions = new List<Vector3>());
		list.Clear();
		if (_cachedFOVPositionKeys == null)
		{
			_cachedFOVPositionKeys = new HashSet<string>();
		}
		_cachedFOVPositionKeys.Clear();
		float num = farClipPlane;
		float num2 = nearClipPlane;
		Vector3[] outCorners = new Vector3[4];
		for (float num3 = num2; num3 < num; num3 += step)
		{
			CalculateFrustumCorners(num3, in outCorners);
			SweepViewClipPlane(in outCorners, in step, list, _cachedFOVPositionKeys);
		}
		return list;
	}

	private static void CalculateFrustumCorners(ActViewCamSetting setting, float z, in Vector3[] outCorners)
	{
		if (setting == null || outCorners == null || outCorners.Length < 4)
		{
			Debug.LogError("Invalid parameters for CalculateFrustumCorners.");
		}
		else if (setting.orthographic)
		{
			CalculateOrthographicFrustumCorners(setting, z, in outCorners);
		}
		else
		{
			CalculatePerspectiveFrustumCorners(setting, z, outCorners);
		}
	}

	private static void CalculateOrthographicFrustumCorners(ActViewCamSetting setting, float z, in Vector3[] outCorners)
	{
		float num = setting.orthographicSize;
		float num2 = setting.aspect;
		float num3 = num * num2;
		float num4 = num3 * 2f;
		float num5 = num * 2f;
		Rect rect = setting.rect;
		float x = 0f - num3 + rect.x * num4;
		float x2 = 0f - num3 + rect.width * num4;
		float y = 0f - num + rect.y * num5;
		float y2 = 0f - num + rect.height * num5;
		outCorners[0] = new Vector3(x, y, z);
		outCorners[1] = new Vector3(x, y2, z);
		outCorners[2] = new Vector3(x2, y2, z);
		outCorners[3] = new Vector3(x2, y, z);
	}

	private static void CalculatePerspectiveFrustumCorners(ActViewCamSetting setting, float z, Vector3[] outCorners)
	{
		float num = setting.fieldOfView * (MathF.PI / 180f);
		float num2 = setting.aspect;
		float num3 = z * Mathf.Tan(num * 0.5f);
		float num4 = num3 * num2;
		Rect rect = setting.rect;
		float x = 0f - num4 + rect.x * 2f * num4;
		float x2 = 0f - num4 + rect.width * 2f * num4;
		float y = 0f - num3 + rect.y * 2f * num3;
		float y2 = 0f - num3 + rect.height * 2f * num3;
		outCorners[0] = new Vector3(x, y, z);
		outCorners[1] = new Vector3(x, y2, z);
		outCorners[2] = new Vector3(x2, y2, z);
		outCorners[3] = new Vector3(x2, y, z);
	}

	private static void SweepViewClipPlane(in Vector3[] corners, in float step, List<Vector3> checkPositions, HashSet<string> checkKeys)
	{
		Vector3 vector = corners[3] - corners[0];
		Vector3 vector2 = corners[1] - corners[0];
		float num = vector.magnitude * 0.5f + step;
		float num2 = vector2.magnitude * 0.5f + step;
		Vector3 normalized = vector.normalized;
		Vector3 normalized2 = vector2.normalized;
		Vector3 vector3 = corners[0] + (corners[3] + corners[1] - corners[0] * 2f) * 0.5f;
		InsertCheckPositon(vector3, checkPositions, checkKeys);
		for (float num3 = step; num3 < num; num3 += step)
		{
			for (float num4 = step; num4 < num2; num4 += step)
			{
				Vector3 vector4 = normalized * num3;
				Vector3 vector5 = normalized2 * num4;
				InsertCheckPositon(vector3 + vector4, checkPositions, checkKeys);
				InsertCheckPositon(vector3 + vector5, checkPositions, checkKeys);
				InsertCheckPositon(vector3 - vector4, checkPositions, checkKeys);
				InsertCheckPositon(vector3 - vector5, checkPositions, checkKeys);
				InsertCheckPositon(vector3 + vector4 - vector5, checkPositions, checkKeys);
				InsertCheckPositon(vector3 + vector4 + vector5, checkPositions, checkKeys);
				InsertCheckPositon(vector3 - vector4 - vector5, checkPositions, checkKeys);
				InsertCheckPositon(vector3 - vector4 + vector5, checkPositions, checkKeys);
			}
		}
	}

	private static void InsertCheckPositon(Vector3 pos, List<Vector3> checkPositions, HashSet<string> checkKeys)
	{
		int num = Mathf.RoundToInt(pos.x);
		int num2 = Mathf.RoundToInt(pos.y);
		int num3 = Mathf.RoundToInt(pos.z);
		string item = $"{num},{num2},{num3}";
		if (checkKeys.Add(item))
		{
			checkPositions.Add(new Vector3(num, num2, num3));
		}
	}
}
