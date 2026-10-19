using System;
using TMPro;

namespace UnityEngine.Localization.PropertyVariants.TrackedObjects;

[Serializable]
[CustomTrackedObject(typeof(TMP_Dropdown), true)]
[DisplayName("TMP Dropdown", null)]
public class TrackedTmpDropdown : JsonSerializerTrackedObject
{
	protected override void PostApplyTrackedProperties()
	{
		((TMP_Dropdown)Target).RefreshShownValue();
		base.PostApplyTrackedProperties();
	}
}
