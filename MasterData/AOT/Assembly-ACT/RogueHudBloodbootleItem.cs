using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using Bamboo.ImageCenter;
using Runtime.Model;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

public class RogueHudBloodbootleItem : MonoBehaviour
{
	public BImage ImageIcon;

	public LocalizeStringEvent TextName;

	public LocalizeStringEvent TextDes;

	public TextMeshProUGUI TextUseCount;

	private ImageAssetStation roguestation;

	public Image ImageQua;

	public GameObject GoNow;

	public List<Sprite> Qualitys = new List<Sprite>();

	private void Start()
	{
	}

	public void Init(RogueElement element, bool isNow)
	{
		RogueHealthPotion data = CoreUtils.GetData(element.id, RuntimeConfigs.data.rogueHealthPotions);
		roguestation = Model<RoGueModel>.Interface.rogueStation;
		roguestation.LoadImage(188, element.iconAddress, ImageIcon);
		TextName.StringReference.TableEntryReference = element.name;
		TextDes.StringReference.TableEntryReference = element.description;
		bool flag = Model<RogueNewModel>.Interface.CheckItemIsBuy(element.id);
		BloodBottleData bloodBottleById = Model<BloodBottleModel>.Interface.GetBloodBottleById(data.potionDataId);
		int num = (flag ? (bloodBottleById.maxUseCount - bloodBottleById.alreadyUseCount) : data.maxUseCount);
		TextUseCount.SetText("{0}/{1}", num, data.maxUseCount);
		ImageQua.sprite = Qualitys[data.rarity - 1];
		GoNow.SetActive(isNow);
	}

	private void Update()
	{
	}
}
