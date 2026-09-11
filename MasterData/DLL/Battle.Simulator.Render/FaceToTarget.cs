using UnityEngine;

public class FaceToTarget : MonoBehaviour
{
	public Transform Axle;

	public Transform Target;

	public Vector3 ReverseTurn = new Vector3(0f, 90f, -107f);

	private Vector3 m_originTargetPos = Vector3.zero;

	public void UpdateTargetPosition(Vector3 pos)
	{
		if (Target != null)
		{
			Target.position = new Vector3(pos.x, Target.position.y, pos.z);
		}
	}

	private void Awake()
	{
		m_originTargetPos = Target.localPosition;
	}

	private void Start()
	{
		ReverseTurn = Axle.localEulerAngles;
	}

	private void LateUpdate()
	{
		if (Axle != null && Target != null)
		{
			Axle.LookAt(Target);
			Axle.Rotate(ReverseTurn, Space.Self);
		}
	}

	private void OnDisable()
	{
		Target.localPosition = m_originTargetPos;
	}
}
