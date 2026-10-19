using ACT.Utility;
using UnityEngine;

namespace ACT.Timeline;

public class TimelineSignal : MonoBehaviour
{
	private bool isHide;

	public void HideScene(bool state)
	{
		Camera component = GameUtility.mainCamera.GetComponent<Camera>();
		if (isHide != state)
		{
			if (state)
			{
				component.cullingMask--;
			}
			else
			{
				component.cullingMask++;
			}
			isHide = state;
		}
	}
}
