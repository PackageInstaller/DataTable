using System;
using System.Collections.Generic;

namespace ACT.UI;

public class MonoBreakSuccessViewData : UIViewData
{
	public int fromLevel;

	public int toLevel;

	public List<(int, float, float)> propertyData;

	public Action callback;
}
