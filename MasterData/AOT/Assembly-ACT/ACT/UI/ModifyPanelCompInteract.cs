using UnityEngine;

namespace ACT.UI;

public class ModifyPanelCompInteract : ModifyPanelCompSingle
{
	[SerializeReference]
	private RectTransform circleBtnRt;

	public override void SetDiameter(float newDiameter)
	{
		if (UseDiameter)
		{
			circleBtnRt.sizeDelta = newDiameter * Vector2.one;
			_curDiameter = newDiameter;
		}
	}
}
