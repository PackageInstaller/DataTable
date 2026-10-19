using Fundamental;
using TMPro;
using UnityEngine.Localization.Components;

namespace ACT.UI.ViewComponent.GemView;

public class GemFilterToggle : ActToggle
{
	public LocalizeStringEvent toggleName;

	public TMP_Text count;

	protected override void OnClickImp()
	{
		if (!_params.audioClickSound.IsNull())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(_params.audioClickSound);
		}
		if (IsActive() && IsInteractable())
		{
			onToggleClick?.Invoke();
			SetIsOn(!IsOn);
		}
	}
}
