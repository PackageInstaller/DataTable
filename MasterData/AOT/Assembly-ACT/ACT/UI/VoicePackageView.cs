using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.LocalLoader;
using ACT.Sound;
using ACT.Sound.Language;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class VoicePackageView : BaseUIView
{
	[Header("UI引用")]
	[SerializeField]
	private ActButton downloadButton;

	[SerializeField]
	private ActButton unloadButton;

	[SerializeField]
	private ActButton applyButton;

	[SerializeField]
	private TextMeshProUGUI warningText;

	[SerializeField]
	private Transform contentParent;

	[SerializeField]
	private GameObject voicePackageItemPrefab;

	private const bool UseEditorMockData = true;

	private const string ChineseVoiceTag = "CN";

	private const string EnglishVoiceTag = "EN";

	private const string JapaneseVoiceTag = "JP";

	private const string LegacyDownloadedPrefsPrefix = "VoicePack.Downloaded.";

	private const float VoicePackageItemHeight = 70f;

	private VoicePackageViewData m_data;

	private VoicePackageDownloadRunner m_downloadRunner;

	private bool m_isReturningToGameStart;

	private bool m_isApplyingVoicePackage;

	protected override void AddEventListener()
	{
		base.AddEventListener();
		if (downloadButton != null)
		{
			downloadButton.OnClick.AddListener(OnPrimaryClicked);
		}
		if (unloadButton != null)
		{
			unloadButton.OnClick.AddListener(OnUnloadClicked);
		}
		if (applyButton != null)
		{
			applyButton.OnClick.AddListener(OnPrimaryClicked);
		}
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		if (downloadButton != null)
		{
			downloadButton.OnClick.RemoveListener(OnPrimaryClicked);
		}
		if (unloadButton != null)
		{
			unloadButton.OnClick.RemoveListener(OnUnloadClicked);
		}
		if (applyButton != null)
		{
			applyButton.OnClick.RemoveListener(OnPrimaryClicked);
		}
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_data = uiViewData as VoicePackageViewData;
		m_isReturningToGameStart = false;
		m_isApplyingVoicePackage = false;
	}

	protected override void Init()
	{
		base.Init();
		RefreshData();
		RefreshUI();
	}

	protected override void UnInit()
	{
		base.UnInit();
		if (m_downloadRunner != null && m_downloadRunner.IsRunning)
		{
			m_downloadRunner.Cancel(notifyCompletion: false);
		}
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

	protected override void OnMoveToShow()
	{
		base.OnMoveToShow();
		if (m_data != null)
		{
			UpdateBottomButtons();
		}
	}

	private void RefreshData()
	{
		DownloadAssetManager.Instance.AddLocalDownloadedTag("CN");
		m_data.PackageDataList = new List<VoicePackageViewData.VoicePackageItemData>(3);
		if (Application.isEditor)
		{
			AddPackageData(AudioLanguageType.Chinese, "普通话", "1.19 GB", isDownloaded: true, isInUse: true);
			AddPackageData(AudioLanguageType.English, "英语", "1.21 GB", IsVoicePackageDownloaded(AudioLanguageType.English), isInUse: false);
			AddPackageData(AudioLanguageType.Japanese, "日语", "2.10 GB", IsVoicePackageDownloaded(AudioLanguageType.Japanese), isInUse: false);
			Debug.Log($"[VoicePackageView] Editor mock data loaded: {m_data.PackageDataList.Count} packages.");
		}
		else
		{
			ZipInfo[] fullRawFileInfos = LuminApplication.RemoteConfig?.FullRawFileInfos;
			TryAddPackageData(fullRawFileInfos, AudioLanguageType.Chinese, "普通话", "CN", "1.19G", IsVoicePackageDownloaded(AudioLanguageType.Chinese));
			TryAddPackageData(fullRawFileInfos, AudioLanguageType.English, "英语", "EN", "1.21G", IsVoicePackageDownloaded(AudioLanguageType.English));
			TryAddPackageData(fullRawFileInfos, AudioLanguageType.Japanese, "日语", "JP", "2.1G", IsVoicePackageDownloaded(AudioLanguageType.Japanese));
		}
	}

	private void TryAddPackageData(ZipInfo[] fullRawFileInfos, AudioLanguageType languageType, string displayName, string packageTag, string defaultPackageSize, bool isDownloaded)
	{
		if (TryGetPackageSize(fullRawFileInfos, packageTag, defaultPackageSize, out var packageSize))
		{
			AddPackageData(languageType, displayName, packageSize, isDownloaded, AudioLanguageManager.CurrentLanguageType == languageType);
		}
	}

	private void AddPackageData(AudioLanguageType languageType, string displayName, string packageSize, bool isDownloaded, bool isInUse)
	{
		isInUse = GetCurrentVoiceLanguageType() == languageType;
		m_data.PackageDataList.Add(new VoicePackageViewData.VoicePackageItemData
		{
			languageType = languageType,
			displayName = displayName,
			packageSize = packageSize,
			isDownloaded = (isDownloaded | isInUse),
			isInUse = isInUse
		});
	}

	private static AudioLanguageType GetCurrentVoiceLanguageType()
	{
		SettingsManager instance = SettingsManager.Instance;
		if (instance != null && instance.RuntimeSettings != null)
		{
			SettingOptions settingOptions = instance.RuntimeSettings.GetSettingOptions("Language.Voice");
			if (settingOptions != null)
			{
				AudioLanguageType[] array = (AudioLanguageType[])Enum.GetValues(typeof(AudioLanguageType));
				int value = settingOptions.GetValue();
				if (value >= 0 && value < array.Length)
				{
					return array[value];
				}
			}
		}
		AudioLanguageType currentLanguageType = AudioLanguageManager.CurrentLanguageType;
		if (currentLanguageType == AudioLanguageType.Chinese || currentLanguageType == AudioLanguageType.English || currentLanguageType == AudioLanguageType.Japanese)
		{
			return currentLanguageType;
		}
		return AudioLanguageType.Chinese;
	}

	private static bool TryGetPackageSize(ZipInfo[] fullRawFileInfos, string packageTag, string defaultPackageSize, out string packageSize)
	{
		packageSize = defaultPackageSize;
		if (fullRawFileInfos == null || fullRawFileInfos.Length == 0)
		{
			return false;
		}
		long num = 0L;
		bool flag = false;
		bool flag2 = false;
		string text = null;
		foreach (ZipInfo zipInfo in fullRawFileInfos)
		{
			if (zipInfo == null || !ContainsPackageTag(zipInfo.tag, packageTag))
			{
				continue;
			}
			flag2 = true;
			if (!string.IsNullOrEmpty(zipInfo.size))
			{
				if (long.TryParse(zipInfo.size, out var result) && result >= 0)
				{
					num += result;
					flag = true;
				}
				else if (text == null)
				{
					text = zipInfo.size;
				}
			}
		}
		if (!flag2)
		{
			return false;
		}
		if (flag)
		{
			packageSize = FileUtility.FormatFileSize(num, false, 1);
			return true;
		}
		packageSize = text ?? defaultPackageSize;
		return true;
	}

	private static bool ContainsPackageTag(string packageTags, string packageTag)
	{
		if (string.IsNullOrWhiteSpace(packageTags) || string.IsNullOrEmpty(packageTag))
		{
			return false;
		}
		int num = 0;
		for (int i = 0; i <= packageTags.Length; i++)
		{
			if (i >= packageTags.Length || packageTags[i] == '-')
			{
				int j = num;
				int num2;
				for (num2 = i - 1; j <= num2 && char.IsWhiteSpace(packageTags[j]); j++)
				{
				}
				while (num2 >= j && char.IsWhiteSpace(packageTags[num2]))
				{
					num2--;
				}
				int num3 = num2 - j + 1;
				if (num3 == packageTag.Length && string.Compare(packageTags, j, packageTag, 0, num3, StringComparison.OrdinalIgnoreCase) == 0)
				{
					return true;
				}
				num = i + 1;
			}
		}
		return false;
	}

	private void RefreshUI(int preferredSelectedIndex = -1, bool rebuildLayout = true)
	{
		m_data.ItemList.Clear();
		m_data.SelectedIndex = -1;
		if (contentParent == null || voicePackageItemPrefab == null)
		{
			return;
		}
		int count = m_data.PackageDataList.Count;
		int childCount = contentParent.childCount;
		for (int i = 0; i < count; i++)
		{
			VoicePackageItem component;
			if (i < childCount)
			{
				GameObject gameObject = contentParent.GetChild(i).gameObject;
				component = gameObject.GetComponent<VoicePackageItem>();
				gameObject.SetActive(value: true);
			}
			else
			{
				GameObject gameObject2 = UnityEngine.Object.Instantiate(voicePackageItemPrefab, contentParent);
				component = gameObject2.GetComponent<VoicePackageItem>();
				gameObject2.SetActive(value: true);
			}
			if (component == null)
			{
				Debug.LogError($"[VoicePackageView] Voice package item at index {i} is missing VoicePackageItem.");
				continue;
			}
			VoicePackageViewData.VoicePackageItemData voicePackageItemData = m_data.PackageDataList[i];
			ConfigureItemLayout(component, i);
			component.Init(i, voicePackageItemData.displayName, voicePackageItemData.packageSize, voicePackageItemData.isDownloaded, voicePackageItemData.isInUse, voicePackageItemData.languageType == AudioLanguageType.Chinese, OnItemSelected);
			if (voicePackageItemData.isInUse)
			{
				m_data.SelectedIndex = i;
			}
			m_data.ItemList.Add(component);
		}
		for (int j = count; j < childCount; j++)
		{
			contentParent.GetChild(j).gameObject.SetActive(value: false);
		}
		if (rebuildLayout)
		{
			if (contentParent is RectTransform layoutRoot)
			{
				Canvas.ForceUpdateCanvases();
				LayoutRebuilder.ForceRebuildLayoutImmediate(layoutRoot);
			}
			ScrollRect componentInParent = contentParent.GetComponentInParent<ScrollRect>();
			if (componentInParent != null)
			{
				componentInParent.verticalNormalizedPosition = 1f;
			}
		}
		Debug.Log($"[VoicePackageView] Refreshed voice package list: data={count}, children={contentParent.childCount}, boundItems={m_data.ItemList.Count}.");
		if (preferredSelectedIndex >= 0 && preferredSelectedIndex < m_data.PackageDataList.Count)
		{
			m_data.SelectedIndex = preferredSelectedIndex;
		}
		if (m_data.SelectedIndex < 0)
		{
			for (int k = 0; k < m_data.PackageDataList.Count; k++)
			{
				if (m_data.PackageDataList[k].isInUse)
				{
					m_data.SelectedIndex = k;
					break;
				}
			}
		}
		if (m_data.SelectedIndex < 0 && m_data.PackageDataList.Count > 0)
		{
			m_data.SelectedIndex = 0;
		}
		for (int l = 0; l < m_data.ItemList.Count; l++)
		{
			m_data.ItemList[l].SetSelected(l == m_data.SelectedIndex);
		}
		UpdateBottomButtons();
	}

	private static void ConfigureItemLayout(VoicePackageItem item, int index)
	{
		item.transform.SetSiblingIndex(index);
		LayoutElement layoutElement = item.GetComponent<LayoutElement>();
		if (layoutElement == null)
		{
			layoutElement = item.gameObject.AddComponent<LayoutElement>();
		}
		layoutElement.minHeight = 70f;
		layoutElement.preferredHeight = 70f;
		layoutElement.flexibleHeight = 0f;
	}

	private void OnItemSelected(int index)
	{
		if (index >= 0 && index < m_data.PackageDataList.Count)
		{
			m_data.SelectedIndex = index;
			Debug.Log($"[VoicePackageView] Selected voice package: index={index}, name={m_data.PackageDataList[index].displayName}.");
			for (int i = 0; i < m_data.ItemList.Count; i++)
			{
				m_data.ItemList[i].SetSelected(i == index);
			}
			UpdateBottomButtons();
		}
	}

	private void OnPrimaryClicked()
	{
		if (m_data.SelectedIndex < 0 || m_data.SelectedIndex >= m_data.PackageDataList.Count)
		{
			return;
		}
		if (m_isApplyingVoicePackage || (m_downloadRunner != null && m_downloadRunner.IsRunning))
		{
			Debug.LogWarning($"[VoicePackageView] Primary click ignored: applying={m_isApplyingVoicePackage}, downloading={m_downloadRunner != null && m_downloadRunner.IsRunning}.");
			return;
		}
		VoicePackageViewData.VoicePackageItemData voicePackageItemData = m_data.PackageDataList[m_data.SelectedIndex];
		if (voicePackageItemData.isInUse)
		{
			UpdateBottomButtons();
		}
		else if (!voicePackageItemData.isDownloaded)
		{
			ShowDownloadVoicePackageConfirm(voicePackageItemData.languageType, voicePackageItemData.displayName, voicePackageItemData.packageSize, m_data.SelectedIndex);
		}
		else
		{
			ShowUseVoicePackageConfirm(voicePackageItemData.languageType, voicePackageItemData.displayName, m_data.SelectedIndex);
		}
	}

	private void ApplyVoicePackage(AudioLanguageType languageType, int uiIndex)
	{
		if (uiIndex >= 0 && uiIndex < m_data.PackageDataList.Count && m_data.PackageDataList[uiIndex].languageType == languageType)
		{
			if (m_isApplyingVoicePackage || m_isReturningToGameStart)
			{
				Debug.LogWarning($"[VoicePackageView] ApplyVoicePackage ignored: applying={m_isApplyingVoicePackage}, returningToGameStart={m_isReturningToGameStart}.");
			}
			else
			{
				ApplyVoicePackageAsync(languageType, uiIndex).Forget();
			}
		}
	}

	private async UniTaskVoid ApplyVoicePackageAsync(AudioLanguageType languageType, int uiIndex)
	{
		if (uiIndex < 0 || uiIndex >= m_data.PackageDataList.Count || m_data.PackageDataList[uiIndex].languageType != languageType)
		{
			return;
		}
		m_isApplyingVoicePackage = true;
		CancellationToken viewToken = gameObject.GetCancellationTokenOnDestroy();
		try
		{
			await WaitForCurrentConfirmPopupToClose(viewToken);
			if (this == null)
			{
				return;
			}
			UpdateBottomButtons();
			AudioLanguageType currentLanguageType = AudioLanguageManager.CurrentLanguageType;
			bool flag;
			try
			{
				flag = TrySwitchVoiceLanguage(languageType);
			}
			finally
			{
				if (AudioLanguageManager.CurrentLanguageType != currentLanguageType)
				{
					AudioLanguageManager.SetLanguage(currentLanguageType);
				}
			}
			if (!flag)
			{
				ShowSimpleMessage("语音切换失败，请稍后重试。", viewToken);
				return;
			}
			Debug.Log("[VoicePackageView] Voice language switched to: " + m_data.PackageDataList[uiIndex].displayName + ". Client restart is required.");
			RefreshData();
			RefreshUI(uiIndex);
			await ShowRestartRequiredConfirmAfterPopupsClosed(currentLanguageType, languageType);
		}
		finally
		{
			m_isApplyingVoicePackage = false;
			if (this != null)
			{
				UpdateBottomButtons();
			}
		}
	}

	private void OnUnloadClicked()
	{
		if (m_isApplyingVoicePackage || (m_downloadRunner != null && m_downloadRunner.IsRunning) || m_data.SelectedIndex < 0 || m_data.SelectedIndex >= m_data.PackageDataList.Count)
		{
			return;
		}
		VoicePackageViewData.VoicePackageItemData voicePackageItemData = m_data.PackageDataList[m_data.SelectedIndex];
		if (voicePackageItemData.isDownloaded)
		{
			if (voicePackageItemData.isInUse)
			{
				Debug.LogWarning("[VoicePackageView] Cannot unload the voice package that is currently in use.");
				UpdateBottomButtons();
			}
			else if (voicePackageItemData.languageType == AudioLanguageType.Chinese)
			{
				Debug.LogWarning("[VoicePackageView] Cannot unload built-in Chinese voice package.");
			}
			else
			{
				ShowUnloadVoicePackageConfirm(voicePackageItemData.languageType, voicePackageItemData.displayName, m_data.SelectedIndex);
			}
		}
	}

	private void UpdateBottomButtons()
	{
		VoicePackageViewData.VoicePackageItemData voicePackageItemData = ((!m_isApplyingVoicePackage && (!(m_downloadRunner != null) || !m_downloadRunner.IsRunning) && m_data.SelectedIndex >= 0 && m_data.SelectedIndex < m_data.PackageDataList.Count) ? m_data.PackageDataList[m_data.SelectedIndex] : null);
		bool flag = voicePackageItemData != null && !voicePackageItemData.isDownloaded;
		bool flag2 = voicePackageItemData != null && voicePackageItemData.isDownloaded && !voicePackageItemData.isInUse;
		bool flag3 = voicePackageItemData != null && voicePackageItemData.isDownloaded && !voicePackageItemData.isInUse && voicePackageItemData.languageType != AudioLanguageType.Chinese;
		if (downloadButton != null)
		{
			downloadButton.gameObject.SetActive(flag);
			downloadButton.interactable = flag;
			SetButtonLabel(downloadButton, "下载");
		}
		if (unloadButton != null)
		{
			unloadButton.gameObject.SetActive(flag3);
			unloadButton.interactable = flag3;
			SetButtonLabel(unloadButton, "卸载");
		}
		if (applyButton != null)
		{
			applyButton.gameObject.SetActive(flag2);
			applyButton.interactable = flag2;
			SetButtonLabel(applyButton, "使用");
		}
		if (warningText != null)
		{
			warningText.gameObject.SetActive(value: false);
		}
		RebuildBottomButtonLayout();
	}

	private void RebuildBottomButtonLayout()
	{
		RectTransform rectTransform = null;
		if (downloadButton != null)
		{
			rectTransform = downloadButton.transform.parent as RectTransform;
		}
		else if (unloadButton != null)
		{
			rectTransform = unloadButton.transform.parent as RectTransform;
		}
		else if (applyButton != null)
		{
			rectTransform = applyButton.transform.parent as RectTransform;
		}
		if (!(rectTransform == null))
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(rectTransform);
		}
	}

	private bool IsVoicePackageDownloaded(AudioLanguageType languageType)
	{
		if (!TryGetVoicePackageTag(languageType, out var packageTag))
		{
			return false;
		}
		DownloadAssetManager instance = DownloadAssetManager.Instance;
		if (instance.HasLocalDownloadedTag(packageTag))
		{
			return true;
		}
		string legacyDownloadedPrefsKey = GetLegacyDownloadedPrefsKey(languageType);
		if (PlayerPrefs.GetInt(legacyDownloadedPrefsKey, 0) == 1)
		{
			instance.AddLocalDownloadedTag(packageTag);
			PlayerPrefs.DeleteKey(legacyDownloadedPrefsKey);
			PlayerPrefs.Save();
			return true;
		}
		return false;
	}

	private void StartDownloadVoicePackage(AudioLanguageType languageType, string displayName, int uiIndex)
	{
		if (!TryGetVoicePackageTag(languageType, out var packageTag))
		{
			Debug.LogError($"[VoicePackageView] Unsupported voice package language: {languageType}");
			return;
		}
		VoicePackageDownloadRunner voicePackageDownloadRunner = ResolveDownloadRunner();
		if (voicePackageDownloadRunner == null)
		{
			return;
		}
		Debug.Log($"[VoicePackageView] Starting download for voice package: {languageType}");
		if (Application.isEditor)
		{
			if (!voicePackageDownloadRunner.BeginEditorMockDownload((bool success) =>
			{
				OnDownloadVoicePackageFinished(languageType, uiIndex, success);
			}))
			{
				UpdateBottomButtons();
				ShowDownloadStartFailure();
			}
			else
			{
				UpdateBottomButtons();
			}
		}
		else if (!voicePackageDownloadRunner.BeginDownload(packageTag, (bool success) =>
		{
			OnDownloadVoicePackageFinished(languageType, uiIndex, success);
		}))
		{
			UpdateBottomButtons();
			ShowDownloadStartFailure();
		}
		else
		{
			UpdateBottomButtons();
		}
	}

	private void ShowDownloadStartFailure()
	{
		Debug.LogError("[VoicePackageView] Voice package download runner failed to start.");
		if (!(warningText == null))
		{
			warningText.text = "下载未能启动，请检查资源配置或稍后重试。";
			warningText.gameObject.SetActive(value: true);
		}
	}

	private void ShowDownloadVoicePackageConfirm(AudioLanguageType languageType, string displayName, string packageSize, int uiIndex)
	{
		if (!TryGetVoicePackageTag(languageType, out var _))
		{
			Debug.LogError($"[VoicePackageView] Unsupported voice package language: {languageType}");
			return;
		}
		bool flag = IsNonWifiMobileNetwork();
		Debug.Log($"[VoicePackageView] Download confirm network: reachability={Application.internetReachability}, showTrafficWarning={flag}.");
		if (!Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPDOWNLOADINSTRUCTIONS, new PopupDownloadInstructionsViewData
		{
			mode = DownloadInstructionsMode.VoicePackageConfirm,
			packageName = displayName,
			totalBytes = -1L,
			downloadSize = packageSize,
			isCarrierNetwork = flag,
			onConfirm = () =>
			{
				StartDownloadVoicePackage(languageType, displayName, uiIndex);
			},
			onCancel = UpdateBottomButtons
		}).IsValid)
		{
			Debug.LogError("[VoicePackageView] Failed to open the voice package download instructions view.");
			UpdateBottomButtons();
		}
		else
		{
			UpdateBottomButtons();
		}
	}

	private void OnDownloadVoicePackageFinished(AudioLanguageType languageType, int uiIndex, bool success)
	{
		if (!success)
		{
			Debug.LogWarning($"[VoicePackageView] Voice package download failed or canceled: {languageType}");
			UpdateBottomButtons();
			ShowDownloadFailure();
			return;
		}
		if (TryGetVoicePackageTag(languageType, out var packageTag))
		{
			DownloadAssetManager.Instance.AddLocalDownloadedTag(packageTag);
			GameStart.RefreshDownloadTagsFromLocalState();
		}
		RefreshData();
		int num = ResolvePackageIndex(languageType, uiIndex);
		if (num >= 0)
		{
			m_data.PackageDataList[num].isDownloaded = true;
		}
		ShowDownloadCompleteUseConfirmAfterProcessClosed(languageType, num).Forget();
	}

	private int ResolvePackageIndex(AudioLanguageType languageType, int preferredIndex)
	{
		if (preferredIndex >= 0 && preferredIndex < m_data.PackageDataList.Count && m_data.PackageDataList[preferredIndex].languageType == languageType)
		{
			return preferredIndex;
		}
		for (int i = 0; i < m_data.PackageDataList.Count; i++)
		{
			if (m_data.PackageDataList[i].languageType == languageType)
			{
				return i;
			}
		}
		return -1;
	}

	private void ShowDownloadFailure()
	{
		if (!(warningText == null))
		{
			warningText.text = "下载失败，请检查网络后重试。";
			warningText.gameObject.SetActive(value: true);
		}
	}

	private async UniTask ShowDownloadCompleteUseConfirmAfterProcessClosed(AudioLanguageType languageType, int uiIndex)
	{
		CancellationToken token = gameObject.GetCancellationTokenOnDestroy();
		await WaitUntilUiIdle(UI_TYPE.UI_POPUPDOWNLOADPROCESS, token);
		await WaitUntilVoiceConfirmPopupsIdle(token);
		if (!(this == null))
		{
			RefreshUI(uiIndex);
			await ShowDownloadCompleteUseConfirm(languageType, uiIndex);
		}
	}

	private async UniTask ShowDownloadCompleteUseConfirm(AudioLanguageType languageType, int uiIndex)
	{
		if (uiIndex >= 0 && uiIndex < m_data.PackageDataList.Count && m_data.PackageDataList[uiIndex].languageType == languageType && !(await OpenPopupWithRetry(UI_TYPE.UI_POPUPDOWNLOADINSTRUCTIONS, new PopupDownloadInstructionsViewData
		{
			mode = DownloadInstructionsMode.VoicePackageUseConfirm,
			packageName = m_data.PackageDataList[uiIndex].displayName,
			totalBytes = -1L,
			onConfirm = () =>
			{
				ApplyVoicePackage(languageType, uiIndex);
			},
			onCancel = () =>
			{
				RefreshUI(uiIndex);
			}
		}, "download complete use confirm", gameObject.GetCancellationTokenOnDestroy())) && this != null)
		{
			RefreshUI(uiIndex);
		}
	}

	private void ShowUnloadVoicePackageConfirm(AudioLanguageType languageType, string displayName, int uiIndex)
	{
		string text = ((GetCurrentVoiceLanguageType() == languageType) ? ("确定删除" + displayName + "语音包？删除后将切回普通话。") : ("确定删除" + displayName + "语音包？"));
		TextPanel.Param param = new TextPanel.Param();
		param.texts = new string[1] { text };
		param.OnConfirm = () =>
		{
			DeleteVoicePackage(languageType, uiIndex);
		};
		OpenTextPanel(param, "unload confirmation", gameObject.GetCancellationTokenOnDestroy()).Forget();
	}

	private void DeleteVoicePackage(AudioLanguageType languageType, int uiIndex)
	{
		if (uiIndex >= 0 && uiIndex < m_data.PackageDataList.Count && m_data.PackageDataList[uiIndex].languageType == languageType && languageType != AudioLanguageType.Chinese)
		{
			VoicePackageViewData.VoicePackageItemData voicePackageItemData = m_data.PackageDataList[uiIndex];
			Debug.Log("[VoicePackageView] Unloading voice package: " + voicePackageItemData.displayName);
			if (GetCurrentVoiceLanguageType() == languageType)
			{
				TrySwitchVoiceLanguage(AudioLanguageType.Chinese);
			}
			if (TryGetVoicePackageTag(languageType, out var packageTag))
			{
				DownloadAssetManager instance = DownloadAssetManager.Instance;
				instance.DeleteLocalDownloadedTagFiles(packageTag);
				instance.DeleteLocalDownloadedTagZipMarkers(packageTag, GameStart.CachedYooAssetInitData?.ZipDownloadParam?.RawFileZipDownloadURLs);
				instance.RemoveLocalDownloadedTag(packageTag);
				GameStart.RefreshDownloadTagsFromLocalState();
			}
			ClearLegacyDownloadedFlag(languageType);
			RefreshVoicePackageList(languageType, uiIndex, rebuildLayout: false);
			RefreshVoicePackageListAfterPopupClosed(languageType, uiIndex).Forget();
		}
	}

	private async UniTaskVoid RefreshVoicePackageListAfterPopupClosed(AudioLanguageType languageType, int uiIndex)
	{
		await WaitForCurrentConfirmPopupToClose(gameObject.GetCancellationTokenOnDestroy());
		if (!(this == null))
		{
			RefreshVoicePackageList(languageType, uiIndex, rebuildLayout: true);
		}
	}

	private void RefreshVoicePackageList(AudioLanguageType languageType, int uiIndex, bool rebuildLayout)
	{
		RefreshData();
		int num = ResolvePackageIndex(languageType, uiIndex);
		if (num >= 0)
		{
			m_data.PackageDataList[num].isDownloaded = false;
			m_data.PackageDataList[num].isInUse = false;
		}
		RefreshUI(num, rebuildLayout);
	}

	private void ShowUseVoicePackageConfirm(AudioLanguageType languageType, string displayName, int uiIndex)
	{
		TextPanel.Param param = new TextPanel.Param();
		param.texts = new string[1] { "是否使用" + displayName + "语音包？" };
		param.OnConfirm = () =>
		{
			ApplyVoicePackage(languageType, uiIndex);
		};
		OpenTextPanel(param, "use confirmation", gameObject.GetCancellationTokenOnDestroy()).Forget();
	}

	private void ShowUsingVoicePackageConfirm(string displayName)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
		{
			texts = new string[1] { "当前正在使用" + displayName + "语音包。" },
			onlyConfirm = true,
			OnConfirm = Close
		});
	}

	private async UniTask ShowRestartRequiredConfirmAfterPopupsClosed(AudioLanguageType sessionLanguage, AudioLanguageType switchedLanguage)
	{
		TextPanel.Param param = new TextPanel.Param();
		param.texts = new string[1] { "语音切换将在重启客户端后生效，请重启客户端。\n确认保留本次切换，取消则恢复原来的语音。" };
		param.onlyClickOnce = true;
		param.OnCancel = () =>
		{
			RevertVoiceLanguage(sessionLanguage, switchedLanguage);
		};
		if (!(await OpenTextPanel(param, "restart required confirmation", CancellationToken.None)))
		{
			Debug.LogError("[VoicePackageView] Failed to open the restart required confirmation view after retries.");
		}
	}

	private void RevertVoiceLanguage(AudioLanguageType sessionLanguage, AudioLanguageType switchedLanguage)
	{
		if (GetCurrentVoiceLanguageType() == switchedLanguage)
		{
			if (!TrySwitchVoiceLanguage(sessionLanguage))
			{
				Debug.LogWarning($"[VoicePackageView] Failed to restore the voice language of the current session: {sessionLanguage}");
			}
			RefreshData();
			RefreshUI(-1, rebuildLayout: false);
		}
	}

	private static async UniTask WaitForCurrentConfirmPopupToClose(CancellationToken token)
	{
		await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate, token).SuppressCancellationThrow();
		await WaitUntilVoiceConfirmPopupsIdle(token);
	}

	private static async UniTask WaitUntilVoiceConfirmPopupsIdle(CancellationToken token)
	{
		await WaitUntilUiIdle(UI_TYPE.UI_TEXTPANEL, token);
		await WaitUntilUiIdle(UI_TYPE.UI_POPUPDOWNLOADINSTRUCTIONS, token);
	}

	private static async UniTask WaitUntilUiIdle(UI_TYPE uiType, CancellationToken token)
	{
		for (int i = 0; i < 90; i++)
		{
			if (!IsUiBusy(uiType))
			{
				break;
			}
			if (token.IsCancellationRequested)
			{
				break;
			}
			await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate, token).SuppressCancellationThrow();
		}
		await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate, token).SuppressCancellationThrow();
	}

	private static bool IsUiBusy(UI_TYPE uiType)
	{
		return Singleton<NewUIManager>.instance.HasUIInTransition(uiType);
	}

	private static bool CanOpenPopup(UI_TYPE uiType)
	{
		IBaseUIController topActivePanel = Singleton<NewUIManager>.instance.GetTopActivePanel();
		if (topActivePanel == null || topActivePanel.State != UIState.Opened || topActivePanel.IsInHideRoot)
		{
			return false;
		}
		return !Singleton<NewUIManager>.instance.HasUIInTransition(uiType);
	}

	private static async UniTask WaitUntilPopupReady(UI_TYPE uiType, CancellationToken token, float timeoutSeconds)
	{
		float deadline = Time.realtimeSinceStartup + timeoutSeconds;
		while (!token.IsCancellationRequested && Time.realtimeSinceStartup < deadline && !CanOpenPopup(uiType))
		{
			await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate, token).SuppressCancellationThrow();
		}
	}

	private static UniTask<bool> OpenTextPanel(TextPanel.Param param, string reason, CancellationToken token)
	{
		return OpenPopupWithRetry(UI_TYPE.UI_TEXTPANEL, param, reason, token);
	}

	private static async UniTask<bool> OpenPopupWithRetry(UI_TYPE uiType, UIViewData param, string reason, CancellationToken token)
	{
		await WaitForCurrentConfirmPopupToClose(token);
		float deadline = Time.realtimeSinceStartup + 8f;
		int attempt = 0;
		while (!token.IsCancellationRequested && Time.realtimeSinceStartup < deadline)
		{
			attempt++;
			await WaitUntilPopupReady(uiType, token, 1f);
			if (token.IsCancellationRequested)
			{
				return false;
			}
			UIOpenResult openResult = Singleton<NewUIManager>.instance.OpenUI(uiType, param);
			if (openResult.IsValid)
			{
				await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate, token).SuppressCancellationThrow();
				if (token.IsCancellationRequested)
				{
					return false;
				}
				UIExpectedState uIExpectedState = Singleton<NewUIManager>.instance.GetUIExpectedState(openResult.Uid);
				UIState uIState = Singleton<NewUIManager>.instance.GetUIState(openResult.Uid);
				if (uIExpectedState == UIExpectedState.Open && uIState != UIState.Closed)
				{
					return true;
				}
				Debug.LogWarning($"[VoicePackageView] {uiType} for {reason} was closed right after opening: state={uIState}, attempt={attempt}.");
			}
			else
			{
				Debug.LogWarning($"[VoicePackageView] Open {uiType} for {reason} failed, attempt={attempt}.");
			}
			await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate, token).SuppressCancellationThrow();
		}
		Debug.LogError($"[VoicePackageView] Failed to open {uiType} for {reason} after {attempt} attempts.");
		return false;
	}

	private void ShowSimpleMessage(string message, CancellationToken token)
	{
		if (this != null && warningText != null)
		{
			warningText.text = message;
			warningText.gameObject.SetActive(value: true);
		}
		TextPanel.Param param = new TextPanel.Param();
		param.texts = new string[1] { message };
		param.onlyConfirm = true;
		OpenTextPanel(param, "simple message", token).Forget();
	}

	private bool TrySwitchVoiceLanguage(AudioLanguageType languageType)
	{
		SettingOptions settingOptions = null;
		if (SettingsManager.Instance != null && SettingsManager.Instance.RuntimeSettings != null)
		{
			settingOptions = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Language.Voice");
		}
		if (settingOptions != null)
		{
			int voiceLanguageOptionIndex = GetVoiceLanguageOptionIndex(languageType);
			if (voiceLanguageOptionIndex < 0)
			{
				Debug.LogWarning($"[VoicePackageView] Voice language is not available in language table: {languageType}");
				return false;
			}
			settingOptions.SetValue(voiceLanguageOptionIndex, applyImmediatly: true);
		}
		AudioLanguageManager.SetLanguage(languageType);
		return true;
	}

	private void ReturnToGameStart()
	{
		if (!m_isReturningToGameStart)
		{
			if (MonoECS.instance == null)
			{
				Debug.LogError("[VoicePackageView] MonoECS is unavailable; cannot return to the game start screen.");
				return;
			}
			m_isReturningToGameStart = true;
			MonoECS.instance.DestroyWorld().Forget();
		}
	}

	private static void SetButtonLabel(ActButton button, string text)
	{
		TextMeshProUGUI componentInChildren = button.GetComponentInChildren<TextMeshProUGUI>(includeInactive: true);
		if (componentInChildren != null)
		{
			componentInChildren.text = text;
		}
	}

	private static int GetVoiceLanguageOptionIndex(AudioLanguageType languageType)
	{
		Dictionary<int, VoiceLanguageData> dictionary = RuntimeConfigs.data?.voiceLanguageDatas;
		if (dictionary != null)
		{
			int num = 0;
			foreach (AudioLanguageType value in Enum.GetValues(typeof(AudioLanguageType)))
			{
				if (dictionary.ContainsKey((int)value))
				{
					if (value == languageType)
					{
						return num;
					}
					num++;
				}
			}
			return -1;
		}
		return Array.IndexOf((AudioLanguageType[])Enum.GetValues(typeof(AudioLanguageType)), languageType);
	}

	private bool TryGetVoicePackageTag(AudioLanguageType languageType, out string packageTag)
	{
		switch (languageType)
		{
		case AudioLanguageType.Chinese:
			packageTag = "CN";
			return true;
		case AudioLanguageType.English:
			packageTag = "EN";
			return true;
		case AudioLanguageType.Japanese:
			packageTag = "JP";
			return true;
		default:
			packageTag = null;
			return false;
		}
	}

	private static string GetLegacyDownloadedPrefsKey(AudioLanguageType languageType)
	{
		return "VoicePack.Downloaded." + languageType;
	}

	private static void ClearLegacyDownloadedFlag(AudioLanguageType languageType)
	{
		string legacyDownloadedPrefsKey = GetLegacyDownloadedPrefsKey(languageType);
		if (PlayerPrefs.HasKey(legacyDownloadedPrefsKey))
		{
			PlayerPrefs.DeleteKey(legacyDownloadedPrefsKey);
			PlayerPrefs.Save();
		}
	}

	private static bool IsNonWifiMobileNetwork()
	{
		return Application.internetReachability != NetworkReachability.ReachableViaLocalAreaNetwork;
	}

	private VoicePackageDownloadRunner ResolveDownloadRunner()
	{
		if (m_downloadRunner != null)
		{
			return m_downloadRunner;
		}
		m_downloadRunner = GetComponent<VoicePackageDownloadRunner>();
		if (m_downloadRunner == null)
		{
			m_downloadRunner = gameObject.AddComponent<VoicePackageDownloadRunner>();
		}
		return m_downloadRunner;
	}
}
