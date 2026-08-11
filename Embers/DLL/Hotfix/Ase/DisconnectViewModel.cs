using System;
using GameFramework.Runtime;

namespace Ase;

public class DisconnectViewModel : OptionBase
{
	private string text;

	private bool isConfirm;

	private SimpleCommand confirmCmd;

	private Action action;

	public string Text
	{
		get
		{
			return text;
		}
		set
		{
			Set(ref text, value, "Text");
		}
	}

	public bool IsConfirm
	{
		get
		{
			return isConfirm;
		}
		set
		{
			Set(ref isConfirm, value, "IsConfirm");
		}
	}

	public ICommand ConfirmCmd => confirmCmd;

	public DisconnectViewModel()
	{
	}

	public DisconnectViewModel(string message, bool isConfirm)
	{
		text = message;
		this.isConfirm = isConfirm;
		confirmCmd = new SimpleCommand(OnConfirm);
	}

	public void UpdateMessage(string message)
	{
		Text = message;
	}

	private void OnConfirm()
	{
		action?.Invoke();
		action = null;
		Close();
	}

	public void AddConfirmAction(Action action)
	{
		this.action = action;
	}
}
