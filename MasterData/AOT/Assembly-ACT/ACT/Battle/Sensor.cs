using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle;

[Serializable]
public class Sensor
{
	public enum CastDirection
	{
		Forward,
		Right,
		Up,
		Backward,
		Left,
		Down
	}

	[SerializeField]
	public enum CastType
	{
		Raycast,
		RaycastArray,
		Spherecast
	}

	public float castLength = 1f;

	public float sphereCastRadius = 0.2f;

	private Vector3 origin = Vector3.zero;

	private CastDirection castDirection;

	private bool hasDetectedHit;

	private Vector3 hitPosition;

	private Vector3 hitNormal;

	private float hitDistance;

	private List<Collider> hitColliders = new List<Collider>();

	private List<Transform> hitTransforms = new List<Transform>();

	private Vector3 backupNormal;

	private Transform tr;

	private Collider col;

	public CastType castType;

	public LayerMask layermask = 255;

	private int ignoreRaycastLayer;

	public bool calculateRealSurfaceNormal;

	public bool calculateRealDistance;

	public int arrayRayCount = 9;

	public int ArrayRows = 3;

	public bool offsetArrayRows;

	private Vector3[] raycastArrayStartPositions;

	private Collider[] ignoreList;

	private int[] ignoreListLayers;

	public bool isInDebugMode;

	private List<Vector3> arrayNormals = new List<Vector3>();

	private List<Vector3> arrayPoints = new List<Vector3>();

	public Sensor(Transform _transform, Collider _collider)
	{
		tr = _transform;
		if (!(_collider == null))
		{
			ignoreList = new Collider[1];
			ignoreList[0] = _collider;
			ignoreRaycastLayer = LayerMask.NameToLayer("Ignore Raycast");
			ignoreListLayers = new int[ignoreList.Length];
		}
	}

	private void ResetFlags()
	{
		hasDetectedHit = false;
		hitPosition = Vector3.zero;
		hitNormal = -GetCastDirection();
		hitDistance = 0f;
		if (hitColliders.Count > 0)
		{
			hitColliders.Clear();
		}
		if (hitTransforms.Count > 0)
		{
			hitTransforms.Clear();
		}
	}

	public static Vector3[] GetRaycastStartPositions(int sensorRows, int sensorRayCount, bool offsetRows, float sensorRadius)
	{
		List<Vector3> list = new List<Vector3>();
		Vector3 zero = Vector3.zero;
		list.Add(zero);
		for (int i = 0; i < sensorRows; i++)
		{
			float num = (float)(i + 1) / (float)sensorRows;
			for (int j = 0; j < sensorRayCount * (i + 1); j++)
			{
				float num2 = 360f / (float)(sensorRayCount * (i + 1)) * (float)j;
				if (offsetRows && i % 2 == 0)
				{
					num2 += 360f / (float)(sensorRayCount * (i + 1)) / 2f;
				}
				float x = num * Mathf.Cos(MathF.PI / 180f * num2);
				float z = num * Mathf.Sin(MathF.PI / 180f * num2);
				list.Add(new Vector3(x, 0f, z) * sensorRadius);
			}
		}
		return list.ToArray();
	}

	public void Cast()
	{
		ResetFlags();
		Vector3 direction = GetCastDirection();
		Vector3 vector = tr.TransformPoint(origin);
		if (ignoreListLayers.Length != ignoreList.Length)
		{
			ignoreListLayers = new int[ignoreList.Length];
		}
		for (int i = 0; i < ignoreList.Length; i++)
		{
			ignoreListLayers[i] = ignoreList[i].gameObject.layer;
			ignoreList[i].gameObject.layer = ignoreRaycastLayer;
		}
		switch (castType)
		{
		case CastType.Raycast:
			CastRay(vector, direction);
			break;
		case CastType.Spherecast:
			CastSphere(vector, direction);
			break;
		case CastType.RaycastArray:
			CastRayArray(vector, direction);
			break;
		default:
			hasDetectedHit = false;
			break;
		}
		for (int j = 0; j < ignoreList.Length; j++)
		{
			ignoreList[j].gameObject.layer = ignoreListLayers[j];
		}
	}

	public void Cast(Vector3 dir)
	{
		ResetFlags();
		Vector3 normalized = dir.normalized;
		Vector3 vector = tr.TransformPoint(origin);
		if (ignoreListLayers.Length != ignoreList.Length)
		{
			ignoreListLayers = new int[ignoreList.Length];
		}
		for (int i = 0; i < ignoreList.Length; i++)
		{
			ignoreListLayers[i] = ignoreList[i].gameObject.layer;
			ignoreList[i].gameObject.layer = ignoreRaycastLayer;
		}
		switch (castType)
		{
		case CastType.Raycast:
			CastRay(vector, normalized);
			break;
		case CastType.Spherecast:
			CastSphere(vector, normalized);
			break;
		case CastType.RaycastArray:
			CastRayArray(vector, normalized);
			break;
		default:
			hasDetectedHit = false;
			break;
		}
		for (int j = 0; j < ignoreList.Length; j++)
		{
			ignoreList[j].gameObject.layer = ignoreListLayers[j];
		}
	}

