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
using UnityEngine.UI;

namespace UI.ViewComponent.CharacterView.SkillUI;

public class RelativeSkillItem : SkillItemBase
{
	private static Dictionary<int, string> _characterTypeColorMap = new Dictionary<int, string>
	{
		{ 1, "#AF7FFF" },
		{ 2, "#F3DE6C" },
		{ 3, "#73C5F0" },
		{ 4, "#6DFFA4" },
		{ 5, "#F07373" }
	};

	[SerializeField]
	private GameObject canUnlockEffect;

	[SerializeField]
	private GameObject lockEffect;

	[SerializeField]
	private Image colorBg;

	public static IReadOnlyDictionary<int, string> CharacterTypeColorMap => _characterTypeColorMap;

	public override bool ShowPreview => false;

	public int CurrentLevel { get; private set; }

	protected override void Awake()
	{
		base.Awake();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Skill_Change, SetData);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Skill_Refresh, SetData);
		toggle.onToggleClick.AddListener(Click);
	}

	private void Click()
	{
		if (LockReason == CharacterViewConst.ReasonType.LessCharacterLevel)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Elite/Property_Gray");
		}
		else
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Elite/Property");
		}
	}

	protected override void OnUnityDestroy()
	{
		toggle.onToggleClick.RemoveListener(Click);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Skill_Change, SetData);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Skill_Refresh, SetData);
	}

	public override void Init()
	{
		base.Init();
		SetData(null);
	}

	private void SetData(BaseEventContent obj)
	{
		if (Character.SkillGroupLevels.TryGetValue(skillGroupId, out var _))
		{
			IsUnLock = true;
			CurrentLevel = Character.GetSkillGroupEventualLevel(skillGroupId);
		}
		else
		{
			IsUnLock = false;
			CurrentLevel = 0;
		}
		GameUtility.CanSkillGroupLevelUp(Character, skillGroupId, out m_LockReason);
		UpdatePerformance();
	}

	public override void UpdatePerformance()
	{
		base.UpdatePerformance();
		canUnlockEffect.SetActive(value: false);
		lockEffect.SetActive(value: false);
		SkillGroupLevelData skillGroupNextLvData = GetSkillGroupNextLvData();
		NeedCoin = (skillGroupNextLvData?.cost.FirstOrDefault((ItemKv x) => x.id == 2)?.count).GetValueOrDefault();
		switch (LockReason)
		{
		case CharacterViewConst.ReasonType.None:
			if ((bool)canUnlockEffect)
			{
				canUnlockEffect?.SetActive(GameUtility.ItemsIsEnough(skillGroupNextLvData.cost));
			}
			break;
		case CharacterViewConst.ReasonType.LessCharacterLevel:
			if ((bool)lockEffect)
			{
				lockEffect.SetActive(value: true);
			}
			break;
		case CharacterViewConst.ReasonType.ReachMaxLevel:
			canUnlockEffect.SetActive(value: false);
			lockEffect.SetActive(value: false);
			NeedCoin = -1;
			break;
		}
		if (!IsUnLock)
		{
			colorBg.color = Color.white;
			return;
		}
		EntityCharacterData data = CoreUtils.GetData(Character.Id, RuntimeConfigs.data.entityCharacterDatas);
		if (ColorUtility.TryParseHtmlString(_characterTypeColorMap[data.mannerType], out var color))
		{
			colorBg.color = color;
		}
	}

	public override SkillGroupLevelData GetSkillGroupNextLvData()
	{
		return CoreUtils.GetData(new MPSkill
		{
			id = skillGroupId,
			level = (byte)(CurrentLevel + 1)
		}.GetSkillIdWithLevel(), RuntimeConfigs.data.skillGroupLevelDatas);
	}
}
