using System.Collections.Generic;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class MonoCharacterLevelUpTipView : BaseUIView
{
	public class CharacterLevelUpData : UIViewData
	{
		public bool isBreak;

		public int iconId;

		public int titleId;

		public int starNum;

		public int levelBefore;

		public int levelAfter;

		public List<(int, int, int)> itemData;
	}

	public BImage icon;

	public LocalizeStringEvent title;

	public GameObject starGroup;

	public List<GameObject> stars;

	public TextMeshProUGUI levelFrom;

	public TextMeshProUGUI levelTo;

	public RectTransform content;

	public GameObject prefab;

	protected override void Init()
	{
		base.Init();
		CharacterLevelUpData characterLevelUpData = (CharacterLevelUpData)uiViewData;
		if (!characterLevelUpData.isBreak)
		{
			starGroup.SetActive(value: false);
		}
		else
		{
			starGroup.SetActive(value: true);
			for (int i = 0; i < stars.Count; i++)
			{
				bool active = i < characterLevelUpData.starNum;
				stars[i].SetActive(active);
			}
		}
		Station.LoadSprite(GameLoader.meta.buffAtlasNameAssetID, characterLevelUpData.iconId, icon);
		title.StringReference.TableEntryReference = characterLevelUpData.titleId;
		levelFrom.text = characterLevelUpData.levelBefore.ToString();
		levelTo.text = characterLevelUpData.levelAfter.ToString();
		List<(int, int, int)> itemData = characterLevelUpData.itemData;
		foreach (var item3 in itemData)
		{
			PropertyCell component = Object.Instantiate(prefab, content).GetComponent<PropertyCell>();
			int item = item3.Item1;
			int item2 = item3.Item2;
			string num = item2.ToString();
			item2 = item3.Item3;
			component.InitInNum(item, num, item2.ToString());
		}
		ListPool<(int, int, int)>.Release(itemData);
	}

	protected override void UnInit()
	{
		base.UnInit();
		for (int num = content.childCount - 1; num >= 0; num--)
		{
			Object.Destroy(content.GetChild(num).gameObject);
		}
	}
}
