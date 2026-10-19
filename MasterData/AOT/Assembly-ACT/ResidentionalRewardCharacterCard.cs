using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

public class ResidentionalRewardCharacterCard : MonoBehaviour
{
	public BImage ImageCharacterCard;

	public GameObject GoCharacterCardMask;

	public GameObject GoSelect;

	public BImage ImageQuality;

	public CharacterProfessionIcon ImageProfession;

	public LocalizeStringEvent TextName;

	public ActButton BtnClick;

	public int id;

	public GachaItem GachaItem;

	public GameObject GoNotGet;

	public GameObject GodestinyNum;

	public TextMeshProUGUI TextdestinyNum;

	public List<CharacterOverTagtem> _listTag;

	public CharacterMannerItem MannerItem;

	private ImageAssetStation _station;

	private int characterId;

	public void RefreshDestinyNum()
	{
		IList<object> list = new List<object>();
		int maxCommonDestinyCount = Model<DestinyModel>.Interface.GetMaxCommonDestinyCount();
		int num = maxCommonDestinyCount - Model<DestinyModel>.Interface.GetCharacterCouldGetDestinyCostCount(characterId);
		list.Add(num);
		list.Add(maxCommonDestinyCount.ToString());
		TextdestinyNum.text = LocalizationUtility.GetLocalizeString("Common", 2159, list);
	}

	public void Init(GachaItem item, ImageAssetStation station)
	{
		id = item.id;
		GachaItem = item;
		_station = station;
		ItemData data = CoreUtils.GetData(item.itemId, RuntimeConfigs.data.itemDatas);
		characterId = data.canBeTransited[0].id;
		EntityCharacterData data2 = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityCharacterDatas);
		EntityData data3 = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityDatas);
		if (data2 != null)
		{
			ImageProfession.UpdateDisPlay(characterId);
			MannerItem?.Init(_station, data2.mannerType);
			int[] characterTagGroup = data2.characterTagGroup;
			if (_listTag != null)
			{
				for (int i = 0; i < _listTag.Count; i++)
				{
					_listTag[i].gameObject.SetActive(characterTagGroup.Length > i);
					if (characterTagGroup.Length > i)
					{
						_listTag[i].Init(characterTagGroup[i]);
						_listTag[i].BtnClick.SetBtnClick(() =>
						{
							Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERTAGDETAILS, new CharacterTagDetailsViewData
							{
								characterId = characterId
							});
						});
					}
				}
			}
		}
		if (data3 != null)
		{
			TextName.StringReference.TableEntryReference = data3.nameLocal;
			_station.LoadImage(176, data2.stars, ImageQuality);
		}
		_station.LoadImage(149, characterId, ImageCharacterCard);
		Refresh();
	}

	public void Refresh()
	{
		if (GameUtility.CheckIsHaveCharacter(characterId))
		{
			GoNotGet.SetActive(value: false);
			GodestinyNum.SetActive(value: true);
			RefreshDestinyNum();
		}
		else
		{
			GoNotGet.SetActive(value: true);
			GodestinyNum.SetActive(value: false);
		}
	}
}
