using ACT.Battle;
using Fundamental;

namespace ACT.UI;

public class CharacterSkinViewInputController : BaseUIViewInputController<CharacterSkinView>
{
	private ContinuousNavigateData _curNavigateState;

	private bool ignoreHideUIRelease;

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateState?.Reset();
		ignoreHideUIRelease = false;
	}

	[GameInputBindingBool("UI/Back")]
	public void OnBack(bool value)
	{
		if (value)
		{
			if (View.TryRestoreHideUI())
			{
				Singleton<GameInputActionManager>.instance.CancelAllActionProcessAtThisFrame();
			}
			else
			{
				View.Close();
			}
		}
	}

	[GameInputBindingBool("UI/PressAnyKey")]
	public void OnRecoverUI(bool value)
	{
		if (value && View.TryRestoreHideUI())
		{
			if (Singleton<GameInputActionManager>.instance.CheckActionIsPressed("UI/UISpecial2"))
			{
				ignoreHideUIRelease = true;
			}
			Singleton<GameInputActionManager>.instance.CancelAllActionProcessAtThisFrame();
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void OnHideUI(bool value)
	{
		if (value)
		{
			if (View.IsHideUI)
			{
				ignoreHideUIRelease = true;
			}
		}
		else if (ignoreHideUIRelease)
		{
			ignoreHideUIRelease = false;
		}
		else if (!View.IsHideUI)
		{
			View.ToggleHideUI();
		}
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void OnSwitchPageUp(bool value)
	{
		if (value && !View.IsHideUI)
		{
			View.SwitchTabUp();
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void OnSwitchPageDown(bool value)
	{
		if (value && !View.IsHideUI)
		{
			View.SwitchTabDown();
		}
	}
}
