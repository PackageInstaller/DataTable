using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class MaterialChangeCell : LoopScrollBaseItem
{
	[SerializeField]
	private GameObject _Selected;

	[SerializeField]
	private ActButton _btn;

	[SerializeField]
	private LocalizeStringEvent _matName;

	[SerializeField]
	private BImage _typeIcon;

	[SerializeField]
	private BImage _matIcon;

	[SerializeField]
	private List<GameObject> _qualityBoard;

	[SerializeField]
	private GameObject selfEquipIcon;

	[SerializeField]
	private GameObject otherEquipIcon;

	private BloodBottleMaterial _material;

	public ActButton btn => _btn;

	public BloodBottleMaterial material => _material;

	public void Refresh(BloodBottleMaterial material, ImageAssetStation station, BloodBottleData curBottle)
	{
		_material = material;
		ItemData data = CoreUtils.GetData(material.id, RuntimeConfigs.data.itemDatas);
		_matName.StringReference.TableEntryReference = data.nameLocal;
		station.LoadImage(157, material.type, _typeIcon);
		station.LoadItemIcon(data.iconAddress, _matIcon);
		selfEquipIcon.SetActive(material.isEquip && material.belongBottle == curBottle.uid);
		otherEquipIcon.SetActive(material.isEquip && material.belongBottle != curBottle.uid);
		_qualityBoard.ForEach((GameObject x) =>
		{
			x.SetActive(value: false);
		});
		if (data.quality > 0)
		{
			_qualityBoard[data.quality - 1].SetActive(value: true);
		}
		_Selected.SetActive(value: false);
		gameObject.SetActive(value: true);
	}

	public void UpdateCurEquipState(bool isEquip)
	{
		selfEquipIcon.SetActive(isEquip);
		if (isEquip)
		{
			otherEquipIcon.SetActive(value: false);
		}
	}

	public void UpdateOtherEquipState(bool isEquip)
	{
		if (isEquip)
		{
			selfEquipIcon.SetActive(value: false);
		}
		otherEquipIcon.SetActive(isEquip);
	}

	public void OnSelected()
	{
		_Selected.SetActive(value: true);
	}

	public void OnUnSelected()
	{
		_Selected.SetActive(value: false);
	}
}
