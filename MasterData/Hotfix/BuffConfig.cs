using System;
using System.Collections.Generic;

[Serializable]
public class BuffConfig
{
	public List<int> buffList;

	public TargetType buffTargetType = TargetType.Friend;

	public bool isRemove;
}
