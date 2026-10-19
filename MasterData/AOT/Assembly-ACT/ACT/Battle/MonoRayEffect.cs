using System;
using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class MonoRayEffect : MonoEffect
{
	public bool right;

	public bool boxCast;

	public BoxCollider boxCollider;

	public LayerMask colliderLayer;

	public float maxLength;

	public bool dontControlLineRadius;

	public float radius;

	public int maxReflections;

	public bool useExternalPath;

	public string externalRayHitName;

	public LineRenderer[] lines;

	public Transform[] endEffects;

	[NonSerialized]
	public Vector3 endPoint;

	private EffectRuntimeItem _runtimeItem;

	private readonly List<Vector3> _cachedPathPoints = new List<Vector3>();

	private readonly List<Vector3> _cachedHitPoints = new List<Vector3>();

	public override void StartEffect(EffectRuntimeItem item)
	{
		_runtimeItem = item;
		base.StartEffect(item);
	}

	public override void SetToBeRemove()
	{
		base.SetToBeRemove();
		isDone = true;
	}

	private void Update()
	{
		List<Vector3> list;
		int num;
		int num2;
		if (useExternalPath && TryGetExternalPath(out var pathPoints) && pathPoints.Count >= 2)
		{
			list = pathPoints;
			num = 1;
			num2 = list.Count - 2;
			endPoint = list[list.Count - 1];
		}
		else
		{
			_cachedPathPoints.Clear();
			_cachedHitPoints.Clear();
			ComputePathSelf(_cachedPathPoints, _cachedHitPoints);
			list = _cachedPathPoints;
			num = -1;
			num2 = _cachedHitPoints.Count;
		}
		LineRenderer[] array = lines;
		foreach (LineRenderer lineRenderer in array)
		{
			lineRenderer.positionCount = list.Count;
			for (int j = 0; j < list.Count; j++)
			{
				lineRenderer.SetPosition(j, lineRenderer.transform.InverseTransformPoint(list[j]));
			}
			if (!dontControlLineRadius)
			{
				lineRenderer.startWidth = radius;
				lineRenderer.endWidth = radius;
			}
		}
		for (int k = 0; k < endEffects.Length; k++)
		{
			if (k < num2)
			{
				endEffects[k].position = ((num >= 0) ? list[num + k] : _cachedHitPoints[k]);
				endEffects[k].gameObject.SetActive(value: true);
			}
			else
			{
				endEffects[k].position = endPoint;
			}
		}
	}

	private bool TryGetExternalPath(out List<Vector3> pathPoints)
	{
		pathPoints = null;
		if (!_runtimeItem.owner.IsValid || string.IsNullOrEmpty(externalRayHitName))
		{
			return false;
		}
		Dictionary<string, RayHitEffectInfo> dictionary = _runtimeItem.owner.GetCompEffect()?.rayEffectInfos;
		if (dictionary != null && dictionary.TryGetValue(externalRayHitName, out var value))
		{
			List<Vector3> reflectPathPoints = value.reflectPathPoints;
			if (reflectPathPoints != null && reflectPathPoints.Count >= 2)
			{
				pathPoints = value.reflectPathPoints;
				return true;
			}
		}
		return false;
	}

	private void ComputePathSelf(List<Vector3> pathPoints, List<Vector3> hitPoints)
	{
		Transform transform = base.transform;
		Vector3 vector = transform.position;
		Vector3 vector2 = (right ? transform.right : transform.forward);
		float num = maxLength;
		int num2 = 0;
		bool flag = false;
		pathPoints.Add(vector);
		while (num > 0.01f && num2 <= maxReflections)
		{
			bool flag2 = false;
			if (!((!boxCast) ? Physics.Raycast(vector, vector2, out var hitInfo, num, colliderLayer.value) : Physics.BoxCast(boxCollider.bounds.center + (vector - transform.position), orientation: (num2 == 0) ? transform.rotation : Quaternion.LookRotation(vector2, transform.up), halfExtents: boxCollider.size, direction: vector2, hitInfo: out hitInfo, maxDistance: num, layerMask: colliderLayer.value)))
			{
				Vector3 item = vector + vector2 * num;
				pathPoints.Add(item);
				endPoint = item;
				flag = true;
				break;
			}
			Vector3 vector3 = ((!boxCast) ? hitInfo.point : (vector + Vector3.Project(hitInfo.point - vector, vector2)));
			pathPoints.Add(vector3);
			hitPoints.Add(vector3);
			float distance = hitInfo.distance;
			num -= distance;
			if (num2 < maxReflections && num > 0.01f)
			{
				vector2 = Vector3.Reflect(vector2, hitInfo.normal).normalized;
				vector = vector3;
				num2++;
				continue;
			}
			endPoint = vector3;
			flag = true;
			break;
		}
		if (!flag && pathPoints.Count > 0)
		{
			endPoint = pathPoints[pathPoints.Count - 1];
		}
	}
}
