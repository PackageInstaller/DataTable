using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using Bamboo.AssetField;
using Bamboo.NumberString;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.InputSystem.DualShock;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class GuidePromptTip : BaseTip
{
	public static GuidePromptTip guideTipInstance;

	public LocalizeStringEvent tip;

	public TextMeshProUGUI tipTextComp;

	private GuidePromptTipData data;

	private Dictionary<string, object> _promptTMPVariables;

	public override void OnGet()
	{
		base.OnGet();
		guideTipInstance = this;
		data = m_Data as GuidePromptTipData;
		_promptTMPVariables = DictionaryPool<string, object>.Get();
		MonoECS.instance.onInputModeChange.AddListener(OnActiveInputDeviceChanged);
		if (data != null && data.tipId != 0)
		{
			tip.StringReference.TableEntryReference = 0L;
			UpdateText();
		}
	}

	public override void OnShow()
	{
		base.OnShow();
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Show").OnAnimationPlay((AnimationBuilder _) =>
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Tip_Mini_Open");
			}).OnComplete((AnimationBuilder _) =>
			{
				OpenAnimationFinish();
			})
				.Play();
		}
		else
		{
			OpenAnimationFinish();
		}
	}

	public override void OnHide()
	{
		base.OnHide();
		MonoECS.instance.onInputModeChange.RemoveListener(OnActiveInputDeviceChanged);
		DictionaryPool<string, object>.Release(_promptTMPVariables);
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Hide").OnAnimationPlay((AnimationBuilder _) =>
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Window_Mini_Finish");
			}).OnComplete((AnimationBuilder _) =>
			{
				CloseAnimationFinish();
			})
				.Play();
		}
		else
		{
			CloseAnimationFinish();
		}
	}

	public void HideNotComplete()
	{
		state = TipState.Closing;
		MonoECS.instance.onInputModeChange.RemoveListener(OnActiveInputDeviceChanged);
		DictionaryPool<string, object>.Release(_promptTMPVariables);
		CloseAnimationFinish();
	}

	private void UpdateText()
	{
		GuideTutorialDes guideTutorialDes = CoreUtils.GetData(data.tipId, RuntimeConfigs.data.guideTutorialDess);
		if (guideTutorialDes.type == 2)
		{
			RefreshHasPromptDisplay(guideTutorialDes);
		}
		else
		{
			RefreshNormalDisplay(guideTutorialDes);
		}
	}

	private void RefreshHasPromptDisplay(GuideTutorialDes tipData)
	{
		_promptTMPVariables.Clear();
		if (tipTextComp == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("tipTextComp is null!");
			}
			return;
		}
		DeviceInputMode inputMode = MonoECS.instance.InputMode;
		YooAssetReference yooAssetReference = ((inputMode != DeviceInputMode.TouchScreen) ? GameLoader.meta.TmpPrompt : GameLoader.meta.SkillSheet);
		YooAssetReference assetID = yooAssetReference;
		AssetLoadHandle assetLoadHandle = AssetStationManager.BattleStation.Load<TMP_SpriteAsset>(assetID);
		tipTextComp.spriteAsset = assetLoadHandle.As<TMP_SpriteAsset>();
		int num = -1;
		for (int i = 0; i < tipData.actionPrompt.Length; i++)
		{
			string text = tipData.actionPrompt[i];
			if (inputMode == DeviceInputMode.TouchScreen)
			{
				if (string.IsNullOrEmpty(text))
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogError("actionName是空字符，检查教程描述表");
					}
				}
				else
				{
					_promptTMPVariables[i.FastToString()] = text;
				}
				continue;
			}
			num++;
			string bindingKeyName3;
			if (MonoECS.instance.TryGetInputActionKeyBindingInfo(text, out var bindingInfo) && bindingInfo.GetMode() == MonoECS.CompositeMode.OneModifier)
			{
				string bindingKeyName = bindingInfo.GetKeyBinding(0);
				if (KeyNameTransferToTMPVariableName(ref bindingKeyName))
				{
					_promptTMPVariables[num.FastToString()] = bindingKeyName;
					num++;
				}
				string bindingKeyName2 = bindingInfo.GetKeyBinding(-1);
				if (KeyNameTransferToTMPVariableName(ref bindingKeyName2))
				{
					_promptTMPVariables[num.FastToString()] = bindingKeyName2;
					num++;
				}
			}
			else if (MonoECS.instance.GetInputDeviceButtonBindingKeyName(text, out bindingKeyName3))
			{
				if (!KeyNameTransferToTMPVariableName(ref bindingKeyName3))
				{
					if (!LuminApplication.LogEnabled)
					{
					}
				}
				else
				{
					_promptTMPVariables[num.FastToString()] = bindingKeyName3;
				}
			}
			else
			{
				_ = LuminApplication.LogEnabled;
			}
		}
		tip.SetTable("longcommon");
		Model<GuideTipModel>.Interface.SetVariablesWithoutCache(tip, _promptTMPVariables);
		tip.StringReference.TableEntryReference = tipData.tutorialTitle;
	}

	private bool KeyNameTransferToTMPVariableName(ref string bindingKeyName)
	{
		if (!string.IsNullOrEmpty(bindingKeyName))
		{
			bindingKeyName = bindingKeyName.Replace("/", "_");
			if (MonoECS.instance.activeInputDevice is DualShockGamepad)
			{
				bindingKeyName = bindingKeyName.Replace("gamepad", "gamepad_Sony");
			}
			return true;
		}
		return false;
	}

	private void RefreshNormalDisplay(GuideTutorialDes tipData)
	{
		tip.SetTable("longcommon");
		tip.StringReference.TableEntryReference = tipData.tutorialTitle;
	}

	private void OnActiveInputDeviceChanged(DeviceInputMode inputMode)
	{
		GuideTutorialDes guideTutorialDes = CoreUtils.GetData(data.tipId, RuntimeConfigs.data.guideTutorialDess);
		if (guideTutorialDes.type == 2)
		{
			RefreshHasPromptDisplay(guideTutorialDes);
		}
		else
		{
			RefreshNormalDisplay(guideTutorialDes);
		}
	}

	protected override void Update()
	{
	}
}
