using UnityEngine;

public class VirtualCursorButton : MonoBehaviour
{
	public KeyCode key1;

	public KeyCode key2;

	private void Update()
	{
		if (Input.GetKeyDown(key1) || Input.GetKeyDown(key2))
		{
			VirtualCursor.ClickAt(base.transform as RectTransform, TouchPhase.Began);
		}
		else if (Input.GetKey(key1) || Input.GetKey(key2))
		{
			VirtualCursor.ClickAt(base.transform as RectTransform, TouchPhase.Moved);
		}
		else if (Input.GetKeyUp(key1) || Input.GetKeyUp(key2))
		{
			VirtualCursor.ClickAt(base.transform as RectTransform, TouchPhase.Ended);
		}
	}
}
