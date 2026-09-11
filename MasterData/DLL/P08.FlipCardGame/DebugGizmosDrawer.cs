using System;
using System.Collections.Generic;
using UnityEngine;

[DisallowMultipleComponent]
public class DebugGizmosDrawer : MonoBehaviour
{
	[SerializeField]
	private VehicleAssembler assembler;

	[SerializeField]
	private VehiclePhysicsController physicsController;

	[SerializeField]
	private bool drawRuntimeGizmos;

	[SerializeField]
	private bool drawMountPoints = true;

	[SerializeField]
	private bool drawCenterOfMass = true;

	[SerializeField]
	private bool drawWheelRadiusAndContact = true;

	[SerializeField]
	private bool drawRecoilVector = true;

	[SerializeField]
	private bool drawVelocity = true;

	[SerializeField]
	private float mountCubeSize = 0.1f;

	[SerializeField]
	private float wheelVectorScale = 0.35f;

	private readonly List<VehiclePhysicsController.DebugWheelState> wheelStates = new List<VehiclePhysicsController.DebugWheelState>(8);

	private void Reset()
	{
		assembler = GetComponent<VehicleAssembler>();
		physicsController = GetComponent<VehiclePhysicsController>();
	}

	private void OnDrawGizmos()
	{
		if (!drawRuntimeGizmos)
		{
			return;
		}
		if (assembler == null || physicsController == null)
		{
			Reset();
		}
		if (!(assembler == null) && !(physicsController == null))
		{
			if (drawMountPoints)
			{
				DrawMounts();
			}
			if (drawCenterOfMass)
			{
				DrawCenterOfMass();
			}
			if (drawWheelRadiusAndContact)
			{
				DrawWheels();
			}
			if (drawRecoilVector)
			{
				DrawRecoil();
			}
			if (drawVelocity)
			{
				DrawVelocity();
			}
		}
	}

	private void DrawMounts()
	{
		IReadOnlyList<MountPoint> mountPoints = assembler.MountPoints;
		for (int i = 0; i < mountPoints.Count; i++)
		{
			MountPoint mountPoint = mountPoints[i];
			if (!(mountPoint == null))
			{
				Gizmos.color = GetMountColor(mountPoint.MountType);
				Gizmos.DrawCube(mountPoint.transform.position, Vector3.one * mountCubeSize);
				Gizmos.DrawLine(mountPoint.transform.position, mountPoint.transform.position + mountPoint.transform.right * 0.25f);
			}
		}
	}

	private void DrawCenterOfMass()
	{
		Gizmos.color = Color.magenta;
		Vector2 centerOfMassWorld = physicsController.CenterOfMassWorld;
		Gizmos.DrawSphere(centerOfMassWorld, 0.08f);
		Gizmos.DrawLine(centerOfMassWorld, centerOfMassWorld + Vector2.up * 0.25f);
	}

	private void DrawWheels()
	{
		wheelStates.Clear();
		physicsController.CopyDebugWheelStates(wheelStates);
		for (int i = 0; i < wheelStates.Count; i++)
		{
			VehiclePhysicsController.DebugWheelState debugWheelState = wheelStates[i];
			Gizmos.color = (debugWheelState.grounded ? new Color(0.2f, 1f, 0.4f, 0.9f) : new Color(1f, 0.65f, 0.2f, 0.9f));
			DrawCircle(debugWheelState.worldPos, debugWheelState.radius, 24);
			if (debugWheelState.grounded)
			{
				Gizmos.DrawLine(debugWheelState.worldPos, debugWheelState.contactPoint);
				Gizmos.DrawSphere(debugWheelState.contactPoint, 0.03f);
				Gizmos.color = Color.green;
				Gizmos.DrawLine(debugWheelState.contactPoint, debugWheelState.contactPoint + debugWheelState.contactNormal * wheelVectorScale);
				Gizmos.color = Color.yellow;
				Gizmos.DrawLine(debugWheelState.contactPoint, debugWheelState.contactPoint + debugWheelState.contactTangent * wheelVectorScale);
				Gizmos.color = Color.red;
				Gizmos.DrawLine(debugWheelState.contactPoint, debugWheelState.contactPoint + debugWheelState.motorForce * 0.002f);
			}
		}
	}

	private void DrawRecoil()
	{
		if (!(physicsController.LastRecoilAge > 0.2f))
		{
			Gizmos.color = Color.red;
			Vector2 lastRecoilPoint = physicsController.LastRecoilPoint;
			Vector2 vector = physicsController.LastRecoilForce * 0.0025f;
			Gizmos.DrawLine(lastRecoilPoint, lastRecoilPoint + vector);
			Gizmos.DrawSphere(lastRecoilPoint, 0.04f);
		}
	}

	private void DrawVelocity()
	{
		Vector2 centerOfMassWorld = physicsController.CenterOfMassWorld;
		Vector2 velocityWorld = physicsController.VelocityWorld;
		Gizmos.color = Color.cyan;
		Gizmos.DrawLine(centerOfMassWorld, centerOfMassWorld + velocityWorld * 0.2f);
		Gizmos.DrawSphere(centerOfMassWorld + velocityWorld * 0.2f, 0.025f);
	}

	private static Color GetMountColor(VehicleMountType type)
	{
		return type switch
		{
			VehicleMountType.Wheel => new Color(0.25f, 0.9f, 1f, 0.85f), 
			VehicleMountType.Weapon => new Color(1f, 0.35f, 0.35f, 0.85f), 
			_ => new Color(1f, 0.9f, 0.25f, 0.85f), 
		};
	}

	private static void DrawCircle(Vector2 center, float radius, int segments)
	{
		segments = Mathf.Max(8, segments);
		Vector3 vector = center + Vector2.right * radius;
		float num = MathF.PI * 2f / (float)segments;
		for (int i = 1; i <= segments; i++)
		{
			float f = num * (float)i;
			Vector3 vector2 = center + new Vector2(Mathf.Cos(f), Mathf.Sin(f)) * radius;
			Gizmos.DrawLine(vector, vector2);
			vector = vector2;
		}
	}
}
