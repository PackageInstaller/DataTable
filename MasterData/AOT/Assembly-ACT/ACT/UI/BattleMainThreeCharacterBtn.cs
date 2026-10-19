using System;
using ACT.Battle;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class BattleMainThreeCharacterBtn : MonoBehaviour, IBattleMainComponent
{
	public TouchSwitchUIMask[] switchCharacter;

	private MonoBattleMainBaseView _view;

	private bool isMobilePlatform
	{
		get
		{
			RuntimePlatform platform = Application.platform;
			return platform == RuntimePlatform.Android || platform == RuntimePlatform.IPhonePlayer;
		}
	}

	public void Initialize(MonoBattleMainBaseView view)
	{
		_view = view;
		SetTransform(Model<CustomUIModel>.Interface.GetCurScheme().HudTeamCharacters);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_EntityDie, OnMainEntityDie);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Team_Refresh, OnRefreshCharactersBtn);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityHpChange, RefreshBloodBar);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Player_Refresh, OnRefreshPlayerUI);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AfterEnterWorld, OnRefreshPlayerUI);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_CharacterEnergyChange, OnCharacterEnergyChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_SwitchCharacterBtnEffect, OnSwitchCharacterBtnEffect);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Open, OnRefreshCharactersUI);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, OnBattleCharacterChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_UpdateCustomUIScheme, OnUpdateCustomUIScheme);
		Model<BattleMainModel>.Interface.OnCharacterBtnDisabledChangeEventHandler += OnCharacterBtnDisabledChangeEventHandler;
		Singleton<GameInputActionManager>.instance.OnActionDisabledChanged += OnActionDisabledChanged;
	}

	private void OnActionDisabledChanged(string arg1, bool arg2)
	{
		RefreshCharactersUI();
		InitSwitchUIParam();
	}

	private void OnCharacterBtnDisabledChangeEventHandler()
	{
		gameObject.SetActive(!Model<BattleMainModel>.Interface.CharacterBtnDisabled);
		if (!Model<BattleMainModel>.Interface.CharacterBtnDisabled)
		{
			OpenComponent();
		}
	}

	public void UnInitialize()
	{
		TouchSwitchUIMask[] array = switchCharacter;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].UnInit();
		}
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_EntityDie, OnMainEntityDie);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Team_Refresh, OnRefreshCharactersBtn);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityHpChange, RefreshBloodBar);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Player_Refresh, OnRefreshPlayerUI);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AfterEnterWorld, OnRefreshPlayerUI);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_CharacterEnergyChange, OnCharacterEnergyChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_SwitchCharacterBtnEffect, OnSwitchCharacterBtnEffect);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Open, OnRefreshCharactersUI);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, OnBattleCharacterChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_UpdateCustomUIScheme, OnUpdateCustomUIScheme);
		Model<BattleMainModel>.Interface.OnCharacterBtnDisabledChangeEventHandler -= OnCharacterBtnDisabledChangeEventHandler;
		Singleton<GameInputActionManager>.instance.OnActionDisabledChanged -= OnActionDisabledChanged;
	}

	public void OpenComponent()
	{
		RefreshCharactersUI();
		InitSwitchUIParam();
	}

	public void CloseComponent()
	{
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
		RefreshCharactersUI();
		InitSwitchUIParam();
	}

	private void SetTransform(CustomUITransform customUITransform)
	{
		RectTransform obj = transform as RectTransform;
		Vector2 anchorMin = (obj.anchorMax = new Vector2(customUITransform.AnchorX, customUITransform.AnchorY));
		obj.anchorMin = anchorMin;
		obj.anchoredPosition = customUITransform.Pos;
	}

	private void OnUpdateCustomUIScheme(BaseEventContent obj)
	{
		if (obj is UpdateCustomUISchemeEvt)
		{
			SetTransform(Model<CustomUIModel>.Interface.GetCurScheme().HudTeamCharacters);
		}
	}

	private void OnBattleCharacterChange(BaseEventContent obj)
	{
		if (!(obj is BattleCharacterChangeEvt battleCharacterChangeEvt) || _view.IsDestroyed)
		{
			return;
		}
		CompCharacter compCharacter = battleCharacterChangeEvt.newEb.GetCompCharacter();
		CompCharacter compCharacter2 = battleCharacterChangeEvt.lastEb.GetCompCharacter();
		TouchSwitchUIMask[] array = switchCharacter;
		foreach (TouchSwitchUIMask touchSwitchUIMask in array)
		{
			if (compCharacter.characterSource.Id() == touchSwitchUIMask.characterId)
			{
				if (isMobilePlatform)
				{
					RefreshHeadDisplay(active: false, touchSwitchUIMask.root);
				}
				touchSwitchUIMask.RestTriggers();
				touchSwitchUIMask.SetSwitchSkillEffect();
				if (battleCharacterChangeEvt.switchSkill)
				{
					touchSwitchUIMask.SetAniSwitchSkill();
				}
				else
				{
					touchSwitchUIMask.SetAniChange();
				}
				touchSwitchUIMask.SetBtnPromptActive(active: false);
				continue;
			}
			if (compCharacter2.characterSource.Id() == touchSwitchUIMask.characterId)
			{
				if (isMobilePlatform && !touchSwitchUIMask.root.activeInHierarchy)
				{
					RefreshHeadDisplay(active: true, touchSwitchUIMask.root);
				}
				touchSwitchUIMask.RestTriggers();
				touchSwitchUIMask.SetSwitchSkillEffect();
				if (battleCharacterChangeEvt.lastEb.IsAlive())
				{
					touchSwitchUIMask.SetAniBackIn();
				}
				else
				{
					touchSwitchUIMask.SetAniDeath();
				}
			}
			else
			{
				Entity entity = MonoECS.instance.localPlayer.IdOfTeamCharacter(touchSwitchUIMask.characterId);
				if (isMobilePlatform)
				{
					RefreshHeadDisplay(entity.IsValid, touchSwitchUIMask.root);
				}
				if (entity.IsAlive() && entity.IsLogicAvailable())
				{
					touchSwitchUIMask.SetSwitchSkillEffect();
				}
			}
			Entity entity2 = MonoECS.instance.localPlayer.IdOfTeamCharacter(touchSwitchUIMask.characterId);
			touchSwitchUIMask.SetBtnPromptActive(entity2.IsValid && entity2.IsAlive() && entity2.IsLogicAvailable());
		}
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.Hud_ChangeCharacter);
	}

	private void OnCharacterLevelUp(BaseEventContent obj)
	{
		_ = (CharacterUpdateEvt)obj;
	}

	public void OnRefreshPlayerUI(BaseEventContent obj)
	{
		RefreshCharactersUI();
	}

	public void RefreshCharactersUI()
	{
		RefreshSwitchButtonDisplay();
		RefreshCharBtn();
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(i);
			if (teamCharacter.IsValid)
			{
				RefreshUltraEnergy(teamCharacter, RefreshUltraEnergyType.NoBattle);
			}
			bool flag = MonoECS.instance.battleEntityIndex == i;
			if (!((bool)_view & flag))
			{
				continue;
			}
			CompAbility compAbility = teamCharacter.GetCompAbility();
			if (compAbility != null)
			{
				if ((bool)_view.BloodBar)
				{
					_view.BloodBar.RefreshBloodUI(compAbility.hp);
				}
				if ((bool)_view.ShieldBar)
				{
					_view.ShieldBar.InitMainEntityShield(compAbility.shield);
				}
			}
		}
	}

	public void RefreshSwitchButtonDisplay()
	{
		bool actionDisabled = Singleton<GameInputActionManager>.instance.GetActionDisabled("Player/Switch1Character");
		bool actionDisabled2 = Singleton<GameInputActionManager>.instance.GetActionDisabled("Player/Switch2Character");
		bool actionDisabled3 = Singleton<GameInputActionManager>.instance.GetActionDisabled("Player/Switch3Character");
		RefreshHeadDisplay(ShouldShowCharacterButton(0, !actionDisabled), switchCharacter[0].root);
		RefreshHeadDisplay(ShouldShowCharacterButton(1, !actionDisabled2), switchCharacter[1].root);
		RefreshHeadDisplay(ShouldShowCharacterButton(2, !actionDisabled3), switchCharacter[2].root);
	}

	public void RefreshCharBtn()
	{
		bool actionDisabled = Singleton<GameInputActionManager>.instance.GetActionDisabled("Player/Switch1Character");
		bool actionDisabled2 = Singleton<GameInputActionManager>.instance.GetActionDisabled("Player/Switch2Character");
		bool actionDisabled3 = Singleton<GameInputActionManager>.instance.GetActionDisabled("Player/Switch3Character");
		for (int i = 0; i < 3; i++)
		{
			TouchSwitchUIMask chose = switchCharacter[i];
			Entity entity = MonoECS.instance.localPlayer.GetTeamCharacter(i);
			if (!entity.IsValid)
			{
				chose.UnInit();
				continue;
			}
			bool btnPromptShow = MonoECS.instance.battleEntityIndex != i && entity.IsValid && entity.IsAlive() && entity.IsLogicAvailable();
			bool flag = i switch
			{
				0 => actionDisabled, 
				1 => actionDisabled2, 
				2 => actionDisabled3, 
				_ => false, 
			};
			CompBehave compBehave = entity.GetCompBehave();
			CompCharacter compCharacter = entity.GetCompCharacter();
			CompAbility compAbility = entity.GetCompAbility();
			EntityType entityType = compBehave.EntityType;
			chose.Init(i, (entityType == EntityType.Character) ? compCharacter.characterSource.Id() : 0, (uint)entity.Id.Index, btnPromptShow);
			if (!ShouldShowCharacterButton(i, !flag))
			{
				RefreshHeadDisplay(active: false, chose.root);
			}
			else if (!chose.root.activeSelf)
			{
				RefreshHeadDisplay(active: true, chose.root);
			}
			if (entityType == EntityType.Character)
			{
				chose.SetCharacterCD(entity);
				compBehave.onChangCD.Clear();
				compBehave.onChangCD += (Action)(() =>
				{
					chose.SetCharacterCD(entity);
				});
				chose.trialRoot.SetActive(compCharacter.characterSource.IsTrailCharacter && !NoTrailWorld());
				chose.InitAssist(compAbility.AssistCost);
				chose.SetHpValue(entity, Model<BattleMainModel>.Interface.bloodWarnPercent, (float)compAbility.hp / (float)compAbility.maxHP);
				chose.SetEnergyValue(entity);
				int characterSkinId = compCharacter.characterSource.GetCharacterSkinId();
				_view.Station.LoadImage(126, characterSkinId, chose.headIcon);
				this.GetImageStation().LoadSprite(GameLoader.meta.characterHalfBodyLitAssetID, characterSkinId, chose.switchSkillImage);
			}
		}
	}

	private bool ShouldShowCharacterButton(int index, bool switchEnabled)
	{
		Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(index);
		if (!teamCharacter.IsValid)
		{
			return false;
		}
		if (isMobilePlatform && MonoECS.instance.battleEntityIndex == index)
		{
			return false;
		}
		if (!switchEnabled)
		{
			return !teamCharacter.IsAlive();
		}
		return true;
	}

	private bool NoTrailWorld()
	{
		return MonoECS.instance.sceneStatus == SceneStatus.Rogue;
	}

	private void OnCharacterEnergyChange(BaseEventContent obj)
	{
		CharacterUltraEnergyUpdateEvt characterUltraEnergyUpdateEvt = (CharacterUltraEnergyUpdateEvt)obj;
		if (characterUltraEnergyUpdateEvt.entity.GetEntityType() == EntityType.Character)
		{
			RefreshUltraEnergy(characterUltraEnergyUpdateEvt.entity, RefreshUltraEnergyType.Battle);
		}
	}

	private void RefreshUltraEnergy(Entity entity, RefreshUltraEnergyType refreshType)
	{
		if (entity.GetEntityType() == EntityType.Character)
		{
			int num = MonoECS.instance.localPlayer.IndexOfTeamCharacter(entity);
			if (num != -1)
			{
				switchCharacter[num].RefreshUltra();
			}
			if (MonoECS.instance.sceneStatus == SceneStatus.Rogue && num > 0)
			{
				switchCharacter[num].SetRogueUltra();
			}
		}
	}

	public void RefreshHeadDisplay(bool active, GameObject button)
	{
		if (!(button == null))
		{
			button.SetActive(active);
		}
	}

	public void RefreshHeadDisplay(GameObject go, float alpha)
	{
		if ((bool)go)
		{
			go.SetActive(value: true);
		}
		CanvasGroup component = go.GetComponent<CanvasGroup>();
		if (!component)
		{
			_ = LuminApplication.LogEnabled;
		}
		else
		{
			component.alpha = alpha;
		}
	}

	private void RefreshBloodBar(BaseEventContent eventContent)
	{
		if (!(eventContent is EntityHpChangeEvt entityHpChangeEvt))
		{
			return;
		}
		Entity entity = GameManager.entities.GetEntity(entityHpChangeEvt.entityId);
		if (entity.IsValid && entity.IsLogicAvailable())
		{
			if (entity == MonoECS.instance.mainEntity)
			{
				_view.BloodBar.RefreshMainEntityBloodDes(entityHpChangeEvt.oldHp, entityHpChangeEvt.curHp, entity);
			}
			int num = MonoECS.instance.localPlayer.IndexOfTeamCharacter(entity);
			if (num != -1 && switchCharacter != null)
			{
				switchCharacter[num].SetHpValue(entity, Model<BattleMainModel>.Interface.bloodWarnPercent, entityHpChangeEvt.curHpPercentage);
			}
		}
	}

	private void OnMainEntityDie(BaseEventContent obj)
	{
		EntityDieEvt entityDieEvt = (EntityDieEvt)obj;
		int num = MPPlayer.local.IndexOfTeamCharacter(entityDieEvt.entity);
		switchCharacter[num].SetAniDeath();
	}

	public void ReSetOnSwitchAnimator(int index)
	{
		TouchSwitchUIMask touchSwitchUIMask = switchCharacter[index];
		Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(index);
		touchSwitchUIMask.RestTriggers();
		touchSwitchUIMask.SetAniEmpty(!teamCharacter.IsValid);
		if (teamCharacter.GetEntityType() != EntityType.Character)
		{
			return;
		}
		if (!teamCharacter.IsAlive())
		{
			touchSwitchUIMask.SetAniDeath();
			return;
		}
		touchSwitchUIMask.SetSwitchSkillEffect();
		touchSwitchUIMask.SetToNormal();
		if (teamCharacter == MonoECS.instance.mainEntity)
		{
			int num = MonoECS.instance.localPlayer.IndexOfTeamCharacter(MonoECS.instance.mainEntity);
			switchCharacter[num].SetAniChange();
		}
		else
		{
			touchSwitchUIMask.SetAniBackIn();
		}
	}

	public void InitSwitchUIParam()
	{
		for (int i = 0; i < 3; i++)
		{
			ReSetOnSwitchAnimator(i);
		}
	}

	private void OnRefreshCharactersBtn(BaseEventContent obj)
	{
		RefreshCharactersUI();
		InitSwitchUIParam();
	}

	public void SetCharacterRedDotActive(BaseEventContent obj)
	{
		if (!(obj is CharacterTutorialEnterOrLeaveRaidEvt characterTutorialEnterOrLeaveRaidEvt))
		{
			return;
		}
		RedDotItem redDotItem = null;
		foreach (RedDotItem redDotItem2 in _view.redDotItems)
		{
			for (int i = 0; i < redDotItem2.fullPath.Count; i++)
			{
				if (redDotItem2.fullPath[i] == "Character")
				{
					redDotItem = redDotItem2;
					break;
				}
			}
			if (redDotItem != null)
			{
				break;
			}
		}
		if (!(redDotItem == null))
		{
			string character = RedDotPathDefine.Character;
			if (Singleton<RedDotManager>.instance.IsPathRegistered(character))
			{
				redDotItem.ForbidDotShow = !characterTutorialEnterOrLeaveRaidEvt.isEnterRaid;
				redDotItem.UpdateDisplay();
			}
		}
	}

	private void OnSwitchCharacterBtnEffect(BaseEventContent obj)
	{
		SwitchCharacterBtnEffectEvent switchCharacterBtnEffectEvent = (SwitchCharacterBtnEffectEvent)obj;
		if (switchCharacterBtnEffectEvent != null)
		{
			SwitchCharacter characterBtnIndex = switchCharacterBtnEffectEvent.characterBtnIndex;
			bool isActive = switchCharacterBtnEffectEvent.isActive;
			switch (characterBtnIndex)
			{
			case SwitchCharacter.switch1Character:
				switchCharacter[0].demonstrateEffect.SetActive(isActive);
				break;
			case SwitchCharacter.switch2Character:
				switchCharacter[1].demonstrateEffect.SetActive(isActive);
				break;
			case SwitchCharacter.switch3Character:
				switchCharacter[2].demonstrateEffect.SetActive(isActive);
				break;
			}
		}
	}

	private void OnRefreshCharactersUI(BaseEventContent obj)
	{
		UIEvent uIEvent = (UIEvent)obj;
		if (uIEvent != null && uIEvent.UIType == UI_TYPE.UI_LETTERBOXINGPANEL)
		{
			RefreshCharactersUI();
		}
	}
}
