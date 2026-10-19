using ACT.Config;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using UnityEngine;

namespace ACT.UI;

public class DecorationItem : MonoBehaviour
{
	public NormalItemUIComponent ItemCell;

	public GameObject GoLock;

	public ActButton BtnClick;

	public GameObject GoSelect;

	public GameObject GoTag;

	public EffectDress DressData { get; private set; }

	public void Init(EffectDress data)
	{
		DressData = data;
		ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(data.id, 0L);
		ItemCell.SetData(item, long.MinValue, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.OneSide);
		ItemCell.UpdatePerformance();
	}

	public void SetState(Character character)
	{
		bool active = character != null && character.EffectDressId == DressData.id;
		if (GoTag != null)
		{
			GoTag.SetActive(active);
		}
		GoLock.SetActive(!Model<SkinModel>.Interface.CheckEffectDressIsHave(DressData.id));
	}

	public void SetSelect(bool isSelect)
	{
		if (GoSelect != null)
		{
			GoSelect.SetActive(isSelect);
		}
	}
}
