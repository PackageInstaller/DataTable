using UnityEngine;

public class ControllerSwitcher : MonoBehaviour
{
	[SerializeField]
	public Controller controller;

	[SerializeField]
	public int stateIndex;

	public void ToggleOnTrigger(bool isOn)
	{
		if (isOn)
		{
			DoSwitch();
		}
	}

	public void NormalTrigger()
	{
		DoSwitch();
	}

	private void DoSwitch()
	{
		controller.SetSelectedIndex(stateIndex);
	}
}
