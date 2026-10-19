using System;
using System.Text;
using ACT.Core;
using ACT.Error;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Net;
using ACT.Utility;
using Fundamental;
using Google.Protobuf;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class PopUpAccountDecorationChangeNameView : BaseUIView<AccountDecorationChangeNameInputController>
{
	public TMP_InputField inputName;

	public LocalizeStringEvent titleText;

	public LocalizeStringEvent placeholderText;

	public GameObject ObNameLengthLimit;

	public LocalizeStringEvent nicknameLengthLimitText;

	public LocalizeStringEvent NameTimeLimit;

	public ActButton confirmBtn;

	public ActButton closeBtn;

	public OperateBtnPrompt confirmPrompt;

	public int nicknameTitleTextId;

	public int nicknamePlaceholderTextId;

	public int nicknameInvalidTip = 1486;

	public int overlong = 14;

	public int nicknameLengthLimitId;

	public int nameTimeLimitId;

	public int modifyTimeLimitId;

	public int nicknameSuccessTipId = 2768;

	private ChangeNameViewData data;

	private bool isSubmitting;

	private bool _isInputFieldTriggered;

	public bool IsInputFieldTriggered => _isInputFieldTriggered;

	protected override void Init()
	{
		base.Init();
		data = uiViewData as ChangeNameViewData;
		if (data == null || inputName == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("修改名字弹窗初始化失败，缺少必要引用");
			}
			return;
		}
		SetupNameInputField();
		ApplyPresentation();
		closeBtn?.SetBtnClick(Close);
		confirmBtn?.SetBtnClick(OnClick);
		RefreshConfirmButtonState();
		RefreshCooldownDisplay();
	}

	protected override void UnInit()
	{
		UnselectInputFieldByGamePad();
		if (inputName != null)
		{
			inputName.onValueChanged.RemoveListener(OnInputValueChanged);
			inputName.onEndEdit.RemoveListener(OnNameEndEdit);
			TMP_InputField tMP_InputField = inputName;
			tMP_InputField.onValidateInput = (TMP_InputField.OnValidateInput)Delegate.Remove(tMP_InputField.onValidateInput, new TMP_InputField.OnValidateInput(ValidateChar));
		}
		CancelInvoke("OnCooldownRefreshTimer");
		base.UnInit();
		data = null;
		isSubmitting = false;
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/ProfileDecoration/Popup");
		AnimationBuilder animationBuilder = betterAnimation?.GetSequence("Show");
		if (animationBuilder == null)
		{
			OpenEffectFinishNew();
			return;
		}
		animationBuilder.OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		AnimationBuilder animationBuilder = betterAnimation?.GetSequence("Hide");
		if (animationBuilder == null)
		{
			CloseEffectFinishNew();
			return;
		}
		animationBuilder.OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	public void OnClick()
	{
		if (data == null || inputName == null || isSubmitting)
		{
			return;
		}
		ApplyNameInputSanitization();
		string text = inputName.text ?? string.Empty;
		if (data.allowSameValue || !(text == (data.currentValue ?? string.Empty)))
		{
			if (IsInModifyCooldown() || !ValidateNickname(text))
			{
				RefreshConfirmButtonState();
				return;
			}
			isSubmitting = true;
			RefreshConfirmButtonState();
			G.service.ChangeNickname(text, ChangeNicknameCallback);
		}
	}

	public void SelectInputFieldByGamePad()
	{
		if (!(inputName == null) && !_isInputFieldTriggered)
		{
			_isInputFieldTriggered = true;
			inputName.ActivateInputField();
			inputName.MoveTextEnd(shift: false);
		}
	}

	public void UnselectInputFieldByGamePad()
	{
		if (!(inputName == null) && _isInputFieldTriggered)
		{
			_isInputFieldTriggered = false;
			inputName.DeactivateInputField();
		}
	}

	public void ConfirmByGamePad()
	{
		if (!(confirmBtn == null) && confirmBtn.interactable)
		{
			OnClick();
		}
	}

	public void CloseByGamePad()
	{
		Close();
	}

	private void ChangeNicknameCallback(bool success, string finalNickname, IMessage message)
	{
		isSubmitting = false;
		if (!success)
		{
			HandleServerFailure(message);
			ResetInputValue();
			return;
		}
		string text = (string.IsNullOrEmpty(finalNickname) ? inputName.text : finalNickname);
		if (!string.IsNullOrEmpty(text) && G.detailUserInfo?.Brief != null)
		{
			G.detailUserInfo.Brief.Nickname = text;
		}
		if (G.localPlayer?.Profile?.EscInfo != null)
		{
			G.localPlayer.Profile.EscInfo.ChangeNameTime = TimeManager.ServerTime.NowTimestampSecond;
		}
		GameUtility.OpenToolTip(nicknameSuccessTipId);
		AccountDecorationChangedEvt evt = Singleton<EventManager>.instance.GetEvt<AccountDecorationChangedEvt>();
		evt.ChangeType = AccountDecorationChangeType.Nickname;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_ChangeAvatar, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		Close();
	}

	private bool ValidateNickname(string value)
	{
		if (string.IsNullOrEmpty(value))
		{
			GameUtility.OpenToolTip(nicknameInvalidTip);
			return false;
		}
		if (Singleton<SensitiveWordManager>.instance._Trie.Check(value))
		{
			GameUtility.OpenToolTip(nicknameInvalidTip);
			return false;
		}
		if (UIUtility.StrLength(value) > GetNicknameMaxLength())
		{
			return false;
		}
		return true;
	}

	private void ApplyPresentation()
	{
		string text = data.currentValue ?? string.Empty;
		titleText.SetTable("Common");
		titleText.StringReference.TableEntryReference = nicknameTitleTextId;
		placeholderText.SetTable("Common");
		placeholderText.StringReference.TableEntryReference = nicknamePlaceholderTextId;
		inputName.text = text;
		inputName.characterLimit = 0;
		RefreshLengthLimitDisplay();
		RefreshCooldownDisplay();
		RefreshConfirmButtonState();
	}

	private void RefreshLengthLimitDisplay()
	{
		if (data != null && !(inputName == null))
		{
			int nicknameMaxLength = GetNicknameMaxLength();
			bool flag = UIUtility.StrLength(inputName.text ?? string.Empty) > nicknameMaxLength;
			ObNameLengthLimit.SetActive(flag);
			if (flag)
			{
				nicknameLengthLimitText.SetTable("Common");
				nicknameLengthLimitText.StringReference.TableEntryReference = nicknameLengthLimitId;
				nicknameLengthLimitText.GetVariable<string>("0").Value = nicknameMaxLength.ToString();
			}
		}
	}

	private void ResetInputValue()
	{
		if (data != null && !(inputName == null))
		{
			inputName.text = data.currentValue ?? string.Empty;
			RefreshLengthLimitDisplay();
			RefreshConfirmButtonState();
		}
	}

	private void OnInputValueChanged(string _)
	{
		RefreshLengthLimitDisplay();
		RefreshConfirmButtonState();
	}

	private void RefreshConfirmButtonState()
	{
		if (!(confirmBtn == null) && !(inputName == null) && data != null)
		{
			string text = inputName.text ?? string.Empty;
			string text2 = data.currentValue ?? string.Empty;
			bool flag = data.allowSameValue || text != text2;
			bool flag2 = !string.IsNullOrEmpty(text);
			bool flag3 = UIUtility.StrLength(text) <= GetNicknameMaxLength();
			bool flag4 = !IsInModifyCooldown();
			confirmBtn.interactable = !isSubmitting & flag & flag2 & flag3 & flag4;
			confirmPrompt?.SetVisible(confirmBtn.interactable);
		}
	}

	private int GetNicknameMaxLength()
	{
		int[] array = RuntimeConfigs.data?.game?.nickNameLengthLimit;
		if (array != null && array.Length > 1)
		{
			return array[1];
		}
		return overlong;
	}

	private bool IsInModifyCooldown()
	{
		return GetRemainingCooldownMilliseconds() > 0;
	}

	private long GetRemainingCooldownMilliseconds()
	{
		EscInfo escInfo = G.localPlayer?.Profile?.EscInfo;
		if (escInfo == null)
		{
			return 0L;
		}
		long changeNameTime = escInfo.ChangeNameTime;
		if (changeNameTime <= 0)
		{
			return 0L;
		}
		if (RuntimeConfigs.data?.game == null || RuntimeConfigs.data.game.NameDuLimit <= 0)
		{
			return 0L;
		}
		long num = NormalizeTimestampToMilliseconds(changeNameTime) + (long)RuntimeConfigs.data.game.NameDuLimit * 1000L;
		return Math.Max(0L, num - TimeManager.ServerTime.NowTimestamp);
	}

	private static long NormalizeTimestampToMilliseconds(long timestamp)
	{
		if (timestamp <= 0)
		{
			return 0L;
		}
		if (timestamp.ToString().Length > 10)
		{
			return timestamp;
		}
		return timestamp * 1000;
	}

	private void RefreshCooldownDisplay()
	{
		if (data != null && !(NameTimeLimit == null))
		{
			long remainingCooldownMilliseconds = GetRemainingCooldownMilliseconds();
			if (remainingCooldownMilliseconds > 0)
			{
				TimeSpan timeSpan = TimeSpan.FromMilliseconds(remainingCooldownMilliseconds);
				NameTimeLimit.SetTable("Common");
				NameTimeLimit.StringReference.TableEntryReference = nameTimeLimitId;
				NameTimeLimit.GetVariable<int>("0").Value = Mathf.Max(0, (int)timeSpan.TotalHours);
				NameTimeLimit.GetVariable<int>("1").Value = Mathf.Max(0, timeSpan.Minutes);
			}
			else
			{
				NameTimeLimit.SetTable("Common");
				NameTimeLimit.StringReference.TableEntryReference = modifyTimeLimitId;
				NameTimeLimit.GetVariable<int>("0").Value = Mathf.Max(0, RuntimeConfigs.data.game.NameDuLimit / 3600);
			}
			RefreshConfirmButtonState();
			ScheduleCooldownRefresh(remainingCooldownMilliseconds);
		}
	}

	private void ScheduleCooldownRefresh(long remainingMilliseconds)
	{
		CancelInvoke("OnCooldownRefreshTimer");
		if (remainingMilliseconds > 0)
		{
			long nextRefreshDelayMilliseconds = GetNextRefreshDelayMilliseconds(remainingMilliseconds);
			Invoke("OnCooldownRefreshTimer", (float)nextRefreshDelayMilliseconds / 1000f);
		}
	}

	private static long GetNextRefreshDelayMilliseconds(long remainingMilliseconds)
	{
		if (remainingMilliseconds <= 0)
		{
			return 0L;
		}
		if (remainingMilliseconds <= 60000)
		{
			return remainingMilliseconds;
		}
		long num = remainingMilliseconds % 60000;
		if (num != 0L)
		{
			return num + 1000;
		}
		return 1000L;
	}

	private void OnCooldownRefreshTimer()
	{
		RefreshCooldownDisplay();
	}

	private void HandleServerFailure(IMessage message)
	{
		if (message is ErrorAck errorAck)
		{
			LuminError.Handle(errorAck, new ErrorHandleOptions(ErrorPresentation.Configured, null, null, null, null, null, (ResolvedError error) =>
			{
				if (error.CodeModule == CodeModule.PROFILE)
				{
					switch ((CodeProfile)error.SubCode)
					{
					case CodeProfile.NICKNAME_LENGTH_NOT_IN_RANGE:
					case CodeProfile.NICKNAME_IS_SENSITIVE:
						GameUtility.OpenToolTip(nicknameInvalidTip);
						return true;
					case CodeProfile.CHANGE_NICKNAME_IN_CD:
						RefreshCooldownDisplay();
						return true;
					}
				}
				GameUtility.OpenToolTip(nicknameInvalidTip);
				return true;
			}));
		}
		else
		{
			GameUtility.OpenToolTip(nicknameInvalidTip);
		}
	}

	private void SetupNameInputField()
	{
		if (!(inputName == null))
		{
			inputName.characterLimit = 0;
			inputName.onValueChanged.RemoveListener(OnInputValueChanged);
			inputName.onValueChanged.AddListener(OnInputValueChanged);
			inputName.onEndEdit.RemoveListener(OnNameEndEdit);
			inputName.onEndEdit.AddListener(OnNameEndEdit);
			TMP_InputField tMP_InputField = inputName;
			tMP_InputField.onValidateInput = (TMP_InputField.OnValidateInput)Delegate.Remove(tMP_InputField.onValidateInput, new TMP_InputField.OnValidateInput(ValidateChar));
			if (Application.platform != RuntimePlatform.IPhonePlayer && Application.platform != RuntimePlatform.tvOS)
			{
				TMP_InputField tMP_InputField2 = inputName;
				tMP_InputField2.onValidateInput = (TMP_InputField.OnValidateInput)Delegate.Combine(tMP_InputField2.onValidateInput, new TMP_InputField.OnValidateInput(ValidateChar));
			}
		}
	}

	private void OnNameEndEdit(string _)
	{
		ApplyNameInputSanitization();
	}

	private void ApplyNameInputSanitization()
	{
		if (!(inputName == null))
		{
			string text = SanitizeNameInput(inputName.text);
			if (text != inputName.text)
			{
				inputName.text = text;
			}
		}
	}

	private string SanitizeNameInput(string str)
	{
		if (string.IsNullOrEmpty(str))
		{
			return string.Empty;
		}
		StringBuilder stringBuilder = new StringBuilder(str.Length);
		for (int i = 0; i < str.Length; i++)
		{
			char c = ValidateChar(str, i, str[i]);
			if (c != '\0')
			{
				stringBuilder.Append(c);
			}
		}
		return stringBuilder.ToString();
	}

	private char ValidateChar(string text, int charIndex, char addedChar)
	{
		if (char.IsWhiteSpace(addedChar))
		{
			return '\0';
		}
		if (IsEmoji(addedChar))
		{
			return '\0';
		}
		return addedChar;
	}

	private bool IsEmoji(char c)
	{
		if (char.IsHighSurrogate(c) || char.IsLowSurrogate(c))
		{
			return true;
		}
		if (c >= 127744 && c <= 129750)
		{
			return true;
		}
		if (c >= '℀' && c <= '➿')
		{
			return true;
		}
		return false;
	}
}
