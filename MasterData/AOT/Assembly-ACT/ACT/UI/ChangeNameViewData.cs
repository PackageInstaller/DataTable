using System;

namespace ACT.UI;

[Serializable]
public class ChangeNameViewData : UIViewData
{
	public string currentValue;

	public bool allowSameValue;
}
