using System.Collections;
using UnityEngine;

public class FollowSlowAction : MonoBehaviour
{
	public Transform TargetPrefab;

	public bool IsUseX;

	public bool IsUseY;

	public bool IsUseZ;

	public float PositionDampingX;

	public float PositionDampingY;

	public float PositionDampingZ;

	public float RotationDamping;

	public bool IsUseDeadZone;

	public float DeadZoneTime;

	public float DeadZoneDistance;

	public string DeadZoneCenter;

	public NAgent TposeAgent;

	private bool canMove;

	private Vector3 rootPoint;

	private Transform point;

	private Coroutine deadZoneCoroutine;

	private bool isOnRunning;

	private void Start()
	{
		point = TposeAgent.transform.Find(DeadZoneCenter);
	}

	private void LateUpdate()
	{
		if (IsUseDeadZone)
		{
			if (!isOnRunning)
			{
				deadZoneCoroutine = StartCoroutine(DeadZone());
			}
		}
		else
		{
			canMove = true;
			if (isOnRunning)
			{
				StopCoroutine(deadZoneCoroutine);
				isOnRunning = false;
			}
		}
		if (PositionDampingX != 0f && canMove && IsUseX)
		{
			base.transform.position = new Vector3(Vector3.Lerp(base.transform.position, TargetPrefab.position, PositionDampingX).x, base.transform.position.y, base.transform.position.z);
		}
		if (PositionDampingY != 0f && canMove && IsUseY)
		{
			base.transform.position = new Vector3(base.transform.position.x, Vector3.Lerp(base.transform.position, TargetPrefab.position, PositionDampingY).y, base.transform.position.z);
		}
		if (PositionDampingZ != 0f && canMove && IsUseZ)
		{
			base.transform.position = new Vector3(base.transform.position.x, base.transform.position.y, Vector3.Lerp(base.transform.position, TargetPrefab.position, PositionDampingZ).z);
		}
		if (RotationDamping != 0f)
		{
			base.transform.rotation = Quaternion.Slerp(base.transform.rotation, TargetPrefab.rotation, RotationDamping);
		}
	}

	private IEnumerator DeadZone()
	{
		isOnRunning = true;
		while (IsUseDeadZone)
		{
			Vector3 position = point.position;
			if ((position - rootPoint).magnitude >= DeadZoneDistance)
			{
				canMove = true;
			}
			else
			{
				canMove = false;
			}
			rootPoint = position;
			yield return new WaitForSeconds(DeadZoneTime);
		}
	}
}
