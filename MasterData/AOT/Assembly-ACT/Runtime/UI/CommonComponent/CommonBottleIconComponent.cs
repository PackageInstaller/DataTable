using ACT;
using ACT.Model;
using ACT.UI;
using Fundamental;
using UnityEngine;

namespace Runtime.UI.CommonComponent;

public class CommonBottleIconComponent : BaseUIComponent
{
	[SerializeField]
	private UIAtlasImage m_BottleIcon;

	private BloodBottleData m_BloodBottleData;

	public BloodBottleData BloodBottleData
	{
		get
		{
			return m_BloodBottleData;
		}
		set
		{
			m_BloodBottleData = value;
			if (value != null)
			{
				gameObject.SetActive(value: true);
				Singleton<UIAtlasManager>.instance.LoadItemSprite(GameLoader.meta.itemAtlasNameAssetID, m_BloodBottleData.id, m_BottleIcon);
			}
			else
			{
				gameObject.SetActive(value: false);
			}
		}
	}
}
