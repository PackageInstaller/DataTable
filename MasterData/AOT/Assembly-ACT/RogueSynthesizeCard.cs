using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

public class RogueSynthesizeCard : MonoBehaviour
{
	public GameObject GoNull;

	public GameObject GoNormal;

	public LocalizeStringEvent TextTrigger;

	public GameObject GoSelect;

	public Transform TfEffectDes;

	public GameObject TextEffect;

	public Button BtnClick;

	public RogueCard RogueCard;

	public List<GameObject> Gorarity;

	public void Init(RogueCard CardData)
	{
		RogueCard = CardData;
		SetState(isNormal: true);
		RogueTriggerCard data = CoreUtils.GetData(CardData.triggerId, RuntimeConfigs.data.rogueTriggerCards);
		TextTrigger.StringReference.TableEntryReference = data.trigger;
		CreateTextEffect(CardData.effects);
		GoSelect.SetActive(value: false);
		for (int i = 0; i < Gorarity.Count; i++)
		{
			Gorarity[i].SetActive(CardData.rarity - 1 == i);
		}
	}

	public void CreateTextEffect(List<int> _list)
	{
		if (TfEffectDes.childCount > 0)
		{
			TfEffectDes.DestroyChildren();
		}
		for (int i = 0; i < _list.Count; i++)
		{
			LocalizeStringEvent localizeStringEvent = UIUtility.AddWidget<LocalizeStringEvent>(TfEffectDes, TextEffect);
			RogueEffectCard data = CoreUtils.GetData(_list[i], RuntimeConfigs.data.rogueEffectCards);
			localizeStringEvent.StringReference.TableEntryReference = data.desc;
		}
	}

	public void Rest()
	{
		SetState(isNormal: false);
	}

	public void SetState(bool isNormal)
	{
		GoNull.SetActive(!isNormal);
		GoNormal.SetActive(isNormal);
	}
}
