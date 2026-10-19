using System;
using System.Collections.Generic;

namespace ACT.World.Asset;

[Serializable]
public class InteractObjectChangeInfo
{
	public string name;

	public List<InteractObjectChangeStateItem> changeInfoList;
}
