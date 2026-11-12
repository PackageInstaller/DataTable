using UnityEngine;
using UnityEngine.UI;

public class JoystickEffect : MonoBehaviour
{
	public CanvasGroup cg;

	public Image imgHandle;

	public Sprite[] spHandle;

	public void OnJoystickPress()
	{
		if (NovaAPI.IsInputEnabled())
		{
			cg.alpha = 1f;
		}
		imgHandle.sprite = spHandle[1];
	}

	public void OnJoystickRelease()
	{
		if (NovaAPI.IsInputEnabled())
		{
			cg.alpha = 0.3f;
		}
		imgHandle.sprite = spHandle[0];
	}
}
