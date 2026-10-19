using UnityEngine;

namespace ACT.UI;

public class AutoRotation : MonoBehaviour
{
	public Vector3 EulerAngleSpeed;

	public bool running = true;

	private void Update()
	{
		if (running && EulerAngleSpeed != Vector3.zero)
		{
			transform.localRotation = Quaternion.Euler(EulerAngleSpeed * Time.deltaTime) * transform.localRotation;
		}
	}

	private void OnDisable()
	{
		transform.localRotation = Quaternion.identity;
	}
}
