using System.Collections.Generic;

public class BuffEventInfo
{
	public int buffId;

	public int buffGroupId;

	public readonly List<int> buffTags = new List<int>();

	public BuffManager.BuffRemoveType removeType;

	public BuffManager.BuffAddType addType;

	public bool iRemoveNature
	{
		get
		{
			if (removeType != BuffManager.BuffRemoveType.Normal)
			{
				return removeType == BuffManager.BuffRemoveType.TimeFinish;
			}
			return true;
		}
	}

	public void Clear()
	{
		buffId = 0;
		buffGroupId = 0;
		buffTags.Clear();
		removeType = BuffManager.BuffRemoveType.Normal;
		addType = BuffManager.BuffAddType.Normal;
	}
}
