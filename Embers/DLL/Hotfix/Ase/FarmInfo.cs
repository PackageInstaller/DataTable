using System.Collections.Generic;

namespace Ase;

public struct FarmInfo
{
	public int Level;

	public List<FarmData> FarmDataList;

	public void UpdateFarmData(List<FarmData> newList)
	{
		if (FarmDataList == null)
		{
			return;
		}
		for (int i = 0; i < FarmDataList.Count; i++)
		{
			for (int j = 0; j < newList.Count; j++)
			{
				if (FarmDataList[i].GridId == newList[j].GridId)
				{
					FarmDataList[i] = newList[j];
				}
			}
		}
	}
}
