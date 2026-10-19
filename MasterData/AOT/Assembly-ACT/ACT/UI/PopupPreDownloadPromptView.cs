using System;
using ACT.Utility;
using TMPro;
using UnityEngine;
using bamboosdk;

namespace ACT.UI;

public class PopupPreDownloadPromptView : BaseUIView
{
	private enum PromptStage
	{
		DownloadPrompt,
		InsufficientSpace,
		SpaceSufficient,
		DownloadCompleted,
		DownloadCanceled
	}

	private const long ExtraDiskSpaceRequired = 3221225472L;

	private readonly string[] _sizeFormatters = new string[4] { "0", "0", "0.0", "0.0" };

	[SerializeField]
	private GameObject text1;

	[SerializeField]
	private GameObject text2;

	[SerializeField]
	private GameObject text3;

	[SerializeField]
	private GameObject text4;

	[SerializeField]
	private GameObject text5;

	[SerializeField]
	private TextMeshProUGUI downloadedSizeText;

	[SerializeField]
	private TextMeshProUGUI totalSizeText;

	[SerializeField]
	private ActButton confirmButton;

	[SerializeField]
	private ActButton cancelButton;

	private PopupPreDownloadPromptViewData _data;

	private PromptStage _stage;

	private bool _resolved;

	protected override void Init()
	{
		base.Init();
		_data = uiViewData as PopupPreDownloadPromptViewData;
		_resolved = false;
		BindButtons();
		RefreshPrompt();
	}

	protected override void ReInit()
	{
		base.ReInit();
		gameObject.SetActive(value: true);
		_data = uiViewData as PopupPreDownloadPromptViewData;
		_resolved = false;
		BindButtons();
		RefreshPrompt();
	}

	protected override void UnInit()
	{
		UnbindButtons();
		if (!_resolved)
		{
			ResolveCancel();
		}
		_data = null;
		base.UnInit();
	}

	private void BindButtons()
	{
		confirmButton.SetBtnClick(OnConfirmClick);
		cancelButton.SetBtnClick(OnCancelClick);
	}

	private void UnbindButtons()
	{
		confirmButton.SetBtnClick(null);
		cancelButton.SetBtnClick(null);
	}

	private void RefreshDownloadSize()
	{
		long num = Math.Max(0L, _data?.downloadedBytes ?? 0);
		long byteSize = Math.Max(num, _data?.totalBytes ?? 0);
		downloadedSizeText.text = ByteConverter(num);
		totalSizeText.text = ByteConverter(byteSize);
	}

	private void RefreshPrompt()
	{
		RefreshDownloadSize();
		PopupPreDownloadPromptViewData data = _data;
		if (data != null && data.isPreDownloadCompleted)
		{
			ShowStage(PromptStage.DownloadCompleted);
			return;
		}
		PopupPreDownloadPromptViewData data2 = _data;
		if (data2 != null && data2.showPauseConfirmation)
		{
			ShowStage(PromptStage.DownloadCanceled);
		}
		else
		{
			ShowStage(PromptStage.DownloadPrompt);
		}
	}

	private void OnConfirmClick()
	{
		Debug.Log(string.Format("[{0}] Confirm clicked. Stage: {1}", "PopupPreDownloadPromptView", _stage));
		switch (_stage)
		{
		case PromptStage.DownloadPrompt:
			if (!HasEnoughDiskSpace())
			{
				ShowStage(PromptStage.InsufficientSpace);
			}
			else if (Application.internetReachability == NetworkReachability.ReachableViaCarrierDataNetwork)
			{
				ShowStage(PromptStage.SpaceSufficient);
			}
			else
			{
				StartPreDownload();
			}
			break;
		case PromptStage.InsufficientSpace:
			_resolved = true;
			_data?.onInsufficientSpaceConfirm?.Invoke();
			Close();
			break;
		case PromptStage.SpaceSufficient:
			StartPreDownload();
			break;
		case PromptStage.DownloadCanceled:
		{
			PopupPreDownloadPromptViewData data = _data;
			if (data != null && data.showPauseConfirmation)
			{
				_resolved = true;
				_data.onPauseConfirm?.Invoke();
				Close();
			}
			break;
		}
		case PromptStage.DownloadCompleted:
			break;
		}
	}

