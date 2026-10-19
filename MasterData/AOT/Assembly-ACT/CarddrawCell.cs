using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

public class CarddrawCell : MonoBehaviour
{
	public int GaChaId;

	public LocalizeStringEvent TextGachaName;

	public GameObject GoSelect;

	public GameObject GoLimitUp;

	public GameObject LimitGuaranteed;

	public GameObject GoResident;

	public BImage ImageGaChaIcon;

	public ActButton BtnClick;

	public RedDotItem _RedDotItem;

	public GaChaPoolType type;

	public Image ImageLine;

	public List<Sprite> ListImgeline;

	public BetterAnimation betterAnimation;

	private bool _isSelected;

	private void Start()
	{
	}

	public void Init(Gacha data, GaChaPoolType type, ImageAssetStation _station)
	{
		GaChaId = data.id;
		this.type = type;
		GachaDisplay data2 = CoreUtils.GetData(GaChaId, RuntimeConfigs.data.gachaDisplays);
		TextGachaName.StringReference.TableReference = LocalizationUtility.localizeTableName_shortcommon;
		TextGachaName.StringReference.TableEntryReference = data.gachaName;
		if (data2 != null)
		{
			_station.LoadImage(150, data2.bannerPic, ImageGaChaIcon);
		}
		GoLimitUp.SetActive(type == GaChaPoolType.Limitup);
		GoResident.SetActive(value: false);
		LimitGuaranteed.SetActive(type == GaChaPoolType.LimitGuranteed);
		string text = RedDotPathDefine.GaCha + $"|{data.id}";
		if (text != "")
		{
			_RedDotItem.fullPath = text.Split("|").ToList();
			_RedDotItem.BindTrieNode();
			_RedDotItem.UpdateDisplay();
		}
		if (data.gachaType <= ListImgeline.Count)
		{
			ImageLine.sprite = ListImgeline[data.gachaType - 1];
		}
	}

	public void SetSelected(bool isSelected, bool playInstantly = false)
	{
		if (_isSelected != isSelected)
		{
			_isSelected = isSelected;
			if (GoSelect != null)
			{
				GoSelect.SetActive(_isSelected);
			}
			if (!(betterAnimation == null))
			{
				string animationName;
				if (playInstantly)
				{
					animationName = (_isSelected ? "SelectedShow" : "NormalShow");
				}
				else
				{
					animationName = (_isSelected ? "Selected" : "Normal");
				}
				betterAnimation.GetSequence(animationName)?.Play();
			}
		}
	}

	private void Update()
	{
	}
}
