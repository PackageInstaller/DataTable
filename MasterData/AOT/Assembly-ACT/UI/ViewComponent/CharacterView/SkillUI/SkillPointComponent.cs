using System;
using ACT.Event;
using ACT.Game.Data;
using ACT.UI;
using Fundamental;
using TMPro;
using UnityEngine;

namespace UI.ViewComponent.CharacterView.SkillUI;

public class SkillPointComponent : MonoBehaviour, IUIFrameElement
{
	[Header("技能点在道具表的Id")]
	public int skillPointItemId;

	public TMP_Text count;

	public RectTransform detailPanelPosition;

	[NonSerialized]
	public Character character;

	public void Initialize()
	{
		OnSkillPointChanged(null);
	}

	public void AddListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Skill_Change, OnSkillPointChanged);
	}

	public void RemoveListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Skill_Change, OnSkillPointChanged);
	}

	private void OnSkillPointChanged(BaseEventContent obj)
	{
		count.SetText(character.SkillPoint.ToString());
	}

	public void OnClick()
	{
	}
}
