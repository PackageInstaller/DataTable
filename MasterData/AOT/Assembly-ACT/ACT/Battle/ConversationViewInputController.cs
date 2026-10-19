using ACT.Model;
using ACT.UI;
using ACT.UI.InputController;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.Battle;

public class ConversationViewInputController : BaseUIViewInputController<MonoConversationView>
{
	private enum OperationType
	{
		Submit,
		Cancel,
		Next,
		PreChoice,
		NextChoice,
		Review,
		AutoPlay,
		Skip,
		HideShow,
		TextLibrary,
		Navigate
	}

	private ContinuousNavigateData m_CurNavigateData;

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		m_CurNavigateData?.Reset();
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			TriggerOperation(OperationType.Cancel);
		}
	}

	[GameInputBindingBool("Conversation/ConversationSkip")]
	public void OnConversationSkip(bool value)
	{
		if (value)
		{
			TriggerOperation(OperationType.Skip);
		}
	}

	[GameInputBindingBool("Conversation/ConversationHide")]
	public void OnConversationHide(bool value)
	{
		if (value)
		{
			TriggerOperation(OperationType.HideShow);
		}
	}

	[GameInputBindingBool("Conversation/ConversationNext")]
	public void OnConversationNext(bool value)
	{
		if (value)
		{
			TriggerOperation(OperationType.Next);
		}
	}

	[GameInputBindingBool("Conversation/ConversationChoose")]
	public void OnConversationChoose(bool value)
	{
		if (value)
		{
			TriggerOperation(OperationType.Submit);
		}
	}

	[GameInputBindingBool("Conversation/ConversationAutoPlay")]
	public void OnConversationAutoPlay(bool value)
	{
		if (value)
		{
			TriggerOperation(OperationType.AutoPlay);
		}
	}

	[GameInputBindingBool("Conversation/ConversationReview")]
	public void OnConversationReview(bool value)
	{
		if (value)
		{
			TriggerOperation(OperationType.Review);
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref m_CurNavigateData, Navigate);
	}

	private void Navigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Up:
			View.viewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			View.viewControlRoot.SelectDown();
			break;
		case MoveDirection.Left:
			View.viewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			View.viewControlRoot.SelectRight();
			break;
		}
	}

	[GameInputBindingBool("UI/TextLibrary")]
	private void TriggerTextLibrary(bool value)
	{
		if (value)
		{
			TriggerOperation(OperationType.TextLibrary);
		}
	}

	private void TriggerOperation(OperationType operationType)
	{
		if (View.IsStoryPanelVisible())
		{
			switch (operationType)
			{
			case OperationType.Cancel:
				EventSystemHelper.Click(View.storyPanel.btnClose);
				break;
			case OperationType.Submit:
			{
				ACT.ViewControl.SelectableEx selectableEx = View.viewControlRoot.CurrentFocusLayer?.LastSelect;
				if ((bool)selectableEx && EventSystemHelper.CurrentSelected == selectableEx.gameObject)
				{
					EventSystemHelper.Click(selectableEx);
				}
				break;
			}
			}
			return;
		}
		if (View.hideTrigger.gameObject.activeInHierarchy)
		{
			EventSystemHelper.Click(View.hideTrigger);
			return;
		}
		switch (operationType)
		{
		case OperationType.TextLibrary:
			if (View.textLibraryPropPick != null && View.textLibraryPropPick.gameObject.activeInHierarchy && Singleton<TextLibraryManager>.instance.HasData)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTLIBRARY, new TextLibraryViewData
				{
					targetJumpTextDataId = Model<TextLibraryModel>.Interface.lastUnLockTextLibraryId
				});
				Model<TextLibraryModel>.Interface.lastUnLockTextLibraryId = 0;
			}
			break;
		case OperationType.HideShow:
			if (View.hide.Source.IsInteractable())
			{
				EventSystemHelper.Click(View.hide);
			}
			break;
		case OperationType.Skip:
			if (View.skip.Source.IsInteractable())
			{
				EventSystemHelper.Click(View.skip);
			}
			break;
		case OperationType.Cancel:
			if (!MonoECS.instance.IsGamePadMode() && View.skip.Source.IsInteractable())
			{
				EventSystemHelper.Click(View.skip);
			}
			break;
		case OperationType.PreChoice:
			if (!View.choiceControlLayer.IsFocused)
			{
				View.choiceControlLayer.Focus();
			}
			else
			{
				View.viewControlRoot.SelectUp();
			}
			break;
		case OperationType.NextChoice:
			if (!View.choiceControlLayer.IsFocused)
			{
				View.choiceControlLayer.Focus();
			}
			else
			{
				View.viewControlRoot.SelectDown();
			}
			break;
		case OperationType.Next:
			EventSystemHelper.Click(View.btnNext);
			break;
		case OperationType.Submit:
			if (View.normalView.CurrentContext != null && View.normalView.CurrentContext.DialogueArg != null && View.normalView.CurrentContext.DialogueArg.OptionDatas != null && View.normalView.CurrentContext.DialogueArg.OptionDatas.Count > 0)
			{
				EventSystemHelper.Click(EventSystemHelper.CurrentSelected);
			}
			break;
		case OperationType.Review:
			if (View.btnOpenStoryPanel.Source.IsInteractable())
			{
				View.ShowStoryPanel();
			}
			break;
		case OperationType.AutoPlay:
			EventSystemHelper.Click(View.autoPlayToggle);
			break;
		}
	}
}
