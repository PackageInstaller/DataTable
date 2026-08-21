using UnityEngine;

public class QWLookAtBone
{
	public Transform transform;

	public Vector3 axis = -Vector3.right;

	public Vector3 forward => transform.rotation * axis;

	public QWLookAtBone(Transform transform)
	{
		this.transform = transform;
	}

	public void Initiate(Transform headTrans, Transform root)
	{
		if (!(headTrans == null))
		{
			transform = headTrans;
			axis = Quaternion.Inverse(transform.rotation) * root.forward;
		}
	}

	public void LookAt(Vector3 direction, float weight)
	{
		if (!(transform == null))
		{
			Quaternion quaternion = Quaternion.FromToRotation(forward, direction);
			Quaternion rotation = transform.rotation;
			transform.rotation = Quaternion.Lerp(rotation, quaternion * rotation, weight);
		}
	}
}
