using System;
using UnityEngine;

namespace ACT.Battle;

public class MonoLineEffect : MonoEffect
{
	public struct Locatable
	{
		private bool isTrans;

		private Transform transform;

		private Vector3 position;

		public void Set(Vector3 position)
		{
			isTrans = false;
			this.position = position;
		}

		public void Set(Transform transform)
		{
			isTrans = true;
			this.transform = transform;
		}

		public Vector3 Get()
		{
			if (!isTrans)
			{
				return position;
			}
			return transform.position;
		}

		public static implicit operator Vector3(Locatable locatable)
		{
			return locatable.Get();
		}

		public static implicit operator Locatable(Vector3 position)
		{
			Locatable result = default;
			result.Set(position);
			return result;
		}

		public static implicit operator Locatable(Transform transform)
		{
			Locatable result = default;
			result.Set(transform);
			return result;
		}
	}

	public LineRenderer lineRenderer;

	public bool localPos;

	[NonSerialized]
	public Locatable start;

	[NonSerialized]
	public Locatable end;

	private void Awake()
	{
		lineRenderer = GetComponentInChildren<LineRenderer>();
		if (localPos)
		{
			Vector3 position = transform.position;
			lineRenderer.SetPosition(0, start - position);
			lineRenderer.SetPosition(1, end - position);
		}
		else
		{
			lineRenderer.SetPosition(0, start);
			lineRenderer.SetPosition(1, end);
		}
	}

	private void LateUpdate()
	{
		if (localPos)
		{
			Vector3 position = transform.position;
			Quaternion quaternion = Quaternion.Inverse(transform.rotation);
			lineRenderer.SetPosition(0, quaternion * (start - position));
			lineRenderer.SetPosition(1, quaternion * (end - position));
		}
		else
		{
			lineRenderer.SetPosition(0, start);
			lineRenderer.SetPosition(1, end);
		}
	}

	public override void StartEffect(EffectRuntimeItem item)
	{
		controlRemove = true;
	}

	public override void SetToBeRemove()
	{
		isDone = true;
		base.SetToBeRemove();
	}
}
