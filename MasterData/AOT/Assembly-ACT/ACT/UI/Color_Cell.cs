using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Utility;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class Color_Cell : MonoBehaviour
{
	public GameObject noraml;

	public GameObject selcet;

	public GameObject lockObj;

	public LocalizeStringEvent colorName;

	public BImage icon;

	public Button button;

	private bool m_IsChosen;

	public bool isChosen
	{
		get
		{
			return m_IsChosen;
		}
		set
		{
			m_IsChosen = value;
			noraml.SetActive(!m_IsChosen);
			selcet.SetActive(m_IsChosen);
		}
	}

	public void Init(Item item)
	{
		ItemData data = CoreUtils.GetData(item.Id, RuntimeConfigs.data.itemDatas);
		this.GetImageStation().LoadItemIcon(data.iconAddress, icon);
		colorName.StringReference.TableEntryReference = RuntimeConfigs.data.itemDatas[item.Id].nameLocal;
	}

	public void UnLoadSprite()
	{
		icon.UnLoad();
	}
}
