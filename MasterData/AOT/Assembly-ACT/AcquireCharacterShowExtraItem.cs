using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.UI;
using ACT.UI.DataProxy;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

public class AcquireCharacterShowExtraItem : MonoBehaviour
{
	[SerializeField]
	private LocalizeStringEvent textName;

	[SerializeField]
	private TextMeshProUGUI textNum;

	[SerializeField]
	private LiteItemUIComponent liteItemUI;

	private void Start()
	{
	}

	public void Init(Item ExtraItem, ImageAssetStation station)
	{
		ItemData data = CoreUtils.GetData(ExtraItem.Id, RuntimeConfigs.data.itemDatas);
		if (data != null)
		{
			textName.StringReference.TableEntryReference = data.nameLocal;
			textNum.SetText("X{0:0}", ExtraItem.Count);
			ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(ExtraItem.Id, ExtraItem.Count);
			liteItemUI.Station = station;
			liteItemUI.SetData(item, long.MinValue, ItemUIComponentBase.InitType.RewardItem);
			liteItemUI.UpdatePerformance();
		}
	}

	private void Update()
	{
	}
}
