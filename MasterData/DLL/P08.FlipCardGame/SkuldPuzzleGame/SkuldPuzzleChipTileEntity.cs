using UnityEngine;
using UnityEngine.UI;

namespace SkuldPuzzleGame;

public class SkuldPuzzleChipTileEntity : MonoBehaviour
{
	public SkuldPuzzleTileData tileData;

	[SerializeField]
	private Image tileImage;

	private float cellWidth = -1f;

	private float cellHeight = -1f;

	private int chipWidth;

	private int chipHeight;

	public void InitData(SkuldPuzzleTileData tileData, int chipWidth = -1, int chipHeight = -1)
	{
		this.tileData = tileData;
		if (chipWidth > 0 && chipHeight > 0)
		{
			this.chipWidth = chipWidth;
			this.chipHeight = chipHeight;
			cellWidth = chipWidth * SkuldPuzzleConst.chipCubeSize + (chipWidth - 1) * SkuldPuzzleConst.cubeSpace - SkuldPuzzleConst.chipEdge * 2;
			cellHeight = chipHeight * SkuldPuzzleConst.chipCubeSize + (chipHeight - 1) * SkuldPuzzleConst.cubeSpace - SkuldPuzzleConst.chipEdge * 2;
			cellWidth /= chipWidth;
			cellHeight /= chipHeight;
			base.transform.GetComponent<RectTransform>().sizeDelta = new Vector2(cellWidth, cellHeight);
		}
		RefreshShow();
	}

	public Sprite GetTileTexture()
	{
		return tileImage.sprite;
	}

	public void SetImage(Sprite chipImage, ColorType colorType, int pixelBeginX, int pixelBeginY)
	{
		Texture2D texture2D = null;
		if (chipImage != null)
		{
			texture2D = chipImage.texture;
		}
		_ = SkuldPuzzleConst.chipSize;
		if (texture2D != null)
		{
			Sprite sprite = Sprite.Create(texture2D, new Rect((float)tileData.x * cellWidth + (float)pixelBeginX, (float)tileData.y * cellHeight + (float)pixelBeginY, cellWidth, cellHeight), new Vector2(0f, 0f));
			tileImage.sprite = sprite;
			tileImage.color = SkuldPuzzleConst.ChipColorDic[colorType];
		}
	}

	public void RefreshChipImage()
	{
		if (!(tileImage == null))
		{
			if (tileData.tileType == TileType.Empty)
			{
				tileImage.enabled = false;
			}
			else
			{
				tileImage.enabled = true;
			}
		}
	}

	public void RefreshShow()
	{
		RefreshChipImage();
		RefreshLayout();
	}

	public void RefreshLayout()
	{
		if (cellWidth > 0f && cellHeight > 0f)
		{
			base.transform.localPosition = new Vector2((float)tileData.x * cellWidth + (float)chipWidth, (float)tileData.y * cellHeight + (float)chipHeight);
		}
		else
		{
			base.transform.localPosition = new Vector2(tileData.x * SkuldPuzzleConst.chipSize, tileData.y * SkuldPuzzleConst.chipSize);
		}
	}

	public void Dispose()
	{
		if ((bool)base.gameObject)
		{
			Object.DestroyImmediate(base.gameObject);
		}
	}
}
