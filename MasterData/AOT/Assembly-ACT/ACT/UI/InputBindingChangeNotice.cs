using TMPro;
using UnityEngine;

namespace ACT.UI;

public class InputBindingChangeNotice : MonoBehaviour
{
	[SerializeField]
	private TextMeshProUGUI _actionNameTxt;

	[SerializeField]
	private InputPromptByRealKey _iconOld;

	[SerializeField]
	private GampadKeyPrompt _modifierOld;

	[SerializeField]
	private InputPromptByRealKey _iconNew;

	[SerializeField]
	private GampadKeyPrompt _modiferNew;

	public void SetActive(bool active)
	{
		gameObject.SetActive(active);
	}

	public void ResetData(bool modifierMode, string bindingActionName, string effectPathOld, string effectPathNew)
	{
		_actionNameTxt.text = bindingActionName;
		SetModifierModeActive(modifierMode);
		_iconOld.SetBindingEffectPath(effectPathOld);
		_iconNew.SetBindingEffectPath(effectPathNew);
	}

	private void SetModifierModeActive(bool active)
	{
		if (active)
		{
			_modiferNew.UpdateDeviceKeyIcon();
			_modifierOld.UpdateDeviceKeyIcon();
		}
		else
		{
			_modiferNew.gameObject.SetActive(value: false);
			_modifierOld.gameObject.SetActive(value: false);
		}
	}
}
