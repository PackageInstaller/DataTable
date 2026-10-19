using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Utility;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class TextPanel : TextPanel<TextPanelInputController>
{
	public struct ButtonInfo
	{
		public int id;

		public Action action;

		public bool closeUI;
	}

	public class Param : UIViewData
	{
		public int titleId;

		public int commonId;

		public bool onlyConfirm;

		public Action OnConfirm;

		public Action OnCancel;

		public string[] Titletexts;

		public string[] texts;

		public List<ButtonInfo> btnInfos;

		public bool needPause;

		public bool onlyClickOnce;

		public bool useLongCommon;

		public LocalizedString content_longCommon;

		public bool showSilence;

		public bool silenceValue;

		public Action<bool> OnClickSilence;

		public YooAssetReference spriteAsset;

		public int cancelBtnDes;

		public int confirmBtnDes;

		public int doubleRewardCount;

		public int doubleRewardCommonId;
	}
}
public class TextPanel<T> : BaseUIView<T> where T : class, IInputController, new()
{
	public LocalizeStringEvent titleEvent;

	public LocalizeStringEvent localStringEvent;

	public TextMeshProUGUI text;

	public Button CancelBtn;

	public LocalizeStringEvent cancelBtnStrEvent;

	public Button ConfirmBtn;

	public LocalizeStringEvent confirmBtnStrEvent;

	public Button SingleBtn;

	public GameObject ClickBtn;

	public Transform content;

	public GameObject silenceToggleRoot;

	public PublicToggle silenceToggle;

	public GamePadTipsComp gamepadTips;

	public LocalizeStringEvent doubleRewardLocalizedString;

	private List<GameObject> m_btns = new List<GameObject>();

	private bool m_isClicked;

	private AssetLoadHandle _handle;

	private Dictionary<string, GamePadTipsAction> _inputActionDic = new Dictionary<string, GamePadTipsAction>();

	private List<GamePadTipsAction> _tipsActions;

	[NonSerialized]
	protected TextPanel.Param m_Param;

	public override UniTask PreInit()
	{
		_inputActionDic["UI/Back"] = new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		};
		_inputActionDic["UI/Confirm"] = new GamePadTipsAction
		{
			inputAction = "UI/Confirm",
			localizeKey = 774,
			localizeTable = "Common"
		};
		return base.PreInit();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Window");
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

	protected override void Init()
	{
		base.Init();
		ReBindBtnPrompt();
		m_Param = (TextPanel.Param)uiViewData;
		m_isClicked = false;
		if ((bool)silenceToggleRoot)
		{
			silenceToggleRoot.SetActive(m_Param.showSilence);
		}
		if ((bool)silenceToggle)
		{
			silenceToggle.isOn = m_Param.silenceValue;
		}
		cancelBtnStrEvent?.SetReference(LocalizeTable.Common, m_Param.cancelBtnDes);
		confirmBtnStrEvent?.SetReference(LocalizeTable.Common, m_Param.confirmBtnDes);
		if (m_Param.spriteAsset != null)
		{
			_handle = AssetStationManager.BattleStation.LoadAsync<TMP_SpriteAsset>(m_Param.spriteAsset);
			_handle.Completed += (AssetLoadHandle h) =>
			{
				text.spriteAsset = h.As<TMP_SpriteAsset>();
			};
		}
		if (m_Param.titleId != 0)
		{
			titleEvent?.gameObject.SetActive(value: true);
			if ((bool)titleEvent)
			{
				titleEvent.StringReference.TableEntryReference = m_Param.titleId;
			}
		}
		else if (m_Param.Titletexts != null && m_Param.Titletexts.Length != 0)
		{
			titleEvent.gameObject.SetActive(value: true);
			for (int num = 0; num < m_Param.Titletexts.Length; num++)
			{
				titleEvent?.OnUpdateString.Invoke(m_Param.Titletexts[num]);
			}
		}
		else
		{
			titleEvent?.gameObject.SetActive(value: false);
		}
		if (m_Param.btnInfos != null)
		{
			ConfirmBtn.gameObject.SetActive(value: false);
			CancelBtn.gameObject.SetActive(value: false);
			for (int num2 = 0; num2 < m_Param.btnInfos.Count; num2++)
			{
				int index = num2;
				GameObject gameObject = UnityEngine.Object.Instantiate(ClickBtn, content);
				gameObject.SetActive(value: true);
				gameObject.GetComponent<Button>().onClick.AddListener(() =>
				{
					OnBtn(index);
				});
				gameObject.GetComponentInChildren<LocalizeStringEvent>().StringReference.TableEntryReference = m_Param.btnInfos[num2].id;
				m_btns.Add(gameObject);
			}
		}
		else
		{
			SingleBtn?.gameObject.SetActive(m_Param.onlyConfirm);
			ConfirmBtn?.gameObject.SetActive(!m_Param.onlyConfirm);
			CancelBtn?.gameObject.SetActive(!m_Param.onlyConfirm);
		}
		if (m_Param.useLongCommon)
		{
			localStringEvent.StringReference = m_Param.content_longCommon;
			RefreshDoubleRewardHint();
			return;
		}
		localStringEvent.StringReference.TableReference = LocalizationUtility.localizeTableName_Common;
		localStringEvent.StringReference.TableEntryReference = m_Param.commonId;
		if (m_Param.texts != null && m_Param.texts.Length != 0)
		{
			if (m_Param.commonId == 0)
			{
				for (int num3 = 0; num3 < m_Param.texts.Length; num3++)
				{
					localStringEvent.OnUpdateString.Invoke(m_Param.texts[num3]);
				}
			}
			else
			{
				for (int num4 = 0; num4 < m_Param.texts.Length; num4++)
				{
					localStringEvent.StringReference.GetVariable<string>(num4.ToString()).Value = m_Param.texts[num4];
				}
			}
		}
		RefreshDoubleRewardHint();
	}

