using System;
using UnityEngine.UI;

namespace UnityEngine.Localization.PropertyVariants.TrackedObjects;

[Serializable]
[CustomTrackedObject(typeof(Dropdown), true)]
[DisplayName("UI Dropdown", null)]
public class TrackedUGuiDropdown : JsonSerializerTrackedObject
{
	protected override void PostApplyTrackedProperties()
	{
		((Dropdown)Target).RefreshShownValue();
		base.PostApplyTrackedProperties();
	}
}
