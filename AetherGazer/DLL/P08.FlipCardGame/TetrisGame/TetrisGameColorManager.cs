using System.Collections.Generic;
using UnityEngine;

namespace TetrisGame;

public class TetrisGameColorManager : MonoBehaviour
{
	private List<int> colorIndexArray;

	public void InitColorList(TetrisGameStageSaveData data)
	{
		colorIndexArray = data.colorIndexArray;
	}

	public int RandomColorType()
	{
		int index = Random.Range(0, colorIndexArray.Count);
		return colorIndexArray[index];
	}
}
