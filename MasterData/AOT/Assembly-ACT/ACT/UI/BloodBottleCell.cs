using System;
using System.Collections.Generic;
using System.Text;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class BloodBottleCell : LoopScrollBaseItem
{
	[SerializeField]
	private GameObject _TriggerIn;

	[SerializeField]
	private ActButton _btn;

	[SerializeField]
	private TextMeshProUGUI _bottleLevel;

	[SerializeField]
	private LocalizeStringEvent _bottleName;

	[SerializeField]
	private LocalizeStringEvent _useDesText;

	[SerializeField]
	private TextMeshProUGUI _maxUseCount;

	[SerializeField]
	private BImage _bottleIcon;

	[SerializeField]
	private List<GameObject> _qualityBoard;

	[SerializeField]
	private GameObject equipIcon;

	[SerializeField]
	private GameObject lockIcon;

	[SerializeField]
	private RedDotItem _redDotItem;

	public GameObject cell;

	public SelectedUGUI selectedUGUI;

	[SerializeField]
	private float _OnTriggerInChangeY;

	public StartList slotComponent;

	private int curBottleItemId;

	private Vector3 _orginalCellLocalPotion;

	public ActButton btn => _btn;

	public float OnTriggerInChangeY => _OnTriggerInChangeY;

	public Vector3 orginalCellLocalPotion => _orginalCellLocalPotion;

	public bool isSelected { get; private set; }

	public bool isTriggerIn { get; private set; }

	public void Refresh(BloodBottleData bottle, ImageAssetStation station, StringBuilder sb, Func<BloodBottleData, bool> bottleIsEquip)
	{
		ItemData data = CoreUtils.GetData(bottle.id, RuntimeConfigs.data.itemDatas);
		curBottleItemId = bottle.id;
		_maxUseCount.gameObject.SetActive(!bottle.isLock);
		if (!bottle.isLock)
		{
			_maxUseCount.SetText(bottle.maxUseCount.FastToString());
		}
		_bottleLevel.SetText(bottle.curLevel.FastToString());
		_bottleName.StringReference.TableEntryReference = data.nameLocal;
		_useDesText.StringReference.TableEntryReference = (bottle.isLock ? LocalizationCommonData.CommonString.NotGain : LocalizationCommonData.CommonString.UseCount);
		station.LoadItemIcon(data.iconAddress, _bottleIcon);
		bool active = bottleIsEquip(bottle);
		equipIcon.SetActive(active);
		lockIcon.SetActive(bottle.isLock);
		slotComponent.SoltInit(bottle, station);
		_qualityBoard.ForEach((GameObject x) =>
		{
			x.SetActive(value: false);
		});
		if (data.quality > 0)
		{
			_qualityBoard[data.quality - 1].SetActive(value: true);
		}
		if (_redDotItem != null)
		{
			string text = string.Format(RedDotPathDefine.BottleNPC + "|{0}|", curBottleItemId);
			if (Singleton<RedDotManager>.instance.GetNode(text) != null)
			{
				_redDotItem.InitRedDot(text, RedDotType.New);
			}
		}
		if (!isSelected)
		{
			_orginalCellLocalPotion = cell.transform.localPosition;
		}
		_TriggerIn.SetActive(value: false);
		gameObject.SetActive(value: true);
	}

	public void OnSelected()
	{
		if (_redDotItem != null && curBottleItemId != 0 && G.localPlayer.redPoints.Items.TryGetValue(curBottleItemId, out var value) && value)
		{
			RedPoints redPoints = new RedPoints();
			redPoints.Items.Add(curBottleItemId, value: false);
			G.service.RefreshRedDot(redPoints, (bool b) =>
			{
				string nodeFullPath = string.Format(RedDotPathDefine.BottleNPC + "|{0}|", curBottleItemId);
				Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, active: false);
			});
		}
		isSelected = true;
		SetHoverVisual(hover: true);
	}

	public void OnUnSelected()
	{
		isSelected = false;
		SetHoverVisual(hover: false);
	}

	public void OnCellTriggerIn()
	{
		_TriggerIn.SetActive(value: true);
	}

	public void OnCellTriggerOut()
	{
		_TriggerIn.SetActive(value: false);
	}

	private void TriggerCallBack(float changeY)
	{
		cell.transform.localPosition = new Vector3(cell.transform.localPosition.x, changeY, cell.transform.localPosition.z);
	}

	private void SetHoverVisual(bool hover)
	{
		if (hover)
		{
			TriggerCallBack(_orginalCellLocalPotion.y + _OnTriggerInChangeY);
		}
		else
		{
			TriggerCallBack(_orginalCellLocalPotion.y);
		}
	}

	public override void Hide()
	{
		base.Hide();
		ResetCellLocalPotion();
	}

	public void ResetCellLocalPotion()
	{
		isSelected = false;
		isTriggerIn = false;
		cell.transform.localPosition = _orginalCellLocalPotion;
	}
}
