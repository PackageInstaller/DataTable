using System;
using Pathfinding;
using Sirenix.OdinInspector;
using UnityEngine;

namespace P08.SimBusiness;

public class DynamicObstacle : SerializedMonoBehaviour
{
	private class DyanamicObstacleModifier : GraphModifier
	{
		private DynamicObstacle obstacle;

		internal DyanamicObstacleModifier(DynamicObstacle obstacle)
		{
			this.obstacle = obstacle;
		}

		public override void OnPostScan()
		{
			obstacle.prevEnabled = obstacle.colliderEnabled;
		}

		internal void CallEnable()
		{
			OnEnable();
		}

		internal void CallDisable()
		{
			OnDisable();
		}
	}

	public Collider collider;

	public float updateError = 1f;

	public float checkTime = 0.2f;

	private Bounds prevBounds;

	private Quaternion prevRotation;

	private bool prevEnabled;

	private float lastCheckTime = -9999f;

	private DyanamicObstacleModifier modifier;

	private Bounds? bounds
	{
		get
		{
			if (!collider)
			{
				return null;
			}
			return collider.bounds;
		}
	}

	private bool colliderEnabled
	{
		get
		{
			if (!collider)
			{
				return false;
			}
			return collider.enabled;
		}
	}

	private DyanamicObstacleModifier GraphModifier
	{
		get
		{
			if (modifier == null)
			{
				modifier = new DyanamicObstacleModifier(this);
			}
			return modifier;
		}
	}

	private void Awake()
	{
		if (collider == null)
		{
			throw new Exception("A collider must be attached to the GameObject(" + base.gameObject.name + ") for the DynamicObstacle to work");
		}
		prevBounds = bounds.Value;
		prevRotation = base.transform.rotation;
		prevEnabled = false;
	}

	private void OnEnable()
	{
		GraphModifier.CallEnable();
	}

	private void OnDisable()
	{
		GraphModifier.CallDisable();
		if (AstarPath.active != null && Application.isPlaying)
		{
			GraphUpdateObject ob = new GraphUpdateObject(prevBounds);
			AstarPath.active.UpdateGraphs(ob);
			prevEnabled = false;
		}
	}

	private void Update()
	{
		if (collider == null)
		{
			Debug.LogError("Removed collider from DynamicGridObstacle", this);
			base.enabled = false;
		}
		else
		{
			if (AstarPath.active == null || AstarPath.active.isScanning || Time.realtimeSinceStartup - lastCheckTime < checkTime || !Application.isPlaying)
			{
				return;
			}
			lastCheckTime = Time.realtimeSinceStartup;
			if (colliderEnabled)
			{
				Bounds value = bounds.Value;
				Quaternion rotation = base.transform.rotation;
				Vector3 vector = prevBounds.min - value.min;
				Vector3 vector2 = prevBounds.max - value.max;
				float num = value.extents.magnitude * Quaternion.Angle(prevRotation, rotation) * (MathF.PI / 180f);
				if (vector.sqrMagnitude > updateError * updateError || vector2.sqrMagnitude > updateError * updateError || num > updateError || !prevEnabled)
				{
					DoUpdateGraphs();
				}
			}
			else if (prevEnabled)
			{
				DoUpdateGraphs();
			}
		}
	}

	public void DoUpdateGraphs()
	{
		if (collider == null)
		{
			return;
		}
		if (!colliderEnabled)
		{
			AstarPath.active.UpdateGraphs(prevBounds);
		}
		else
		{
			Bounds value = bounds.Value;
			Bounds b = value;
			b.Encapsulate(prevBounds);
			if (BoundsVolume(b) < BoundsVolume(value) + BoundsVolume(prevBounds))
			{
				AstarPath.active.UpdateGraphs(b);
				DrawUpdateBounds(b, Color.yellow);
			}
			else
			{
				AstarPath.active.UpdateGraphs(prevBounds);
				DrawUpdateBounds(prevBounds, Color.red);
				AstarPath.active.UpdateGraphs(value);
				DrawUpdateBounds(value, Color.green);
			}
			prevBounds = value;
		}
		prevEnabled = AstarPath.active != null && colliderEnabled;
		prevRotation = base.transform.rotation;
		lastCheckTime = Time.realtimeSinceStartup;
	}

	private static float BoundsVolume(Bounds b)
	{
		return Math.Abs(b.size.x * b.size.y * b.size.z);
	}

	private static void DrawUpdateBounds(Bounds bounds, Color color)
	{
	}
}
