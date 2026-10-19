using System.Collections.Generic;
using ACT.Battle;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Fundamental;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem.DualShock;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class TextLibraryPropPickTitle : UIBehaviour
{
	public BImage iconImage;

	public LocalizeStringEvent promptTip;

	public ActButton self;

	private const string TextLibraryDeviceActionName = "TextLibrary";

	private List<string> _textLibraryGamePadPromptTipActionName = new List<string> { "TextLibraryUITipGamePadModifier", "TextLibraryUITipGamePadBinding" };

	private const int TEXTLIBRARYPROMPT = 2398;

	private const int TEXTLIBRARYPROMPTONPC = 2397;

	private const int TEXTLIBRARYPROMPTONGamePad = 2512;

	private Dictionary<string, object> _promptTMPVariables = new Dictionary<string, object>();

	public void Init()
	{
		self.SetBtnClick(() =>
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTLIBRARY, new TextLibraryViewData
			{
				targetJumpTextDataId = Model<TextLibraryModel>.Interface.lastUnLockTextLibraryId
			});
			Model<TextLibraryModel>.Interface.lastUnLockTextLibraryId = 0;
		});
		promptTip.SetTable("Common");
		promptTip.StringReference.Clear();
		SetPromptVariable();
		LocalizedString stringReference = promptTip.StringReference;
		DeviceInputMode inputMode = MonoECS.instance.InputMode;
		stringReference.TableEntryReference = inputMode switch
		{
			DeviceInputMode.TouchScreen => 2398, 
			DeviceInputMode.KeyboardAndMouse => 2397, 
			DeviceInputMode.Gamepad => 2512, 
		};
	}

	private void SetPromptVariable()
	{
		_promptTMPVariables.Clear();
		if (MonoECS.instance.InputMode != DeviceInputMode.Gamepad)
		{
			ConvertActionNameToKeyName("TextLibrary");
		}
		else
		{
			for (int i = 0; i < _textLibraryGamePadPromptTipActionName.Count; i++)
			{
				string actionName = _textLibraryGamePadPromptTipActionName[i];
				ConvertActionNameToKeyName(actionName, i);
			}
		}
		Model<GuideTipModel>.Interface.SetVariablesWithoutCache(promptTip, _promptTMPVariables);
	}

	private void ConvertActionNameToKeyName(string actionName, int paramIndex = 0)
	{
		if (MonoECS.instance.GetInputDeviceButtonBindingKeyName(actionName, out var bindingKeyName))
		{
			if (!string.IsNullOrEmpty(bindingKeyName))
			{
				bindingKeyName = bindingKeyName.Replace("/", "_");
				if (MonoECS.instance.GetPromptIconDevice() is DualShockGamepad)
				{
					bindingKeyName = bindingKeyName.Replace("gamepad", "gamepad_Sony");
				}
				_promptTMPVariables[paramIndex.FastToString()] = bindingKeyName;
			}
			else
			{
				_ = LuminApplication.LogEnabled;
			}
		}
		else
		{
			_ = LuminApplication.LogEnabled;
		}
	}
}
