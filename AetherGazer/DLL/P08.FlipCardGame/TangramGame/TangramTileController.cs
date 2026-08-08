using System;
using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.UI;

namespace TangramGame;

public class TangramTileController : SerializedMonoBehaviour
{
	public TangramGameConst.TILE_TYPE curType;

	public RectTransform rect;

	internal int x;

	internal int y;

	public GameObject go;

	public Image cubeImage;

	public GameObject triggerController;

	public GameObject maskGo;

	public Image trigger1;

	public Image trigger2;

	public GameObject baseTile;

	[Header("策划编辑部分")]
	public List<TangramChipTileData> dataList;

	[HideInInspector]
	public bool isChipTile;

	public TangramGameConst.TILE_DATA_TYPE tileTpye;

	[HideInInspector]
	public TangramGameConst.TILE_DATA_TYPE oldType;

	[HideInInspector]
	public TangramGameConst.TILE_TYPE oriTileType = TangramGameConst.TILE_TYPE.EMPTY;

	private void Awake()
	{
		rect = base.gameObject.GetComponent<RectTransform>();
	}

	public void StartGame(int indexX, int indexY)
	{
		x = indexX;
		y = indexY;
		curType = TangramGameConst.TILE_TYPE.EMPTY;
		ShowRunTimeColor();
	}

	public void SetImage(Sprite chipImage, Texture2D needTexture = null, bool canEmpty = false)
	{
		if ((curType != TangramGameConst.TILE_TYPE.EMPTY) | canEmpty)
		{
			triggerController.SetActive(value: false);
			cubeImage.gameObject.SetActive(value: true);
			int num = 40;
			Texture2D texture2D = ((!(chipImage != null)) ? needTexture : chipImage.texture);
			if (texture2D != null)
			{
				Sprite sprite = Sprite.Create(texture2D, new Rect(x * num, y * num, num, num), new Vector2(0f, 0f));
				cubeImage.sprite = sprite;
				cubeImage.color = Color.white;
			}
			ChangeMaskState();
		}
	}

	public void ChangeMaskState()
	{
		if (isChipTile)
		{
			if (curType != TangramGameConst.TILE_TYPE.FULL && curType != TangramGameConst.TILE_TYPE.EMPTY)
			{
				maskGo.SetActive(value: true);
				RotateMaskTriggerGo();
				cubeImage.transform.SetParent(maskGo.transform);
			}
			else
			{
				maskGo.SetActive(value: false);
			}
		}
		else if (tileTpye == TangramGameConst.TILE_DATA_TYPE.TIGGER)
		{
			bool flag = false;
			TangramGameConst.TILE_TYPE tileType = TangramGameConst.TILE_TYPE.EMPTY;
			foreach (TangramChipTileData data in dataList)
			{
				if (data.chipIndex == 0)
				{
					flag = true;
				}
				else
				{
					tileType = data.tileType;
				}
			}
			if (flag)
			{
				maskGo.SetActive(value: true);
				RotateMaskTriggerGo(tileType);
				cubeImage.transform.SetParent(maskGo.transform);
			}
		}
		else
		{
			maskGo.SetActive(value: false);
			cubeImage.transform.SetParent(base.transform);
		}
	}

	public void ShowRunTimeColor()
	{
		if (oriTileType != TangramGameConst.TILE_TYPE.EMPTY)
		{
			if (tileTpye == TangramGameConst.TILE_DATA_TYPE.SINGLE)
			{
				ShowSpriteColor(cubeImage, dataList[0], !isChipTile);
				return;
			}
			triggerController.SetActive(value: true);
			cubeImage.gameObject.SetActive(value: false);
			if (dataList.Count > 1)
			{
				ShowSpriteColor(trigger1, dataList[0], !isChipTile);
				ShowSpriteColor(trigger2, dataList[1], !isChipTile);
			}
			RotateTriggerGo();
		}
		else
		{
			SetNullTile();
		}
	}

	public void RefreshState()
	{
		ChangeTileType();
		ChangeShowState();
	}

	public void SetData(int indexX, int indexY)
	{
		x = indexX;
		y = indexY;
		dataList = new List<TangramChipTileData>();
		switch (tileTpye)
		{
		case TangramGameConst.TILE_DATA_TYPE.SINGLE:
			dataList.Add(new TangramChipTileData(x, y));
			break;
		case TangramGameConst.TILE_DATA_TYPE.TIGGER:
			dataList.Add(new TangramChipTileData(x, y));
			dataList.Add(new TangramChipTileData(x, y));
			break;
		}
		ChangeShowState();
	}

