using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class CharacterTrialTipsView : BaseUIView<CharacterTrialTipsViewController>
{
	private CharacterTrialTipsViewData m_data;

	public BImage CharacterIcon;

	public CharacterProfessionIcon CharacterProfessionIcon;

	public BImage CharacterQulity;

	public TextMeshProUGUI CharacterName;

	public CharacterMannerItem CharacterMannerItem;

	public List<CharacterOverTagtem> CharacterOverTagtems;

	public GameObject Page1;

	[SerializeField]
	private ActButton _nextPageBtn;

	public GameObject Page2;

	[SerializeField]
	public ActButton _previourPageBtn;

	[SerializeField]
	public ActButton _startTrialBtn;

	[SerializeField]
	public ActButton _closeBtn;

	[SerializeField]
	public CharacterTrialTipsItem _characterTrialTipsItem;

	public RectTransform CharacterTrialTipsItemParent;

	private ScrollRect _characterTrialTipsScrollRect;

	public GameObject GamepadTipsRoot;

	private Dictionary<string, object> _promptTMPVariables;

	private StringBuilder _bindingKeyNameBuilder;

	private int characterId;

	private int _curPage;

	private bool _hasSecondPage;

	private List<CharacterTrialTipsItem> _characterTrialTipsItems = new List<CharacterTrialTipsItem>();

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		_nextPageBtn.SetBtnClick(OnClickNextPageBtnHandle);
		_previourPageBtn.SetBtnClick(OnClickPreviourPageBtnHandle);
		_startTrialBtn.SetBtnClick(OnClickStartTrialBtnHandle);
		_closeBtn.SetBtnClick(Close);
	}

	protected override void Init()
	{
		base.Init();
		_promptTMPVariables = DictionaryPool<string, object>.Get();
		_bindingKeyNameBuilder = new StringBuilder();
		m_data = uiViewData as CharacterTrialTipsViewData;
		characterId = RuntimeConfigs.data.entityCharacterProbations[m_data.characterId].characterId;
		_curPage = 1;
		RefreshCharcterInfo();
		RefreshPage(1);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		_nextPageBtn.OnClick.RemoveAllListeners();
		_previourPageBtn.OnClick.RemoveAllListeners();
		_startTrialBtn.OnClick.RemoveAllListeners();
		_closeBtn.OnClick.RemoveAllListeners();
		DictionaryPool<string, object>.Release(_promptTMPVariables);
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BATTLEMAIN);
	}

	private void OnClickNextPageBtnHandle()
	{
		RefreshPage(2);
	}

	private void OnClickPreviourPageBtnHandle()
	{
		RefreshPage(1);
	}

	private void OnClickStartTrialBtnHandle()
	{
		Close();
	}

	public void RefreshCharcterInfo()
	{
		EntityCharacterData entityCharacterData = RuntimeConfigs.data.entityCharacterDatas[characterId];
		EntityData entityData = RuntimeConfigs.data.entityDatas[characterId];
		Station.LoadImage(195, characterId, CharacterIcon);
		Station.LoadImage(176, entityCharacterData.stars, CharacterQulity);
		CharacterName.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, entityData.nameLocal);
		CharacterProfessionIcon.UpdateDisPlay(characterId);
		CharacterMannerItem.Init(Station, entityCharacterData.mannerType);
		int[] characterTagGroup = entityCharacterData.characterTagGroup;
		for (int i = 0; i < CharacterOverTagtems.Count; i++)
		{
			CharacterOverTagtems[i].gameObject.SetActive(characterTagGroup.Length > i);
			if (characterTagGroup.Length > i)
			{
				CharacterOverTagtems[i].Init(characterTagGroup[i]);
				CharacterOverTagtems[i].BtnClick.SetBtnClick(() =>
				{
					Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERTAGDETAILS, new CharacterTagDetailsViewData
					{
						characterId = characterId
					});
				});
			}
		}
	}

	public void RefreshPage(int page)
	{
		Dictionary<int, EntityCharacterProbationMessage> dictionary = new Dictionary<int, EntityCharacterProbationMessage>();
		int num = 0;
		foreach (KeyValuePair<int, EntityCharacterProbationMessage> entityCharacterProbationMessage in RuntimeConfigs.data.entityCharacterProbationMessages)
		{
			if (entityCharacterProbationMessage.Value.characterId == characterId)
			{
				dictionary.Add(num, entityCharacterProbationMessage.Value);
				num++;
			}
		}
		_hasSecondPage = HasPageContent(dictionary, 2);
		if (page == 2 && !_hasSecondPage)
		{
			page = 1;
		}
		_curPage = page;
		Page1.SetActive(page == 1 && _hasSecondPage);
		Page2.SetActive(page == 2 || !_hasSecondPage);
		_previourPageBtn.gameObject.SetActive(_hasSecondPage);
		_startTrialBtn.gameObject.SetActive(page == 2 || !_hasSecondPage);
		for (int i = 0; i < _characterTrialTipsItems.Count; i++)
		{
			_characterTrialTipsItems[i].gameObject.SetActive(value: false);
		}
		if (dictionary.Count <= 0)
		{
			ResetCharacterTrialTipsScrollPosition();
			return;
		}
		int num2 = 0;
		for (int j = 0; j < dictionary.Count; j++)
		{
			if ((page != 1 || dictionary[j].title1 > 0) && (page != 2 || dictionary[j].title2 > 0))
			{
				if (page == 1)
				{
					int skillId = ((dictionary[j].showIcon1.Length != 0) ? dictionary[j].showIcon1[0] : 0);
					CreateCharacterTrialTipsItem(num2, dictionary[j].title1, skillId, dictionary[j].showText1, dictionary[j].actionPrompt1);
				}
				else
				{
					int skillId2 = ((dictionary[j].showIcon2.Length != 0) ? dictionary[j].showIcon2[0] : 0);
					CreateCharacterTrialTipsItem(num2, dictionary[j].title2, skillId2, dictionary[j].showText, dictionary[j].actionPrompt2);
				}
				num2++;
			}
		}
		LayoutRebuilder.ForceRebuildLayoutImmediate(CharacterTrialTipsItemParent);
		ResetCharacterTrialTipsScrollPosition();
	}

	private bool HasPageContent(Dictionary<int, EntityCharacterProbationMessage> messageDic, int page)
	{
		for (int i = 0; i < messageDic.Count; i++)
		{
			if (page == 1 && messageDic[i].title1 > 0)
			{
				return true;
			}
			if (page == 2 && messageDic[i].title2 > 0)
			{
				return true;
			}
		}
		return false;
	}

	private void ResetCharacterTrialTipsScrollPosition()
	{
		if (_characterTrialTipsScrollRect == null)
		{
			_characterTrialTipsScrollRect = CharacterTrialTipsItemParent.GetComponentInParent<ScrollRect>();
		}
		if (!(_characterTrialTipsScrollRect == null))
		{
			_characterTrialTipsScrollRect.StopMovement();
			Canvas.ForceUpdateCanvases();
			_characterTrialTipsScrollRect.verticalNormalizedPosition = 1f;
			_characterTrialTipsScrollRect.horizontalNormalizedPosition = 0f;
		}
	}

	private void CreateCharacterTrialTipsItem(int index, int titleLocalizeId, int skillId, int descLocalizeId, string[] actionPrompts)
	{
		CharacterTrialTipsItem characterTrialTipsItem = null;
		if (index >= _characterTrialTipsItems.Count)
		{
			characterTrialTipsItem = Object.Instantiate(_characterTrialTipsItem, CharacterTrialTipsItemParent);
			characterTrialTipsItem.gameObject.SetActive(value: true);
			_characterTrialTipsItems.Add(characterTrialTipsItem);
		}
		else
		{
			characterTrialTipsItem = _characterTrialTipsItems[index];
			characterTrialTipsItem.gameObject.SetActive(value: true);
		}
		characterTrialTipsItem.RefreshUI(titleLocalizeId, skillId, descLocalizeId, actionPrompts, Station);
		characterTrialTipsItem.InternalOnInputDeviceChange(MonoECS.instance.InputMode);
	}

	public void OnControllerActivate()
	{
		OnInputDeviceChange(MonoECS.instance.InputMode);
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		GamepadTipsRoot.SetActive(type == DeviceInputMode.Gamepad);
	}

	public void SwitchPageLeft()
	{
		if (_hasSecondPage && _previourPageBtn.gameObject.activeSelf && _previourPageBtn.IsInteractable())
		{
			_previourPageBtn.OnSubmit(null);
		}
	}

	public void SwitchPageRight()
	{
		if (_hasSecondPage && _nextPageBtn.gameObject.activeSelf && _nextPageBtn.IsInteractable())
		{
			_nextPageBtn.OnSubmit(null);
		}
	}

	public void OnConfirm()
	{
		if (_startTrialBtn.gameObject.activeSelf && _startTrialBtn.IsInteractable() && (!_hasSecondPage || _curPage == 2))
		{
			_startTrialBtn.OnSubmit(null);
		}
	}

	public void OnSelect()
	{
		if (CharacterOverTagtems.Count > 0)
		{
			CharacterOverTagtems[0].BtnClick.OnSubmit(null);
		}
	}
}
