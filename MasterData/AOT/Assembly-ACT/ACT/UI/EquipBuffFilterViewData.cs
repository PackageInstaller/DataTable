using System;
using System.Collections.Generic;

namespace ACT.UI;

public class EquipBuffFilterViewData : UIViewData
{
	public List<int> SelectedFeatureIds;

	public Action OnClose;
}
