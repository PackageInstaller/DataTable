using TMPro;
using UnityEngine;

namespace ACT.UI;

public class PopupDownloadInstructionsView : BaseUIView
{
	private const string CarrierNetworkWarning = "检测到当前网络环境为移动数据环境，建议在WIFI环境下下载。";

	[Header("下载说明")]
	[SerializeField]
	private TextMeshProUGUI messageText;

	[SerializeField]
	private TextMeshProUGUI sizeText;

	[SerializeField]
	private GameObject resourceRoot;

	[SerializeField]
	private TextMeshProUGUI voicePackageMessageText;

	[SerializeField]
	private ActButton confirmButton;

	[SerializeField]
	private ActButton cancelButton;

	[SerializeField]
	private ActButton closeButton;

	private readonly string[] _sizeFormatters = new string[4] { "0", "0", "0.0", "0.0" };

	private PopupDownloadInstructionsViewData _data;

	private bool _resolved;

	protected override void Init()
	{
		base.Init();
		_data = uiViewData as PopupDownloadInstructionsViewData;
		_resolved = false;
		BindButtons();
		RefreshContent();
	}

	protected override void UnInit()
	{
		UnbindButtons();
		if (!_resolved)
		{
			Resolve(confirmed: false);
		}
		_data = null;
		base.UnInit();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	private void BindButtons()
	{
		CacheButtons();
		confirmButton?.OnClick.AddListener(Confirm);
		cancelButton?.OnClick.AddListener(Cancel);
		if (closeButton != null)
		{
			closeButton.OnClick.RemoveAllListeners();
			closeButton.OnClick.AddListener(Cancel);
		}
	}

	private void UnbindButtons()
	{
		confirmButton?.OnClick.RemoveListener(Confirm);
		cancelButton?.OnClick.RemoveListener(Cancel);
		closeButton?.OnClick.RemoveListener(Cancel);
	}

	private void CacheButtons()
	{
		if (confirmButton != null && cancelButton != null && closeButton != null)
		{
			return;
		}
		ActButton[] componentsInChildren = GetComponentsInChildren<ActButton>(includeInactive: true);
		foreach (ActButton actButton in componentsInChildren)
		{
			if (actButton.name == "common_btn_lv2_v4")
			{
				confirmButton = actButton;
			}
			else if (actButton.name == "common_btn_lv2_v4_white")
			{
				cancelButton = actButton;
			}
			else if (actButton.name == "btn_close_popup")
			{
				closeButton = actButton;
			}
		}
	}

	public void Confirm()
	{
		Resolve(confirmed: true);
		Close();
	}

	public void Cancel()
	{
		Resolve(confirmed: false);
		Close();
	}

	private void RefreshContent()
	{
		if (_data != null)
		{
			bool flag = _data.mode == DownloadInstructionsMode.VoicePackageConfirm;
			bool flag2 = _data.mode == DownloadInstructionsMode.VoicePackageUseConfirm;
			bool flag3 = flag | flag2;
			bool flag4 = flag && _data.isCarrierNetwork;
			if ((bool)messageText)
			{
				bool active = flag4 || !flag3;
				messageText.gameObject.SetActive(active);
				TextMeshProUGUI textMeshProUGUI = messageText;
				textMeshProUGUI.text = _data.mode switch
				{
					DownloadInstructionsMode.CancelConfirm => "确认取消下载？", 
					DownloadInstructionsMode.VoicePackageConfirm => "检测到当前网络环境为移动数据环境，建议在WIFI环境下下载。", 
					_ => _data.isCarrierNetwork ? ("当前使用移动网络，本次更新需要下载" + ByteConverter(_data.totalBytes) + "资源，是否继续？") : ("本次更新需要下载" + ByteConverter(_data.totalBytes) + "资源，是否继续？"), 
				};
			}
			if ((bool)voicePackageMessageText)
			{
				voicePackageMessageText.gameObject.SetActive(flag3);
				TextMeshProUGUI textMeshProUGUI = voicePackageMessageText;
				textMeshProUGUI.text = _data.mode switch
				{
					DownloadInstructionsMode.VoicePackageConfirm => "当前尚未下载完整语音包，是否下载" + _data.packageName + "？", 
					DownloadInstructionsMode.VoicePackageUseConfirm => _data.packageName + "语音包下载完成，是否立即使用？", 
					_ => string.Empty, 
				};
			}
			if ((bool)sizeText)
			{
				string downloadSize = GetDownloadSize();
				bool flag5 = _data.mode != DownloadInstructionsMode.CancelConfirm && _data.mode != DownloadInstructionsMode.VoicePackageUseConfirm && !string.IsNullOrEmpty(downloadSize);
				resourceRoot?.SetActive(flag5);
				sizeText.gameObject.SetActive(flag5);
				sizeText.text = (flag5 ? ("资源大小:" + downloadSize) : string.Empty);
			}
		}
	}

	private string GetDownloadSize()
	{
		if (!string.IsNullOrEmpty(_data.downloadSize))
		{
			return _data.downloadSize;
		}
		if (_data.totalBytes < 0)
		{
			return string.Empty;
		}
		return ByteConverter(_data.totalBytes);
	}

	private void Resolve(bool confirmed)
	{
		if (!_resolved)
		{
			_resolved = true;
			((!confirmed) ? _data?.onCancel : _data?.onConfirm)?.Invoke();
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
