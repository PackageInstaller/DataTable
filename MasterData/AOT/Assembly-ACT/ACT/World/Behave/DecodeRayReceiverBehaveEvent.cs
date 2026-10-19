using System;
using ACT.Utility;
using ACT.World.StateObject;
using UnityEngine;

namespace ACT.World.Behave;

public class DecodeRayReceiverBehaveEvent : LuminSerializedMonoBehaviour
{
	public abstract class RayChangeRule
	{
		public abstract Vector3 OnReflect(Vector3 inputVector, Vector3 normalVector);
	}

	public class ReflectRule : RayChangeRule
	{
		public override Vector3 OnReflect(Vector3 inputVector, Vector3 normalVector)
		{
			return Vector3.Reflect(inputVector, normalVector);
		}
	}

	public class RefractRule : RayChangeRule
	{
		[Tooltip("使用法线作为基准，否则以入射角为基准")]
		public bool useNormal;

		public float angleOffset;

		public override Vector3 OnReflect(Vector3 inputVector, Vector3 normalVector)
		{
			Vector3 vector = (useNormal ? normalVector : inputVector);
			return Quaternion.AngleAxis(angleOffset, Vector3.Cross(inputVector, normalVector)) * vector;
		}
	}

	public RayChangeRule rule;

	public string[] raycastLayer;

	private LayerMask m_Mask;

	private void Start()
	{
		m_Mask = LayerMask.GetMask(raycastLayer);
	}

	public void OnReflect(DecodeRayEmitterBehaveEvent emitter, Vector3 origin, Vector3 hitPoint)
	{
		emitter.receiverCounts++;
		Transform transform = base.transform;
		Vector3 position = transform.position;
		Vector3 forward = transform.forward;
		Vector3 vector = hitPoint - origin;
		Vector3 vector2 = rule.OnReflect(vector, forward);
		Vector3 intersectWithLineAndPlane = VectorUtility.GetIntersectWithLineAndPlane(hitPoint, vector, forward, (position - hitPoint).normalized * float.Epsilon + hitPoint);
		Ray ray = new Ray(intersectWithLineAndPlane, vector2.normalized);
		if (Physics.Raycast(ray, out var hitInfo, 1000f, m_Mask))
		{
			DecodeRayReceiverBehaveEvent component = hitInfo.transform.GetComponent<DecodeRayReceiverBehaveEvent>();
			StateObjectBase component2 = hitInfo.transform.GetComponent<StateObjectBase>();
			if ((bool)component && component != this)
			{
				try
				{
					emitter.AddCorner(intersectWithLineAndPlane, hitInfo.point);
				}
				catch (StackOverflowException)
				{
					return;
				}
				component.OnReflect(emitter, intersectWithLineAndPlane, hitInfo.point);
				return;
			}
			if ((bool)component2)
			{
				try
				{
					emitter.AddCorner(intersectWithLineAndPlane, hitInfo.point);
					emitter.OnShootStateObject(component2);
					return;
				}
				catch (Exception ex2)
				{
					if (!(ex2 is StackOverflowException))
					{
						Debug.LogException(ex2);
					}
					return;
				}
			}
			MissReceiver(emitter, intersectWithLineAndPlane, hitInfo.point);
		}
		else
		{
			MissReceiver(emitter, intersectWithLineAndPlane, ray.GetPoint(1000f));
		}
	}

	private void MissReceiver(DecodeRayEmitterBehaveEvent emitter, Vector3 start, Vector3 end)
	{
		emitter.AddCorner(start, end);
		emitter.OnMissStateObject();
	}
}
