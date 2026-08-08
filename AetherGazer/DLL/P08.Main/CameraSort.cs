using UnityEngine;

public class CameraSort : MonoBehaviour
{
	private Camera mainCamera;

	private void Start()
	{
		mainCamera = GetComponent<Camera>();
		if (mainCamera != null)
		{
			mainCamera.transparencySortMode = TransparencySortMode.Orthographic;
		}
	}

	private void Update()
	{
	}
}
