using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class AccomplishmentViewInputController : BaseUIViewInputController<MonoAccomplishmentView>
{
	private ContinuousNavigateData _curNavigateData;

	public AccomplishmentViewControllerType ControllerType { get; set; }

	protected override void OnInitView(MonoAccomplishmentView view)
	{
		base.OnInitView(view);
		ControllerType = AccomplishmentViewControllerType.AccomplishmentMainList;
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		_curNavigateData?.Reset();
		View?.OnControllerActivate();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (value)
		{
			View.HandleGamepadConfirm();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void OnSpecial1(bool value)
	{
		if (value)
		{
			View.HandleGamepadOneKeyPickUp();
		}
	}

	public void ChangeControllerType(AccomplishmentViewControllerType controllerType)
	{
		ControllerType = controllerType;
	}
}
