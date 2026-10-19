using System;
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

public class MonoChangeNameSignatureView : BaseUIView<ChangeNameSignatureInputController>
{
	public TMP_InputField inputName;

	public LocalizeStringEvent titleText;

	public LocalizeStringEvent placeholderText;

	public TextMeshProUGUI timeLimitText;

	public GameObject ObSignatureLengthLimit;

	public LocalizeStringEvent SignatureTimeLimit;

	public ActButton confirmBtn;

	public ActButton closeBtn;

	public OperateBtnPrompt confirmPrompt;

	public int signatureTitleTextId;

	public int signaturePlaceholderTextId;

	public int signatureInvalidTip = 2770;

	public int signatureTimeLimitId;

	public int modifyTimeLimitId;

	public int signatureSuccessTipId = 2771;

	private ChangeSignatureViewData data;

	private bool isSubmitting;

	private bool _isInputFieldTriggered;

	public bool IsInputFieldTriggered => _isInputFieldTriggered;

	protected override void Init()
	{
		base.Init();
		data = uiViewData as ChangeSignatureViewData;
		if (data == null || inputName == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("修改签名弹窗初始化失败，缺少必要引用");
			}
			return;
		}
		ApplyPresentation();
		closeBtn?.SetBtnClick(Close);
		confirmBtn?.SetBtnClick(OnClick);
		inputName.onValueChanged.AddListener(OnInputValueChanged);
		RefreshConfirmButtonState();
		RefreshCooldownDisplay();
	}

	protected override void UnInit()
	{
		UnselectInputFieldByGamePad();
		if (inputName != null)
		{
			inputName.onValueChanged.RemoveListener(OnInputValueChanged);
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
		string text = inputName.text ?? string.Empty;
		if (data.allowSameValue || !(text == (data.currentValue ?? string.Empty)))
		{
			if (IsInModifyCooldown() || !ValidateSignature(text))
			{
				RefreshConfirmButtonState();
				return;
			}
			isSubmitting = true;
			RefreshConfirmButtonState();
			G.service.ChangeSignature(text, ChangeSignatureCallback);
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

	private void ChangeSignatureCallback(bool success, IMessage message)
	{
		isSubmitting = false;
		if (!success)
		{
			HandleServerFailure(message);
			ResetInputValue();
			return;
		}
		if (G.localPlayer?.Profile?.EscInfo != null)
		{
			G.localPlayer.Profile.EscInfo.Signature = inputName.text ?? string.Empty;
			G.localPlayer.Profile.EscInfo.ChangeSignatureTime = TimeManager.ServerTime.NowTimestampSecond;
		}
		GameUtility.OpenToolTip(signatureSuccessTipId);
		AccountDecorationChangedEvt evt = Singleton<EventManager>.instance.GetEvt<AccountDecorationChangedEvt>();
		evt.ChangeType = AccountDecorationChangeType.Signature;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_ChangeAvatar, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		Close();
	}

	private bool ValidateSignature(string value)
	{
		if (string.IsNullOrWhiteSpace(value))
		{
			return false;
		}
		if (Singleton<SensitiveWordManager>.instance._Trie.Check(value))
		{
			GameUtility.OpenToolTip(signatureInvalidTip);
			return false;
		}
		if (UIUtility.StrLength(value) > GetSignatureMaxLength())
		{
			return false;
		}
		return true;
	}

	private void ApplyPresentation()
	{
		titleText.SetTable("Common");
		titleText.StringReference.TableEntryReference = signatureTitleTextId;
		placeholderText.SetTable("Common");
		placeholderText.StringReference.TableEntryReference = signaturePlaceholderTextId;
		inputName.text = data.currentValue ?? string.Empty;
		inputName.characterLimit = 0;
		RefreshLengthLimitDisplay();
		RefreshCooldownDisplay();
		RefreshConfirmButtonState();
	}

	private int GetSignatureMaxLength()
	{
		return RuntimeConfigs.data.game.MessageLimit;
	}

	private void RefreshLengthLimitDisplay()
	{
		if (data != null && !(inputName == null))
		{
			bool active = UIUtility.StrLength(inputName.text ?? string.Empty) > GetSignatureMaxLength();
			if (ObSignatureLengthLimit != null)
			{
				ObSignatureLengthLimit.SetActive(active);
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
			bool flag2 = !string.IsNullOrWhiteSpace(text);
			bool flag3 = UIUtility.StrLength(text) <= GetSignatureMaxLength();
			bool flag4 = !IsInModifyCooldown();
			confirmBtn.interactable = !isSubmitting & flag & flag2 & flag3 & flag4;
			confirmPrompt?.SetVisible(confirmBtn.interactable);
		}
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
		long changeSignatureTime = escInfo.ChangeSignatureTime;
		if (changeSignatureTime <= 0)
		{
			return 0L;
		}
		if (RuntimeConfigs.data?.game == null || RuntimeConfigs.data.game.MessageDuaLimit <= 0)
		{
			return 0L;
		}
		long num = NormalizeTimestampToMilliseconds(changeSignatureTime) + (long)RuntimeConfigs.data.game.MessageDuaLimit * 1000L;
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
		if (!(timeLimitText == null) && data != null)
		{
			long remainingCooldownMilliseconds = GetRemainingCooldownMilliseconds();
			if (remainingCooldownMilliseconds > 0)
			{
				TimeSpan timeSpan = TimeSpan.FromMilliseconds(remainingCooldownMilliseconds);
				SignatureTimeLimit.SetTable("Common");
				SignatureTimeLimit.StringReference.TableEntryReference = signatureTimeLimitId;
				SignatureTimeLimit.GetVariable<int>("0").Value = Mathf.Max(0, (int)timeSpan.TotalHours);
				SignatureTimeLimit.GetVariable<int>("1").Value = Mathf.Max(0, timeSpan.Minutes);
				SignatureTimeLimit.RefreshString();
			}
			else
			{
				SignatureTimeLimit.SetTable("Common");
				SignatureTimeLimit.StringReference.TableEntryReference = modifyTimeLimitId;
				SignatureTimeLimit.GetVariable<int>("0").Value = Mathf.Max(0, RuntimeConfigs.data.game.MessageDuaLimit / 3600);
				SignatureTimeLimit.RefreshString();
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
					case CodeProfile.SIGNATURE_LENGTH_NOT_IN_RANGE:
					case CodeProfile.SIGNATURE_IS_SENSITIVE:
						GameUtility.OpenToolTip(signatureInvalidTip);
						return true;
					case CodeProfile.CHANGE_SIGNATURE_IN_CD:
						RefreshCooldownDisplay();
						return true;
					}
				}
				GameUtility.OpenToolTip(signatureInvalidTip);
				return true;
			}));
		}
		else
		{
			GameUtility.OpenToolTip(signatureInvalidTip);
		}
	}
}