	private void RefreshDoubleRewardHint()
	{
		if (doubleRewardLocalizedString == null)
		{
			return;
		}
		int num = m_Param?.doubleRewardCount ?? 0;
		doubleRewardLocalizedString.gameObject.SetActive(num > 0);
		if (num > 0)
		{
			TextPanel.Param param = m_Param;
			if (param != null && param.doubleRewardCommonId > 0)
			{
				doubleRewardLocalizedString.SetReference(LocalizeTable.Common, m_Param.doubleRewardCommonId);
			}
			doubleRewardLocalizedString.StringReference.GetVariable<string>("0").Value = num.ToString();
		}
	}

	protected override void UnInit()
	{
		if (_handle.IsValid)
		{
			AssetStationManager.BattleStation.Release(_handle);
		}
		base.UnInit();
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		if (type != DeviceInputMode.TouchScreen)
		{
			OnDeviceChange(type);
		}
	}

	public void OnConfirmBtn()
	{
		if (m_isClicked)
		{
			return;
		}
		if (m_Param.onlyClickOnce)
		{
			m_isClicked = true;
		}
		try
		{
			m_Param.OnConfirm?.Invoke();
			if (m_Param.showSilence && silenceToggle.isOn)
			{
				m_Param.OnClickSilence?.Invoke(silenceToggle.isOn);
			}
		}
		catch (Exception arg)
		{
			Debug.LogError($"[TextPanel] OnConfirm callback failed: {arg}");
		}
		Close();
	}

	public void OnCancelBtn()
	{
		if (!m_isClicked)
		{
			if (m_Param.onlyClickOnce)
			{
				m_isClicked = true;
			}
			try
			{
				m_Param.OnCancel?.Invoke();
			}
			catch (Exception arg)
			{
				Debug.LogError($"[TextPanel] OnCancel callback failed: {arg}");
			}
			Close();
		}
	}

	public void OnBtn(int index)
	{
		if (m_isClicked)
		{
			return;
		}
		if (m_Param.onlyClickOnce)
		{
			m_isClicked = true;
		}
		try
		{
			m_Param.btnInfos[index].action?.Invoke();
		}
		catch (Exception arg)
		{
			Debug.LogError($"[TextPanel] OnBtn callback failed: {arg}");
		}
		if (m_Param.btnInfos[index].closeUI)
		{
			Close();
			for (int num = m_btns.Count - 1; num >= 0; num--)
			{
				UnityEngine.Object.Destroy(m_btns[num]);
			}
			m_btns.Clear();
		}
	}

	public void OnClickSilence(bool value)
	{
	}

	private void OnDeviceChange(DeviceInputMode type)
	{
		if (GetController() is TextPanelInputController textPanelInputController)
		{
			switch (type)
			{
			case DeviceInputMode.Gamepad:
				ReBindBtnPrompt();
				textPanelInputController?.RefreshSelection();
				break;
			case DeviceInputMode.KeyboardAndMouse:
				gamepadTips?.ClearAllPrompts();
				_tipsActions?.Clear();
				textPanelInputController?.RefreshSelection();
				break;
			}
		}
	}

	private void ReBindBtnPrompt()
	{
		List<GamePadTipsAction> tipsActions = _tipsActions;
		if (tipsActions == null || tipsActions.Count <= 0)
		{
			_tipsActions = new List<GamePadTipsAction>();
		}
		gamepadTips?.ClearAllPrompts();
		_tipsActions.Clear();
		_tipsActions.Add(_inputActionDic["UI/Confirm"]);
		_tipsActions.Add(_inputActionDic["UI/Back"]);
		gamepadTips?.RegisterInputActions(_tipsActions);
	}
}
