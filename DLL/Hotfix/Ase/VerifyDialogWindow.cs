using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class VerifyDialogWindow : Window
{
	public TextMeshProUGUI Title;

	public TextMeshProUGUI Message;

	public InputField InputField;

	public Button ConfirmButton;

	public Button CloseButton;

	public Button OutsideButton;

	private TextMeshProUGUI placeholderText;

	private VerifyDialogViewModel viewModel;

	public bool CanceledOnTouchOutside { get; set; }

	public VerifyDialogViewModel ViewModel
	{
		get
		{
			return viewModel;
		}
		set
		{
			viewModel = value;
			OnChangeViewModel();
		}
	}

	protected virtual void Button_OnClick(int which)
	{
		Dismiss();
		viewModel.OnClick(which, InputField.text);
	}

	public virtual void Cancel()
	{
		Button_OnClick(-2);
	}

	protected override void OnCreate(IBundle bundle)
	{
		base.WindowType = WindowType.DIALOG;
		if (InputField != null)
		{
			placeholderText = InputField.placeholder.gameObject.GetComponent<TextMeshProUGUI>();
		}
	}

	protected void OnChangeViewModel()
	{
		if ((Object)(object)Message != null)
		{
			if (!string.IsNullOrEmpty(viewModel.Message))
			{
				((Component)(object)Message).gameObject.SetActive(value: true);
				((TMP_Text)Message).text = viewModel.Message;
			}
			else
			{
				((Component)(object)Message).gameObject.SetActive(value: false);
			}
		}
		if ((Object)(object)Title != null)
		{
			if (!string.IsNullOrEmpty(viewModel.Title))
			{
				((Component)(object)Title).gameObject.SetActive(value: true);
				((TMP_Text)Title).text = viewModel.Title;
			}
			else
			{
				((Component)(object)Title).gameObject.SetActive(value: false);
			}
		}
		if ((Object)(object)placeholderText != null)
		{
			if (!string.IsNullOrEmpty(viewModel.InputFieldTipsText))
			{
				((TMP_Text)placeholderText).text = viewModel.InputFieldTipsText;
			}
			else
			{
				((TMP_Text)placeholderText).text = "请输入验证信息";
			}
		}
		if (ConfirmButton != null)
		{
			if (!string.IsNullOrEmpty(viewModel.ConfirmButtonText))
			{
				ConfirmButton.gameObject.SetActive(value: true);
				ConfirmButton.onClick.AddListener(delegate
				{
					Button_OnClick(-1);
				});
				TextMeshProUGUI componentInChildren = ConfirmButton.GetComponentInChildren<TextMeshProUGUI>();
				if ((Object)(object)componentInChildren != null)
				{
					((TMP_Text)componentInChildren).text = viewModel.ConfirmButtonText;
				}
			}
			else
			{
				ConfirmButton.gameObject.SetActive(value: false);
			}
		}
		if (CloseButton != null)
		{
			CloseButton.gameObject.SetActive(value: true);
			CloseButton.interactable = true;
			CloseButton.onClick.AddListener(Cancel);
		}
		CanceledOnTouchOutside = viewModel.CanceledOnTouchOutside;
		if (OutsideButton != null && CanceledOnTouchOutside)
		{
			OutsideButton.gameObject.SetActive(value: true);
			OutsideButton.interactable = true;
			OutsideButton.onClick.AddListener(Cancel);
		}
	}
}
