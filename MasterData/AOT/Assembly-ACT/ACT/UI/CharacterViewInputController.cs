using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class CharacterViewInputController : BaseUIViewInputController<CharacterView>
{
	private bool tabPrevPress;

	private bool tabNextPress;

	protected override void OnBackPressed(bool value)
	{
		if (value || View.currentCharacterSubView == null)
		{
			return;
		}
		switch (View.currentCharacterSubView.SceneType)
		{
		case CharacterViewScene.CvSceneType.Over:
			View.Close();
			return;
		case CharacterViewScene.CvSceneType.Skill:
		case CharacterViewScene.CvSceneType.Destiny:
			return;
		}
		if (!(View.currentCharacterSubView is EquipmentSubView equipmentSubView) || !equipmentSubView.TryConsumeSubviewBack())
		{
			View.CloseSubView();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		View.currentCharacterSubView?.OnNavigate(value);
	}

	[GameInputBindingBool("UI/UISpecial4")]
	public void OpenCharacterList(bool value)
	{
		if (value)
		{
			ICharacterSubView currentCharacterSubView = View.currentCharacterSubView;
			if (currentCharacterSubView == null || currentCharacterSubView.SceneType != CharacterViewScene.CvSceneType.Destiny)
			{
				View.OpenBagShowViewByController();
			}
		}
	}

	[GameInputBindingVector2("UI/RightStickNavigate")]
	public void RightStickNavigate(Vector2 value)
	{
		View.currentCharacterSubView?.OnRightStickNavigate(value);
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void PrevCharacter(bool value)
	{
		if (value)
		{
			View.CycleCharacter(forward: false);
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void NextCharacter(bool value)
	{
		if (value)
		{
			View.CycleCharacter(forward: true);
		}
	}

	[GameInputBindingBool("UI/SwitchPageLeft")]
	public void PrevTab(bool value)
	{
		if (tabPrevPress != value)
		{
			tabPrevPress = value;
			if (value)
			{
				View.CycleToggle(forward: false);
			}
		}
	}

	[GameInputBindingBool("UI/SwitchPageRight")]
	public void NextTab(bool value)
	{
		if (tabNextPress != value)
		{
			tabNextPress = value;
			if (value)
			{
				View.CycleToggle(forward: true);
			}
		}
	}

	[GameInputBindingBool("UI/RightStickPress")]
	public void RightStickPress(bool value)
	{
		ICharacterSubView currentCharacterSubView = View.currentCharacterSubView;
		if (currentCharacterSubView != null && value)
		{
			currentCharacterSubView.OnRightStickPressed();
		}
	}
}
