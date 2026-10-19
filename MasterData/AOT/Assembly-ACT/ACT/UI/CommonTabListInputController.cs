using System;
using ACT.Battle;
using ACT.UI.InputController;
using ACT.UI.Interface;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class CommonTabListInputController : SubUIViewInputController<CommonTabListComponent>
{
	protected override void OnEnable()
	{
		base.OnEnable();
		SetActive(active: true);
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		SetActive(active: true);
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		SetActive(active: false);
	}

	private void SetActive(bool active)
	{
		if (active)
		{
			Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/SwitchPageDown", View.switchPageInputType != SwitchPageInputType.Shoulder);
			Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/SwitchPageUp", View.switchPageInputType != SwitchPageInputType.Shoulder);
			Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/SwitchPageLeft", View.switchPageInputType != SwitchPageInputType.Trigger);
			Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/SwitchPageRight", View.switchPageInputType != SwitchPageInputType.Trigger);
		}
		else
		{
			Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/SwitchPageDown", value: true);
			Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/SwitchPageUp", value: true);
			Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/SwitchPageLeft", value: true);
			Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/SwitchPageRight", value: true);
		}
	}

	[GameInputBindingBool("UI/SwitchPageLeft")]
	public void OnSwitchPageLeft(bool isPressed)
	{
		if (isPressed)
		{
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/SwitchPageLeft", PageUp, 0.05f, -1, 0.3f);
		}
	}

	[GameInputBindingBool("UI/SwitchPageRight")]
	public void OnSwitchPageRight(bool isPressed)
	{
		if (isPressed)
		{
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/SwitchPageRight", PageDown, 0.05f, -1, 0.3f);
		}
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void OnSwitchPageUp(bool isPressed)
	{
		if (isPressed)
		{
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/SwitchPageUp", PageUp, 0.05f, -1, 0.3f);
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void OnSwitchPageDown(bool isPressed)
	{
		if (isPressed)
		{
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/SwitchPageDown", PageDown, 0.05f, -1, 0.3f);
		}
	}

	private void PageUp()
	{
		SwitchPage(-1);
	}

	private void PageDown()
	{
		SwitchPage(1);
	}

	private void SwitchPage(int direction)
	{
		if (View.TabItems == null)
		{
			Debug.LogError("Tab items are null, cannot navigate");
			return;
		}
		int num = View.TabItems.IndexOf(View.ActiveTab);
		if (num < 0 || num >= View.TabItems.Count)
		{
			Debug.LogWarning("Active tab index is out of bounds, cannot navigate");
			return;
		}
		for (int i = num + direction; i >= 0 && i < View.TabItems.Count; i += direction)
		{
			ITabItem tabItem = View.TabItems[i];
			Func<bool> canActive = tabItem.CanActive;
			if (canActive == null || canActive())
			{
				View.ActiveTab = tabItem;
				EventSystemHelper.SetSelectedGameObject((tabItem as MonoBehaviour)?.gameObject);
				break;
			}
		}
	}
}
