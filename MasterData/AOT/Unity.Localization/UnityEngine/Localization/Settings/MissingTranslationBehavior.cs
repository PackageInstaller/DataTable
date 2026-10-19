using System;

namespace UnityEngine.Localization.Settings;

[Flags]
public enum MissingTranslationBehavior
{
	ShowMissingTranslationMessage = 1,
	PrintWarning = 2
}
