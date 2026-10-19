using System;
using System.Collections.Generic;

namespace ACT.Model;

public class EquipSlotInfo : ICloneable
{
	public HashSet<int> SuitIDs { get; set; } = new HashSet<int>();

	public List<int> SortIDs { get; set; } = new List<int>();

	public object Clone()
	{
		return new EquipSlotInfo
		{
			SuitIDs = new HashSet<int>(SuitIDs),
			SortIDs = new List<int>(SortIDs)
		};
	}
}
