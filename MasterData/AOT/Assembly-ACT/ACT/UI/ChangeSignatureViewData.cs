using System;

namespace ACT.UI;

[Serializable]
public class ChangeSignatureViewData : UIViewData
{
	public string currentValue;

	public bool allowSameValue;
}
