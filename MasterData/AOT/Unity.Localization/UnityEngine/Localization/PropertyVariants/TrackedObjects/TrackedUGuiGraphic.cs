using System;
using UnityEngine.UI;

namespace UnityEngine.Localization.PropertyVariants.TrackedObjects;

[Serializable]
[CustomTrackedObject(typeof(Graphic), true)]
[DisplayName("UI Graphic", null)]
public class TrackedUGuiGraphic : JsonSerializerTrackedObject
{
	protected override void PostApplyTrackedProperties()
	{
		((Graphic)Target).SetAllDirty();
		base.PostApplyTrackedProperties();
	}
}
