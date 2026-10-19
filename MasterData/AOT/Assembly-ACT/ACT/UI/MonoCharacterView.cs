using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Sound;
using Bamboo.Chronos;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoCharacterView : BaseUIView
{
	public MonoScrollBagComponent charactersVertical;

	public MonoScrollBagComponent charactersVerticalDetail;

	public CharacterIconsGrid charactersGrid;

	public GameObject settingGroup;

	private List<Character> m_Character;

	public GameObject commonWeaponBag;

	public GameObject GoAttributePanel;

	public Button BtnWeapon;

	public Button BtnSkill;

	public Button BtnChip;

	public CharacterRightBase[] characterBases;

	public Character curCharacter;

	private int m_curPageIndex;

	private int JumpPageIndex;

	private int lastpageindex = -1;

	private static readonly int Selected = Animator.StringToHash("Selected");

	private static readonly int Normal = Animator.StringToHash("Normal");

	public CommonWeaponBag cwb;

	public List<TabToggle> tabToggles;

	private CancellationTokenSource m_cts;

	private CancellationTokenSource cts = new CancellationTokenSource();

	public BImage character_element;

	public BImage character_profession;

	public GameObject GoBookmark;

	public GameObject BtnDisPlayModelShow;

	public GameObject BtnDisPlayModelHide;

	public GameObject GoBtnClose;

	public GameObject GoBtnReturn;

	public GameObject GoBtnDisPlayReturn;

	private MonoCharacterViewData m_Data;

	public int CurrentPageIndex => m_curPageIndex;

	private void Awake()
	{
		charactersVertical.gameObject.SetActive(value: false);
		charactersVerticalDetail.gameObject.SetActive(value: false);
		charactersGrid.gameObject.SetActive(value: false);
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		for (int i = 0; i < characterBases.Length; i++)
		{
			characterBases[i].AddEventListener();
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Character_LevelUp, OnCharacterLevelUp);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Character_HideTab, OnHideTab);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Character_ShowTab, OnShowTab);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		for (int i = 0; i < characterBases.Length; i++)
		{
			characterBases[i].RemoveEventListener();
		}
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Character_LevelUp, OnCharacterLevelUp);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Character_HideTab, OnHideTab);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Character_ShowTab, OnShowTab);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("ShowNew").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("HideNew").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_cts = new CancellationTokenSource();
		JumpPageIndex = 0;
		m_Data = uiViewData as MonoCharacterViewData;
		if (m_Data != null && m_Data.PageIndex != -1)
		{
			JumpPageIndex = m_Data.PageIndex;
		}
		else
		{
			m_curPageIndex = 0;
		}
		await Singleton<NewUIManager>.instance.BlackLoad.Enable();
		await UICharacterScene.LoadPrefab();
		UICharacterScene.Push();
		m_Character = ListPool<Character>.Get();
		InitScence();
		EntityCharacterData entityCharacterData = RuntimeConfigs.data.entityCharacterDatas[curCharacter.Id];
		Singleton<GameManager>.instance.audioManager.PlaySound(entityCharacterData.viewSound, new AudioPlayOptions
		{
			attachTarget = transform
		});
		for (int i = 0; i < characterBases.Length; i++)
		{
			characterBases[i].parentUi = this;
		}
		CharacterRightBase[] array = characterBases;
		for (int j = 0; j < array.Length; j++)
		{
			array[j].UnLoad();
		}
		await Singleton<NewUIManager>.instance.BlackLoad.Disable();
		if (JumpPageIndex != 0)
		{
			SelectPage(JumpPageIndex);
		}
		else
		{
			UICharacterScene.instance.DIsableAnimatorUpdate = true;
			SelectPage(m_curPageIndex);
		}
		int element = CoreUtils.GetData(curCharacter.Id, RuntimeConfigs.data.entityDatas).element;
		int characterDamageType = CoreUtils.GetData(curCharacter.Id, RuntimeConfigs.data.entityCharacterDatas).characterDamageType;
		Station.LoadSprite(GameLoader.meta.elementAssetID, element, character_element);
		Station.LoadSprite(GameLoader.meta.professionAssetID, characterDamageType, character_profession);
	}

	protected override void Init()
	{
		base.Init();
		InitCharacterIcon();
		InitToggles();
	}

	public void InitToggles()
	{
		for (int i = 0; i < tabToggles.Count; i++)
		{
			TabToggle tabToggle = tabToggles[i];
			bool isSelect = ((JumpPageIndex != 0) ? (JumpPageIndex == i) : (m_curPageIndex == i));
			tabToggle.InitToggle(isSelect, OnChangeValue, new TabToggleParam
			{
				pointerClickActionParam = i
			});
		}
	}

	private void OnCharacterLevelUp(BaseEventContent obj)
	{
		charactersVertical.OnSortTypeChange();
	}

	private void OnHideTab(BaseEventContent obj)
	{
		betterAnimation.GetSequence("HideNew").Play();
	}

	private void OnShowTab(BaseEventContent obj)
	{
		betterAnimation.GetSequence("ShowNew").Play();
	}

	private void InitScence()
	{
		InitCharacters();
	}

	protected override void OpenEffectCallback()
	{
		foreach (TabToggle tabToggle in tabToggles)
		{
			tabToggle.BindOnValueChanged();
		}
	}

	protected override void UnInit()
	{
		base.UnInit();
		charactersVertical.UnInit();
		charactersVerticalDetail.UnInit();
		character_profession.UnLoad();
		character_element.UnLoad();
	}

	protected override void CloseEffectCallback()
	{
		cts?.Cancel();
		base.CloseEffectCallback();
		OnBtnPageChange(0);
		CharacterRightBase[] array = characterBases;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].UnLoad();
		}
		curCharacter = null;
		charactersVertical.gameObject.SetActive(value: false);
		charactersVerticalDetail.gameObject.SetActive(value: false);
		charactersGrid.UnInit();
		ListPool<Character>.Release(m_Character);
		m_Character = null;
	}

	protected override void CloseComplete()
	{
		UICharacterScene.Pop();
	}

	public async void OpenToBackUI()
	{
		await Singleton<NewUIManager>.instance.BlackLoad.Enable();
		await CloseAsync();
		Singleton<NewUIManager>.instance.BlackLoad.Disable();
	}

	public override async void Close()
	{
		await Singleton<NewUIManager>.instance.BlackLoad.Enable();
		await CloseAsync();
	}

	public async void OpenBattleMain()
	{
		await Singleton<NewUIManager>.instance.BlackLoad.Enable();
		UIOpenResult openUIResult = Singleton<NewUIManager>.instance.BackToBattleMain();
		await Singleton<NewUIManager>.instance.WaitUIOpenAsync(openUIResult);
		Singleton<NewUIManager>.instance.BlackLoad.Disable();
	}

	private void InitCharacters()
	{
		m_Character.AddRange(CharacterDataHelper.GetCurAllCharacters());
		int characterId = ((m_Data != null && m_Data.defaultCharacterId != -1) ? m_Data.defaultCharacterId : MonoECS.instance.mainEntity.GetCompCharacter().characterSource.Id());
		curCharacter = G.localPlayer.GetCharacter(characterId);
		m_Character.Sort((Character x, Character y) =>
		{
			RepeatedField<int> characterIds = G.localPlayer.teamInfo.PresetTeams[G.localPlayer.teamInfo.MainTeamIdx].CharacterIds;
			int num = characterIds.IndexOf(x.Id);
			int num2 = characterIds.IndexOf(y.Id);
			return num - num2;
		});
	}

	private async void InitCharacterIcon()
	{
		charactersVertical.gameObject.SetActive(value: true);
		charactersVerticalDetail.gameObject.SetActive(value: false);
		charactersGrid.gameObject.SetActive(value: false);
		int num = m_Character.IndexOf(curCharacter);
		MonoScrollBagComponent.Param myParam = new MonoScrollBagComponent.Param
		{
			allItems = 
			{
				characters = m_Character
			},
			paramType = MonoScrollBagComponent.ParamType.SimpleCharacter,
			sortType = MonoScrollBagComponent.SortType.Character,
			onSelectItem = (ItemUIComponentBase itemBase) =>
			{
				ItemUIComponent itemUIComponent = itemBase as ItemUIComponent;
				if (itemUIComponent.anim.isActiveAndEnabled)
				{
					itemUIComponent.anim.Play("Select");
				}
				OnChooseCharacter(itemUIComponent.character);
				itemUIComponent.anim.SetBool("Switch", value: true);
			},
			onUnSelectItem = (ItemUIComponentBase itemBase) =>
			{
				(itemBase as ItemUIComponent).anim.Play("NormalExchange");
			}
		};
		int num2 = 0;
		foreach (int characterId in G.localPlayer.teamInfo.PresetTeams[G.localPlayer.teamInfo.MainTeamIdx].CharacterIds)
		{
			if (characterId != 0)
			{
				num2++;
			}
		}
		charactersVertical.Init(myParam, num, -1, num2);
		charactersVertical.InitSortDropDown(MonoScrollBagComponent.SortType.Character);
		myParam = new MonoScrollBagComponent.Param
		{
			allItems = 
			{
				characters = m_Character
			},
			paramType = MonoScrollBagComponent.ParamType.DetailedCharacter,
			sortType = MonoScrollBagComponent.SortType.Character,
			onSelectItem = (ItemUIComponentBase component) =>
			{
				if (component.gameObject.activeInHierarchy)
				{
					OnChooseCharacter(component.ItemUnifier.As<Character>());
				}
			}
		};
		charactersVerticalDetail.Init(myParam, num, -1, num2);
		charactersVerticalDetail.InitSortDropDown(MonoScrollBagComponent.SortType.Character);
		myParam = new MonoScrollBagComponent.Param
		{
			allItems = 
			{
				characters = m_Character
			},
			paramType = MonoScrollBagComponent.ParamType.DetailedCharacter,
			sortType = MonoScrollBagComponent.SortType.Character,
			onSelectItem = (ItemUIComponentBase component) =>
			{
				if (component.gameObject.activeInHierarchy)
				{
					OnChooseCharacter(component.ItemUnifier.As<Character>());
				}
			}
		};
		charactersGrid.Init(myParam, num, -1);
		settingGroup.SetActive(value: false);
	}

	public void OnChooseCharacter(Character character)
	{
		if (curCharacter != character && (bool)UICharacterScene.instance)
		{
			curCharacter = character;
			int element = CoreUtils.GetData(character.Id, RuntimeConfigs.data.entityDatas).element;
			int characterDamageType = CoreUtils.GetData(character.Id, RuntimeConfigs.data.entityCharacterDatas).characterDamageType;
			Station.LoadSprite(GameLoader.meta.elementAssetID, element, character_element);
			Station.LoadSprite(GameLoader.meta.professionAssetID, characterDamageType, character_profession);
			CharacterChangeEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterChangeEvt>();
			evt.c = curCharacter;
			evt.curPageIndex = m_curPageIndex;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Character_ChangeCharacter, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	public void OnChangeValue(int index)
	{
		charactersVertical.gameObject.SetActive(index != 4);
		GoBookmark.SetActive(index != 0 && index != 4);
		OnBtnPageChange(index);
	}

	public void OnBtnClcik(int index)
	{
		Singleton<NewUIManager>.instance.CharacterFullScreenAni.Open();
		UpdateTimer.Default.DelayMs(100, () =>
		{
			charactersVertical.gameObject.SetActive(index != 4);
			GoBookmark.SetActive(index != 0 && index != 4);
			OnBtnPageChange(index);
			if (index < tabToggles.Count)
			{
				tabToggles[index].isOn = true;
			}
		});
	}

	public void OnLevelUp()
	{
		Singleton<NewUIManager>.instance.CharacterFullScreenAni.Open();
		GoBookmark.SetActive(value: false);
		OnBtnPageChange(5);
	}

	public void OnBtnPageChange(int index)
	{
		GoBtnReturn.SetActive(index != 4);
		GoBtnDisPlayReturn.SetActive(index == 4);
		UICharacterScene.instance.CharacterBoard.gameObject.SetActive(index == 0);
		if (index != m_curPageIndex || index == 0)
		{
			int curPageIndex = m_curPageIndex;
			m_curPageIndex = index;
			lastpageindex = index;
			m_cts.Cancel();
			m_cts.Dispose();
			m_cts = new CancellationTokenSource();
			if (curPageIndex != -1)
			{
				characterBases[curPageIndex].PlayCloseAnim(m_cts.Token);
				characterBases[curPageIndex].CloseBagPanel();
				characterBases[curPageIndex].gameObject.SetActive(value: false);
			}
			CharacterPageChangeEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterPageChangeEvt>();
			evt.token = m_cts.Token;
			evt.currentPageIndex = index;
			evt.character = curCharacter;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Character_ChangePage, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	public void OnShowTypeChange()
	{
		charactersVertical.SetSelectedCharacter(curCharacter);
		charactersVerticalDetail.SetSelectedCharacter(curCharacter);
		charactersGrid.SetSelectedCharacter(curCharacter);
	}

	public async void ChangeCharacterList(bool value)
	{
		charactersVertical.gameObject.SetActive(!value);
		charactersVerticalDetail.gameObject.SetActive(value);
		if (!value)
		{
			await cwb.Close();
		}
		else
		{
			cwb.PlayCellAnimationByRow();
		}
	}

	public void Return()
	{
		if (m_curPageIndex != 0)
		{
			Singleton<NewUIManager>.instance.CharacterFullScreenAni.Open();
			UpdateTimer.Default.DelayMs(100, () =>
			{
				tabToggles[0].isOn = true;
				OnChangeValue(0);
			});
		}
		else
		{
			Close();
		}
	}

	private void SelectPage(int index)
	{
		switch (index)
		{
		case 0:
			OnChangeValue(index);
			break;
		case 1:
			Weapon();
			break;
		case 2:
			Chip();
			break;
		case 3:
			Skill();
			break;
		case 4:
			DisplayModel();
			break;
		case 5:
			LevelUp();
			break;
		case 6:
			Destiny();
			break;
		}
	}

	public void Weapon()
	{
		OnBtnClcik(1);
	}

	public void Skill()
	{
		OnBtnClcik(3);
	}

	public void Chip()
	{
		OnBtnClcik(2);
	}

	public void DisplayModel()
	{
		OnBtnClcik(4);
	}

	public void LevelUp()
	{
		OnLevelUp();
	}

	public void Destiny()
	{
		OnBtnClcik(6);
	}

	public void DisPlayModelShow(bool isshow)
	{
		BtnDisPlayModelShow.SetActive(!isshow);
		GoBtnClose.SetActive(isshow);
		GoBtnDisPlayReturn.SetActive(isshow);
		BtnDisPlayModelHide.SetActive(isshow);
	}
}
