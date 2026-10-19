using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Game.Data;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.UI.View.SkillUI;

public class SkillPanelBase : MonoBehaviour
{
	public List<SkillItemBase> toggles;

	public BetterAnimation betterMoveEffect;

	[SerializeField]
	private CommonDestiny commonDestiny;

	public const string Show = "Show";

	public const string Hide = "Hide";

	public const string MoveIn = "Movein";

	public const string MoveOut = "Moveout";

	private SkillItemBase m_ActiveItem;

	public SkillItemBase ActiveItem
	{
		get
		{
			if (m_ActiveItem == null)
			{
				return null;
			}
			m_ActiveItem = m_ActiveItem.toggle.Group.GetFirstActiveToggle().GetComponent<SkillItemBase>();
			return m_ActiveItem;
		}
	}

	public void ShowPanel(Character character)
	{
		ShowPanel(character, null, null, character?.IsTrailCharacter ?? false);
	}

	public void ShowPanel(Character character, ImageAssetStation station, UnityAction openDestiny, bool isTrialCharacter)
	{
		gameObject.SetActive(value: true);
		RefreshCommonDestiny(character, station, openDestiny, isTrialCharacter);
		betterMoveEffect.GetSequence("Show").Play();
		foreach (SkillItemBase toggle in toggles)
		{
			try
			{
				toggle.Character = character;
				toggle.Init();
				toggle.OnSelectedCallBack = null;
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
		}
		SkillItemBase skillItemBase = toggles.FirstOrDefault((SkillItemBase x) => x.SkillGroupData.skillType == 1);
		skillItemBase = ((skillItemBase != null) ? skillItemBase : toggles.First());
		skillItemBase.toggle.SetIsOn(val: true);
		m_ActiveItem = skillItemBase;
	}

	public void HidePanel()
	{
		betterMoveEffect.GetSequence("Hide");
		foreach (SkillItemBase toggle in toggles)
		{
			toggle.UnInit();
			toggle.OnSelectedCallBack = null;
		}
		gameObject.SetActive(value: false);
	}

	private void RefreshCommonDestiny(Character character, ImageAssetStation station, UnityAction openDestiny, bool isTrialCharacter)
	{
		if (commonDestiny == null)
		{
			commonDestiny = GetComponentInChildren<CommonDestiny>(includeInactive: true);
		}
		if (!(commonDestiny == null) && character != null)
		{
			commonDestiny.Refresh(character.Id, character, station, isTrialCharacter, openDestiny);
		}
	}
}
