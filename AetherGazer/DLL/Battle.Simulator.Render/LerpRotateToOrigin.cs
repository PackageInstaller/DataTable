using UnityEngine;

public class LerpRotateToOrigin : MonoBehaviour
{
	private Quaternion targetRotation;

	private float remainingDuration;

	public void BeginRotation(Vector3 targetDirection, float duration)
	{
		targetRotation = Quaternion.LookRotation(targetDirection);
		remainingDuration = duration;
	}

	private void Update()
	{
		if (remainingDuration > 0f)
		{
			float deltaTime = Time.deltaTime;
			float t = Mathf.Clamp01(deltaTime / remainingDuration);
			base.transform.rotation = Quaternion.Slerp(base.transform.rotation, targetRotation, t);
			remainingDuration -= deltaTime;
		}
		else
		{
			Object.Destroy(this);
		}
	}
}
