using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class GamePadSelectComponent : MonoBehaviour
{
	public GameObject select;

	public GameObject gamePadArrow;

	public void SetSelectState(bool active)
	{
		select.SetActive(active);
		gamePadArrow.SetActive(active && MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	public void SetGamePadArrowState(bool active)
	{
		gamePadArrow.SetActive(active);
	}
}
