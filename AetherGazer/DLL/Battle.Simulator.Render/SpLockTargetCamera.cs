using Cinemachine;
using UnityEngine;

public class SpLockTargetCamera : MonoBehaviour
{
	private GameObject follow;

	private GameObject target;

	public CinemachineVirtualCamera virtualCamera;

	private CinemachineOrbitalTransposer transposer;

	public int priority = 10;

	public float startRotateAngle = 30f;

	public float endRotateAngle = 25f;

	public float maxAngle = 35f;

	public float a = 0.5f;

	public float minRotateSpeed = 1f;

	private float speed;

	private void Awake()
	{
		if (virtualCamera != null && transposer == null)
		{
			transposer = virtualCamera.GetCinemachineComponent<CinemachineOrbitalTransposer>();
		}
	}

	public void SetPlayer(GameObject player)
	{
		follow = player;
		if (virtualCamera != null && follow != null)
		{
			virtualCamera.Follow = follow.transform;
			virtualCamera.LookAt = follow.transform;
		}
	}

	public void SetTarget(GameObject target)
	{
		this.target = target;
	}

	public void LateUpdate()
	{
		if (virtualCamera == null || follow == null || transposer == null)
		{
			return;
		}
		if (target == null)
		{
			virtualCamera.Priority = 0;
		}
		else
		{
			if (maxAngle < startRotateAngle || startRotateAngle < endRotateAngle)
			{
				return;
			}
			if (priority != virtualCamera.Priority)
			{
				virtualCamera.Priority = priority;
			}
			Vector3 vector = base.transform.forward.NewY(0f);
			Vector3 vector2 = target.transform.position - base.transform.position;
			vector2 = vector2.NewY(0f);
			float num = Vector3.SignedAngle(vector, vector2, Vector3.up);
			float num2 = Mathf.Abs(num);
			if (num2 > startRotateAngle && num2 <= maxAngle)
			{
				speed = (num2 - startRotateAngle) * a + minRotateSpeed * Time.deltaTime;
				speed = ((num > 0f) ? speed : (0f - speed));
			}
			else if (num2 > maxAngle)
			{
				speed = num2 - maxAngle + (num2 - startRotateAngle) * a + minRotateSpeed * Time.deltaTime;
				speed = ((num > 0f) ? speed : (0f - speed));
			}
			else if (num2 <= endRotateAngle)
			{
				vector2 = target.transform.position - follow.transform.position;
				vector2 = vector2.NewY(0f);
				num = Vector3.SignedAngle(vector, vector2, Vector3.up);
				num2 = Mathf.Abs(num);
				if (num2 >= 90f)
				{
					speed = num2 - 90f + minRotateSpeed * Time.deltaTime;
					speed = ((num > 0f) ? speed : (0f - speed));
				}
				else
				{
					speed = 0f;
				}
			}
			transposer.m_XAxis.Value += speed;
		}
	}
}
