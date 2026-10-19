using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Utility;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

public class RogueInfoItem : MonoBehaviour
{
	public BImage ItemIcon;

	public Image ImageQuality;

	public LocalizeStringEvent TextName;

	public LocalizeStringEvent TextDescription;

	public Transform TfRogueInfoInScriptionIconItem;

	public GameObject RogueInfoInScriptionIconItemPrefab;

	public List<Sprite> Qualitys = new List<Sprite>();

	private void Start()
	{
	}

	public void Init(int itemid, ImageAssetStation station)
	{
		RogueElement rogueElement = RuntimeConfigs.data.rogueElements[itemid];
		RogueItem rogueItem = RuntimeConfigs.data.rogueItems[itemid];
		station.LoadImage(188, rogueElement.iconAddress, ItemIcon);
		if (TfRogueInfoInScriptionIconItem.childCount > 0)
		{
			TfRogueInfoInScriptionIconItem.DestroyChildren();
		}
		if (rogueItem != null)
		{
			for (int i = 0; i < rogueItem.inscriptionIds.Length; i++)
			{
				UIUtility.AddWidget<RogueInfoInScriptionIconItem>(TfRogueInfoInScriptionIconItem, RogueInfoInScriptionIconItemPrefab).Init(rogueItem.inscriptionIds[i], station);
			}
		}
		TextName.StringReference.TableEntryReference = rogueElement.name;
		TextDescription.StringReference.TableEntryReference = rogueElement.description;
		ImageQuality.sprite = Qualitys[rogueItem.rarity - 1];
	}

	private void Update()
	{
	}
}
