using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class SevenDaySignInFixedItem : MonoBehaviour
{
	public bool useAnimation;

	public Animator uiEffectAnimator;

	public BetterAnimation betterAnimation;

	public Image IconAtlasImage;

	public Image BuffAtlasImage1;

	public CharacterProfessionIcon ProfessionIcon;

	public GameObject Fixed;

	public TextMeshProUGUI Name;

	public GameObject Select;

	public GameObject SelectHandle;

	public List<SevenDaySignIn.SpriteInfo> SpriteInfos;

	public List<Sprite> Attributes;

	public List<Sprite> Occupations;

	public Button ItemButton;

	public CanvasGroup CanvasGroup;

	public TextMeshProUGUI TipsDesc;

	private Action<int> _callBack;

	private ActCharacterData _actCharacterData;

	public void RefreshUI(ActCharacterData actCharacterData, int fixedCharacterId, Action<int> callBack)
	{
		ItemButton.SetBtnClick(OnClickItemButtonHandle, "event:/UI/Interface/Activity/Choise");
		if (actCharacterData == null)
		{
			return;
		}
		_actCharacterData = actCharacterData;
		_callBack = callBack;
		for (int i = 0; i < SpriteInfos.Count; i++)
		{
			if (SpriteInfos[i].CharaterId == actCharacterData.id)
			{
				IconAtlasImage.sprite = SpriteInfos[i].Sprite;
				break;
			}
		}
		EntityData data = CoreUtils.GetData(actCharacterData.id, RuntimeConfigs.data.entityDatas);
		BuffAtlasImage1.sprite = Occupations[data.element - 1];
		EntityCharacterData data2 = CoreUtils.GetData(actCharacterData.id, RuntimeConfigs.data.entityCharacterDatas);
		ProfessionIcon.UpdateDisPlay(data2.id);
		Fixed.SetActive(actCharacterData.id == fixedCharacterId);
		Name.text = actCharacterData.name;
		Select.SetActive(value: false);
		if (actCharacterData.id == fixedCharacterId)
		{
			OnClickItemButtonHandle();
		}
		int id = actCharacterData.id;
		int maxCommonDestinyCount = Model<DestinyModel>.Interface.GetMaxCommonDestinyCount();
		int num = maxCommonDestinyCount - Model<DestinyModel>.Interface.GetCharacterCouldGetDestinyCostCount(id);
		if (CharacterDataHelper.GetCurCharacterRepository().Characters.ContainsKey(id))
		{
			TipsDesc.text = $"{LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2156)}：{num.ToString()}/{maxCommonDestinyCount.ToString()}";
		}
		else
		{
			TipsDesc.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2155);
		}
	}

	public void SetSelect(bool value)
	{
		Select.SetActive(value);
	}

	public void OnClickItemButtonHandle()
	{
		if (_actCharacterData != null)
		{
			_callBack?.Invoke(_actCharacterData.id);
		}
	}

	public void PlayTopOpenAnimation()
	{
		betterAnimation.GetSequence("ShowTop").Play();
	}

	public void PlayBottomOpenAnimation()
	{
		betterAnimation.GetSequence("ShowBottom").Play();
	}

	public void OnControllerStatusChange(bool isGamepad)
	{
		SelectHandle.SetActive(isGamepad);
	}
}
