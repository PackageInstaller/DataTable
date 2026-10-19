using System.Collections.Generic;

namespace ACT.UI;

public class UITypeComparer : IEqualityComparer<UI_TYPE>
{
	public bool Equals(UI_TYPE x, UI_TYPE y)
	{
		int num = (int)x;
		return num.Equals((int)y);
	}

	public int GetHashCode(UI_TYPE obj)
	{
		return (int)obj;
	}
}
