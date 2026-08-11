using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class AlertDialogWindow : UGuiWindow
{
	public TextMeshProUGUI Title;

	public TextMeshProUGUI Message;

	public GameObject Content;

	public Button ConfirmButton;

	public Button NeutralButton;

	public Button CancelButton;

	public Button CancelButton2;

	public Button OutsideButton;

	private AlertDialogViewModel viewModel;

	public bool CanceledOnTouchOutside { get; set; }

	public AlertDialogViewModel ViewModel
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
		viewModel.OnClick(which);
	}

	public virtual void Cancel()
	{
		Button_OnClick(-2);
	}

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		base.WindowType = WindowType.DIALOG;
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
		if (CancelButton != null)
		{
			if (!string.IsNullOrEmpty(viewModel.CancelButtonText))
			{
				CancelButton.gameObject.SetActive(value: true);
				CancelButton.onClick.AddListener(delegate
				{
					Button_OnClick(-2);
				});
				TextMeshProUGUI componentInChildren2 = CancelButton.GetComponentInChildren<TextMeshProUGUI>();
				if ((Object)(object)componentInChildren2 != null)
				{
					((TMP_Text)componentInChildren2).text = viewModel.CancelButtonText;
				}
			}
			else
			{
				CancelButton.gameObject.SetActive(value: false);
			}
		}
		if (CancelButton2 != null)
		{
			CancelButton2.gameObject.SetActive(viewModel.CanceledOnTop);
			CancelButton2.onClick.AddListener(delegate
			{
				Button_OnClick(-2);
			});
		}
		if (NeutralButton != null)
		{
			if (!string.IsNullOrEmpty(viewModel.NeutralButtonText))
			{
				NeutralButton.gameObject.SetActive(value: true);
				NeutralButton.onClick.AddListener(delegate
				{
					Button_OnClick(-3);
				});
				TextMeshProUGUI componentInChildren3 = NeutralButton.GetComponentInChildren<TextMeshProUGUI>();
				if ((Object)(object)componentInChildren3 != null)
				{
					((TMP_Text)componentInChildren3).text = viewModel.NeutralButtonText;
				}
			}
			else
			{
				NeutralButton.gameObject.SetActive(value: false);
			}
		}
		CanceledOnTouchOutside = viewModel.CanceledOnTouchOutside;
		if (OutsideButton != null && CanceledOnTouchOutside)
		{
			OutsideButton.gameObject.SetActive(value: true);
			OutsideButton.interactable = true;
			OutsideButton.onClick.AddListener(delegate
			{
				Button_OnClick(-2);
			});
		}
	}
}
