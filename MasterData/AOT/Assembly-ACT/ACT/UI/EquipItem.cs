using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class EquipItem : BaseUIComponent, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
{
	[SerializeField]
	private GameObject noEquipRoot;

	[SerializeField]
	private GameObject equipRoot;

	[SerializeField]
	private GameObject[] qualityRoots;

	[SerializeField]
	private BImage itemIcon;

	[SerializeField]
	private CommonNumberComponent level;

	[SerializeField]
	private GameObject selectedRoot;

	[SerializeField]
	public GemHoleItems gemSlots;

	private int m_EquipSlotIndex;

	private Equip m_Equip;

	private bool _selected;

	private bool _hovered;

	private bool m_HoverEnabled;

	public void Register(int index)
	{
		m_EquipSlotIndex = index;
	}

	public void Init(Equip equip, bool isTrialCharacter = false)
	{
		m_Equip = equip;
		equipRoot.SetActive(equip != null);
		if ((bool)level)
		{
			level.gameObject.SetActive(equip != null);
		}
		noEquipRoot.SetActive(equip == null);
		EquipGemSlot[] levelHoles = gemSlots.levelHoles;
		for (int i = 0; i < levelHoles.Length; i++)
		{
			levelHoles[i].gameObject.SetActive(m_Equip != null);
		}
		gemSlots.Init(equip, isTrialCharacter);
		if (m_Equip != null)
		{
			EquipData data = CoreUtils.GetData(m_Equip.Id, RuntimeConfigs.data.equipDatas);
			for (int j = 0; j < qualityRoots.Length; j++)
			{
				qualityRoots[j].SetActive(m_Equip.GetQuality() - 1 == j);
			}
			int iconAddress = CoreUtils.GetData(data.id, RuntimeConfigs.data.itemDatas).iconAddress;
			Station.LoadItemIconAsync(iconAddress, itemIcon).Forget();
			if ((bool)level)
			{
				level.UpdateNumber(m_Equip.Level, RuntimeConfigs.data.game.equipRareLevel[m_Equip.GetQuality() - 1]);
			}
		}
	}

	public void Selected(bool selected)
	{
		_selected = selected;
		RefreshSelectedVisual();
	}

	public void SetHoverEnabled(bool enabled)
	{
		m_HoverEnabled = enabled;
		if (!enabled && _hovered)
		{
			_hovered = false;
			RefreshSelectedVisual();
		}
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		if (m_HoverEnabled)
		{
			_hovered = true;
			RefreshSelectedVisual();
		}
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		if (m_HoverEnabled)
		{
			_hovered = false;
			RefreshSelectedVisual();
		}
	}

	private void RefreshSelectedVisual()
	{
		if (!(selectedRoot == null))
		{
			selectedRoot.SetActive(_selected || _hovered);
		}
	}
}
