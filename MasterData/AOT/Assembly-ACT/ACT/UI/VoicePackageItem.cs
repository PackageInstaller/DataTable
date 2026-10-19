using System;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class VoicePackageItem : MonoBehaviour
{
	[SerializeField]
	private TextMeshProUGUI nameText;

	[SerializeField]
	private TextMeshProUGUI sizeText;

	[SerializeField]
	private TextMeshProUGUI statusText;

	[SerializeField]
	private ActButton selectButton;

	[SerializeField]
	private GameObject selectedMark;

	[SerializeField]
	private GameObject downloadedMark;

	[SerializeField]
	private GameObject nonChineseDisplayObject;

	private int _index;

	private Action<int> _onSelected;

	public void Init(int index, string displayName, string packageSize, bool isDownloaded, bool isInUse, bool isChineseVoicePackage, Action<int> onSelected)
	{
		_index = index;
		_onSelected = onSelected;
		if (nameText != null)
		{
			nameText.text = (string.IsNullOrEmpty(packageSize) ? displayName : (displayName + "(" + packageSize + ")"));
		}
		if (sizeText != null)
		{
			sizeText.text = packageSize;
		}
		if (statusText != null)
		{
			TextMeshProUGUI textMeshProUGUI = statusText;
			string text;
			if (isInUse)
			{
				text = "使用中";
			}
			else
			{
				text = (isDownloaded ? "已下载" : "未下载");
			}
			textMeshProUGUI.text = text;
		}
		if (downloadedMark != null)
		{
			downloadedMark.SetActive(isDownloaded);
		}
		if (nonChineseDisplayObject != null)
		{
			nonChineseDisplayObject.SetActive(!isChineseVoicePackage);
		}
		SetSelected(isInUse);
		if (selectButton != null)
		{
			selectButton.OnClick.RemoveListener(OnSelectButtonClicked);
			selectButton.OnClick.AddListener(OnSelectButtonClicked);
		}
	}

	private void OnSelectButtonClicked()
	{
		Debug.Log($"[VoicePackageItem] Button selected: index={_index}.");
		_onSelected?.Invoke(_index);
	}

	public void SetSelected(bool selected)
	{
		SetSelectedGameObjectActive(selected);
	}

	private void SetSelectedGameObjectActive(bool selected)
	{
		if (selectedMark != null)
		{
			selectedMark.SetActive(selected);
		}
	}

	private void OnDestroy()
	{
		if (selectButton != null)
		{
			selectButton.OnClick.RemoveListener(OnSelectButtonClicked);
		}
	}
}
