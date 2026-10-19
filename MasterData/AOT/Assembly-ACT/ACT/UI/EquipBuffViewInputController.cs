using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class EquipBuffViewInputController : BaseUIViewInputController<EquipBuffView>
{
	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		if (!(View == null))
		{
			View?.OnNavigate(value);
		}
	}

	[GameInputBindingVector2("UI/RightStickNavigate")]
	public void ScrollSkillDataView(Vector2 value)
	{
		if (!(View == null))
		{
			View?.OnScrollbarNavigate(value);
		}
	}
}
