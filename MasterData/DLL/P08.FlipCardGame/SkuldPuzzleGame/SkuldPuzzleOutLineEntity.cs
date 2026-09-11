using UnityEngine;
using UnityEngine.UI;

namespace SkuldPuzzleGame;

public class SkuldPuzzleOutLineEntity : MonoBehaviour
{
	private SkuldPuzzleChipBlockEntity chipEntitiy;

	[SerializeField]
	private Image tileImage;

	public void GetDirAndLine(SkuldPuzzleTileData tileData, out DIR roteDir, out int nearLine)
	{
		roteDir = DIR.UP;
		nearLine = 0;
	}

	public void DrawShow(DIR roteDir, int nearLine)
	{
	}

	public void InitData(SkuldPuzzleTileData tileData, SkuldPuzzleChipBlockEntity chipEntitiy)
	{
		RefreshLayout(tileData);
	}

	public void RefreshLayout(SkuldPuzzleTileData tileData)
	{
		base.transform.localPosition = new Vector2(tileData.x * SkuldPuzzleConst.chipSize, tileData.y * SkuldPuzzleConst.chipSize);
	}

	public void Dispose()
	{
		if ((bool)base.gameObject)
		{
			Object.DestroyImmediate(base.gameObject);
		}
	}
}
