using UnityEngine;
using UnityEngine.UI;

namespace TetrisGame;

public class TetrisGameTileEntity : MonoBehaviour
{
	public int chipIndex;

	public int colorIndex;

	[HideInInspector]
	public int widthPos;

	[HideInInspector]
	public int heightPos;

	public RectTransform rect;

	[SerializeField]
	private Image sprite;

	[SerializeField]
	private Image fillSprite;

	[SerializeField]
	private Image fillExpect;

	[SerializeField]
	private Image expectSprite;

	public bool isChipTile;

	public bool needEmpty;

	public TileType curType;

	public bool isExpect;

	private IUIController controller;

	private int curFillChipIndex;

	private int curExpectChipIndex;

	public TileType editType;

	public TetrisGameTileSaveData GetSaveData()
	{
		return new TetrisGameTileSaveData
		{
			width = widthPos,
			height = heightPos,
			tileType = editType,
			chipIndex = chipIndex,
			colorIndex = colorIndex
		};
	}

	public void SetTileType(TileType type, int colorIndex = -1)
	{
		curType = type;
		editType = type;
		if (curType == TileType.Empty)
		{
			curFillChipIndex = 0;
		}
		else if (colorIndex > 0)
		{
			this.colorIndex = colorIndex;
			curFillChipIndex = colorIndex;
		}
		ChangeShowState();
	}

	public void SetNullTile()
	{
		SetTileType(TileType.Empty);
		sprite.gameObject.SetActive(value: false);
	}

	public void SetGameLoseState()
	{
		if (curType != TileType.Empty)
		{
			controller.SetSelectedState("lose");
		}
	}

	public void ChangeShowState()
	{
		if (isChipTile)
		{
			sprite.sprite = TetrisGameManager.GetTileTexture(colorIndex);
			return;
		}
		if (controller == null)
		{
			controller = base.transform.GetComponent<IUIController>();
		}
		if (needEmpty)
		{
			if (controller != null)
			{
				controller.SetSelectedState("expect");
			}
			if (TileType.Full == curType || TileType.BUBBLE == curType)
			{
				expectSprite.color = GetColorBtChipIndex(curFillChipIndex);
			}
			else if (curExpectChipIndex == 0 && controller != null)
			{
				controller.SetSelectedState("false");
			}
			else
			{
				expectSprite.color = GetColorBtChipIndex(curExpectChipIndex);
			}
			return;
		}
		if (isExpect)
		{
			if (curType != TileType.Full && curType != TileType.BUBBLE)
			{
				if (controller != null)
				{
					controller.SetSelectedState("fullExpect");
				}
				Sprite tileTexture = TetrisGameManager.GetTileTexture(curExpectChipIndex);
				fillExpect.sprite = tileTexture;
				Color color = fillExpect.color;
				color.a = 0.4f;
				fillExpect.color = color;
			}
			return;
		}
		switch (curType)
		{
		case TileType.Empty:
			if (controller != null)
			{
				controller.SetSelectedState("false");
			}
			break;
		case TileType.Full:
			if (controller != null)
			{
				controller.SetSelectedState("true");
			}
			fillSprite.sprite = TetrisGameManager.GetTileTexture(curFillChipIndex);
			break;
		case TileType.BUBBLE:
			if (controller != null)
			{
				controller.SetSelectedState("true");
			}
			fillSprite.sprite = TetrisGameManager.GetTileTexture(curFillChipIndex);
			break;
		}
	}

	private Color GetColorBtChipIndex(int chipIndex)
	{
		string htmlString = "#000000";
		switch (chipIndex)
		{
		case 0:
			htmlString = "#000000";
			break;
		case 1:
			htmlString = "#FC9FDB";
			break;
		case 2:
			htmlString = "#3ACF88";
			break;
		case 3:
			htmlString = "#FDA171";
			break;
		case 4:
			htmlString = "#F7DA76";
			break;
		case 5:
			htmlString = "#B0F27E";
			break;
		case 6:
			htmlString = "#3E90EE";
			break;
		case 7:
			htmlString = "#A47DF6";
			break;
		case 8:
			htmlString = "#EC6E8D";
			break;
		case 9:
			htmlString = "#8CF5FA";
			break;
		case 10:
			htmlString = "#9EB6E6";
			break;
		case 11:
			htmlString = "#746D7B";
			break;
		case 12:
			htmlString = "#B3E3F5";
			break;
		case 13:
			htmlString = "#8CF5FA";
			break;
		case 16:
			htmlString = "#BAD0EA";
			break;
		case 17:
			htmlString = "#BAD0EA";
			break;
		}
		ColorUtility.TryParseHtmlString(htmlString, out var color);
		return color;
	}

	public void SetData(TetrisGameTileSaveData data)
	{
		widthPos = data.width;
		heightPos = data.height;
		curType = data.tileType;
	}

	public bool CheckTileCanPlace(TileType type)
	{
		return type switch
		{
			TileType.Empty => true, 
			TileType.BUBBLE => true, 
			_ => curType switch
			{
				TileType.Empty => true, 
				TileType.Full => false, 
				_ => false, 
			}, 
		};
	}

	public void FillTile(TileType type, int colorIndex)
	{
		if (CheckTileCanPlace(type))
		{
			switch (curType)
			{
			case TileType.Empty:
				curFillChipIndex = colorIndex;
				SetTileType(type);
				break;
			case TileType.Full:
			case TileType.BUBBLE:
				break;
			}
		}
	}

	public void FillExpect(bool flag, int colorIndex = 0)
	{
		isExpect = flag;
		curExpectChipIndex = colorIndex;
		ChangeShowState();
	}

	public int GetCurShowColor()
	{
		if (curExpectChipIndex > 0)
		{
			return curExpectChipIndex;
		}
		return curFillChipIndex;
	}

	public bool IsSameColor(int chipColorIndex)
	{
		if (GetCurShowColor() == chipColorIndex)
		{
			return true;
		}
		if (GetCurShowColor() == 17)
		{
			return true;
		}
		if (chipColorIndex == 17)
		{
			return true;
		}
		return false;
	}

	public void UpdataExpectDispose()
	{
		ChangeShowState();
	}

	public void RemoveTile(TileType type)
	{
		switch (curType)
		{
		case TileType.Empty:
			SetTileType(type);
			break;
		case TileType.Full:
			if (type == TileType.Full)
			{
				SetTileType(TileType.Empty);
			}
			break;
		}
	}

	public void Dispose()
	{
		Object.DestroyImmediate(base.gameObject);
	}
}
