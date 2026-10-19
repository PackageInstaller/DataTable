using System.Collections.Generic;
using ACT.Config;
using ACT.UI;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;

public class RogueCardSelectItem : MonoBehaviour, ISubmitHandler, IEventSystemHandler
{
	public LocalizeStringEvent TextName;

	public GameObject GoSelect;

	public Transform TfEffectDes;

	public GameObject TextEffect;

	public BImage ImageBdIcon;

	public LocalizeStringEvent TextDesc;

	public ActButton BtnClick;

	private void Start()
	{
	}

	public void Init(BdCore data, ImageAssetStation station)
	{
		TextName.StringReference.TableEntryReference = data.name;
		TextDesc.StringReference.TableEntryReference = data.description;
		station.LoadImage(196, data.iconAddress, ImageBdIcon);
	}

	public void CreateTextEffect(List<int> _list)
	{
	}

	public void RefreshSelect(bool IsSelect)
	{
		GoSelect.SetActive(IsSelect);
	}

	private void Update()
	{
	}

	public void OnSubmit(BaseEventData eventData)
	{
		if (BtnClick.interactable)
		{
			BtnClick.OnClick?.Invoke();
		}
	}
}
