using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Fundamental;
using UI.ViewComponent.CharacterView.SkillUI;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.UI;

public class CharacterLevelUpSubView : SubUIView<CharacterLevelUpSubInputController>, ICharacterSubView, ISubUIView, IBaseUIComponent
{
	[SerializeReference]
	private CharacterLevelUpPanel characterLevelUpPanel;

	[SerializeField]
	private BetterAnimation animation;

	[SerializeField]
	private ActToggleGroup relativeToggleGroup;

	[SerializeField]
	private RelativeSkillItem[] relativeSkillItems;

	public ViewControlLayer costLayer;

	public ViewControlLayer skillLayer;

	public ViewControlLayer subViewLayer;

	public GamePadTipsComp gamePadGroup;

	public GameObject[] nonSkillLayerPrompts;

	private bool _afterAnimation;

	private int _characterId;

	private ImageAssetStation _station;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt = new Dictionary<string, GamePadTipsAction>();

	private List<GamePadTipsAction> _tipsActions;

	public CharacterView CharacterView { get; private set; }

	public int Depth => 2;

	public ICharacterSubView lastSubView { get; set; }

	public CharacterViewScene.CvSceneType SceneType => CharacterViewScene.CvSceneType.Level;

	public IReadOnlyList<RelativeSkillItem> RelativeSkillItems => relativeSkillItems;

	public new object Context { get; set; }

	public bool AfterAnimation
	{
		get
		{
			return _afterAnimation;
		}
		set
		{
			_afterAnimation = value;
			if (value)
			{
				((ICharacterSubView)this).SendAfterAnimationEvent();
			}
		}
	}

	public void Init(CharacterView characterView)
	{
		CharacterView = characterView;
	}

	public void ScrollToMaxLevel()
	{
		characterLevelUpPanel.ScrollToMaxLevel();
	}

	public void TriggerUpgrade()
	{
		characterLevelUpPanel.TriggerUpgrade();
	}

	public void SelectNextLevel()
	{
		characterLevelUpPanel.ScrollToNextLevel();
	}

	public void SelectPrevLevel()
	{
		characterLevelUpPanel.ScrollToPrevLevel();
	}

	private void Awake()
	{
		RelativeSkillItem[] array = relativeSkillItems;
		foreach (RelativeSkillItem relativeSkillItem in array)
		{
			relativeSkillItem.OnClickCallBack = null;
			RelativeSkillItem relativeSkillItem2 = relativeSkillItem;
			relativeSkillItem2.OnClickCallBack = (UnityAction)Delegate.Combine(relativeSkillItem2.OnClickCallBack, (UnityAction)(() =>
			{
				OnRelativeSkillItemSelected(relativeSkillItem);
			}));
		}
	}