	public void SetData(TangramTileData data)
	{
		x = data.x;
		y = data.y;
		dataList = data.dataList;
		tileTpye = data.tileType;
		ChangeShowState();
	}

	public void SetNullTile()
	{
		triggerController.SetActive(value: false);
		cubeImage.gameObject.SetActive(value: false);
		curType = TangramGameConst.TILE_TYPE.EMPTY;
		maskGo.SetActive(value: false);
		if (isChipTile)
		{
			base.transform.GetComponent<BoxCollider>().enabled = false;
			if (baseTile != null)
			{
				baseTile.SetActive(value: false);
			}
		}
	}

	public void Dispose(bool retainTile = false)
	{
		if (dataList != null)
		{
			dataList.Clear();
		}
		oriTileType = TangramGameConst.TILE_TYPE.EMPTY;
		tileTpye = TangramGameConst.TILE_DATA_TYPE.SINGLE;
		oldType = TangramGameConst.TILE_DATA_TYPE.SINGLE;
		curType = TangramGameConst.TILE_TYPE.EMPTY;
		isChipTile = false;
		if (!retainTile)
		{
			UnityEngine.Object.DestroyImmediate(go);
		}
	}

	public void CloseImage()
	{
		triggerController.SetActive(value: false);
		cubeImage.gameObject.SetActive(value: false);
	}

	public void ChangeShowState()
	{
		if (tileTpye == TangramGameConst.TILE_DATA_TYPE.SINGLE)
		{
			triggerController.SetActive(value: false);
			cubeImage.gameObject.SetActive(value: true);
			if (dataList.Count > 0)
			{
				CheckChipIndex(dataList[0]);
				ShowSpriteColor(cubeImage, dataList[0]);
				oriTileType = dataList[0].tileType;
			}
			return;
		}
		triggerController.SetActive(value: true);
		cubeImage.gameObject.SetActive(value: false);
		if (!CheckChipTileIsCorrect(dataList[0], dataList[1]))
		{
			return;
		}
		if (dataList.Count > 1)
		{
			CheckChipIndex(dataList[0]);
			CheckChipIndex(dataList[1]);
			ShowSpriteColor(trigger1, dataList[0]);
			ShowSpriteColor(trigger2, dataList[1]);
			if (dataList[0].tileType == TangramGameConst.TILE_TYPE.EMPTY || dataList[1].tileType == TangramGameConst.TILE_TYPE.EMPTY)
			{
				oriTileType = ((dataList[0].tileType == TangramGameConst.TILE_TYPE.EMPTY) ? dataList[1].tileType : dataList[0].tileType);
			}
			else
			{
				oriTileType = TangramGameConst.TILE_TYPE.FULL;
			}
		}
		RotateTriggerGo();
	}

	private void CheckChipIndex(TangramChipTileData data)
	{
		if (data.tileType == TangramGameConst.TILE_TYPE.EMPTY)
		{
			data.chipIndex = 0;
		}
		else
		{
			data.chipIndex = Math.Clamp(data.chipIndex, 1, 10);
		}
	}

	private bool CheckChipTileIsCorrect(TangramChipTileData data1, TangramChipTileData data2)
	{
		if (data1.tileType == TangramGameConst.TILE_TYPE.EMPTY || data2.tileType == TangramGameConst.TILE_TYPE.EMPTY)
		{
			return true;
		}
		if (data1.tileType == TangramGameConst.TILE_TYPE.FULL || data2.tileType == TangramGameConst.TILE_TYPE.FULL)
		{
			return false;
		}
		bool result = false;
		switch (data1.tileType)
		{
		case TangramGameConst.TILE_TYPE.LEFT_HIGH:
			if (data2.tileType == TangramGameConst.TILE_TYPE.RIGHT_LOW)
			{
				result = true;
			}
			break;
		case TangramGameConst.TILE_TYPE.LEFT_LOW:
			if (data2.tileType == TangramGameConst.TILE_TYPE.RIGHT_HIGH)
			{
				result = true;
			}
			break;
		case TangramGameConst.TILE_TYPE.RIGHT_HIGH:
			if (data2.tileType == TangramGameConst.TILE_TYPE.LEFT_LOW)
			{
				result = true;
			}
			break;
		case TangramGameConst.TILE_TYPE.RIGHT_LOW:
			if (data2.tileType == TangramGameConst.TILE_TYPE.LEFT_HIGH)
			{
				result = true;
			}
			break;
		default:
			return false;
		}
		return result;
	}

