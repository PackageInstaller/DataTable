using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI.ItemDetail.Styles;

public class EquipSuitStyle : UniqStyleBase
{
	[Header("Middle")]
	public LocalizeStringEvent suitDesc;

	public LocalizeStringEvent[] equipNames;

	public EquipBuffDetail equipBuffDetail;

	public override void Reset()
	{
		base.Reset();
		LocalizeStringEvent[] array = equipNames;
		foreach (LocalizeStringEvent localizeStringEvent in array)
		{
			if (!(localizeStringEvent == null))
			{
				localizeStringEvent.gameObject.SetActive(value: false);
			}
		}
	}
}
