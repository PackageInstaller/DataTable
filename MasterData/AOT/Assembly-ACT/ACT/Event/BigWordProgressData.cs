using System.Collections.Generic;
using UnityEngine.Localization.Components;

namespace ACT.Event;

public class BigWordProgressData : BaseEventContent
{
	public LocalizeStringEvent str;

	public string value;

	public List<string> values;
}
