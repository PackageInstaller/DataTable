using System;
using System.Collections.Generic;

[Serializable]
public class UITreeGroupData
{
	public int id;

	public string text;

	public string controllerStateValue;

	public string extraData;

	public List<UITreeItemData> itemDatas = new List<UITreeItemData>();

	public int defaultIndex;
}
