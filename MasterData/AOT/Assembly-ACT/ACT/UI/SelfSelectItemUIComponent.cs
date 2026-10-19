using ACT.Config;
using ACT.Core;
using ACT.UI.DataProxy;
using ACT.Utility;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class SelfSelectItemUIComponent : ItemUIComponentBase
{
	public bool longPressOpenDetail;

	public GameObject selectCountTag;

	public TMP_Text selectCountText;

	[SerializeField]
	public ActButton reduceButton;

	public GameObject limitMask;

	protected override void OnGameObjectAwake()
	{
		base.OnGameObjectAwake();
		if (longPressOpenDetail)
		{
			holdEvent.AddListener(LongPressOpenDetailPanel);
		}
		if ((bool)reduceButton)
		{
			reduceButton.OnClick.AddListener(OnInvertClick);
		}
	}

	protected override void OnGameObjectDestroy()
	{
		if (longPressOpenDetail)
		{
			holdEvent.RemoveListener(LongPressOpenDetailPanel);
		}
		if ((bool)reduceButton)
		{
			reduceButton.OnClick.RemoveListener(OnInvertClick);
		}
		base.OnGameObjectDestroy();
	}

	public void SetSelectCount(int count)
	{
		if (!(selectCountTag == null) && !(selectCountText == null))
		{
			selectCountTag.SetActive(count > 0);
			selectCountText.SetText("{0:0}", count);
			if ((bool)reduceButton)
			{
				reduceButton.gameObject.SetActive(count > 0);
			}
		}
	}

	protected override void ShowDetailPanel()
	{
		if (!longPressOpenDetail)
		{
			base.ShowDetailPanel();
		}
	}

	public void LongPressOpenDetailPanel()
	{
		if (longPressOpenDetail)
		{
			base.ShowDetailPanel();
		}
	}

	public override void UpdatePerformance()
	{
		base.UpdatePerformance();
		RefreshItemLimitMask(0);
	}

	public void RefreshItemLimitMask(int selectedCount)
	{
		if (!(limitMask == null))
		{
			if (m_ItemUnifier == null || m_ItemUnifier == ItemUnifierProxy.Empty)
			{
				limitMask.SetActive(value: false);
			}
			else
			{
				limitMask.SetActive(ShouldShowItemLimitMask(selectedCount));
			}
		}
	}

	private bool ShouldShowItemLimitMask(int selectedCount)
	{
		ItemData data = CoreUtils.GetData(m_ItemUnifier.Id, RuntimeConfigs.data.itemDatas);
		if (data == null)
		{
			return false;
		}
		ItemType data2 = CoreUtils.GetData(data.type, RuntimeConfigs.data.itemTypes);
		if (data2 == null)
		{
			return false;
		}
		GameUtility.CheckItemQuantityOwnedIsValid(m_ItemUnifier.Id, 0, out var result);
		if (result.maxNum <= 0 || result.leftCount < 0)
		{
			return false;
		}
		long count = m_ItemUnifier.Count;
		if (count <= 0)
		{
			return false;
		}
		int num = Mathf.Max(selectedCount, 0);
		if (data2.CanOverflowConvert)
		{
			long num2 = count * num;
			return result.leftCount - num2 <= 0;
		}
		return count * (num + 1) > result.leftCount;
	}
}
