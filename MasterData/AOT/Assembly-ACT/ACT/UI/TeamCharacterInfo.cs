using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class TeamCharacterInfo : MonoBehaviour
{
	[Header("角色职业")]
	public CharacterProfessionIcon professionImage;

	public LocalizeStringEvent characterNameLocalize;

	public TextMeshProUGUI levelNumberText;

	public GameObject trialLogo;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	[SerializeField]
	private TextMeshProUGUI _indexText;

	[SerializeField]
	[Header("角色战斗编队体系")]
	private CharacterOverTagtem[] _characterOverTagtems;

	[SerializeField]
	[Header("角色风格")]
	private CharacterMannerItem _mannerItem;

	[SerializeField]
	private OperateBtnPrompt _operateBtnPrompt;

	private const string ShowAni = "Show";

	public int CharacterId { get; private set; }

	public void Init(Character character, int index, ImageAssetStation station, TeamViewSubControllerType controllerType)
	{
		CharacterId = character.Id;
		EntityCharacterData data = CoreUtils.GetData(character.Id, RuntimeConfigs.data.entityCharacterDatas);
		int[] characterTagGroup = data.characterTagGroup;
		int mannerType = data.mannerType;
		_mannerItem.Init(station, mannerType);
		professionImage.UpdateDisPlay(character.Id);
		for (int i = 0; i < _characterOverTagtems.Length; i++)
		{
			CharacterOverTagtem characterOverTagtem = _characterOverTagtems[i];
			characterOverTagtem.gameObject.SetActive(i < characterTagGroup.Length);
			if (i < characterTagGroup.Length)
			{
				characterOverTagtem.Init(characterTagGroup[i]);
				characterOverTagtem.BtnClick.SetBtnClick(() =>
				{
					Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERTAGDETAILS, new CharacterTagDetailsViewData
					{
						characterId = character.Id
					});
				});
			}
		}
		characterNameLocalize.StringReference.TableEntryReference = RuntimeConfigs.data.entityDatas[character.Id].nameLocal;
		levelNumberText.SetText("{0:0}", G.localPlayer.GetBagCharacter(character.Id).Level);
		trialLogo.gameObject.SetActive(character.IsTrailCharacter);
		_indexText.gameObject.SetActive(index != -1);
		_indexText.SetText("{0:00}", index + 1);
		SetOperateBtnPromptActive(controllerType == TeamViewSubControllerType.CharacterBag);
	}

	public void UnInit()
	{
		CharacterId = 0;
		SetOperateBtnPromptActive(active: false);
		_betterAnimation.GetSequence("Show").Goto(0f);
	}

	public void SetOperateBtnPromptActive(bool active)
	{
		_operateBtnPrompt?.SetVisible(active);
	}

	public void Active(bool active)
	{
		if (active)
		{
			gameObject.SetActive(value: true);
			_betterAnimation.GetSequence("Show").Play();
		}
		else
		{
			SetOperateBtnPromptActive(active: false);
			_betterAnimation.GetSequence("Show").Goto(0f);
		}
	}
}