	public void Show(int characterId, ImageAssetStation station, ICharacterSource characterSource)
	{
		AfterAnimation = false;
		_characterId = characterId;
		_station = station;
		gameObject.SetActive(value: true);
		if ((bool)animation)
		{
			animation.GetSequence("Show").OnComplete((AnimationBuilder a) =>
			{
				subViewLayer.Focus();
				AfterAnimation = true;
			}).Play();
		}
		else
		{
			AfterAnimation = true;
		}
		Refresh(characterId);
		AddEventListener();
		OnGamePadInit();
		ReBindBtnPrompt();
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>
		{
			["UI/Back"] = new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			},
			["UI/Confirm"] = new GamePadTipsAction
			{
				inputAction = "UI/Confirm",
				localizeKey = 774,
				localizeTable = "Common"
			}
		};
	}

	private void ReBindBtnPrompt()
	{
		List<GamePadTipsAction> tipsActions = _tipsActions;
		if (tipsActions == null || tipsActions.Count <= 0)
		{
			_tipsActions = new List<GamePadTipsAction>();
		}
		gamePadGroup.ClearAllPrompts();
		_tipsActions.Clear();
		_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
		_tipsActions.Add(_allInputPrompt["UI/Back"]);
		gamePadGroup.RegisterInputActions(_tipsActions);
	}

	private void AddEventListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_PlayerAttribute_Refresh, ReFreshCoinNum);
	}

	private void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_PlayerAttribute_Refresh, ReFreshCoinNum);
	}

	public void ReFreshCoinNum(BaseEventContent obj)
	{
		if (obj is PlayerAttributeChangeEvt playerAttributeChangeEvt)
		{
			bool num = playerAttributeChangeEvt.id == (int)characterLevelUpPanel.CoinItemId || playerAttributeChangeEvt.id == (int)characterLevelUpPanel.RoleExpItemId;
			bool flag = playerAttributeChangeEvt.currentNum != playerAttributeChangeEvt.lastNum;
			if (num & flag)
			{
				Refresh(_characterId, preserveSelectedLevel: true);
			}
		}
	}

	public void Hide()
	{
		costLayer.UnFocus();
		RemoveEventListener();
		characterLevelUpPanel.UnInit();
		AfterAnimation = false;
		if ((bool)animation)
		{
			animation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				gameObject.SetActive(value: false);
			}).Play();
		}
		else
		{
			gameObject.SetActive(value: false);
		}
	}

	public void Freeze()
	{
		gameObject.SetActive(value: false);
	}

	public void UnFreeze(int characterId)
	{
		gameObject.SetActive(value: true);
	}

	public void OnSelectCharacter(ICharacterSource characterSource)
	{
		_characterId = characterSource.Id();
		Refresh(characterSource.Id());
	}

	private void Refresh(int characterId, bool preserveSelectedLevel = false)
	{
		Character bagCharacter = G.localPlayer.GetBagCharacter(characterId);
		int characterLevel = CoreUtils.GetData(SystemUnlockManager.playerLevel, RuntimeConfigs.data.playerLevelDatas).characterLevel;
		int normalSelectLevel = ((preserveSelectedLevel && characterLevelUpPanel.IsInitialized) ? characterLevelUpPanel.SelectedLevel : Model<GuideModel>.Interface.GetCharacterTargetLevel());
		int itemEnoughLevel = CalculationCurrentItemEnoughLevel(bagCharacter.Level, characterLevel, characterId);
		characterLevelUpPanel.Init(new CharacterLevelUpPanelData(1, characterLevel, bagCharacter.Level, 1, CoreUtils.GetData(_characterId, RuntimeConfigs.data.entityCharacterDatas).characterPorpertyAdd, RuntimeConfigs.data.playerLevelDatas.Last().Value.characterLevel, _station, itemEnoughLevel, _characterId, normalSelectLevel));
		UpdateRelativeSkillItems();
	}

	private int CalculationCurrentItemEnoughLevel(int currentLevel, int maxLevel, int characterId)
	{
		Character bagCharacter = G.localPlayer.GetBagCharacter(characterId);
		int result = currentLevel;
		int countById = G.localPlayer.GetCountById((int)characterLevelUpPanel.RoleExpItemId);
		int countById2 = G.localPlayer.GetCountById((int)characterLevelUpPanel.CoinItemId);
		for (int i = currentLevel + 1; i <= maxLevel; i++)
		{
			int num = 0;
			int num2 = 0;
			int exp = bagCharacter.Exp;
			int xpTotal = RuntimeConfigs.data.entityCharacterXPDatas[bagCharacter.GetCharacterXpId()].xpTotal;
			num = RuntimeConfigs.data.entityCharacterXPDatas[bagCharacter.GetCharacterXpId(i)].xpTotal - xpTotal - exp;
			num2 = Mathf.CeilToInt((float)num / RuntimeConfigs.data.game.expToCoinData);
			if (countById >= num && countById2 >= num2)
			{
				result = i;
			}
		}
		return result;
	}

	private void UpdateRelativeSkillItems()
	{
		EntityCharacterData data = CoreUtils.GetData(_characterId, RuntimeConfigs.data.entityCharacterDatas);
		if (data == null)
		{
			return;
		}
		int[] skillGroupIds = data.skillGroupIds;
		int num = 0;
		int[] array = skillGroupIds;
		foreach (int num2 in array)
		{
			if (CoreUtils.GetData(num2, RuntimeConfigs.data.skillGroupDatas).skillType == 12)
			{
				RelativeSkillItem obj = relativeSkillItems[num++];
				obj.skillGroupId = num2;
				obj.Character = G.localPlayer.GetBagCharacter(_characterId);
				obj.Init();
			}
		}
		relativeToggleGroup.SetAllToggleOff();
	}

	private void OnRelativeSkillItemSelected(RelativeSkillItem target)
	{
		if ((bool)target)
		{
			GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.Skill_TalentNode_Click);
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SKILLUNLOCK, new SkillUnlockViewData
			{
				Character = G.localPlayer.GetBagCharacter(_characterId),
				SkillGroupID = target.skillGroupId
			});
		}
	}
}
