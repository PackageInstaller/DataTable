using Cinemachine;
using UnityEngine;

public class CinemachineTouchInputMapper : MonoBehaviour
{
	[Tooltip("Sensitivity multiplier for x-axis")]
	public float TouchSensitivityX = 10f;

	[Tooltip("Sensitivity multiplier for y-axis")]
	public float TouchSensitivityY = 10f;

	[Tooltip("Input channel to spoof for X axis")]
	public string TouchXInputMapTo = "Mouse X";

	[Tooltip("Input channel to spoof for Y axis")]
	public string TouchYInputMapTo = "Mouse Y";

	private void Start()
	{
		CinemachineCore.GetInputAxis = GetInputAxis;
	}

	private float GetInputAxis(string axisName)
	{
		if (Input.touchCount > 0)
		{
			if (axisName == TouchXInputMapTo)
			{
				return Input.touches[0].deltaPosition.x / TouchSensitivityX;
			}
			if (axisName == TouchYInputMapTo)
			{
				return Input.touches[0].deltaPosition.y / TouchSensitivityY;
			}
		}
		return Input.GetAxis(axisName);
	}
}
