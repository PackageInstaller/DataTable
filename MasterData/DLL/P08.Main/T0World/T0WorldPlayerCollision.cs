using UnityEngine;

namespace T0World;

public class T0WorldPlayerCollision : MonoBehaviour
{
	public LayerMask blockLayer;

	public LayerMask groundLayer;

	public float skinWidth = 0.01f;

	public float radiusOffset = 0.01f;

	public float radiusPredictRatio = 0.5f;

	private Collider[] neighbours;

	private RaycastHit[] hits;

	private CapsuleCollider mCollider;

	public Vector2 BodySize = new Vector2(0.6f, 2f);

	public LayerMask BlockLayer => blockLayer;

	public LayerMask GroundLayer => groundLayer;

	public Vector3 Position
	{
		get
		{
			return base.transform.position;
		}
		set
		{
			base.transform.position = value;
		}
	}

	public Quaternion Rotation
	{
		get
		{
			return base.transform.rotation;
		}
		set
		{
			base.transform.rotation = value;
		}
	}

	public Vector3 Forward
	{
		get
		{
			return Rotation * Vector3.forward;
		}
		set
		{
			Quaternion quaternion = Quaternion.FromToRotation(Forward, value);
			Rotation = quaternion * Rotation;
		}
	}

	public virtual Vector3 Up
	{
		get
		{
			return Rotation * Vector3.up;
		}
		set
		{
			Quaternion quaternion = Quaternion.FromToRotation(Up, value);
			Rotation = quaternion * Rotation;
		}
	}

	private CapsuleCollider thisCollider
	{
		get
		{
			if (mCollider == null)
			{
				mCollider = GetComponent<CapsuleCollider>();
			}
			return mCollider;
		}
	}

	public Vector3 GetBottomCenter(Vector3 position, float bottomOffset = 0f)
	{
		return position + Up * (BodySize.y / 2f + bottomOffset);
	}

	public Vector3 GetTopCenter(Vector3 position, float topOffset = 0f)
	{
		return position + Up * ((0f - BodySize.y) / 2f - topOffset);
	}

	public Vector3 ComputePenetrationIter(int iterTimes, float buttomOffset, float topOffset)
	{
		float radius = BodySize.x * 0.5f;
		Vector3 zero = Vector3.zero;
		float num = 0.001f;
		for (int i = 0; i < iterTimes; i++)
		{
			Vector3 vector = ComputePenetration(buttomOffset, topOffset, radius);
			if (vector.magnitude < num)
			{
				break;
			}
			zero += vector;
			Position += vector;
		}
		return zero;
	}

	protected Vector3 ComputePenetration(float buttomOffset, float topOffset, float radius)
	{
		if (neighbours == null)
		{
			neighbours = new Collider[8];
		}
		int num = 0;
		Vector3 bottomCenter = GetBottomCenter(base.transform.position, buttomOffset);
		Vector3 topCenter = GetTopCenter(base.transform.position, topOffset);
		if (thisCollider == null)
		{
			return Vector3.zero;
		}
		for (int i = 0; i < neighbours.Length; i++)
		{
			neighbours[i] = null;
		}
		int layerMask = BlockLayer;
		num = Physics.OverlapCapsuleNonAlloc(bottomCenter, topCenter, radius * 2f, neighbours, layerMask);
		if (num == 0)
		{
			return Vector3.zero;
		}
		Vector3 zero = Vector3.zero;
		for (int j = 0; j < num; j++)
		{
			Collider collider = neighbours[j];
			if (!(collider.transform == thisCollider))
			{
				int layer = collider.gameObject.layer;
				if (((1 << layer) & (int)GroundLayer) > 0)
				{
					zero += Vector3.zero;
				}
				else if (((1 << layer) & (int)BlockLayer) > 0)
				{
					zero += ComputeBlockPenetration(collider);
				}
			}
		}
		return Vector3.ClampMagnitude(zero, BodySize.x * 0.5f);
	}

	private Vector3 ComputeBlockPenetration(Collider collider)
	{
		Vector3 position = collider.gameObject.transform.position;
		Quaternion rotation = collider.gameObject.transform.rotation;
		float distance = 0f;
		if (Physics.ComputePenetration(thisCollider, thisCollider.transform.position, thisCollider.transform.rotation, collider, position, rotation, out var direction, out distance))
		{
			Debug.DrawRay(base.transform.position, direction * 10f, Color.yellow);
			return direction * Mathf.Max(distance + skinWidth, 0.001f);
		}
		return Vector3.zero;
	}
}
