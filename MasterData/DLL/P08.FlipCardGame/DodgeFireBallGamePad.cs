using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

public class DodgeFireBallGamePad : MonoBehaviour
{
	public Button upButton;

	public Button downButton;

	public Button leftButton;

	public Button rightButton;

	public void RegisterInputCallback(CookingGameConst.DogeFireBallInputType inputType, UnityAction callback)
	{
		switch (inputType)
		{
		case CookingGameConst.DogeFireBallInputType.UP:
			upButton.onClick.AddListener(callback);
			break;
		case CookingGameConst.DogeFireBallInputType.DOWN:
			downButton.onClick.AddListener(callback);
			break;
		case CookingGameConst.DogeFireBallInputType.LEFT:
			leftButton.onClick.AddListener(callback);
			break;
		case CookingGameConst.DogeFireBallInputType.RIGHT:
			rightButton.onClick.AddListener(callback);
			break;
		}
	}
}
