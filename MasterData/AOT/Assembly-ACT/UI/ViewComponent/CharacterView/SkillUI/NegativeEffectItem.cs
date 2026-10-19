using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.MultiPlayer;
using ACT.UI;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace UI.ViewComponent.CharacterView.SkillUI;

public class NegativeEffectItem : SkillItemBase
{
	public CommonNumberComponent levelIndicator;

	public Image icon;

	[Header("命座提升颜色")]
	public Color constellationPromoteColor;

	[Header("已解锁")]
	public GameObject normalBg;

	[Header("满级图片")]
	public GameObject maxLevelBg;

	public GameObject boardMax;

	[Header("未解锁")]
	public GameObject lockBg;

	public Color LockColor;

	[Header("未解锁可解锁")]
	public GameObject unlockableBg;

	[Header("可升级")]
	public GameObject unlockBg;

	public int currentLevel { get; protected set; }

	public int baseLevel { get; protected set; }

	public int maxLevel { get; protected set; }

	public override void Init()
	{
		base.Init();
		SetData(null);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Skill_Change, SetData);
	}

	private void SetData(BaseEventContent obj)
	{
		maxLevel = SkillGroupData.levelUpLimit;
		levelIndicator.transform.parent.gameObject.SetActive(maxLevel > 1);
		if (Character.SkillGroupLevels.TryGetValue(skillGroupId, out var value))
		{
			IsUnLock = true;
			baseLevel = value;
			currentLevel = Character.GetSkillGroupEventualLevel(skillGroupId);
			if (currentLevel > baseLevel)
			{
				levelIndicator.frontPostProcessor = (List<RichTagConfig> x) =>
				{
					for (int i = 0; i < x.Count; i++)
					{
						RichTagConfig value2 = x[i];
						if (value2.tag == RichTextTag.TagType.Color)
						{
							value2.ColorValue = constellationPromoteColor;
							x[i] = value2;
							break;
						}
					}
				};
			}
			GameUtility.CanSkillGroupLevelUp(Character, skillGroupId, out m_LockReason);
		}
		UpdatePerformance();
	}

	protected override bool CheckUnLock()
	{
		return GameUtility.CanSkillGroupLevelUp(Character, skillGroupId, out m_LockReason);
	}

	public override void UnInit()
	{
		base.UnInit();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Skill_Change, SetData);
	}

	public override void UpdatePerformance()
	{
		lockBg.SetActive(value: false);
		maxLevelBg.SetActive(value: false);
		boardMax.SetActive(value: false);
		normalBg.SetActive(value: false);
		unlockBg.SetActive(value: false);
		unlockableBg.SetActive(value: false);
		switch (LockReason)
		{
		case CharacterViewConst.ReasonType.LackMaterial:
		{
			SkillGroupLevelData skillGroupNextLvData = GetSkillGroupNextLvData();
			normalBg.SetActive(value: true);
			NeedCoin = skillGroupNextLvData.cost.FirstOrDefault((ItemKv x) => x.id == 2)?.count ?? 0;
			break;
		}
		case CharacterViewConst.ReasonType.None:
		{
			unlockBg.SetActive(value: true);
			SkillGroupLevelData skillGroupNextLvData = GetSkillGroupNextLvData();
			NeedCoin = skillGroupNextLvData.cost.FirstOrDefault((ItemKv x) => x.id == 2)?.count ?? 0;
			break;
		}
		case CharacterViewConst.ReasonType.ReachMaxLevel:
			boardMax.SetActive(value: true);
			maxLevelBg.SetActive(value: true);
			break;
		}
		levelIndicator.UpdateNumber(currentLevel, maxLevel);
	}

	public override SkillGroupLevelData GetSkillGroupNextLvData()
	{
		return CoreUtils.GetData(new MPSkill
		{
			id = skillGroupId,
			level = (byte)(baseLevel + 1)
		}.GetSkillIdWithLevel(), RuntimeConfigs.data.skillGroupLevelDatas);
	}
}
