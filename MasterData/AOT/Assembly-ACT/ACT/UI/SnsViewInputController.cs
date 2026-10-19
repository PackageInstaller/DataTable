using ACT.Battle;
using ACT.Model;
using ACT.UI.InputController;
using ACT.ViewControl;
using Com.ForbiddenByte.OSA.DataHelpers;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class SnsViewInputController : BaseUIViewInputController<SNSBaseView>
{
	private SNSSubController subControllerType;

	private ViewControlRoot m_ViewControlRoot;

	private GameObject curSelectItem;

	private ContinuousNavigateData _curNavigateData;

	public SNSSubController ControllerType
	{
		get
		{
			return subControllerType;
		}
		set
		{
			subControllerType = value;
		}
	}

	protected override void OnInitView(SNSBaseView view)
	{
		base.OnInitView(view);
		subControllerType = SNSSubController.main;
		m_ViewControlRoot = view?.GetComponentInChildren<ViewControlRoot>();
		curSelectItem = null;
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View?.HandleGamePadReturnButtonInput(ControllerType);
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnSelectionNavigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Down:
			m_ViewControlRoot.SelectDown();
			if (subControllerType == SNSSubController.main)
			{
				CommonSelect(1);
			}
			break;
		case MoveDirection.Up:
			if ((bool)EventSystemHelper.CurrentSelected && subControllerType == SNSSubController.main)
			{
				SessionComp component = EventSystemHelper.CurrentSelected.GetComponent<SessionComp>();
				TreeDataHelper<SNSContactsOSA.SNSContactsModel> data = View.contactsOsa.Data;
				if (data.ShowCount > 0 && data[0] is SNSContactsOSA.ContactsCharacterModel contactsCharacterModel && (bool)component)
				{
					SNSModel.SnsSession session = Model<SNSModel>.Interface.GetSession(component.SessionId);
					if (contactsCharacterModel.ContactsId == session.ContactsId && data[1] != null && data[1] is SNSContactsOSA.ContactsSessionModel contactsSessionModel && contactsSessionModel.SessionId == component.SessionId)
					{
						break;
					}
				}
			}
			m_ViewControlRoot.SelectUp();
			if (subControllerType == SNSSubController.main)
			{
				CommonSelect(0);
			}
			break;
		}
	}

	[GameInputBindingBool("UI/CommonSelect")]
	public void OnOpenImageGroup(bool value)
	{
		if (value && subControllerType == SNSSubController.main)
		{
			View?.sessionDetailComp.GamePadOpenImageViewList();
		}
	}

	[GameInputBindingBool("LargeMapView/Delete")]
	public void OnOpenMission(bool value)
	{
		if ((View != null) & value)
		{
			View?.sessionDetailComp.GamePadOpenMission();
		}
	}

	[GameInputBindingBool("LargeMapView/Select")]
	private void OnGamepadSelect(bool value)
	{
		if ((View != null) & value)
		{
			View.HandleGamePadSelectButtonInput(subControllerType);
		}
	}

	public void CommonSelect(int index)
	{
		if (!EventSystemHelper.CurrentSelected || !(curSelectItem != EventSystemHelper.CurrentSelected))
		{
			return;
		}
		ContactsComp component = EventSystemHelper.CurrentSelected.GetComponent<ContactsComp>();
		SessionComp sessionComp = curSelectItem?.GetComponent<SessionComp>();
		if (component != null && component.Select.activeSelf)
		{
			if ((bool)EventSystemHelper.CurrentSelected && curSelectItem != EventSystemHelper.CurrentSelected)
			{
				TreeDataHelper<SNSContactsOSA.SNSContactsModel> data = View.contactsOsa.Data;
				if (data.ShowCount > 0 && data[0] is SNSContactsOSA.ContactsCharacterModel contactsCharacterModel && (bool)component && contactsCharacterModel.ContactsId == component.ContactsId)
				{
					return;
				}
			}
			if (sessionComp != null && Model<SNSModel>.Interface.GetSession(sessionComp.SessionId).ContactsId == component.ContactsId)
			{
				m_ViewControlRoot.SelectUp();
				CommonSelect(0);
				return;
			}
		}
		EventSystemHelper.ClickCurrent();
		curSelectItem = EventSystemHelper.CurrentSelected;
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}
}
