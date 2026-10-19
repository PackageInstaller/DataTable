using System.Collections.Generic;
using UnityEngine.Localization;

namespace ACT;

public class CommonLocalizeStringConfig : LuminSerializedScriptableObject
{
	public Dictionary<LocalizationCommonData.CommonString, LocalizedString> commonStrings = new Dictionary<LocalizationCommonData.CommonString, LocalizedString>();
}
