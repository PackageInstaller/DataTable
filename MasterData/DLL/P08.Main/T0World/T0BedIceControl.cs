using UnityEngine;

namespace T0World;

public class T0BedIceControl : MonoBehaviour
{
	public Transform iceTrans;

	public Transform parentNode;

	public BedPosEnum applyBodyType;

	public Transform iceInitParent;

	public Vector3 minMovePos;

	public Vector3 maxMovePos;

	public Vector3 accumulatedDisplacement;

	public float posMoveSpeed = 0.0005f;

	public void BeginDrag()
	{
		accumulatedDisplacement = Vector3.zero;
		if (parentNode != null)
		{
			base.transform.SetParent(parentNode, worldPositionStays: true);
		}
	}

	public void EndDrag()
	{
		base.transform.SetParent(iceInitParent, worldPositionStays: true);
		accumulatedDisplacement = Vector3.zero;
		base.transform.localPosition = Vector3.zero;
		base.transform.localRotation = Quaternion.identity;
		base.transform.localScale = Vector3.one;
	}

	public void OnDragMove(Vector2 dragDelta)
	{
		Vector3 movePos = new Vector3((0f - dragDelta.y) * posMoveSpeed, dragDelta.x * posMoveSpeed, 0f);
		MoveIcePos(movePos);
	}

	public void MoveIcePos(Vector3 movePos)
	{
		Vector3 vector = accumulatedDisplacement + movePos;
		Vector3 vector2 = new Vector3(Mathf.Clamp(vector.x, minMovePos.x, maxMovePos.x), Mathf.Clamp(vector.y, minMovePos.y, maxMovePos.y), Mathf.Clamp(vector.z, minMovePos.z, maxMovePos.z));
		Vector3 vector3 = vector2 - accumulatedDisplacement;
		accumulatedDisplacement = vector2;
		if (iceTrans.parent != null)
		{
			Vector3 vector4 = iceTrans.rotation * vector3;
			Vector3 vector5 = base.transform.InverseTransformVector(vector4);
			base.transform.position -= base.transform.TransformVector(vector5);
		}
	}
}
