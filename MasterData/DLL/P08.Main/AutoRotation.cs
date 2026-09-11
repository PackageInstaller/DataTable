using UnityEngine;

public class AutoRotation : MonoBehaviour
{
	public Vector3 EulerAngleSpeed;

	public bool running = true;

	private void Update()
	{
		if (running && EulerAngleSpeed != Vector3.zero)
		{
			base.transform.localRotation = Quaternion.Euler(EulerAngleSpeed * Time.deltaTime) * base.transform.localRotation;
		}
	}
}
