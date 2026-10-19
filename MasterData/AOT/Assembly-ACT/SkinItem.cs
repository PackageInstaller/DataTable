using ACT.Config;
using ACT.Game.Data;
using ACT.UI;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Localization.Components;

public class SkinItem : MonoBehaviour
{
	public GameObject GoTag;

	public BImage SkinIcon;

	public GameObject GoSelect;

	public LocalizeStringEvent TextTime;

	public ActButton BtnClick;

	public SkinQualityComponent SkinQualityComponent;

	public Skin SkinData;

	private void Start()
	{
	}

	public void Init(Skin skindata, ImageAssetStation station, Character character)
	{
		SkinData = skindata;
		station.LoadImage(195, skindata.id, SkinIcon);
		SetSelect(isSelect: false);
		SetState(character);
		SkinQualityComponent.SetSkinQuality(skindata.skinQuality);
	}

	public void SetState(Character character)
	{
		bool active = character != null && ((character.SkinId == 0) ? (SkinData.skinType == 1) : (character.SkinId == SkinData.id));
		GoTag.SetActive(active);
	}

	public void SetSelect(bool isSelect)
	{
		GoSelect.SetActive(isSelect);
	}

	private void Update()
	{
	}
}
