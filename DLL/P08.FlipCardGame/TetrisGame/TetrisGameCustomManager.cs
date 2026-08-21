using System.Collections.Generic;
using UnityEngine;

namespace TetrisGame;

public class TetrisGameCustomManager : MonoBehaviour
{
	public List<TetrisGameChipCustomData> customArray;

	private int customIndex;

	public void InitCustomData(List<TetrisGameChipCustomData> customArray)
	{
		this.customArray = customArray;
		customIndex = 0;
	}

	public TetrisGameChipCustomData GetCustomData()
	{
		if (customIndex < customArray.Count)
		{
			TetrisGameChipCustomData result = customArray[customIndex];
			customIndex++;
			return result;
		}
		return null;
	}
}
