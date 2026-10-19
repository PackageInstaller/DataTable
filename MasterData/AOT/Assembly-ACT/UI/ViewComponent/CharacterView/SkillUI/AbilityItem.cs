using System.Collections.Generic;
using System.Linq;
using ACT;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.MultiPlayer;
using ACT.UI;
using ACT.Utility;
using Fundamental;
using UnityEngine;

namespace UI.ViewComponent.CharacterView.SkillUI;

public class AbilityItem : SkillItemBase
{
	public CommonNumberComponent levelIndicator;

	[Header("命座提升颜色")]
	public Color constellationPromoteColor;

	[Header("满级图片")]
	public GameObject maxLevelBg;

	[Header("可升级特效")]
	public GameObject upGrade;

	public int currentLevel { get; protected set; }

	public int baseLevel { get; protected set; }

	public int maxLevel => SkillGroupData.levelUpLimit + currentLevel - baseLevel;

	public int maxBaseLevel => SkillGroupData.levelUpLimit;

	public bool hasExternalModified => currentLevel > baseLevel;

	public List<int> externalModifyData { get; protected set; }

	protected override void Awake()
	{
		base.Awake();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Skill_Change, SetData);
	}

	protected override void OnUnityDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Skill_Change, SetData);
	}

	public override void Init()
	{
		base.Init();
		SetData(null);
		skillItemAnimation?.GetSequence((LockReason == CharacterViewConst.ReasonType.ReachMaxLevel) ? "Max" : "Normal").Play();
		if (toggle != null)
		{
			toggle.onValueChanged.RemoveListener(OnValueChanged);
			toggle.onValueChanged.AddListener(OnValueChanged);
		}
	}

	private void OnValueChanged(bool isOn)
	{
		if (isOn)
		{
			skillItemAnimation?.GetSequence("Selected").Play();
		}
		else
		{
			skillItemAnimation?.GetSequence("Normal").Play();
		}
	}

	private void SetData(BaseEventContent obj)
	{
		if (Character.SkillGroupLevels.TryGetValue(skillGroupId, out var value))
		{
			IsUnLock = true;
			externalModifyData = ListPool<int>.Get();
			currentLevel = Character.GetSkillGroupEventualLevel(skillGroupId, externalModifyData);
			baseLevel = value;
			if (currentLevel > baseLevel)
			{
				levelIndicator.frontPostProcessor = SetExtraLevelStyle;
			}
			levelIndicator.UpdateNumber(currentLevel, maxLevel);
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"当前角色{Character}中没有ID为 {skillGroupId} 的技能组数据！");
		}
		GameUtility.CanSkillGroupLevelUp(Character, skillGroupId, out m_LockReason);
		UpdatePerformance();
	}

	public override void UnInit()
	{
		base.UnInit();
		if (externalModifyData != null)
		{
			ListPool<int>.Release(externalModifyData);
			externalModifyData = null;
		}
	}

	public override void UpdatePerformance()
	{
		maxLevelBg.SetActive(value: false);
		if ((bool)upGrade)
		{
			upGrade?.SetActive(value: false);
		}
		SkillGroupLevelData skillGroupNextLvData = GetSkillGroupNextLvData();
		NeedCoin = skillGroupNextLvData.cost.FirstOrDefault((ItemKv x) => x.id == 2)?.count ?? 0;
		switch (LockReason)
		{
		case CharacterViewConst.ReasonType.None:
			skillGroupNextLvData = GetSkillGroupNextLvData();
			if ((bool)upGrade)
			{
				upGrade?.SetActive(GameUtility.ItemsIsEnough(skillGroupNextLvData.cost));
			}
			break;
		case CharacterViewConst.ReasonType.ReachMaxLevel:
			NeedCoin = -1;
			maxLevelBg.SetActive(value: true);
			break;
		}
	}

	protected override bool CheckUnLock()
	{
		return true;
	}

	public override SkillGroupLevelData GetSkillGroupNextLvData()
	{
		return CoreUtils.GetData(new MPSkill
		{
			id = skillGroupId,
			level = (byte)(baseLevel + 1)
		}.GetSkillIdWithLevel(), RuntimeConfigs.data.skillGroupLevelDatas);
	}

	public void SetExtraLevelStyle(List<RichTagConfig> x)
	{
		for (int i = 0; i < x.Count; i++)
		{
			RichTagConfig value = x[i];
			if (value.tag == RichTextTag.TagType.Color)
			{
				value.ColorValue = constellationPromoteColor;
				x[i] = value;
				break;
			}
		}
	}
}
