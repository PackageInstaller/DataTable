using System.Collections.Generic;
using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using Bamboo.ECS;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class TouchUIMaskBloodBar : TouchUIMaskBase
{
	public Slider frontSlider;

	public Slider backSlider;

	public Image fillImage;

	public Image backImage;

	public Color normalColor;

	public Color lowColor;

	public Color backNormalColor;

	public Color backLowColor;

	public BloodWarn warnEffect;

	[SerializeField]
	private TextMeshProUGUI curHp;

	[SerializeField]
	private TextMeshProUGUI maxHp;

	[SerializeField]
	private TextMeshProUGUI level;

	private int _characterId = -1;

	private void Awake()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_EntityDie, OnMainEntityDieRefreshBloodUI);
	}

	private void Start()
	{
		SetTransform(Model<CustomUIModel>.Interface.GetCurScheme().BloodBarTransform);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_UpdateCustomUIScheme, OnUpdateCustomUIScheme);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_Character_HpChange, OnCharacterHpChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Character_LevelUp, OnRefreshCharacterLevel);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, OnRefreshBattleUI);
		Model<BattleMainModel>.Interface.OnBloodBarDisabledChangeEventHandler += OnBloodBarDisabledChangeEventHandler;
	}

	private void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_UpdateCustomUIScheme, OnUpdateCustomUIScheme);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_Character_HpChange, OnCharacterHpChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Character_LevelUp, OnRefreshCharacterLevel);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, OnRefreshBattleUI);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_EntityDie, OnMainEntityDieRefreshBloodUI);
		Model<BattleMainModel>.Interface.OnBloodBarDisabledChangeEventHandler -= OnBloodBarDisabledChangeEventHandler;
	}

	private void OnBloodBarDisabledChangeEventHandler()
	{
		bool bloodBarDisabled = Model<BattleMainModel>.Interface.BloodBarDisabled;
		gameObject.SetActive(!bloodBarDisabled);
	}

	public void OnChangeMainEntity(Entity entityBehave)
	{
		_characterId = entityBehave.GetCompCharacter().characterSource.Id();
		CompAbility compAbility = entityBehave.GetCompAbility();
		float num = (targetValue = compAbility.HpPercent);
		value = num;
		UpdateBarAndEffect(compAbility.HpPercent, compAbility.hp, compAbility.maxHP);
		RefreshCharacterLevel();
	}

	protected override void Changed()
	{
		frontSlider.value = targetValue;
	}

	public override void SetValue()
	{
		if (targetValue > value)
		{
			backSlider.value = value;
			return;
		}
		frontSlider.value = targetValue;
		backSlider.value = value;
	}

	public void SetTransform(CustomUITransform customUITransform)
	{
		RectTransform obj = transform as RectTransform;
		Vector2 anchorMin = (obj.anchorMax = new Vector2(customUITransform.AnchorX, customUITransform.AnchorY));
		obj.anchorMin = anchorMin;
		obj.anchoredPosition = customUITransform.Pos;
	}

	private void OnUpdateCustomUIScheme(BaseEventContent eventContent)
	{
		if (eventContent is UpdateCustomUISchemeEvt updateCustomUISchemeEvt)
		{
			SetTransform(updateCustomUISchemeEvt.scheme.BloodBarTransform);
		}
	}

	private void RefreshCharacterLevel()
	{
		level.SetText("{0:0}", MonoECS.instance.mainEntity.GetCompAbility().level);
	}

	private void OnRefreshCharacterLevel(BaseEventContent eventContent)
	{
		CharacterUpdateEvt characterUpdateEvt = (CharacterUpdateEvt)eventContent;
		List<Character> curTeamCharacters = CharacterDataHelper.GetCurTeamCharacters();
		if (curTeamCharacters == null)
		{
			return;
		}
		for (int i = 0; i < curTeamCharacters.Count; i++)
		{
			if (curTeamCharacters[i].Id == characterUpdateEvt.character.Id && MonoECS.instance.localPlayer.battleEntityIndex == i)
			{
				level.SetText("{0:0}", curTeamCharacters[i].Level);
			}
		}
	}

	private void OnCharacterHpChange(BaseEventContent content)
	{
		if (content is CharacterHpChangeEvt characterHpChangeEvt && characterHpChangeEvt.characterId == _characterId && MonoECS.instance.mainEntity.IsAlive())
		{
			targetValue = characterHpChangeEvt.HpPercent;
			UpdateBarAndEffect(characterHpChangeEvt.HpPercent, characterHpChangeEvt.curHp, characterHpChangeEvt.maxHp);
		}
	}

	private void UpdateBarAndEffect(float hpPercent, int curHpVal, int maxHpVal)
	{
		if (hpPercent < RuntimeConfigs.data.game.characterLowHpPercent)
		{
			fillImage.color = lowColor;
			if (backImage != null)
			{
				backImage.color = backLowColor;
			}
		}
		else
		{
			fillImage.color = normalColor;
			if (backImage != null)
			{
				backImage.color = backLowColor;
			}
		}
		if (warnEffect != null)
		{
			if (hpPercent < RuntimeConfigs.data.game.characterLowHpPercent)
			{
				if (!warnEffect.playing)
				{
					warnEffect.StartPlay();
				}
			}
			else if (warnEffect.playing)
			{
				warnEffect.StopPlay();
			}
		}
		curHp.SetText("{0:0}", curHpVal);
		maxHp.SetText("{0:0}", maxHpVal);
	}

	public void BloodWarn(float last, float curr)
	{
		if (curr < Model<BattleMainModel>.Interface.bloodWarnPercent)
		{
			fillImage.color = lowColor;
			if (backImage != null)
			{
				backImage.color = backLowColor;
			}
		}
		else
		{
			fillImage.color = normalColor;
			if (backImage != null)
			{
				backImage.color = backNormalColor;
			}
		}
		if (curr < Model<BattleMainModel>.Interface.bloodWarnEffectPercent)
		{
			if (!warnEffect.playing)
			{
				warnEffect.StartPlay();
			}
		}
		else if (warnEffect.playing)
		{
			warnEffect.StopPlay();
		}
	}

	public void InitMainEntityBloodBar(int newValue)
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		OnChangeMainEntity(mainEntity);
		RefreshMainEntityBloodDes(0, newValue, mainEntity);
	}

	public void RefreshMainEntityBloodDes(int hp, int newValue, Entity eb)
	{
		BloodWarn((float)hp / (float)eb.GetCompAbility().maxHP, targetValue);
	}

	public void RefreshBloodUI(int newValue)
	{
		warnEffect.PlayReset();
		InitMainEntityBloodBar(newValue);
	}

	public void OnMainEntityDieRefreshBloodUI(BaseEventContent obj)
	{
		EntityDieEvt entityDieEvt = (EntityDieEvt)obj;
		if (entityDieEvt != null && entityDieEvt.entity == MonoECS.instance.mainEntity)
		{
			warnEffect.PlayReset();
		}
	}

	private void OnRefreshBattleUI(BaseEventContent obj)
	{
		if (obj is BattleCharacterChangeEvt)
		{
			RefreshBloodUI(MonoECS.instance.mainEntity.GetCompAbility().hp);
		}
	}
}
