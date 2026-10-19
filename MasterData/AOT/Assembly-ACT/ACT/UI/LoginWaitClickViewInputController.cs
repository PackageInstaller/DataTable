using ACT.Battle;
using ACT.LocalLoader;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class LoginWaitClickViewInputController : BaseUIViewInputController<MonoLoginWaitClickView>
{
	private MonoMessageBox _messageBox_fromView;

	private bool _couldBack;

	private MonoMessageBox messageBox
	{
		get
		{
			MonoMessageBox monoMessageBox = Singleton<NewUIManager>.instance.MessageBox;
			if ((object)monoMessageBox != null && monoMessageBox.isActiveAndEnabled)
			{
				_couldBack = false;
				return monoMessageBox;
			}
			_couldBack = true;
			return _messageBox_fromView;
		}
	}

	protected override void OnInitView(MonoLoginWaitClickView view)
	{
		base.OnInitView(view);
		_messageBox_fromView = view.MessagePanel;
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		Singleton<GameInputActionManager>.instance.SetGameInputState(GameInputState.Loading, active: true);
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		Singleton<GameInputActionManager>.instance.SetGameInputState(GameInputState.Loading, active: false);
	}

	private bool QuitByGameStart()
	{
		if (!GameStart.IsGameStart)
		{
			return false;
		}
		GameStart gameStart = Object.FindObjectOfType<GameStart>();
		if ((object)gameStart == null)
		{
			return false;
		}
		if (gameStart.messageBox.isActiveAndEnabled)
		{
			gameStart.messageBox.gameObject.SetActive(value: false);
		}
		else
		{
			gameStart.hotUpdateView.QuitGameBtn();
		}
		return true;
	}

	protected override void OnBackPressed(bool value)
	{
		if (value)
		{
			return;
		}
		if (messageBox.isActiveAndEnabled)
		{
			if (_couldBack)
			{
				messageBox.gameObject.SetActive(value: false);
			}
		}
		else if (!QuitByGameStart())
		{
			MonoLoginWaitClickView view = View;
			if (!view.ShowAgeNotice(show: false) && !view.HideExitGameConfirm() && !view.CloseAnnouncementSafe())
			{
				view.ShowExitGameConfirm();
			}
		}
	}

	[GameInputBindingBool("UI/Next")]
	private void HandleNext(bool pressed)
	{
		if (!pressed && messageBox.isActiveAndEnabled)
		{
			messageBox.btnSelector.SelectNext();
		}
	}

	[GameInputBindingBool("UI/Prev")]
	private void HandlePrev(bool pressed)
	{
		if (!pressed && messageBox.isActiveAndEnabled)
		{
			messageBox.btnSelector.SelectPrev();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	private void HandleExitConfirm(bool pressed)
	{
		if (!pressed && messageBox.isActiveAndEnabled)
		{
			messageBox.btnSelector.ClickCurrentByGamepad();
		}
	}

	[GameInputBindingBool("Login/Account")]
	private void HandleAccount(bool pressed)
	{
		if (!pressed && !messageBox.isActiveAndEnabled)
		{
			View.LoginOrOut();
		}
	}

	[GameInputBindingBool("Login/AgeNotice")]
	private void HandleAgeNotice(bool pressed)
	{
		if (!pressed && !messageBox.isActiveAndEnabled)
		{
			View.ShowAgeNotice(show: true);
		}
	}

	[GameInputBindingBool("Login/SoundMute")]
	private void HandleSetting(bool pressed)
	{
		if (!pressed && !messageBox.isActiveAndEnabled)
		{
			View.OnClickSettingBtn();
		}
	}

	[GameInputBindingBool("Login/Billboard")]
	private void HandleBillboard(bool pressed)
	{
		if (!pressed && !messageBox.isActiveAndEnabled)
		{
			View.ShowAnnouncement();
		}
	}

	[GameInputBindingBool("Login/Enter")]
	private void HandleEnter(bool pressed)
	{
		if (pressed && !messageBox.isActiveAndEnabled)
		{
			View.ClickEnterGame();
		}
	}
}
