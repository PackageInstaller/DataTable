using System.Collections.Generic;
using ACT;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.UI;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;

public class ElementalResonance : MonoBehaviour
{
	public BImage Icon;

	public GameObject GoDefault;

	private List<int> m_characterIds;

	public void SetCharacterIds(int currentIndex, List<PresetTeam> teams)
	{
		m_characterIds = new List<int>(teams[currentIndex].CharacterIds);
		RefreshElemental();
	}

	public void SetCharacterIds(List<int> characterIds)
	{
		m_characterIds = characterIds;
		RefreshElemental();
	}

	public void SetCharacterIds(int[] characterIds)
	{
		m_characterIds = new List<int>(characterIds);
		RefreshElemental();
	}

	public void RefreshElemental()
	{
		Dictionary<int, int> dictionary = new Dictionary<int, int>();
		int num = 0;
		ElementResonanceData elementResonanceData = null;
		for (int i = 0; i < m_characterIds.Count; i++)
		{
			if (m_characterIds[i] == 0)
			{
				continue;
			}
			EntityData data = CoreUtils.GetData(m_characterIds[i], RuntimeConfigs.data.entityDatas);
			if (data != null)
			{
				if (dictionary.TryGetValue(data.element, out var value))
				{
					value++;
					num = value;
					elementResonanceData = RuntimeConfigs.data.elementResonanceDatas[data.element];
				}
				else
				{
					dictionary.Add(data.element, 1);
				}
			}
		}
		if (num > 1)
		{
			this.GetImageStation().LoadSprite(GameLoader.meta.elementalResonanceAtlasAssetID, elementResonanceData.activatedTeamIcon, Icon);
		}
		Icon.icon.gameObject.SetActive(num > 1);
		GoDefault.SetActive(num <= 1);
	}

	public void OpenElementalResonanceView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ELEMENTALRESONANCE, new ElementalResonanceViewData
		{
			list = m_characterIds
		});
	}
}
