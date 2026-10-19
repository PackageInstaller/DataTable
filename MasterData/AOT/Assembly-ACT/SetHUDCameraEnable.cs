using UnityEngine;

public class SetHUDCameraEnable : MonoBehaviour
{
	public void Update()
	{
		if (Input.GetKeyDown(KeyCode.F8))
		{
			Execute();
		}
	}

	public static void Execute()
	{
		GameObject gameObject = GameObject.Find("HUDCamera");
		if (!(gameObject == null))
		{
			Camera component = gameObject.GetComponent<Camera>();
			if (!(component == null))
			{
				component.enabled = !component.enabled;
			}
		}
	}
}
