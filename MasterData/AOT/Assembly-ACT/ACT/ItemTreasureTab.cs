using System;
using System.Linq;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT;

public class ItemTreasureTab : MonoBehaviour
{
	[SerializeField]
	private ActButton ItemButton;

	[SerializeField]
	private GameObject SelectBG;

	[SerializeField]
	private RedDotItem redDot;

	[SerializeField]
	private BImage Icon;

	[SerializeField]
	private BImage highLightIcon;

	private ImageAssetStation _imageStation;

	public int _TreasureType;

	private Action<int> _callBack;

	public void UpdateTabView(int treasureType)
	{
		ItemButton.SetBtnClick(OnClickTabButtonHandle);
		_TreasureType = treasureType;
		_imageStation = ImageManager.instance.GetAssetStation();
		_imageStation.LoadImage(158, Model<TreasureModel>.Interface.GetTypeIcon(_TreasureType), Icon);
		_imageStation.LoadImage(158, Model<TreasureModel>.Interface.GetTypeIcon(_TreasureType), highLightIcon);
		SetSelect(value: false);
	}

	public void SetClickCallBack(Action<int> callBack)
	{
		_callBack = callBack;
	}

	public void SetSelect(bool value)
	{
		SelectBG.SetActive(value);
		Icon.icon.gameObject.SetActive(!value);
		highLightIcon.icon.gameObject.SetActive(value);
		UpdateRedDot();
	}

	public void OnClickTabButtonHandle()
	{
		_callBack?.Invoke(_TreasureType);
	}

	public void UpdateRedDot()
	{
		string text = string.Empty;
		switch ((TreasureType)_TreasureType)
		{
		case TreasureType.Precious:
			text = RedDotPathDefine.Treasure_Precious;
			break;
		case TreasureType.Fragmented:
			text = RedDotPathDefine.Treasure_Fragmented;
			break;
		case TreasureType.WaterfallSeal:
			text = RedDotPathDefine.Treasure_WaterfallSeal;
			break;
		case TreasureType.Relic:
			text = RedDotPathDefine.Treasure_Relic;
			break;
		case TreasureType.BygoneOldObject:
			text = RedDotPathDefine.Treasure_BygoneOldObject;
			break;
		case TreasureType.LeftOver:
			text = RedDotPathDefine.Treasure_LeftOver;
			break;
		case TreasureType.EnergyControl:
			text = RedDotPathDefine.Treasure_EnergyControl;
			break;
		}
		if (redDot != null && text != string.Empty)
		{
			redDot.fullPath = text.Split("|").ToList();
			redDot.BindTrieNode();
			redDot.UpdateDisplay();
		}
	}
}