	private void CastRayArray(Vector3 _origin, Vector3 _direction)
	{
		_ = Vector3.zero;
		Vector3 direction = GetCastDirection();
		arrayNormals.Clear();
		arrayPoints.Clear();
		for (int i = 0; i < raycastArrayStartPositions.Length; i++)
		{
			if (Physics.Raycast(_origin + tr.TransformDirection(raycastArrayStartPositions[i]), direction, out var hitInfo, castLength, layermask, QueryTriggerInteraction.Ignore))
			{
				if (isInDebugMode)
				{
					Debug.DrawRay(hitInfo.point, hitInfo.normal, Color.red, Time.fixedDeltaTime * 1.01f);
				}
				hitColliders.Add(hitInfo.collider);
				hitTransforms.Add(hitInfo.transform);
				arrayNormals.Add(hitInfo.normal);
				arrayPoints.Add(hitInfo.point);
			}
		}
		hasDetectedHit = arrayPoints.Count > 0;
		if (hasDetectedHit)
		{
			Vector3 zero = Vector3.zero;
			for (int j = 0; j < arrayNormals.Count; j++)
			{
				zero += arrayNormals[j];
			}
			zero.Normalize();
			Vector3 zero2 = Vector3.zero;
			for (int k = 0; k < arrayPoints.Count; k++)
			{
				zero2 += arrayPoints[k];
			}
			zero2 /= (float)arrayPoints.Count;
			hitPosition = zero2;
			hitNormal = zero;
			hitDistance = VectorMath.ExtractDotVector(_origin - hitPosition, _direction).magnitude;
		}
	}

	private void CastRay(Vector3 _origin, Vector3 _direction)
	{
		hasDetectedHit = Physics.Raycast(_origin, _direction, out var hitInfo, castLength, layermask, QueryTriggerInteraction.Ignore);
		Debug.DrawRay(_origin, _direction * castLength, Color.yellow, Time.fixedDeltaTime * 1.01f);
		if (hasDetectedHit)
		{
			hitPosition = hitInfo.point;
			hitNormal = hitInfo.normal;
			hitColliders.Add(hitInfo.collider);
			hitTransforms.Add(hitInfo.transform);
			hitDistance = hitInfo.distance;
		}
	}

	private void CastSphere(Vector3 _origin, Vector3 _direction)
	{
		hasDetectedHit = Physics.SphereCast(_origin, sphereCastRadius, _direction, out var hitInfo, castLength - sphereCastRadius, layermask, QueryTriggerInteraction.Ignore);
		if (!hasDetectedHit)
		{
			return;
		}
		hitPosition = hitInfo.point;
		hitNormal = hitInfo.normal;
		hitColliders.Add(hitInfo.collider);
		hitTransforms.Add(hitInfo.transform);
		hitDistance = hitInfo.distance;
		hitDistance += sphereCastRadius;
		if (calculateRealDistance)
		{
			hitDistance = VectorMath.ExtractDotVector(_origin - hitPosition, _direction).magnitude;
		}
		Collider collider = hitColliders[0];
		if (!calculateRealSurfaceNormal)
		{
			return;
		}
		if (collider.Raycast(new Ray(hitPosition - _direction, _direction), out hitInfo, 1.5f))
		{
			if (Vector3.Angle(hitInfo.normal, -_direction) >= 89f)
			{
				hitNormal = backupNormal;
			}
			else
			{
				hitNormal = hitInfo.normal;
			}
		}
		else
		{
			hitNormal = backupNormal;
		}
		backupNormal = hitNormal;
	}

	private Vector3 GetCastDirection()
	{
		return castDirection switch
		{
			CastDirection.Forward => tr.forward, 
			CastDirection.Right => tr.right, 
			CastDirection.Up => tr.up, 
			CastDirection.Backward => -tr.forward, 
			CastDirection.Left => -tr.right, 
			CastDirection.Down => -tr.up, 
			_ => Vector3.one, 
		};
	}

	public void DrawDebug()
	{
		if (hasDetectedHit && isInDebugMode)
		{
			Debug.DrawRay(hitPosition, hitNormal, Color.red, Time.deltaTime);
			float num = 0.2f;
			Debug.DrawLine(hitPosition + Vector3.up * num, hitPosition - Vector3.up * num, Color.green, Time.deltaTime);
			Debug.DrawLine(hitPosition + Vector3.right * num, hitPosition - Vector3.right * num, Color.green, Time.deltaTime);
			Debug.DrawLine(hitPosition + Vector3.forward * num, hitPosition - Vector3.forward * num, Color.green, Time.deltaTime);
		}
	}

	public bool HasDetectedHit()
	{
		return hasDetectedHit;
	}

	public float GetDistance()
	{
		return hitDistance;
	}

	public Vector3 GetNormal()
	{
		return hitNormal;
	}

	public Vector3 GetPosition()
	{
		return hitPosition;
	}

	public Collider GetCollider()
	{
		return hitColliders[0];
	}

	public Transform GetTransform()
	{
		return hitTransforms[0];
	}

	public void SetCastOrigin(Vector3 _origin)
	{
		if (!(tr == null))
		{
			origin = tr.InverseTransformPoint(_origin);
		}
	}

	public void SetCastDirection(CastDirection _direction)
	{
		if (!(tr == null))
		{
			castDirection = _direction;
		}
	}

	public void RecalibrateRaycastArrayPositions()
	{
		raycastArrayStartPositions = GetRaycastStartPositions(ArrayRows, arrayRayCount, offsetArrayRows, sphereCastRadius);
	}
}
