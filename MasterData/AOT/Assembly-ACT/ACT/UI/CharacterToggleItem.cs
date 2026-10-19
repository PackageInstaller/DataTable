using System.Collections.Generic;
using ACT.Core;
using ACT.Game.Data;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

[RequireComponent(typeof(PublicToggle))]
public class CharacterToggleItem : MonoBehaviour
{
	public enum SkillState
	{
		Upgrade,
		Locked,
		Normal
	}

	public BImage icon;

	public Image lockImage;

	public LocalizeStringEvent nameText;

	public LocalizeStringEvent levelText;

	public PublicToggle toggle;

	public int level;

	public SkillState skillState;

	private Character m_Character;

	public void InitDestiny(int iconId, int label, int targetLevel, bool isLock = false)
	{
		level = targetLevel;
		this.GetImageStation().LoadSprite(GameLoader.meta.constellationAtlasNameAssetID, iconId, icon);
		nameText.StringReference.TableEntryReference = label;
		lockImage.gameObject.SetActive(isLock);
	}

	public void InitSkill(int skillGroupId, Character character)
	{
		m_Character = character;
		m_Character.SkillGroupLevels.TryGetValue(skillGroupId, out level);
		List<int> list = ListPool<int>.Get();
		TableRule.GetAllSkillGroups(m_Character.Id, list);
		if (!m_Character.SkillGroupLevels.ContainsKey(skillGroupId))
		{
			skillState = SkillState.Locked;
			lockImage.gameObject.SetActive(value: true);
		}
		else if (CanUpGrade(skillGroupId))
		{
			skillState = SkillState.Upgrade;
			lockImage.gameObject.SetActive(value: false);
		}
		else
		{
			skillState = SkillState.Normal;
			lockImage.gameObject.SetActive(value: false);
		}
		levelText.gameObject.SetActive(skillState != SkillState.Locked);
		levelText.StringReference.GetVariable<int>("0").Value = level;
		ListPool<int>.Release(list);
	}

	private bool CanUpGrade(int skillGroupId)
	{
		CharacterViewConst.ReasonType reason;
		if (RuntimeConfigs.data.skillGroupLevelDatas.TryGetValue(skillGroupId * 100 + m_Character.SkillGroupLevels[skillGroupId], out var _))
		{
			return GameUtility.CanSkillGroupLevelUp(m_Character, skillGroupId, out reason);
		}
		return false;
	}
}
