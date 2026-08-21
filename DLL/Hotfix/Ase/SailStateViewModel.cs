using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class SailStateViewModel : OptionBase
{
	private int state;

	private List<SailHeroItemData> heroItemList;

	private List<SailHeroItemData> sailHeroItemList;

	private int selectCount;

	private float fill;

	private string successText;

	private string leftTimeText;

	private bool showHeroItemList;

	private List<HeroItemViewModel> heroItemViewModelList;

	private InteractionRequest refreshHeroItemRequest;

	private InteractionRequest selectHeroRequest;

	private InteractionRequest playAnimationRequest;

	private InteractionRequest stopAnimationRequest;

	private SailEventItemData sailEventItemData;

	private Color color;

	private int buildingLevel;

	public bool needPlayAnimation;

	public int State
	{
		get
		{
			return state;
		}
		set
		{
			Set(ref state, value, "State");
		}
	}

	public float Fill
	{
		get
		{
			return fill;
		}
		set
		{
			Set(ref fill, value, "Fill");
		}
	}

	public string SuccessText
	{
		get
		{
			return successText;
		}
		set
		{
			Set(ref successText, value, "SuccessText");
		}
	}

	public string LeftTimeText
	{
		get
		{
			return leftTimeText;
		}
		set
		{
			Set(ref leftTimeText, value, "LeftTimeText");
		}
	}

	public bool ShowHeroItemList
	{
		get
		{
			return showHeroItemList;
		}
		set
		{
			Set(ref showHeroItemList, value, "ShowHeroItemList");
		}
	}

	public List<HeroItemViewModel> HeroItemViewModelList
	{
		get
		{
			return heroItemViewModelList;
		}
		set
		{
			Set(ref heroItemViewModelList, value, "HeroItemViewModelList");
		}
	}

	public List<SailHeroItemData> HeroItemList
	{
		get
		{
			return heroItemList;
		}
		set
		{
			Set(ref heroItemList, value, "HeroItemList");
		}
	}

	public List<SailHeroItemData> SailHeroItemList
	{
		get
		{
			return sailHeroItemList;
		}
		set
		{
			Set(ref sailHeroItemList, value, "SailHeroItemList");
		}
	}

	public Color Color
	{
		get
		{
			return color;
		}
		set
		{
			Set(ref color, value, "Color");
		}
	}

	public InteractionRequest SelectHeroRequest => selectHeroRequest;

	public InteractionRequest RefreshHeroItemRequest => refreshHeroItemRequest;

	public InteractionRequest PlayAnimationRequest => playAnimationRequest;

	public InteractionRequest StopAnimationRequest => stopAnimationRequest;

	public SailStateViewModel(OptionBase parent, SailEventItemData sailEventItemData, List<int> sailingHeroId, int buildingLevel)
	{
		base.parent = parent;
		showHeroItemList = false;
		selectHeroRequest = new InteractionRequest();
		playAnimationRequest = new InteractionRequest();
		stopAnimationRequest = new InteractionRequest();
		refreshHeroItemRequest = new InteractionRequest();
		LeftTimeText = sailEventItemData.LeftTimeText;
		this.buildingLevel = buildingLevel;
		heroItemList = new List<SailHeroItemData>
		{
			new SailHeroItemData(this),
			new SailHeroItemData(this),
			new SailHeroItemData(this)
		};
		sailHeroItemList = new List<SailHeroItemData>();
		heroItemViewModelList = new List<HeroItemViewModel>();
		foreach (HeroModel item2 in Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetAllHeroData().Values.ToList())
		{
			HeroItemViewModel item = new HeroItemViewModel(this, item2);
			heroItemViewModelList.Add(item);
		}
		SetHeroSailState(sailingHeroId, value: true);
		SetInfo(sailEventItemData);
	}

	public void StopAnimation()
	{
		stopAnimationRequest.Raise();
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg && optionArg.Obj is SailHeroItemData && optionArg.OptionName.Equals("OpenHeroView"))
		{
			HeroItemViewModelList.Sort(new HeroItemSortBySail());
			refreshHeroItemRequest.Raise();
			ShowHeroItemList = true;
		}
		if (obj is HeroItemViewModel { IsChecked: false } heroItemViewModel)
		{
			if (heroItemViewModel.IsSelected)
			{
				RemoveHero(heroItemViewModel);
			}
			else if (selectCount == 3)
			{
				Toast.ShowInfo("至多可选择3位烬天使");
			}
			else
			{
				AddHero(heroItemViewModel);
			}
		}
	}

	public void PlayAnimation()
	{
		needPlayAnimation = true;
		playAnimationRequest.Raise();
	}

	public void AnimationFinish()
	{
		if (needPlayAnimation)
		{
			parent?.ItemOnClick(new OptionArg(this, "AnimationFinish"));
		}
	}

	private void AddHero(HeroItemViewModel heroItemViewModel)
	{
		for (int i = 0; i < heroItemList.Count; i++)
		{
			if (heroItemList[i].HeroId == 0)
			{
				heroItemList[i].SetHeroId(heroItemViewModel.HeroModel.Id);
				heroItemList[i].IsEmpty = false;
				heroItemViewModel.SetSelected(value: true);
				selectCount++;
				break;
			}
		}
		CountRate(heroItemViewModel.MarkValue, isAdd: true);
	}

	private void RemoveHero(HeroItemViewModel heroItemViewModel)
	{
		for (int i = 0; i < heroItemList.Count; i++)
		{
			if (heroItemList[i].HeroId == heroItemViewModel.HeroModel.Id)
			{
				heroItemList[i].SetHeroId();
				heroItemList[i].IsEmpty = true;
				heroItemViewModel.SetSelected(value: false);
				selectCount--;
				break;
			}
		}
		CountRate(heroItemViewModel.MarkValue, isAdd: false);
	}

	private float GetRateValue(HeroModel heroModel)
	{
		int id = 0;
		switch (heroModel.DestinyLevel)
		{
		case 1:
			id = 8;
			break;
		case 2:
			id = 7;
			break;
		case 3:
			id = 6;
			break;
		case 4:
			id = 5;
			break;
		case 5:
			id = 3;
			break;
		case 6:
			id = 2;
			break;
		}
		int num = 0;
		if (GameEntry.DataTable.GetDataRow<DRSailEventQualityRate>(id) != null)
		{
			num = GameEntry.DataTable.GetDataRow<DRSailEventQualityRate>(id).Odd;
		}
		int num2 = 0;
		if (heroModel.Area == sailEventItemData.DrSailEvent.Area && GameEntry.DataTable.GetDataTable<DRSailEventQualityRate>().GetDataRow(4) != null)
		{
			num2 = GameEntry.DataTable.GetDataTable<DRSailEventQualityRate>().GetDataRow(4).Odd;
		}
		int num3 = 0;
		foreach (int item in sailEventItemData.DrSailEvent.Hero)
		{
			if (item == heroModel.Id && GameEntry.DataTable.GetDataRow<DRSailEventQualityRate>(1) != null)
			{
				num3 = GameEntry.DataTable.GetDataRow<DRSailEventQualityRate>(1).Odd;
			}
		}
		return num + num3 + num2;
	}

	private void CountRate(float rate, bool isAdd)
	{
		float odd = GameEntry.DataTable.GetDataRow<DRSailLightLevel>(buildingLevel).Odd;
		if (isAdd)
		{
			Fill += rate;
			if (selectCount == 1)
			{
				Fill += odd;
			}
		}
		else
		{
			Fill -= rate;
			if (selectCount == 0)
			{
				Fill = 0f;
			}
		}
		SetText();
	}

	private void SetText()
	{
		string text = "低";
		string htmlString = "#e65d4a";
		if ((double)Fill <= 0.6 && (double)Fill > 0.3)
		{
			text = "中";
			htmlString = "#ffcd6c";
		}
		else if ((double)Fill > 0.6)
		{
			text = "高";
			htmlString = "#79e264";
		}
		ColorUtility.TryParseHtmlString(htmlString, out var color);
		Color = color;
		SuccessText = "大成功概率:" + text;
	}

	private void SetInfo(SailEventItemData sailEventItemData)
	{
		State = sailEventItemData.State;
		this.sailEventItemData = sailEventItemData;
		LeftTimeText = this.sailEventItemData.LeftTimeText;
		foreach (HeroItemViewModel heroItemViewModel in heroItemViewModelList)
		{
			heroItemViewModel.SetSelected(value: false);
		}
		selectCount = 0;
		if (State != 2)
		{
			SailHeroItemList.Clear();
			foreach (int heroId in sailEventItemData.HeroIdList)
			{
				SailHeroItemList.Add(new SailHeroItemData(this, heroId));
			}
		}
		else
		{
			for (int i = 0; i < 3; i++)
			{
				HeroItemList[i].SetHeroId();
				HeroItemList[i].IsEmpty = true;
				Fill = 0f;
				SetText();
			}
		}
		foreach (HeroItemViewModel heroItemViewModel2 in HeroItemViewModelList)
		{
			heroItemViewModel2.MarkValue = GetRateValue(heroItemViewModel2.HeroModel) / 100f;
		}
		selectHeroRequest.Raise();
	}

	public void Refresh(SailEventItemData sailEventItemData)
	{
		SetInfo(sailEventItemData);
	}

	public void SetHeroSailState(List<int> heroIdList, bool value)
	{
		foreach (int heroId in heroIdList)
		{
			foreach (HeroItemViewModel heroItemViewModel in heroItemViewModelList)
			{
				if (heroItemViewModel.HeroModel.Id == heroId)
				{
					heroItemViewModel.SetChecked(value);
					break;
				}
			}
		}
	}

	public void AutoSelect()
	{
		HeroItemViewModelList.Sort(new HeroItemSortBySail());
		selectCount = 0;
		for (int i = 0; i < 3; i++)
		{
			HeroItemList[i].SetHeroId();
			HeroItemList[i].IsEmpty = true;
			Fill = 0f;
		}
		foreach (HeroItemViewModel heroItemViewModel in HeroItemViewModelList)
		{
			if (heroItemViewModel.IsSelected)
			{
				heroItemViewModel.SetSelected(value: false);
			}
			if (!heroItemViewModel.IsChecked && selectCount < 3)
			{
				AddHero(heroItemViewModel);
			}
		}
		if (selectCount == 0)
		{
			Toast.ShowInfo("暂无可选择的烬天使");
		}
	}

	public void Confirm()
	{
		ShowHeroItemList = false;
	}

	public void HideHeroItemList()
	{
		ShowHeroItemList = false;
	}
}