	public void ChangeTileType()
	{
		if (oldType != tileTpye)
		{
			dataList.Clear();
			switch (tileTpye)
			{
			case TangramGameConst.TILE_DATA_TYPE.SINGLE:
				dataList.Add(new TangramChipTileData(x, y));
				break;
			case TangramGameConst.TILE_DATA_TYPE.TIGGER:
				dataList.Add(new TangramChipTileData(x, y));
				dataList.Add(new TangramChipTileData(x, y));
				break;
			}
			oldType = tileTpye;
		}
	}

	private void ShowSpriteColor(Image sprite, TangramChipTileData data, bool hidColor = false)
	{
		if (hidColor)
		{
			Texture2D baseImage = TangramGameStageManager.Instance.tileManager.baseImage;
			if ((bool)baseImage)
			{
				SetImage(null, baseImage, hidColor);
			}
		}
		else if (TangramManager.Instance == null || !TangramManager.Instance.isRunTime)
		{
			if ((bool)sprite)
			{
				switch (data.tileType)
				{
				case TangramGameConst.TILE_TYPE.EMPTY:
					sprite.color = Color.gray;
					sprite.gameObject.SetActive(!isChipTile);
					break;
				case TangramGameConst.TILE_TYPE.LEFT_LOW:
				case TangramGameConst.TILE_TYPE.LEFT_HIGH:
				case TangramGameConst.TILE_TYPE.RIGHT_HIGH:
				case TangramGameConst.TILE_TYPE.RIGHT_LOW:
				case TangramGameConst.TILE_TYPE.FULL:
					sprite.color = TangramGameConst.COLOR_LIST[data.chipIndex];
					break;
				}
			}
		}
		else if ((bool)sprite)
		{
			switch (data.tileType)
			{
			case TangramGameConst.TILE_TYPE.EMPTY:
				sprite.color = Color.gray;
				sprite.gameObject.SetActive(!isChipTile);
				break;
			case TangramGameConst.TILE_TYPE.LEFT_LOW:
			case TangramGameConst.TILE_TYPE.LEFT_HIGH:
			case TangramGameConst.TILE_TYPE.RIGHT_HIGH:
			case TangramGameConst.TILE_TYPE.RIGHT_LOW:
			case TangramGameConst.TILE_TYPE.FULL:
				sprite.color = Color.black;
				break;
			}
		}
	}

	private void RotateTriggerGo()
	{
		if (dataList.Count > 0)
		{
			switch (dataList[0].tileType)
			{
			case TangramGameConst.TILE_TYPE.LEFT_LOW:
				triggerController.transform.eulerAngles = new Vector3(0f, 0f, 0f) + triggerController.transform.parent.eulerAngles;
				break;
			case TangramGameConst.TILE_TYPE.LEFT_HIGH:
				triggerController.transform.eulerAngles = new Vector3(0f, 0f, 270f) + triggerController.transform.parent.eulerAngles;
				break;
			case TangramGameConst.TILE_TYPE.RIGHT_HIGH:
				triggerController.transform.eulerAngles = new Vector3(0f, 0f, 180f) + triggerController.transform.parent.eulerAngles;
				break;
			case TangramGameConst.TILE_TYPE.RIGHT_LOW:
				triggerController.transform.eulerAngles = new Vector3(0f, 0f, 90f) + triggerController.transform.parent.eulerAngles;
				break;
			}
		}
	}

	private void RotateMaskTriggerGo(TangramGameConst.TILE_TYPE tileType = TangramGameConst.TILE_TYPE.EMPTY)
	{
		if (dataList.Count > 0)
		{
			maskGo.transform.eulerAngles = new Vector3(0f, 0f, 0f);
			TangramGameConst.TILE_TYPE tILE_TYPE = TangramGameConst.TILE_TYPE.EMPTY;
			switch ((tileType != TangramGameConst.TILE_TYPE.EMPTY) ? tileType : dataList[0].tileType)
			{
			case TangramGameConst.TILE_TYPE.LEFT_LOW:
				maskGo.transform.eulerAngles = new Vector3(0f, 0f, 0f) + maskGo.transform.parent.eulerAngles;
				break;
			case TangramGameConst.TILE_TYPE.LEFT_HIGH:
				maskGo.transform.eulerAngles = new Vector3(0f, 0f, 270f) + maskGo.transform.parent.eulerAngles;
				break;
			case TangramGameConst.TILE_TYPE.RIGHT_HIGH:
				maskGo.transform.eulerAngles = new Vector3(0f, 0f, 180f) + maskGo.transform.parent.eulerAngles;
				break;
			case TangramGameConst.TILE_TYPE.RIGHT_LOW:
				maskGo.transform.eulerAngles = new Vector3(0f, 0f, 90f) + maskGo.transform.parent.eulerAngles;
				break;
			}
		}
	}

