using System;
using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class DestinyBtnBase : MonoBehaviour
{
	[SerializeField]
	protected GameObject[] activeGos;

	[SerializeField]
	protected GameObject[] inactiveGos;

	[SerializeField]
	protected GameObject select;

	[SerializeField]
	protected GameObject gamePadSelectArrow;

	protected Action<int, bool> _selectDestiny;

	public virtual void SetSelectState(bool active, bool showArrow = true)
	{
		select.SetActive(active);
		gamePadSelectArrow.SetActive((showArrow & active) && MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	public virtual void Select()
	{
	}
}
