using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class CvOverviewSubInputController : SubUIViewInputController<CvOverview>, ISubInputController, IInputController, IGameInputBindingHandle
{
	private ContinuousNavigateData navData;

	[GameInputBindingBool("UI/UISpecial2")]
	public void OpenDestiny(bool value)
	{
		if (value)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click");
			View.OpenDestinyByController();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void Upgrade(bool value)
	{
		if (value)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click");
			View.CharacterView.OpenLevelUpPanelByController();
		}
	}

	[GameInputBindingBool("UI/UISpecial3")]
	public void OpenSkinView(bool value)
	{
		if (value)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click");
			View.CharacterView.OpenSkinByController();
		}
	}

	[GameInputBindingBool("UI/RightStickPress")]
	public void EnterTraining(bool value)
	{
		if (value)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click");
			View.CharacterView.EnterTrainTipsByController();
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		navData?.Reset();
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref navData, ExecuteNavigate);
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Up:
			View.subViewLayer.Root?.SelectUp();
			break;
		case MoveDirection.Down:
			View.subViewLayer.Root?.SelectDown();
			break;
		case MoveDirection.Left:
			View.subViewLayer.Root?.SelectLeft();
			break;
		case MoveDirection.Right:
			View.subViewLayer.Root?.SelectRight();
			break;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			currentSelected.GetComponent<SelectionUGUI>()?.ScrollTargetToShow(currentSelected.transform);
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!value)
		{
			GameObject currentSelected = EventSystemHelper.CurrentSelected;
			if (!(currentSelected == null))
			{
				EventSystemHelper.Click(currentSelected);
			}
		}
	}
}
