using UnityEngine;
using UnityEngine.UI;

namespace SkuldPuzzleGame;

public class SkuldPuzzleMapBlockEntity : MonoBehaviour
{
	[SerializeField]
	private Image expectSprite;

	private IUIController controller;

	private int fillChipID;

	public SkuldPuzzleMapBlockData mapBlockData;

	public int GetFillChipID()
	{
		return fillChipID;
	}

	public ColorType GetColorType()
	{
		return mapBlockData.colorType;
	}

	public SkuldPuzzleMapBlockData GetMapBlockData()
	{
		return mapBlockData;
	}

	public void Awake()
	{
		controller = base.transform.GetComponent<IUIController>();
	}

	public void InitData(SkuldPuzzleMapBlockData mapBlockData)
	{
		fillChipID = -1;
		this.mapBlockData = mapBlockData;
		RefreshControllerShow();
	}

	public void RefreshControllerShow()
	{
		if (controller == null)
		{
			controller = base.transform.GetComponent<IUIController>();
		}
		if (mapBlockData.puzzleTileData.tileType == TileType.Damaged)
		{
			controller.SetSelectedState("lock");
			return;
		}
		string value = SkuldPuzzleConst.TileColorController[mapBlockData.colorType];
		controller.SetSelectedState(value);
	}

	public void RefreshTileExpectShow(Vector3 eulerAngles)
	{
		expectSprite.transform.eulerAngles = eulerAngles;
		controller.SetSelectedState("expect");
	}

	public bool CheckIsMeetColor(ColorType chipColor)
	{
		if (mapBlockData.colorType != ColorType.None && chipColor != mapBlockData.colorType)
		{
			return false;
		}
		return true;
	}

	public bool CheckTileCanPlace(SkuldPuzzleChipBlockEntity chipBlockEntity)
	{
		if (mapBlockData.puzzleTileData.tileType != TileType.Empty)
		{
			return false;
		}
		if (!CheckIsMeetColor(chipBlockEntity.chipBlockData.colorType))
		{
			return false;
		}
		return true;
	}

	public void SetTileTileTypeState(bool isFull, int chipBlockByID)
	{
		if (mapBlockData.puzzleTileData.tileType != TileType.Damaged)
		{
			if (isFull)
			{
				RefreshControllerShow();
				mapBlockData.puzzleTileData.tileType = TileType.Full;
				fillChipID = chipBlockByID;
			}
			else
			{
				mapBlockData.puzzleTileData.tileType = TileType.Empty;
				fillChipID = -1;
			}
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
