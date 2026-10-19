using System;
using System.Collections.Generic;

namespace ACT.MissionSystem;

[Serializable]
public class ItemSubmitConditionParam
{
	public List<ItemSubmit> items = new List<ItemSubmit>();
}
