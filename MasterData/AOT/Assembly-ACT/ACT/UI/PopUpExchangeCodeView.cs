using System;
using System.Collections.Generic;
using ACT.Error;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Google.Protobuf;
using Pb;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class PopUpExchangeCodeView : BaseUIView<PopUpExchangeCodeViewInputController>
{
	public GamePadTipsComp gamePadGroup;

	[Header("Input Binding")]
	public ViewControlLayer viewControlLayer;

	private PopUpExchangeCodeViewData m_data;

	private const int CodeMaxLen = 15;

	private const float ClickIntervalLimitSec = 1f;

	private const float CooldownSec = 5f;

	private bool _isSanitizingInput;

	private bool _isRequesting;

	private float _lastConfirmClickTimeUnscaled = -999f;

	private float _cooldownEndTimeUnscaled;

	private bool _isExchangeFail;

	private bool _canReshowExchangeFailTip;

	private string _lastExchangeFailText = string.Empty;

	[SerializeField]
	private ActButton _closeBtn;

	[SerializeField]
	public TMP_InputField inputField;

	[SerializeField]
	private ActButton _confirmBtn;

	[SerializeField]
	private ActButton _cancleBtn;

	[SerializeField]
	private ActButton _CopyBtn;

	[SerializeField]
	private ActButton _ClearBtn;

	[SerializeField]
	private GameObject _exchangeCodeRoot;

	[SerializeField]
	private GameObject _exchangeCodeFailRoot;

	[SerializeField]
	private TextMeshProUGUI _failText;

	private string redColor = "#FFE1E1";

	[SerializeField]
	private BetterAnimation _betteretterAnimation1;

	[SerializeField]
	private BetterAnimation _betteretterAnimation2;

	private bool m_canRightStickScroll;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt = new Dictionary<string, GamePadTipsAction>();

	private List<GamePadTipsAction> _tipsActions;

	public bool CanPaste => _CopyBtn?.gameObject.activeSelf ?? false;

	public bool CanClear => _ClearBtn?.gameObject.activeSelf ?? false;

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
		m_data = uiViewData as PopUpExchangeCodeViewData;
	}

	protected override void Init()
	{
		base.Init();
		BindUI();
		ResetViewState();
		OnGamePadInit();
		ReBindBtnPrompt(hasConfirm: true);
	}

	protected override void PlayOpenAnimation()
	{
		CdkeyEvent evt = EventTrackSolver.Instance.GetEvt<CdkeyEvent>();
		evt.cdkey = "";
		evt.result = 0;
		evt.type = 0;
		EventTrackSolver.Instance.Dispatch(evt);
		base.PlayOpenAnimation();
		_betteretterAnimation1.GetSequence("Show")?.Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		UnbindUI();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		_betteretterAnimation1.GetSequence("Hide")?.Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		CdkeyEvent evt = EventTrackSolver.Instance.GetEvt<CdkeyEvent>();
		evt.cdkey = "";
		evt.result = 0;
		evt.type = 0;
		EventTrackSolver.Instance.Dispatch(evt);
		base.Close();
	}

	private void Update()
	{
		if (!(_cooldownEndTimeUnscaled <= 0f) && Time.unscaledTime >= _cooldownEndTimeUnscaled)
		{
			_cooldownEndTimeUnscaled = 0f;
			_canReshowExchangeFailTip = _isExchangeFail;
		}
	}

	private void BindUI()
	{
		if (_closeBtn != null)
		{
			_closeBtn.OnClick.AddListener(OnCancelClicked);
		}
		if (_cancleBtn != null)
		{
			_cancleBtn.OnClick.AddListener(OnCancelClicked);
		}
		if (_ClearBtn != null)
		{
			_ClearBtn.OnClick.AddListener(OnClearClicked);
		}
		if (_CopyBtn != null)
		{
			_CopyBtn.OnClick.AddListener(OnPasteClicked);
		}
		if (_confirmBtn != null)
		{
			_confirmBtn.OnClick.AddListener(OnConfirmClicked);
		}
		if (_confirmBtn != null)
		{
			_confirmBtn.OnUnInteractableClick.AddListener(OnConfirmUnInteractableClicked);
		}
		if (inputField != null)
		{
			inputField.characterLimit = 15;
			inputField.onValidateInput = OnValidateInput;
			inputField.onValueChanged.RemoveAllListeners();
			inputField.onValueChanged.AddListener(OnInputValueChanged);
		}
	}

	private void UnbindUI()
	{
		if (_closeBtn != null)
		{
			_closeBtn.OnClick.RemoveListener(OnCancelClicked);
		}
		if (_cancleBtn != null)
		{
			_cancleBtn.OnClick.RemoveListener(OnCancelClicked);
		}
		if (_ClearBtn != null)
		{
			_ClearBtn.OnClick.RemoveListener(OnClearClicked);
		}
		if (_CopyBtn != null)
		{
			_CopyBtn.OnClick.RemoveListener(OnPasteClicked);
		}
		if (_confirmBtn != null)
		{
			_confirmBtn.OnClick.RemoveListener(OnConfirmClicked);
		}
		if (_confirmBtn != null)
		{
			_confirmBtn.OnUnInteractableClick.RemoveListener(OnConfirmUnInteractableClicked);
		}
		if (inputField != null)
		{
			inputField.onValueChanged.RemoveListener(OnInputValueChanged);
			if (inputField.onValidateInput == new TMP_InputField.OnValidateInput(OnValidateInput))
			{
				inputField.onValidateInput = null;
			}
		}
	}

	private void ResetViewState()
	{
		_isRequesting = false;
		_isSanitizingInput = false;
		_lastConfirmClickTimeUnscaled = -999f;
		_isExchangeFail = false;
		_canReshowExchangeFailTip = false;
		_lastExchangeFailText = string.Empty;
		if (_exchangeCodeRoot != null)
		{
			_exchangeCodeRoot.SetActive(value: true);
		}
		if (_exchangeCodeFailRoot != null)
		{
			_exchangeCodeFailRoot.SetActive(value: false);
		}
		if (_failText != null)
		{
			_failText.gameObject.SetActive(value: false);
			_failText.SetText(string.Empty);
		}
		if (_CopyBtn != null)
		{
			_CopyBtn.gameObject.SetActive(value: true);
		}
		if (inputField != null)
		{
			inputField.SetTextWithoutNotify(string.Empty);
			inputField.ForceLabelUpdate();
		}
		if (_ClearBtn != null)
		{
			_ClearBtn.gameObject.SetActive(value: false);
		}
	}

	private bool IsInCooldown()
	{
		if (_cooldownEndTimeUnscaled > 0f)
		{
			return Time.unscaledTime < _cooldownEndTimeUnscaled;
		}
		return false;
	}

	private int GetCooldownRemainSeconds()
	{
		if (!IsInCooldown())
		{
			return 0;
		}
		return Mathf.Max(1, Mathf.CeilToInt(_cooldownEndTimeUnscaled - Time.unscaledTime));
	}

	private void StartCooldown(float seconds)
	{
		_cooldownEndTimeUnscaled = Time.unscaledTime + Mathf.Max(0f, seconds);
	}

	private void ShowCooldownTip()
	{
		int num = GetCooldownRemainSeconds();
		if (num <= 0)
		{
			num = Mathf.CeilToInt(5f);
		}
		_exchangeCodeFailRoot.SetActive(value: true);
		_failText.gameObject.SetActive(value: true);
		LocalizeStringEvent component = _failText.GetComponent<LocalizeStringEvent>();
		if (component != null)
		{
			component.enabled = true;
			component.StringReference.TableEntryReference = 2557L;
			component.StringReference.GetVariable<string>("0").Value = num.ToString();
			component.RefreshString();
		}
	}

	private void OnConfirmUnInteractableClicked()
	{
		if (string.IsNullOrEmpty((inputField != null) ? SanitizeCode(inputField.text) : string.Empty))
		{
			ShowEmptyCodeTip();
		}
		else if (IsInCooldown())
		{
			ShowCooldownTip();
		}
	}

	public void FocusInput(bool focus)
	{
		if (focus)
		{
			inputField.Select();
		}
		else
		{
			inputField.ReleaseSelection();
		}
	}

	public void OnCancelClicked()
	{
		Close();
	}

	public void OnClearClicked()
	{
		if (inputField != null)
		{
			inputField.SetTextWithoutNotify(string.Empty);
			inputField.ForceLabelUpdate();
			if (inputField.textComponent != null)
			{
				inputField.textComponent.color = Color.white;
			}
		}
		if (_ClearBtn != null)
		{
			_ClearBtn.gameObject.SetActive(value: false);
		}
		if (_CopyBtn != null)
		{
			_CopyBtn.gameObject.SetActive(value: true);
		}
		if (_exchangeCodeFailRoot != null)
		{
			_exchangeCodeFailRoot.SetActive(value: false);
		}
		_isExchangeFail = false;
		_canReshowExchangeFailTip = false;
		_lastExchangeFailText = string.Empty;
	}

	public void OnPasteClicked()
	{
		string text = SanitizeCode(GUIUtility.systemCopyBuffer ?? string.Empty);
		if (string.IsNullOrEmpty(text))
		{
			GameUtility.OpenToolTip(LocalizationUtility.GetLocalizeString("Common", 2558));
		}
		else if (inputField != null)
		{
			inputField.text = text;
		}
	}

	public void OnConfirmClicked()
	{
		if (_isRequesting)
		{
			return;
		}
		string text = ((inputField != null) ? SanitizeCode(inputField.text) : string.Empty);
		if (string.IsNullOrEmpty(text))
		{
			ShowEmptyCodeTip();
			return;
		}
		if (IsInCooldown())
		{
			ShowCooldownTip();
			return;
		}
		if (inputField != null && inputField.text != text)
		{
			inputField.text = text;
		}
		if (_isExchangeFail)
		{
			if (_canReshowExchangeFailTip)
			{
				ShowExchangeFailText();
				StartCooldown(5f);
				_canReshowExchangeFailTip = false;
			}
			else
			{
				StartCooldown(5f);
				ShowCooldownTip();
			}
		}
		else
		{
			float unscaledTime = Time.unscaledTime;
			if (!(unscaledTime - _lastConfirmClickTimeUnscaled < 1f))
			{
				_lastConfirmClickTimeUnscaled = unscaledTime;
				RedeemCodeAsync(text).Forget();
			}
		}
	}

	private async UniTaskVoid RedeemCodeAsync(string code)
	{
		_isRequesting = true;
		try
		{
			UniTaskCompletionSource<(bool IsSuccess, IMessage Message)> requestTcs = new UniTaskCompletionSource<(bool, IMessage)>();
			G.service.SendRedeemCodeUseReq(code, (RedeemCodeUseAck ack, bool b, IMessage item) =>
			{
				requestTcs.TrySetResult((b, item));
			});
			var (flag, message) = await requestTcs.Task;
			if (flag)
			{
				_isExchangeFail = false;
				GameUtility.OpenToolTip(LocalizationUtility.GetLocalizeString("Common", 2559));
				Close();
			}
			else
			{
				ShowRedeemFailed(message as ErrorAck);
			}
		}
		catch (Exception message2)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError(message2);
			}
			ShowRedeemFailed(null);
		}
		finally
		{
			_isRequesting = false;
		}
	}

	private void ShowRedeemFailed(ErrorAck errorAck)
	{
		PlayerRedeemFailedAnimation();
		_isExchangeFail = true;
		ColorUtility.TryParseHtmlString(redColor, out var color);
		inputField.textComponent.color = color;
		_lastExchangeFailText = LuminError.Handle(errorAck, new ErrorHandleOptions(ErrorPresentation.None)).Message;
		ShowExchangeFailText();
		if (_exchangeCodeRoot != null)
		{
			_exchangeCodeRoot.SetActive(value: true);
		}
		StartCooldown(5f);
		_canReshowExchangeFailTip = false;
	}

	private void ShowExchangeFailText()
	{
		if (_exchangeCodeFailRoot != null)
		{
			_exchangeCodeFailRoot.SetActive(value: true);
		}
		if (_failText != null)
		{
			_failText.gameObject.SetActive(value: true);
		}
		LocalizeStringEvent component = _failText.GetComponent<LocalizeStringEvent>();
		if (component != null)
		{
			component.enabled = false;
		}
		_failText.text = _lastExchangeFailText;
	}

	private void ShowEmptyCodeTip()
	{
		if (_exchangeCodeFailRoot != null)
		{
			_exchangeCodeFailRoot.SetActive(value: true);
		}
		if (_failText != null)
		{
			_failText.gameObject.SetActive(value: true);
			LocalizeStringEvent component = _failText.GetComponent<LocalizeStringEvent>();
			if (component != null)
			{
				component.enabled = false;
			}
			_failText.text = LocalizationUtility.GetLocalizeString("Common", 2560);
		}
	}

	private void PlayerRedeemFailedAnimation()
	{
		_betteretterAnimation2.GetSequence("Show")?.Play();
	}

	private void OnInputValueChanged(string value)
	{
		inputField.textComponent.color = Color.white;
		if (_isSanitizingInput || inputField == null)
		{
			return;
		}
		if (string.IsNullOrEmpty(inputField.text))
		{
			if (_ClearBtn != null)
			{
				_ClearBtn.gameObject.SetActive(value: false);
			}
			if (_CopyBtn != null)
			{
				_CopyBtn.gameObject.SetActive(value: true);
			}
			if (_exchangeCodeFailRoot != null)
			{
				_exchangeCodeFailRoot.SetActive(value: false);
			}
		}
		else
		{
			if (_ClearBtn != null)
			{
				_ClearBtn.gameObject.SetActive(value: true);
			}
			if (_CopyBtn != null)
			{
				_CopyBtn.gameObject.SetActive(value: false);
			}
		}
		_isExchangeFail = false;
		_canReshowExchangeFailTip = false;
		_lastExchangeFailText = string.Empty;
		string text = SanitizeCode(value);
		if (!(text == value))
		{
			_isSanitizingInput = true;
			inputField.text = text;
			_isSanitizingInput = false;
		}
	}

	private char OnValidateInput(string text, int charIndex, char addedChar)
	{
		if (char.ToUpperInvariant(addedChar) == 'K' && string.IsNullOrEmpty(text) && !string.IsNullOrEmpty(SanitizeCode(GUIUtility.systemCopyBuffer)))
		{
			OnPasteClicked();
			return '\0';
		}
		if (char.IsDigit(addedChar))
		{
			return addedChar;
		}
		if (addedChar >= 'A' && addedChar <= 'Z')
		{
			return addedChar;
		}
		if (addedChar >= 'a' && addedChar <= 'z')
		{
			return char.ToUpperInvariant(addedChar);
		}
		return '\0';
	}

	private static string SanitizeCode(string raw)
	{
		if (string.IsNullOrEmpty(raw))
		{
			return string.Empty;
		}
		int num = 15;
		char[] array = new char[Mathf.Min(num, raw.Length)];
		int num2 = 0;
		for (int i = 0; i < raw.Length; i++)
		{
			if (num2 >= num)
			{
				break;
			}
			char c = raw[i];
			if (c >= '0' && c <= '9')
			{
				array[num2++] = c;
			}
			else if (c >= 'A' && c <= 'Z')
			{
				array[num2++] = c;
			}
			else if (c >= 'a' && c <= 'z')
			{
				array[num2++] = char.ToUpperInvariant(c);
			}
		}
		if (num2 > 0)
		{
			return new string(array, 0, num2);
		}
		return string.Empty;
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>
		{
			["UI/Back"] = new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			},
			["UI/Confirm"] = new GamePadTipsAction
			{
				inputAction = "UI/Confirm",
				localizeKey = 774,
				localizeTable = "Common"
			}
		};
	}

	public void ReBindBtnPrompt(bool hasConfirm)
	{
		List<GamePadTipsAction> tipsActions = _tipsActions;
		if (tipsActions == null || tipsActions.Count <= 0)
		{
			_tipsActions = new List<GamePadTipsAction>();
		}
		gamePadGroup.ClearAllPrompts();
		_tipsActions.Clear();
		_tipsActions.Add(_allInputPrompt["UI/Back"]);
		if (hasConfirm)
		{
			_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
		}
		gamePadGroup.RegisterInputActions(_tipsActions);
	}
}
