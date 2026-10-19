using System;
using ACT.Core;
using ACT.Game.Data;
using ACT.UI;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace Runtime.UI.CommonComponent;

public class CommonCharacterEquipComponent : BaseUIComponent
{
	[SerializeField]
	private GameObject m_CharacterIconRoot;

	[SerializeField]
	private BImage m_CharacterIcon;

	[SerializeField]
	private LocalizeStringEvent m_CharacterName;

	private Character m_Character;

	public Character Character
	{
		get
		{
			return m_Character;
		}
		set
		{
			try
			{
				m_Character = value;
				if (value != null)
				{
					m_CharacterIconRoot.SetActive(value: true);
					UpdateIcon();
					UpdateText();
				}
				else
				{
					m_CharacterIconRoot.SetActive(value: false);
				}
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
		}
	}

	private void UpdateIcon()
	{
		Station.LoadImageAsync(126, Character.Id, m_CharacterIcon).Forget();
	}

	private void UpdateText()
	{
		if ((bool)m_CharacterName)
		{
			m_CharacterName.SetTable("Common");
			m_CharacterName.StringReference.TableEntryReference = LocalizationCommonData.CommonString.HasEquipped;
			m_CharacterName.StringReference.GetVariable<string>("0").Value = LocalizationUtility.GetLocalizeString("shortcommon", CoreUtils.GetData(Character.Id, RuntimeConfigs.data.entityDatas).nameLocal);
		}
	}
}
