using ACT.Battle;
using ACT.UI;

public class CreateCharacterViewInputController : BaseUIViewInputController<CreateCharacterView>
{
	[GameInputBindingBool("UI/SelectNameInput")]
	private void OnSelectPressed(bool value)
	{
		if (!value && !View.IsStageChanging)
		{
			View.ActivateInputField();
		}
	}

	[GameInputBindingBool("UI/Back")]
	protected override void OnBackPressed(bool value)
	{
		if (!View.isEmpty && !value)
		{
			View.OnBtnCancel();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	private void OnConfirmPressed(bool value)
	{
		if (!value && !View.IsStageChanging)
		{
			View.OnBtnConfirm();
		}
	}

	[GameInputBindingFloat("UI/LSLeftRightSelect")]
	private void Navigate(float value)
	{
		if (!View.IsStageChanging && value != 0f)
		{
			if (value > 0f)
			{
				View.SelectGender(1);
			}
			else
			{
				View.SelectGender(2);
			}
		}
	}
}
