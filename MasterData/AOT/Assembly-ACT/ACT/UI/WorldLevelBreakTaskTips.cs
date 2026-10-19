using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using ACT.Battle;
using ACT.Model;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.InputSystem.DualShock;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class WorldLevelBreakTaskTips : SubUIView<WorldLevelBreakTaskTipsInputController>, IBattleMainComponent
{
	private const float AutoHideDelaySeconds = 3f;

	private const int TipsTouchLocalizeId = 2923;

	private const int TipsGamepadLocalizeId = 2924;

	private const int TipsKeyboardLocalizeId = 2925;

	private BetterAnimation _betterAnimation;

	private CancellationTokenSource _cts;

	private bool _queueDequeued;

	private readonly StringBuilder _bindingKeyNameBuilder = new StringBuilder();

	private readonly Dictionary<string, object> _promptTMPVariables = new Dictionary<string, object>();

	private TMP_SpriteAsset _promptSpriteAsset;

	[SerializeField]
	private ActButton _btnArea;

	[SerializeField]
	private LocalizeStringEvent tips;

	public void Initialize(MonoBattleMainBaseView view)
	{
		_betterAnimation = GetComponentInChildren<BetterAnimation>(includeInactive: true);
		gameObject.SetActive(value: false);
		_btnArea.SetBtnClick(OpenWorldLevelView);
	}

	public void Show(Action openFail)
	{
		onClose = () =>
		{
			if (!_queueDequeued)
			{
				_queueDequeued = true;
				if (Model<BattleMainModel>.HasInstance())
				{
					Model<BattleMainModel>.Interface.HudPositionUIDequeue(UIPosition.Top);
				}
			}
		};
		_queueDequeued = false;
		CancelAutoHide();
		try
		{
			if ((object)_betterAnimation == null)
			{
				_betterAnimation = GetComponentInChildren<BetterAnimation>(includeInactive: true);
			}
			gameObject.SetActive(value: true);
			PlayShowAnimation();
			RefreshTips(MonoECS.instance.InputMode);
			FocusIn();
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"世界等级突破任务提示打开失败：{arg}");
			}
			openFail?.Invoke();
			HideImmediate();
		}
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		RefreshTips(type);
	}

	public void UnInitialize()
	{
		CancelAutoHide();
		HideImmediate();
	}

	public void OpenComponent()
	{
	}

	public void CloseComponent()
	{
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}

	private void PlayShowAnimation()
	{
		_cts = new CancellationTokenSource();
		CancellationToken token = _cts.Token;
		AnimationBuilder animationBuilder = _betterAnimation?.GetSequence("Show");
		if (animationBuilder != null)
		{
			animationBuilder.OnComplete((AnimationBuilder _) =>
			{
				if (!(this == null))
				{
					AutoHideAfterDelay(token).Forget();
				}
			}).Play();
		}
		else
		{
			AutoHideAfterDelay(token).Forget();
		}
	}

	private async UniTaskVoid AutoHideAfterDelay(CancellationToken token)
	{
		try
		{
			await UniTask.Delay(TimeSpan.FromSeconds(3.0), ignoreTimeScale: false, PlayerLoopTiming.Update, token);
			Hide();
		}
		catch (OperationCanceledException)
		{
		}
	}

	private void Hide()
	{
		if (this == null)
		{
			return;
		}
		CancelAutoHide();
		FocusOut();
		AnimationBuilder animationBuilder = _betterAnimation?.GetSequence("Hide");
		if (animationBuilder != null)
		{
			animationBuilder.OnComplete((AnimationBuilder _) =>
			{
				HideImmediate();
			}).Play();
		}
		else
		{
			HideImmediate();
		}
	}

	private void HideImmediate()
	{
		if (!(this == null))
		{
			FocusOut();
			gameObject.SetActive(value: false);
			onClose?.Invoke();
			onClose = null;
		}
	}

	private void CancelAutoHide()
	{
		_cts?.Cancel();
		_cts?.Dispose();
		_cts = null;
	}

	private void RefreshTips(DeviceInputMode deviceInputMode)
	{
		if (tips == null)
		{
			return;
		}
		TextMeshProUGUI component = tips.GetComponent<TextMeshProUGUI>();
		EnsurePromptSpriteAsset(component);
		if (deviceInputMode == DeviceInputMode.TouchScreen)
		{
			tips.StringReference.Clear();
			tips.SetTable(LocalizationUtility.localizeTableName_Common);
			tips.StringReference.TableEntryReference = 2923L;
			return;
		}
		_promptTMPVariables.Clear();
		string bindingKeyName;
		string spriteTag3;
		if (deviceInputMode == DeviceInputMode.Gamepad && MonoECS.instance.TryGetInputActionKeyBindingInfo("UI/WorldLevelBreakTips", out var bindingInfo) && bindingInfo.GetMode() == MonoECS.CompositeMode.OneModifier && TryBuildSpriteTag(bindingInfo.GetKeyBinding(0), out var spriteTag) && TryBuildSpriteTag(bindingInfo.GetKeyBinding(-1), out var spriteTag2))
		{
			_promptTMPVariables["0"] = spriteTag;
			_promptTMPVariables["1"] = spriteTag2;
			ApplyPromptVariables(2924);
		}
		else if (MonoECS.instance.GetInputDeviceButtonBindingKeyName("UI/WorldLevelBreakTips", out bindingKeyName) && TryBuildSpriteTag(bindingKeyName, out spriteTag3))
		{
			_promptTMPVariables["0"] = spriteTag3;
			ApplyPromptVariables(2925);
		}
		else
		{
			_ = LuminApplication.LogEnabled;
		}
	}

	private void EnsurePromptSpriteAsset(TextMeshProUGUI tmp)
	{
		if (!(tmp == null))
		{
			if (_promptSpriteAsset == null)
			{
				_promptSpriteAsset = AssetStationManager.BattleStation.Load<TMP_SpriteAsset>(GameLoader.meta.TmpPrompt).As<TMP_SpriteAsset>();
			}
			if (_promptSpriteAsset == null)
			{
				_promptSpriteAsset = tmp.spriteAsset;
			}
			if (_promptSpriteAsset != null)
			{
				tmp.spriteAsset = _promptSpriteAsset;
			}
		}
	}

	private void ApplyPromptVariables(int localizeId)
	{
		Model<GuideTipModel>.Interface.SetVariablesWithoutCache(tips, _promptTMPVariables);
		tips.SetTable(LocalizationUtility.localizeTableName_Common);
		tips.StringReference.TableEntryReference = localizeId;
	}

	private bool TryBuildSpriteTag(string bindingKeyName, out string spriteTag)
	{
		spriteTag = null;
		if (!KeyNameTransferToTMPVariableName(bindingKeyName, out var tmpSpriteName))
		{
			return false;
		}
		if (_promptSpriteAsset != null)
		{
			List<TMP_SpriteCharacter> spriteCharacterTable = _promptSpriteAsset.spriteCharacterTable;
			for (int i = 0; i < spriteCharacterTable.Count; i++)
			{
				TMP_SpriteCharacter tMP_SpriteCharacter = spriteCharacterTable[i];
				if (tMP_SpriteCharacter != null && tMP_SpriteCharacter.name == tmpSpriteName)
				{
					spriteTag = $"<sprite index={i}>";
					return true;
				}
			}
		}
		spriteTag = "<sprite name=" + tmpSpriteName + ">";
		return true;
	}

	private bool KeyNameTransferToTMPVariableName(string bindingKeyName, out string tmpSpriteName)
	{
		tmpSpriteName = null;
		if (string.IsNullOrEmpty(bindingKeyName))
		{
			return false;
		}
		if (bindingKeyName.IndexOf("#(])", StringComparison.Ordinal) >= 0)
		{
			tmpSpriteName = "keyboard_rightbracket";
			return true;
		}
		_bindingKeyNameBuilder.Clear();
		_bindingKeyNameBuilder.Append(bindingKeyName);
		_bindingKeyNameBuilder.Replace("/", "_");
		if (MonoECS.instance.activeInputDevice is DualShockGamepad)
		{
			_bindingKeyNameBuilder.Replace("gamepad", "gamepad_Sony");
		}
		tmpSpriteName = _bindingKeyNameBuilder.ToString();
		return !string.IsNullOrEmpty(tmpSpriteName);
	}

	public void JumpToWorldLevelView()
	{
		if (_btnArea != null && _btnArea.gameObject.activeSelf && _btnArea.IsInteractable())
		{
			_btnArea.OnSubmit(null);
		}
		else
		{
			OpenWorldLevelView();
		}
	}

	private void OpenWorldLevelView()
	{
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_MONOJOURNEYTRACESVIEW, new MonoJourneyTracesViewData
		{
			tabIndex = 0
		}).Forget();
	}
}
