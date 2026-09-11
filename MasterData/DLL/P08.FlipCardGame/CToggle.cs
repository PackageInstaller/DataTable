using System;
using UnityEngine;
using UnityEngine.UI;

[Serializable]
[RequireComponent(typeof(Controller))]
public class CToggle : Toggle
{
	[HideInInspector]
	[SerializeField]
	private Controller _controller;

	protected override void Awake()
	{
		base.Awake();
		_controller = GetComponent<Controller>();
		onValueChanged.AddListener(OnValueChanged);
	}

	protected override void OnDestroy()
	{
		onValueChanged.RemoveListener(OnValueChanged);
		base.OnDestroy();
	}

	public void UpdateControllerValue()
	{
		if (base.isOn)
		{
			_controller.SetSelectedIndex(1);
		}
		else
		{
			_controller.SetSelectedIndex(0);
		}
	}

	private void OnValueChanged(bool isOn)
	{
		UpdateControllerValue();
	}
}