	private void OnCancelClick()
	{
		ResolveCancel();
		Close();
	}

	private void StartPreDownload()
	{
		if (PreDownloadAssetRunner.StartPreDownload(this))
		{
			_resolved = true;
			_data?.onConfirm?.Invoke();
			gameObject.SetActive(value: false);
		}
	}

	public void ShowDownloadCompleted()
	{
		gameObject.SetActive(value: true);
		ShowStage(PromptStage.DownloadCompleted);
	}

	public void ShowPauseConfirmation(Action onPauseConfirm)
	{
		gameObject.SetActive(value: true);
		_data = new PopupPreDownloadPromptViewData
		{
			showPauseConfirmation = true,
			onPauseConfirm = onPauseConfirm
		};
		_resolved = false;
		BindButtons();
		RefreshPrompt();
	}

	public void ShowDownloadCanceled()
	{
		gameObject.SetActive(value: true);
		ShowStage(PromptStage.DownloadCanceled);
	}

	private void ShowStage(PromptStage stage)
	{
		_stage = stage;
		text1.SetActive(stage == PromptStage.DownloadPrompt);
		text2.SetActive(stage == PromptStage.InsufficientSpace);
		text3.SetActive(stage == PromptStage.SpaceSufficient);
		text4.SetActive(stage == PromptStage.DownloadCompleted);
		text5.SetActive(stage == PromptStage.DownloadCanceled);
		bool flag = stage == PromptStage.DownloadCanceled && (_data?.showPauseConfirmation ?? false);
		bool flag2 = (stage == PromptStage.DownloadPrompt || stage == PromptStage.InsufficientSpace || stage == PromptStage.SpaceSufficient) | flag;
		confirmButton.gameObject.SetActive(flag2);
		cancelButton.gameObject.SetActive((stage == PromptStage.DownloadPrompt || stage == PromptStage.SpaceSufficient) | flag);
		confirmButton.interactable = flag2;
		cancelButton.interactable = cancelButton.gameObject.activeSelf;
	}

	private bool HasEnoughDiskSpace()
	{
		long leftDiskSpace = LuminBambooBridgeListener.LeftDiskSpace;
		long requiredSpaceBytes = GetRequiredSpaceBytes();
		Debug.Log(string.Format("[{0}] Required disk space: {1} bytes, available: {2} bytes", "PopupPreDownloadPromptView", requiredSpaceBytes, leftDiskSpace));
		if (leftDiskSpace >= 0)
		{
			return leftDiskSpace >= requiredSpaceBytes;
		}
		return true;
	}

	private long GetRequiredSpaceBytes()
	{
		if (_data == null)
		{
			return 0L;
		}
		if (_data.requiredSpaceBytes >= 0)
		{
			return _data.requiredSpaceBytes;
		}
		return Math.Max(0L, _data.totalBytes - _data.downloadedBytes) + 3221225472u;
	}

	private void ResolveCancel()
	{
		if (!_resolved)
		{
			_resolved = true;
			_data?.onCancel?.Invoke();
		}
	}

	private string ByteConverter(long byteSize)
	{
		float num = (float)byteSize / 1024f;
		if (num < 1024f)
		{
			return num.ToString(_sizeFormatters[0]) + "KB";
		}
		num /= 1024f;
		if (num < 1024f)
		{
			return num.ToString(_sizeFormatters[1]) + "MB";
		}
		num /= 1024f;
		if (num < 1024f)
		{
			return num.ToString(_sizeFormatters[2]) + "GB";
		}
		return (num / 1024f).ToString(_sizeFormatters[3]) + "TB";
	}
}