	public bool CheckTileCanPlace(TangramGameConst.TILE_TYPE type)
	{
		if (type == TangramGameConst.TILE_TYPE.EMPTY)
		{
			return true;
		}
		switch (curType)
		{
		case TangramGameConst.TILE_TYPE.EMPTY:
			return true;
		case TangramGameConst.TILE_TYPE.FULL:
			return false;
		case TangramGameConst.TILE_TYPE.LEFT_HIGH:
			if (type == TangramGameConst.TILE_TYPE.RIGHT_LOW)
			{
				return true;
			}
			return false;
		case TangramGameConst.TILE_TYPE.LEFT_LOW:
			if (type == TangramGameConst.TILE_TYPE.RIGHT_HIGH)
			{
				return true;
			}
			return false;
		case TangramGameConst.TILE_TYPE.RIGHT_HIGH:
			if (type == TangramGameConst.TILE_TYPE.LEFT_LOW)
			{
				return true;
			}
			return false;
		case TangramGameConst.TILE_TYPE.RIGHT_LOW:
			if (type == TangramGameConst.TILE_TYPE.LEFT_HIGH)
			{
				return true;
			}
			return false;
		default:
			return false;
		}
	}

	public void FillTile(TangramGameConst.TILE_TYPE type)
	{
		if (!CheckTileCanPlace(type))
		{
			return;
		}
		switch (curType)
		{
		case TangramGameConst.TILE_TYPE.EMPTY:
			curType = type;
			break;
		case TangramGameConst.TILE_TYPE.LEFT_HIGH:
			if (type == TangramGameConst.TILE_TYPE.RIGHT_LOW)
			{
				curType = TangramGameConst.TILE_TYPE.FULL;
			}
			break;
		case TangramGameConst.TILE_TYPE.LEFT_LOW:
			if (type == TangramGameConst.TILE_TYPE.RIGHT_HIGH)
			{
				curType = TangramGameConst.TILE_TYPE.FULL;
			}
			break;
		case TangramGameConst.TILE_TYPE.RIGHT_HIGH:
			if (type == TangramGameConst.TILE_TYPE.LEFT_LOW)
			{
				curType = TangramGameConst.TILE_TYPE.FULL;
			}
			break;
		case TangramGameConst.TILE_TYPE.RIGHT_LOW:
			if (type == TangramGameConst.TILE_TYPE.LEFT_HIGH)
			{
				curType = TangramGameConst.TILE_TYPE.FULL;
			}
			break;
		case TangramGameConst.TILE_TYPE.FULL:
			break;
		}
	}

	public void RemoveTile(TangramGameConst.TILE_TYPE type)
	{
		switch (curType)
		{
		case TangramGameConst.TILE_TYPE.FULL:
			switch (type)
			{
			case TangramGameConst.TILE_TYPE.LEFT_HIGH:
				curType = TangramGameConst.TILE_TYPE.RIGHT_LOW;
				break;
			case TangramGameConst.TILE_TYPE.LEFT_LOW:
				curType = TangramGameConst.TILE_TYPE.RIGHT_HIGH;
				break;
			case TangramGameConst.TILE_TYPE.RIGHT_HIGH:
				curType = TangramGameConst.TILE_TYPE.LEFT_LOW;
				break;
			case TangramGameConst.TILE_TYPE.RIGHT_LOW:
				curType = TangramGameConst.TILE_TYPE.LEFT_HIGH;
				break;
			case TangramGameConst.TILE_TYPE.FULL:
				curType = TangramGameConst.TILE_TYPE.EMPTY;
				break;
			}
			break;
		case TangramGameConst.TILE_TYPE.LEFT_HIGH:
			if (type == TangramGameConst.TILE_TYPE.LEFT_HIGH)
			{
				curType = TangramGameConst.TILE_TYPE.EMPTY;
			}
			break;
		case TangramGameConst.TILE_TYPE.LEFT_LOW:
			if (type == TangramGameConst.TILE_TYPE.LEFT_LOW)
			{
				curType = TangramGameConst.TILE_TYPE.EMPTY;
			}
			break;
		case TangramGameConst.TILE_TYPE.RIGHT_HIGH:
			if (type == TangramGameConst.TILE_TYPE.RIGHT_HIGH)
			{
				curType = TangramGameConst.TILE_TYPE.EMPTY;
			}
			break;
		case TangramGameConst.TILE_TYPE.RIGHT_LOW:
			if (type == TangramGameConst.TILE_TYPE.RIGHT_LOW)
			{
				curType = TangramGameConst.TILE_TYPE.EMPTY;
			}
			break;
		case TangramGameConst.TILE_TYPE.EMPTY:
			break;
		}
	}
}
