using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class PopupDownloadProcessView : BaseUIView
{
	[Header("下载进度")]
	[SerializeField]
	private Slider progressBar;

	[SerializeField]
	private TextMeshProUGUI percentText;

	[SerializeField]
	private TextMeshProUGUI stageNameText;

	[SerializeField]
	private TextMeshProUGUI detailText;

	[SerializeField]
	private ActButton cancelButton;

	private readonly string[] _progressFormatters = new string[4] { "0", "0", "0.0", "0.0" };

	private readonly string[] _speedFormatters = new string[4] { "0.0", "0.0", "0.0", "0.0" };

	private PopupDownloadProcessViewData _data;

	private DownloadData _downloadData;

	private ProgressStageType _currentStage;

	private bool _completed;

	private bool _cancelRequested;

	protected override void Init()
	{
		base.Init();
		_data = uiViewData as PopupDownloadProcessViewData;
		_completed = false;
		_cancelRequested = false;
		BindCancelButton();
		BindDownloadData(_data?.downloadData);
	}

	protected override void UnInit()
	{
		UnbindCancelButton();
		UnbindDownloadData();
		if (!_completed && !_cancelRequested)
		{
			_data?.onCancel?.Invoke();
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

	public void ShowComplete()
	{
		_completed = true;
		if ((bool)progressBar)
		{
			progressBar.value = 1f;
		}
		if ((bool)percentText)
		{
			percentText.text = ToPercentage(1f, 0);
		}
	}

	public void ShowCheckProgress(string stageName, float percent)
	{
		if ((bool)stageNameText)
		{
			stageNameText.text = stageName;
		}
		if ((bool)detailText)
		{
			detailText.gameObject.SetActive(value: false);
		}
		if ((bool)percentText)
		{
			percentText.text = ToPercentage(percent, 2);
		}
		if ((bool)progressBar)
		{
			progressBar.value = percent;
		}
	}

	public void RequestCancel()
	{
		if (!_cancelRequested)
		{
			_cancelRequested = true;
			if (_downloadData != null)
			{
				_downloadData.CancelRequested = true;
			}
			_data?.onCancel?.Invoke();
		}
	}

	private void BindCancelButton()
	{
		ActButton[] componentsInChildren = GetComponentsInChildren<ActButton>(includeInactive: true);
		ActButton actButton = null;
		foreach (ActButton actButton2 in componentsInChildren)
		{
			if (!(actButton2 == null))
			{
				bool flag = actButton2.name == "btn_close_popup";
				bool flag2 = actButton2.name == "common_btn_lv2_v4_white";
				if ((cancelButton == null) & flag2)
				{
					cancelButton = actButton2;
				}
				if (actButton == null && !flag)
				{
					actButton = actButton2;
				}
				actButton2.gameObject.SetActive(value: false);
			}
		}
		if (cancelButton == null)
		{
			cancelButton = actButton;
		}
		if (cancelButton == null)
		{
			Debug.LogWarning("[PopupDownloadProcessView] No cancel button found in the download process prefab.");
			return;
		}
		cancelButton.gameObject.SetActive(value: true);
		cancelButton.interactable = true;
		cancelButton.OnClick.RemoveListener(RequestCancel);
		cancelButton.OnClick.AddListener(RequestCancel);
		SetButtonLabel(cancelButton, "取消下载");
	}

	private void UnbindCancelButton()
	{
		cancelButton?.OnClick.RemoveListener(RequestCancel);
	}

	private static void SetButtonLabel(ActButton button, string text)
	{
		TextMeshProUGUI componentInChildren = button.GetComponentInChildren<TextMeshProUGUI>(includeInactive: true);
		if (componentInChildren != null)
		{
			componentInChildren.text = text;
		}
	}

	private void BindDownloadData(DownloadData downloadData)
	{
		UnbindDownloadData();
		_downloadData = downloadData;
		if (_downloadData != null)
		{
			DownloadData downloadData2 = _downloadData;
			downloadData2.StageProgressChanged = (Action<ProgressStageType, StageProgressData>)Delegate.Combine(downloadData2.StageProgressChanged, new Action<ProgressStageType, StageProgressData>(OnStageProgressChanged));
			DownloadData downloadData3 = _downloadData;
			downloadData3.StageChanged = (Action<ProgressStageType>)Delegate.Combine(downloadData3.StageChanged, new Action<ProgressStageType>(OnStageChanged));
			_currentStage = _downloadData.CurrentStage;
			UpdateStageUI(_downloadData.GetStageProgressData(_currentStage));
		}
	}

	private void UnbindDownloadData()
	{
		if (_downloadData != null)
		{
			DownloadData downloadData = _downloadData;
			downloadData.StageProgressChanged = (Action<ProgressStageType, StageProgressData>)Delegate.Remove(downloadData.StageProgressChanged, new Action<ProgressStageType, StageProgressData>(OnStageProgressChanged));
			DownloadData downloadData2 = _downloadData;
			downloadData2.StageChanged = (Action<ProgressStageType>)Delegate.Remove(downloadData2.StageChanged, new Action<ProgressStageType>(OnStageChanged));
			_downloadData = null;
		}
	}

	private void OnStageProgressChanged(ProgressStageType stageType, StageProgressData data)
	{
		if (data == null)
		{
			return;
		}
		if (stageType != _currentStage)
		{
			if (data.IsActive)
			{
				OnStageChanged(stageType);
			}
		}
		else
		{
			UpdateStageUI(data);
		}
	}

	private void OnStageChanged(ProgressStageType stageType)
	{
		_currentStage = stageType;
		StageProgressData stageProgressData = _downloadData?.GetStageProgressData(stageType);
		if (stageProgressData != null)
		{
			UpdateStageUI(stageProgressData);
		}
	}

	private void UpdateStageUI(StageProgressData data)
	{
		switch (_currentStage)
		{
		case ProgressStageType.Download:
		case ProgressStageType.CheckIntegrity:
			UpdateDownloadUI(data);
			break;
		case ProgressStageType.Extract:
			UpdateExtractUI(data);
			break;
		}
	}

	private void UpdateDownloadUI(StageProgressData data)
	{
		float num = Mathf.Clamp01(data.Percent);
		if ((bool)progressBar)
		{
			progressBar.value = num;
		}
		if ((bool)stageNameText && !string.IsNullOrEmpty(data.StageName))
		{
			stageNameText.text = data.StageName;
		}
		if ((bool)percentText)
		{
			percentText.text = ToPercentage(num, 2);
		}
		if ((bool)detailText)
		{
			detailText.gameObject.SetActive(data.IsActive);
			detailText.text = (data.IsActive ? FormatDownloadDetail(data) : string.Empty);
		}
	}

	private void UpdateExtractUI(StageProgressData data)
	{
		float num = Mathf.Clamp01(data.Percent);
		if ((bool)progressBar)
		{
			progressBar.value = num;
		}
		if ((bool)stageNameText && !string.IsNullOrEmpty(data.StageName))
		{
			stageNameText.text = data.StageName;
		}
		if ((bool)percentText)
		{
			percentText.text = ToPercentage(num, 1);
		}
		if ((bool)detailText)
		{
			detailText.gameObject.SetActive(data.TotalCount > 0);
			detailText.text = ((data.TotalCount > 0) ? $"({data.CurrentCount}/{data.TotalCount})" : string.Empty);
		}
	}

	private string FormatDownloadDetail(StageProgressData data)
	{
		if (data.TotalBytes <= 0)
		{
			return string.Empty;
		}
		string text = "(" + ByteConverter(data.CurrentBytes, _progressFormatters) + "/" + ByteConverter(data.TotalBytes, _progressFormatters) + ")";
		if (data.SpeedBytesPerSecond <= 0)
		{
			return text;
		}
		return text + " " + ByteConverter(data.SpeedBytesPerSecond, _speedFormatters) + "/s";
	}

	private static string ByteConverter(long byteSize, string[] formatters)
	{
		float num = (float)byteSize / 1024f;
		if (num < 1024f)
		{
			return num.ToString(formatters[0]) + "KB";
		}
		num /= 1024f;
		if (num < 1024f)
		{
			return num.ToString(formatters[1]) + "MB";
		}
		num /= 1024f;
		if (num < 1024f)
		{
			return num.ToString(formatters[2]) + "GB";
		}
		return (num / 1024f).ToString(formatters[3]) + "TB";
	}

	private static string ToPercentage(float percent, int decimalPlaces)
	{
		return percent.ToString($"p{decimalPlaces}");
	}
}
