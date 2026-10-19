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
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class BottleMaterialInfo : MonoBehaviour
{
	public BImage matTypeIcon;

	public BImage slotIcon;

	public new LocalizeStringEvent name;

	public TextMeshProUGUI matDes;

	public TextMeshProUGUI lockdDesTxt;

	public TextMeshProUGUI emptyDesTxt;

	public GameObject commonRoot;

	public GameObject enmptyRoot;

	public GameObject lockRoot;

	private const int _sloticonConfigId = 140;

	private const int _typeIconConfigId = 157;

	public void Refresh(BloodBottleData bottle, ImageAssetStation station, int slotIndex, StringBuilder sb)
	{
		BottleMaterialSlot bottleMaterialSlot = bottle.wineMaterialSlots[slotIndex];
		int slotStateImageIdByType = GetSlotStateImageIdByType(bottleMaterialSlot.curState, bottleMaterialSlot.types[0]);
		station.LoadImage(140, slotStateImageIdByType, slotIcon);
		station.LoadImage(157, (int)bottleMaterialSlot.types[0], matTypeIcon);
		switch (bottleMaterialSlot.curState)
		{
		case SlotState.IsLock:
		{
			commonRoot.SetActive(value: false);
			lockRoot.SetActive(value: true);
			enmptyRoot.SetActive(value: false);
			sb.Clear();
			string localizeString2 = LocalizationUtility.GetLocalizeString("Common", 2052);
			string localizeString3 = LocalizationUtility.GetLocalizeString("Common", 41000078);
			int unlockNextSlotLevel = Model<BloodBottleModel>.Interface.GetUnlockNextSlotLevel(bottle.uid, slotIndex);
			sb.Append(localizeString2).Append(unlockNextSlotLevel).Append(localizeString3);
			lockdDesTxt.SetText(sb);
			break;
		}
		case SlotState.Empty:
		{
			commonRoot.SetActive(value: false);
			enmptyRoot.SetActive(value: true);
			lockRoot.SetActive(value: false);
			sb.Clear();
			string localizeString = LocalizationUtility.GetLocalizeString("Common", 41000080);
			sb.Append(localizeString);
			emptyDesTxt.SetText(sb);
			break;
		}
		case SlotState.Filled:
		{
			commonRoot.SetActive(value: true);
			enmptyRoot.SetActive(value: false);
			lockRoot.SetActive(value: false);
			BloodBottleMaterial bottleMatById = Model<BloodBottleModel>.Interface.GetBottleMatById(bottleMaterialSlot.matId);
			ItemData data = CoreUtils.GetData(bottleMatById.id, RuntimeConfigs.data.itemDatas);
			name.StringReference.TableEntryReference = data.nameLocal;
			matDes.SetText(Singleton<BloodBottleBuffHandler>.instance.GetBottleMatDesc(bottleMatById, isDetailDesc: false));
			break;
		}
		}
	}

	private int GetSlotStateImageIdByType(SlotState slotState, BottleMatType _type)
	{
		return slotState switch
		{
			SlotState.IsLock => GetIconIdByMatType(_type) + 2, 
			SlotState.Empty => GetIconIdByMatType(_type), 
			SlotState.Filled => GetIconIdByMatType(_type) + 1, 
			_ => 0, 
		};
	}

	private int GetIconIdByMatType(BottleMatType _type)
	{
		return _type switch
		{
			BottleMatType.Yellow => 10, 
			BottleMatType.Blue => 20, 
			BottleMatType.Green => 30, 
			BottleMatType.Purple => 40, 
			_ => 0, 
		};
	}
}
