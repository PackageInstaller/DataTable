using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class BottleMatDetail : UIBehaviour
{
	[SerializeField]
	private LocalizeStringEvent _matName;

	[SerializeField]
	private BImage _matIcon;

	[SerializeField]
	private BImage _typeIcon;

	[SerializeField]
	private List<GameObject> _qualityBoards;

	[SerializeField]
	private TextMeshProUGUI _skillDes;

	[SerializeField]
	private LocalizeStringEvent _itemDes;

	[SerializeField]
	private GameObject equipedRoot;

	[SerializeField]
	private TextMeshProUGUI _equipedDes;

	public void Refresh(BloodBottleMaterial material, ImageAssetStation station, StringBuilder sb)
	{
		ItemData data = CoreUtils.GetData(material.id, RuntimeConfigs.data.itemDatas);
		_matName.StringReference.TableEntryReference = data.nameLocal;
		station.LoadItemIcon(data.iconAddress, _matIcon);
		station.LoadImage(157, material.type, _typeIcon);
		_qualityBoards.ForEach((GameObject x) =>
		{
			x.SetActive(value: false);
		});
		if (data.quality > 0)
		{
			_qualityBoards[data.quality - 1].SetActive(value: true);
		}
		_skillDes.text = Singleton<BloodBottleBuffHandler>.instance.GetBottleMatDesc(material, isDetailDesc: false);
		_itemDes.StringReference.TableEntryReference = data.descLocal;
		equipedRoot.SetActive(material.isEquip);
		if (material.isEquip)
		{
			BloodBottleData bloodBottleById = Model<BloodBottleModel>.Interface.GetBloodBottleById(material.belongBottle);
			if (bloodBottleById != null)
			{
				int nameLocal = CoreUtils.GetData(bloodBottleById.id, RuntimeConfigs.data.itemDatas).nameLocal;
				string localizeString = LocalizationUtility.GetLocalizeString("shortcommon", nameLocal);
				sb.Clear();
				sb.Append("已被").Append(localizeString).Append("装配");
				_equipedDes.SetText(sb);
			}
		}
		gameObject.SetActive(value: true);
	}

	public void Hide()
	{
		gameObject.SetActive(value: false);
	}
}
