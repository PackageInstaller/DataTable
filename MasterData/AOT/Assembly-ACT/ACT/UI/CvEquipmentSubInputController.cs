using ACT.Battle;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class CvEquipmentSubInputController : SubUIViewInputController<CvEquipment>, ISubInputController, IInputController, IGameInputBindingHandle
{
	private ContinuousNavigateData _continuousNavigateData;

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_continuousNavigateData?.Reset();
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!value)
		{
			View?.OnConfirm();
		}
	}

	[GameInputBindingBool("UI/Back")]
	public void OnBack(bool value)
	{
		if (!value)
		{
			View?.CharacterView?.Close();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _continuousNavigateData, View.OnNavigate);
	}

	[GameInputBindingBool("UI/UISpecial3")]
	public void ShowLevelUpPreviewView(bool value)
	{
		if (!value)
		{
			View?.equipBuffDetail?.OpenBuffDetail();
		}
	}

	[GameInputBindingBool("UI/UISpecial6")]
	public void ShowCurrencyDetail(bool value)
	{
		if (!value)
		{
			View?.equipPropertyEquipComponent?.ClickPropertyDetail();
			Singleton<GameInputActionManager>.instance.CancelAllActionProcessAtThisFrame();
		}
	}

	[GameInputBindingVector2("UI/ScrollViewRightStickControl")]
	public void ScrollSkillDataView(Vector2 value)
	{
		View?.OnScrollbarNavigate(value);
	}
}
