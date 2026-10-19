using ACT.Battle;
using UnityEngine;

namespace ACT.UI.InputController.CharacterBattleAttributeView;

public class CharacterBattleAttributeViewInputController : BaseUIViewInputController<ACT.UI.CharacterBattleAttributeView>
{
	[GameInputBindingVector2("UI/ScrollViewRightStickControl")]
	public void Scroll(Vector2 value)
	{
		View.Scroll(value);
	}
}
