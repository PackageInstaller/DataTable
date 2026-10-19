using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Sound;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class ReadableView : BaseUIView<ReadableViewInputController>
{
	public enum ReadableType
	{
		Stone = 4,
		ElectronicScreen = 5,
		Paper = 6,
		ImageText = 99
	}

	[Serializable]
	public class ReadableStyle
	{
		public ReadableType type;

		public GameObject root;

		public LocalizeStringEvent title;

		public LocalizeStringEvent content;

		public RightStickScrollSupport rightStickScroll;

		public ScrollTextWithArrow scrollArrow;

		public ViewControlLayer viewControlLayer;

		public string openSequence = "Show";

		public string closeSequence = "Hide";

		public string openSound;

		public string closeSound;

		public BImage thumbnail;

		public Button thumbnailButton;

		public BImage imageView;

		public Button imageViewButton;

		public LocalizeStringEvent closeImageDes;
	}

	public List<ReadableStyle> styles;

	public GamePadTipsComp gamePadGroup;

	private ReadableViewData m_data;

	private TextLibraryContent m_readableData;

	private ReadableStyle m_currentStyle;

	private bool m_hasImage;

	private uint _audioInstance;

	private ScrollRect _currentScrollRect;

	private bool _rightStickCanScroll;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt;

	private List<GamePadTipsAction> _tipsActions;

	public bool rightStickCanScroll => _rightStickCanScroll;

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>();
		_allInputPrompt["UI/RSUpDownSelect"] = new GamePadTipsAction
		{
			inputAction = "UI/RSUpDownSelect",
			localizeKey = 2165,
			localizeTable = "Common"
		};
		_allInputPrompt["UI/Back"] = new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		};
		_allInputPrompt["UI/CommonSelect"] = new GamePadTipsAction
		{
			inputAction = "UI/CommonSelect",
			localizeKey = 606,
			localizeTable = "Common"
		};
	}

	protected override void Init()
	{
		base.Init();
		MonoECS.instance.PushPause();
		if (uiViewData != null)
		{
			m_data = uiViewData as ReadableViewData;
		}
		if (TryResolveReadable(out var readableInfo))
		{
			m_readableData = readableInfo;
			ApplyStyle(readableInfo);
			OnDeviceChange();
			if (!string.IsNullOrEmpty(m_currentStyle?.openSound))
			{
				Singleton<GameManager>.instance.audioManager.PlaySound(m_currentStyle.openSound);
			}
			_audioInstance = Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Readable/Loop", new AudioPlayOptions
			{
				attachTarget = Camera.main.transform
			});
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		PlayStyleAnimation(m_currentStyle?.openSequence, "Show", OpenEffectFinishNew);
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	private bool TryResolveReadable(out TextLibraryContent readableInfo)
	{
		readableInfo = null;
		if (m_data == null)
		{
			Debug.LogError("ReadableView 缺少 ReadableViewData");
			return false;
		}
		Dictionary<int, TextLibraryContent> dictionary = RuntimeConfigs.data?.textLibraryContents;
		if (m_data.previewType >= 0)
		{
			TextLibraryContent value = null;
			if (dictionary != null && m_data.id != 0)
			{
				dictionary.TryGetValue(m_data.id, out value);
			}
			if (value == null && dictionary != null)
			{
				foreach (KeyValuePair<int, TextLibraryContent> item in dictionary)
				{
					value = item.Value;
					if (value != null)
					{
						break;
					}
				}
			}
			readableInfo = new TextLibraryContent(m_data.id, value?.titleName ?? 0, m_data.previewType, value?.content ?? 0, 0, 0);
			return true;
		}
		if (dictionary == null || !dictionary.TryGetValue(m_data.id, out readableInfo))
		{
			Debug.LogError($"ReadableView 找不到可阅读物 id={m_data.id}");
			return false;
		}
		return true;
	}

	private void ApplyStyle(TextLibraryContent readableInfo)
	{
		m_currentStyle = null;
		m_hasImage = false;
		_currentScrollRect = null;
		_rightStickCanScroll = false;
		if (styles != null)
		{
			for (int i = 0; i < styles.Count; i++)
			{
				ReadableStyle readableStyle = styles[i];
				if (readableStyle?.root != null)
				{
					readableStyle.root.SetActive(value: false);
				}
				if (readableStyle != null && readableStyle.type == (ReadableType)readableInfo.type)
				{
					m_currentStyle = readableStyle;
				}
			}
		}
		if (m_currentStyle?.root == null)
		{
			Debug.LogError($"ReadableView 未绑定类型 {readableInfo.type}，id={readableInfo.id}");
			return;
		}
		m_currentStyle.root.SetActive(value: true);
		if (m_currentStyle.title != null)
		{
			m_currentStyle.title.StringReference.TableEntryReference = readableInfo.titleName;
		}
		if (m_currentStyle.content != null)
		{
			m_currentStyle.content.StringReference.TableEntryReference = readableInfo.content;
		}
		SetupImage(readableInfo);
		RebuildContentLayout();
		SetupScroll();
	}

	private void RebuildContentLayout()
	{
		if (m_currentStyle?.content == null)
		{
			return;
		}
		RectTransform rectTransform = m_currentStyle.content.transform as RectTransform;
		if (!(rectTransform == null))
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(rectTransform);
			RectTransform rectTransform2 = ((rectTransform.parent != null) ? rectTransform.parent.GetComponent<RectTransform>() : null);
			if (rectTransform2 != null)
			{
				LayoutRebuilder.ForceRebuildLayoutImmediate(rectTransform2);
			}
		}
	}

	private void SetupImage(TextLibraryContent readableInfo)
	{
		HideImageView();
		ReadableStyle currentStyle = m_currentStyle;
		if (currentStyle.thumbnailButton != null)
		{
			currentStyle.thumbnailButton.onClick.RemoveAllListeners();
		}
		if (currentStyle.imageViewButton != null)
		{
			currentStyle.imageViewButton.onClick.RemoveAllListeners();
		}
		m_hasImage = readableInfo.resName != 0 && currentStyle.thumbnail != null && currentStyle.thumbnail.icon != null;
		if (!m_hasImage)
		{
			if (currentStyle.thumbnail != null && currentStyle.thumbnail.icon != null)
			{
				currentStyle.thumbnail.icon.gameObject.SetActive(value: false);
			}
			return;
		}
		currentStyle.thumbnail.icon.gameObject.SetActive(value: true);
		Station.LoadImage(159, readableInfo.resName, currentStyle.thumbnail);
		if (currentStyle.imageView != null && currentStyle.imageView.icon != null)
		{
			Station.LoadImage(159, readableInfo.resName, currentStyle.imageView);
		}
		if (currentStyle.thumbnailButton != null)
		{
			currentStyle.thumbnailButton.onClick.AddListener(ShowImageView);
		}
		if (currentStyle.imageViewButton != null)
		{
			currentStyle.imageViewButton.onClick.AddListener(HideImageView);
		}
	}

	private void SetupScroll()
	{
		ReadableStyle currentStyle = m_currentStyle;
		if (!(currentStyle.rightStickScroll == null))
		{
			_currentScrollRect = currentStyle.rightStickScroll.GetComponentInChildren<ScrollRect>();
			_rightStickCanScroll = _currentScrollRect != null && _currentScrollRect.content.rect.height > _currentScrollRect.viewport.rect.height;
			currentStyle.rightStickScroll.SetForbidScroll(!_rightStickCanScroll);
			if (currentStyle.scrollArrow != null && currentStyle.scrollArrow.downArrow != null)
			{
				currentStyle.scrollArrow.downArrow.SetActive(_rightStickCanScroll);
			}
		}
	}

	private void ShowImageView()
	{
		ReadableStyle currentStyle = m_currentStyle;
		if (!(currentStyle?.imageViewButton == null))
		{
			currentStyle.imageViewButton.gameObject.SetActive(value: true);
			if (currentStyle.closeImageDes != null)
			{
				currentStyle.closeImageDes.gameObject.SetActive(MonoECS.instance.InputMode == DeviceInputMode.KeyboardAndMouse || MonoECS.instance.InputMode == DeviceInputMode.TouchScreen);
			}
			if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
			{
				ReBindBtnPrompt();
			}
		}
	}

	private void HideImageView()
	{
		ReadableStyle currentStyle = m_currentStyle;
		if (!(currentStyle?.imageViewButton == null) && currentStyle.imageViewButton.gameObject.activeSelf)
		{
			currentStyle.imageViewButton.gameObject.SetActive(value: false);
			if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
			{
				ReBindBtnPrompt();
			}
		}
	}

	private void PlayStyleAnimation(string sequenceName, string fallbackSequence, Action onComplete)
	{
		if (string.IsNullOrEmpty(sequenceName))
		{
			sequenceName = fallbackSequence;
		}
		AnimationBuilder sequence = betterAnimation.GetSequence(sequenceName);
		if (sequence == null && sequenceName != fallbackSequence)
		{
			sequence = betterAnimation.GetSequence(fallbackSequence);
		}
		if (sequence == null)
		{
			onComplete?.Invoke();
			return;
		}
		sequence.OnComplete((AnimationBuilder _) =>
		{
			onComplete?.Invoke();
		}).Play();
	}

	protected override void UnInit()
	{
		base.UnInit();
		MonoECS.instance.PopPause();
		if (m_currentStyle != null)
		{
			m_currentStyle.thumbnailButton?.onClick.RemoveAllListeners();
			m_currentStyle.imageViewButton?.onClick.RemoveAllListeners();
			if (!string.IsNullOrEmpty(m_currentStyle.closeSound))
			{
				Singleton<GameManager>.instance.audioManager.PlaySound(m_currentStyle.closeSound);
			}
		}
		Singleton<GameManager>.instance.audioManager.Stop(_audioInstance);
		m_data?.onClose?.Invoke();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		PlayStyleAnimation(m_currentStyle?.closeSequence, "Hide", CloseEffectFinishNew);
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		if (UIController.State == UIState.Opened)
		{
			_rightStickCanScroll = type switch
			{
				DeviceInputMode.Gamepad => _currentScrollRect != null && _currentScrollRect.content.rect.height > _currentScrollRect.viewport.rect.height, 
				DeviceInputMode.KeyboardAndMouse => false, 
			};
			OnDeviceChange();
		}
	}

	private void ReBindBtnPrompt()
	{
		List<GamePadTipsAction> tipsActions = _tipsActions;
		if (tipsActions == null || tipsActions.Count <= 0)
		{
			_tipsActions = new List<GamePadTipsAction>();
		}
		gamePadGroup.ClearAllPrompts();
		_tipsActions.Clear();
		_tipsActions.Add(_allInputPrompt["UI/Back"]);
		bool flag = m_currentStyle?.imageViewButton != null && m_currentStyle.imageViewButton.gameObject.activeInHierarchy;
		if (_rightStickCanScroll && !flag)
		{
			_tipsActions.Add(_allInputPrompt["UI/RSUpDownSelect"]);
		}
		if (m_hasImage && m_currentStyle.thumbnailButton != null && m_currentStyle.thumbnailButton.gameObject.activeInHierarchy && !flag)
		{
			_tipsActions.Add(_allInputPrompt["UI/CommonSelect"]);
		}
		gamePadGroup.RegisterInputActions(_tipsActions);
	}

	private void OnDeviceChange()
	{
		if (GetController() != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			ReBindBtnPrompt();
			m_currentStyle?.viewControlLayer?.Focus();
		}
	}

	public void OnGamepadSelect()
	{
		if (m_hasImage && !(m_currentStyle?.thumbnailButton == null) && (!(m_currentStyle.imageViewButton != null) || !m_currentStyle.imageViewButton.gameObject.activeInHierarchy))
		{
			ShowImageView();
		}
	}

	public void OnGamepadBack()
	{
		if (m_currentStyle?.imageViewButton != null && m_currentStyle.imageViewButton.gameObject.activeInHierarchy)
		{
			HideImageView();
			return;
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Popup_Close");
		Close();
	}
}
