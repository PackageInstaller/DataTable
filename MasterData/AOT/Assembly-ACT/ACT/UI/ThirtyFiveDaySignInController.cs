using ACT.Battle;
using ACT.Model;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class ThirtyFiveDaySignInController : SubUIViewInputController<ThirtyFiveDaySignIn>
{
	private const int DailyItemCount = 35;

	private const int DailyColumnCount = 7;

	private const int FirstBigPrizeIndex = 35;

	private const int BigPrizeCount = 3;

	private const int LastBigPrizeIndex = 37;

	private ContinuousNavigateData navData;

	protected override void OnActivate()
	{
		base.OnActivate();
		View.viewControlLayer.ReFocus();
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

	public void SelectDefaultReward()
	{
		for (int num = View.m_35DaySignInItems.Count - 1; num >= 0; num--)
		{
			ThirtyFiveDaySignInItem thirtyFiveDaySignInItem = View.m_35DaySignInItems[num];
			if (thirtyFiveDaySignInItem.gameObject.activeInHierarchy && thirtyFiveDaySignInItem.rewardState == ActivityCenterModel.ActivityRewardState.Receive)
			{
				SelectItem(num);
				return;
			}
		}
		for (int i = 0; i < View.m_35DaySignInItems.Count; i++)
		{
			if (View.m_35DaySignInItems[i].gameObject.activeInHierarchy)
			{
				SelectItem(i);
				break;
			}
		}
	}

	private void ExecuteNavigate(MoveDirection direction)
	{
		if (!EventSystemHelper.Available)
		{
			return;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!currentSelected)
		{
			SelectDefaultReward();
			return;
		}
		ThirtyFiveDaySignInItem component = currentSelected.GetComponent<ThirtyFiveDaySignInItem>();
		if ((bool)component)
		{
			int num = View.m_35DaySignInItems.IndexOf(component);
			if (num >= 0)
			{
				int index = ((num < 35) ? GetDailyTargetIndex(num, direction) : GetBigPrizeTargetIndex(num, direction));
				SelectItem(index);
			}
		}
	}

	private int GetDailyTargetIndex(int currentIndex, MoveDirection direction)
	{
		switch (direction)
		{
		case MoveDirection.Up:
			if (currentIndex < 7)
			{
				return currentIndex;
			}
			return currentIndex - 7;
		case MoveDirection.Down:
			if (currentIndex + 7 >= 35)
			{
				return currentIndex;
			}
			return currentIndex + 7;
		case MoveDirection.Left:
			if (currentIndex % 7 <= 0)
			{
				return currentIndex;
			}
			return currentIndex - 1;
		case MoveDirection.Right:
			if (currentIndex % 7 >= 6)
			{
				return 35;
			}
			return currentIndex + 1;
		default:
			return currentIndex;
		}
	}

	private int GetBigPrizeTargetIndex(int currentIndex, MoveDirection direction)
	{
		switch (direction)
		{
		case MoveDirection.Left:
			if (currentIndex != 35)
			{
				return currentIndex - 1;
			}
			return 34;
		case MoveDirection.Right:
			if (currentIndex >= 37)
			{
				return currentIndex;
			}
			return currentIndex + 1;
		default:
			return currentIndex;
		}
	}

	private void SelectItem(int index)
	{
		if (index >= 0 && index < View.m_35DaySignInItems.Count)
		{
			ThirtyFiveDaySignInItem thirtyFiveDaySignInItem = View.m_35DaySignInItems[index];
			if (thirtyFiveDaySignInItem.gameObject.activeInHierarchy && EventSystemHelper.Available)
			{
				EventSystemHelper.SetSelectedGameObject(thirtyFiveDaySignInItem.gameObject);
				thirtyFiveDaySignInItem.GetComponent<SelectionUGUI>()?.ScrollTargetToShow(thirtyFiveDaySignInItem.transform);
			}
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (value && EventSystemHelper.Available)
		{
			GameObject currentSelected = EventSystemHelper.CurrentSelected;
			if ((bool)currentSelected)
			{
				EventSystemHelper.Click(currentSelected);
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial6")]
	public void RightStickPress(bool value)
	{
		if (value)
		{
			View.OpenActivityDetail();
		}
	}
}
