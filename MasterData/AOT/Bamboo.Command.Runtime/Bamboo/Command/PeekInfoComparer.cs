using System.Collections.Generic;

namespace Bamboo.Command;

internal class PeekInfoComparer : IComparer<BasePeekInfo>
{
	private EventStation _sender;

	private readonly List<EventStation> _subTreeRoots = new List<EventStation>();

	public void Init(EventStation sender)
	{
		_sender = sender;
		_subTreeRoots.Clear();
		for (EventStation eventStation = _sender; eventStation != null; eventStation = eventStation.Parent)
		{
			_subTreeRoots.Add(eventStation);
		}
	}

	public void Clear()
	{
		_sender = null;
		_subTreeRoots.Clear();
	}

	public int Compare(BasePeekInfo x, BasePeekInfo y)
	{
		int subTreeIndex = GetSubTreeIndex(x.Peeker);
		int subTreeIndex2 = GetSubTreeIndex(y.Peeker);
		if (subTreeIndex != subTreeIndex2)
		{
			return subTreeIndex - subTreeIndex2;
		}
		EventStation eventStation = _subTreeRoots[subTreeIndex];
		if (x.Peeker.Depth > y.Peeker.Depth)
		{
			EventStation eventStation2 = GetParentFromDepth(x.Peeker, y.Peeker.Depth);
			if (eventStation2 == y.Peeker)
			{
				return 1;
			}
			EventStation eventStation3 = y.Peeker;
			for (int num = y.Peeker.Depth; num > eventStation.Depth; num--)
			{
				if (eventStation2.Parent == eventStation3.Parent)
				{
					return eventStation2.Index - eventStation3.Index;
				}
				eventStation2 = eventStation2.Parent;
				eventStation3 = eventStation3.Parent;
			}
		}
		else if (x.Peeker.Depth < y.Peeker.Depth)
		{
			EventStation eventStation4 = GetParentFromDepth(y.Peeker, x.Peeker.Depth);
			if (eventStation4 == x.Peeker)
			{
				return -1;
			}
			EventStation eventStation5 = x.Peeker;
			for (int num2 = x.Peeker.Depth; num2 > eventStation.Depth; num2--)
			{
				if (eventStation5.Parent == eventStation4.Parent)
				{
					return eventStation5.Index - eventStation4.Index;
				}
				eventStation5 = eventStation5.Parent;
				eventStation4 = eventStation4.Parent;
			}
		}
		else
		{
			EventStation eventStation6 = x.Peeker;
			EventStation eventStation7 = y.Peeker;
			for (int num3 = x.Peeker.Depth; num3 > eventStation.Depth; num3--)
			{
				if (eventStation6.Parent == eventStation7.Parent)
				{
					return eventStation6.Index - eventStation7.Index;
				}
				eventStation6 = eventStation6.Parent;
				eventStation7 = eventStation7.Parent;
			}
		}
		return 0;
	}

	private int GetSubTreeIndex(EventStation postBox)
	{
		int count = _subTreeRoots.Count;
		for (EventStation eventStation = postBox; eventStation != null; eventStation = eventStation.Parent)
		{
			for (int i = 0; i < count; i++)
			{
				if (eventStation == _subTreeRoots[i])
				{
					return i;
				}
			}
		}
		return -1;
	}

	private EventStation GetParentFromDepth(EventStation postBox, int depth)
	{
		for (EventStation eventStation = postBox; eventStation != null; eventStation = eventStation.Parent)
		{
			if (eventStation.Depth == depth)
			{
				return eventStation;
			}
		}
		return null;
	}
}
