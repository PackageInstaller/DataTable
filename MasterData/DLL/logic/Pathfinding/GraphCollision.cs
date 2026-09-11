using System;
using System.Collections.Generic;
using Pathfinding.Serialization;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding;

[Serializable]
public class GraphCollision
{
	public ColliderType type;

	public float diameter;

	public float height;

	public float collisionOffset;

	public RayDirection rayDirection;

	public LayerMask mask;

	public LayerMask heightMask;

	public float fromHeight;

	public bool thickRaycast;

	public float thickRaycastDiameter;

	public bool unwalkableWhenNoGround;

	public bool use2D;

	public bool collisionCheck;

	public bool heightCheck;

	public Vector3 up;

	private Vector3 upheight;

	private float finalRadius;

	private float finalRaycastRadius;

	public const float RaycastErrorMargin = 0.005f;

	public void Initialize(GraphTransform transform, float scale)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = transform.Transform(Vector3.up) - transform.Transform(Vector3.zero);
		up = ((Vector3)(ref val)).normalized;
		upheight = up * height;
		finalRadius = diameter * scale * 0.5f;
		finalRaycastRadius = thickRaycastDiameter * scale * 0.5f;
	}

	public bool Check(Vector3 position)
	{
		//IL_006b: Unknown result type (might be due to invalid IL or missing references)
		//IL_006d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0078: Unknown result type (might be due to invalid IL or missing references)
		//IL_007d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0082: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c1: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_0092: Unknown result type (might be due to invalid IL or missing references)
		//IL_0093: Unknown result type (might be due to invalid IL or missing references)
		//IL_0095: Unknown result type (might be due to invalid IL or missing references)
		//IL_009a: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a6: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		//IL_0134: Unknown result type (might be due to invalid IL or missing references)
		//IL_0136: Unknown result type (might be due to invalid IL or missing references)
		//IL_0142: Unknown result type (might be due to invalid IL or missing references)
		//IL_0155: Unknown result type (might be due to invalid IL or missing references)
		//IL_0157: Unknown result type (might be due to invalid IL or missing references)
		//IL_015c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0162: Unknown result type (might be due to invalid IL or missing references)
		//IL_0167: Unknown result type (might be due to invalid IL or missing references)
		//IL_0173: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f0: Unknown result type (might be due to invalid IL or missing references)
		//IL_0101: Unknown result type (might be due to invalid IL or missing references)
		//IL_0103: Unknown result type (might be due to invalid IL or missing references)
		//IL_0108: Unknown result type (might be due to invalid IL or missing references)
		//IL_010e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0113: Unknown result type (might be due to invalid IL or missing references)
		//IL_011f: Unknown result type (might be due to invalid IL or missing references)
		if (!collisionCheck)
		{
			return true;
		}
		if (use2D)
		{
			return type switch
			{
				ColliderType.Capsule => throw new Exception("Capsule mode cannot be used with 2D since capsules don't exist in 2D. Please change the Physics Testing -> Collider Type setting."), 
				ColliderType.Sphere => (Object)(object)Physics2D.OverlapCircle(Vector2.op_Implicit(position), finalRadius, LayerMask.op_Implicit(mask)) == (Object)null, 
				_ => (Object)(object)Physics2D.OverlapPoint(Vector2.op_Implicit(position), LayerMask.op_Implicit(mask)) == (Object)null, 
			};
		}
		position += up * collisionOffset;
		switch (type)
		{
		case ColliderType.Capsule:
			return !Physics.CheckCapsule(position, position + upheight, finalRadius, LayerMask.op_Implicit(mask));
		case ColliderType.Sphere:
			return !Physics.CheckSphere(position, finalRadius, LayerMask.op_Implicit(mask));
		default:
			switch (rayDirection)
			{
			case RayDirection.Both:
				if (!Physics.Raycast(position, up, height, LayerMask.op_Implicit(mask)))
				{
					return !Physics.Raycast(position + upheight, -up, height, LayerMask.op_Implicit(mask));
				}
				return false;
			case RayDirection.Up:
				return !Physics.Raycast(position, up, height, LayerMask.op_Implicit(mask));
			default:
				return !Physics.Raycast(position + upheight, -up, height, LayerMask.op_Implicit(mask));
			}
		}
	}

	public Vector3 CheckHeight(Vector3 position)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		RaycastHit hit;
		bool walkable;
		return CheckHeight(position, out hit, out walkable);
	}

	public Vector3 CheckHeight(Vector3 position, out RaycastHit hit, out bool walkable)
	{
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ac: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ae: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00be: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00dc: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0065: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ee: Unknown result type (might be due to invalid IL or missing references)
		//IL_0078: Unknown result type (might be due to invalid IL or missing references)
		//IL_007f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0086: Unknown result type (might be due to invalid IL or missing references)
		//IL_008b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0091: Unknown result type (might be due to invalid IL or missing references)
		//IL_0096: Unknown result type (might be due to invalid IL or missing references)
		//IL_0102: Unknown result type (might be due to invalid IL or missing references)
		walkable = true;
		if (!heightCheck || use2D)
		{
			hit = default(RaycastHit);
			return position;
		}
		if (thickRaycast)
		{
			Ray val = default(Ray);
			((Ray)(ref val))._002Ector(position + up * fromHeight, -up);
			if (Physics.SphereCast(val, finalRaycastRadius, ref hit, fromHeight + 0.005f, LayerMask.op_Implicit(heightMask)))
			{
				return VectorMath.ClosestPointOnLine(((Ray)(ref val)).origin, ((Ray)(ref val)).origin + ((Ray)(ref val)).direction, ((RaycastHit)(ref hit)).point);
			}
			walkable &= !unwalkableWhenNoGround;
		}
		else
		{
			if (Physics.Raycast(position + up * fromHeight, -up, ref hit, fromHeight + 0.005f, LayerMask.op_Implicit(heightMask)))
			{
				return ((RaycastHit)(ref hit)).point;
			}
			walkable &= !unwalkableWhenNoGround;
		}
		return position;
	}

	public Vector3 Raycast(Vector3 origin, out RaycastHit hit, out bool walkable)
	{
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ab: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c3: Unknown result type (might be due to invalid IL or missing references)
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		//IL_004d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0062: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d5: Unknown result type (might be due to invalid IL or missing references)
		//IL_0075: Unknown result type (might be due to invalid IL or missing references)
		//IL_007c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0083: Unknown result type (might be due to invalid IL or missing references)
		//IL_0088: Unknown result type (might be due to invalid IL or missing references)
		//IL_008e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0093: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00eb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fb: Unknown result type (might be due to invalid IL or missing references)
		walkable = true;
		if (!heightCheck || use2D)
		{
			hit = default(RaycastHit);
			return origin - up * fromHeight;
		}
		if (thickRaycast)
		{
			Ray val = default(Ray);
			((Ray)(ref val))._002Ector(origin, -up);
			if (Physics.SphereCast(val, finalRaycastRadius, ref hit, fromHeight + 0.005f, LayerMask.op_Implicit(heightMask)))
			{
				return VectorMath.ClosestPointOnLine(((Ray)(ref val)).origin, ((Ray)(ref val)).origin + ((Ray)(ref val)).direction, ((RaycastHit)(ref hit)).point);
			}
			walkable &= !unwalkableWhenNoGround;
		}
		else
		{
			if (Physics.Raycast(origin, -up, ref hit, fromHeight + 0.005f, LayerMask.op_Implicit(heightMask)))
			{
				return ((RaycastHit)(ref hit)).point;
			}
			walkable &= !unwalkableWhenNoGround;
		}
		return origin - up * fromHeight;
	}

	public unsafe RaycastHit[] CheckHeightAll(Vector3 position)
	{
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0034: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_0051: Unknown result type (might be due to invalid IL or missing references)
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		//IL_005e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_0068: Unknown result type (might be due to invalid IL or missing references)
		//IL_0069: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		//IL_0078: Unknown result type (might be due to invalid IL or missing references)
		//IL_0092: Unknown result type (might be due to invalid IL or missing references)
		//IL_0097: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00af: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00be: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00db: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ea: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ef: Unknown result type (might be due to invalid IL or missing references)
		//IL_0104: Unknown result type (might be due to invalid IL or missing references)
		//IL_0105: Unknown result type (might be due to invalid IL or missing references)
		//IL_0119: Unknown result type (might be due to invalid IL or missing references)
		//IL_011a: Unknown result type (might be due to invalid IL or missing references)
		if (!heightCheck || use2D)
		{
			RaycastHit val = default(RaycastHit);
			((RaycastHit)(ref val)).point = position;
			((RaycastHit)(ref val)).distance = 0f;
			return (RaycastHit[])(object)new RaycastHit[1] { val };
		}
		if (thickRaycast)
		{
			return (RaycastHit[])(object)new RaycastHit[0];
		}
		List<RaycastHit> list = new List<RaycastHit>();
		Vector3 val2 = position + up * fromHeight;
		Vector3 val3 = Vector3.zero;
		int num = 0;
		while (true)
		{
			Raycast(val2, out var hit, out var _);
			if ((Object)(object)((RaycastHit)(ref hit)).transform == (Object)null)
			{
				break;
			}
			if (((RaycastHit)(ref hit)).point != val3 || list.Count == 0)
			{
				val2 = ((RaycastHit)(ref hit)).point - up * 0.005f;
				val3 = ((RaycastHit)(ref hit)).point;
				num = 0;
				list.Add(hit);
				continue;
			}
			val2 -= up * 0.001f;
			num++;
			if (num <= 10)
			{
				continue;
			}
			Vector3 val4 = val2;
			string text = ((object)(*(Vector3*)(&val4))/*cast due to constrained. prefix*/).ToString();
			val4 = val3;
			Debug.LogError((object)("Infinite Loop when raycasting. Please report this error (arongranberg.com)\n" + text + " : " + ((object)(*(Vector3*)(&val4))/*cast due to constrained. prefix*/).ToString()));
			break;
		}
		return list.ToArray();
	}

	public void DeserializeSettingsCompatibility(GraphSerializationContext ctx)
	{
		//IL_0061: Unknown result type (might be due to invalid IL or missing references)
		//IL_0066: Unknown result type (might be due to invalid IL or missing references)
		//IL_0077: Unknown result type (might be due to invalid IL or missing references)
		//IL_007c: Unknown result type (might be due to invalid IL or missing references)
		type = (ColliderType)ctx.reader.ReadInt32();
		diameter = ctx.reader.ReadSingle();
		height = ctx.reader.ReadSingle();
		collisionOffset = ctx.reader.ReadSingle();
		rayDirection = (RayDirection)ctx.reader.ReadInt32();
		mask = LayerMask.op_Implicit(ctx.reader.ReadInt32());
		heightMask = LayerMask.op_Implicit(ctx.reader.ReadInt32());
		fromHeight = ctx.reader.ReadSingle();
		thickRaycast = ctx.reader.ReadBoolean();
		thickRaycastDiameter = ctx.reader.ReadSingle();
		unwalkableWhenNoGround = ctx.reader.ReadBoolean();
		use2D = ctx.reader.ReadBoolean();
		collisionCheck = ctx.reader.ReadBoolean();
		heightCheck = ctx.reader.ReadBoolean();
	}

	public GraphCollision()
	{
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		type = ColliderType.Capsule;
		diameter = 1f;
		height = 2f;
		rayDirection = RayDirection.Both;
		heightMask = LayerMask.op_Implicit(-1);
		fromHeight = 100f;
		thickRaycastDiameter = 1f;
		unwalkableWhenNoGround = true;
		collisionCheck = true;
		heightCheck = true;
		base._002Ector();
	}
}
