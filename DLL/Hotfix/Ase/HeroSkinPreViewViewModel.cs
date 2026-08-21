using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class HeroSkinPreViewViewModel : OptionBase
{
	private List<HeroSkinItemData> heroSkinItemList;

	private string heroName;

	private string skinName;

	private string skinDesc;

	private string skinAssetPath;

	private int heroId;

	private string _skinTagIcon = "";

	private bool isUsingCurrentSkin;

	private string pressButtonText;

	private int heroEquipSkinId;

	private HeroSkinItemData curHeroSkinData;

	private bool showPressButton;

	private string skinStateText;

	private InteractionRequest<int> switchHeroSkinRequest;

	private InteractionRequest<int> playAnimationRequest;

	private SimpleCommand pressBtnCmd;

	private int windowType;

	private string pressText = "";

	public bool IsUsingCurrentSkin
	{
		get
		{
			return isUsingCurrentSkin;
		}
		set
		{
			Set(ref isUsingCurrentSkin, value, "IsUsingCurrentSkin");
		}
	}

	public string SkinStateText
	{
		get
		{
			return skinStateText;
		}
		set
		{
			Set(ref skinStateText, value, "SkinStateText");
		}
	}

	public string HeroName
	{
		get
		{
			return heroName;
		}
		private set
		{
			Set(ref heroName, value, "HeroName");
		}
	}

	public string SkinName
	{
		get
		{
			return skinName;
		}
		private set
		{
			Set(ref skinName, value, "SkinName");
		}
	}

	public string SkinDesc
	{
		get
		{
			return skinDesc;
		}
		private set
		{
			Set(ref skinDesc, value, "SkinDesc");
		}
	}

	public string SkinAssetPath
	{
		get
		{
			return skinAssetPath;
		}
		private set
		{
			Set(ref skinAssetPath, value, "SkinAssetPath");
		}
	}

	public string SkinTagIcon
	{
		get
		{
			return _skinTagIcon;
		}
		set
		{
			Set(ref _skinTagIcon, value, "SkinTagIcon");
		}
	}

	public string PressButtonText
	{
		get
		{
			return pressButtonText;
		}
		private set
		{
			Set(ref pressButtonText, value, "PressButtonText");
		}
	}

	public bool ShowPressButton
	{
		get
		{
			return showPressButton;
		}
		private set
		{
			Set(ref showPressButton, value, "ShowPressButton");
		}
	}

	public List<HeroSkinItemData> HeroSkinItemList => heroSkinItemList;

	public InteractionRequest<int> SwitchHeroSkinRequest => switchHeroSkinRequest;

	public HeroSkinItemData CurHeroSkinData => curHeroSkinData;

	public SimpleCommand PressBtnCmd => pressBtnCmd;

	public HeroSkinPreViewViewModel(OptionBase parent, int heroId, int skinId = 0)
	{
		base.parent = parent;
		this.heroId = heroId;
		switchHeroSkinRequest = new InteractionRequest<int>();
		playAnimationRequest = new InteractionRequest<int>();
		pressBtnCmd = new SimpleCommand(PressBtnOnClick);
		LoadHeroSkinItem(skinId);
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is HeroSkinItemData heroSkinItemData && !heroSkinItemData.Icon.Equals("empty") && curHeroSkinData.Sort != heroSkinItemData.Sort)
		{
			switchHeroSkinRequest.Raise(heroSkinItemData.Sort);
		}
	}

	private void LoadHeroSkinItem(int skinId)
	{
		heroSkinItemList = new List<HeroSkinItemData>();
		List<int> heroSkins = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroSkins(heroId);
		DRUIHeroSkin[] dataRows = GameEntry.DataTable.GetDataRows((DRUIHeroSkin p) => p.HeroID == heroId);
		HeroSkinItemData heroSkinItemData = new HeroSkinItemData(this);
		heroSkinItemData.SetEmptyItem();
		heroSkinItemList.Add(heroSkinItemData);
		DRUIHeroSkin[] array = dataRows;
		foreach (DRUIHeroSkin info in array)
		{
			HeroSkinItemData heroSkinItemData2 = new HeroSkinItemData(this, info.Id);
			heroSkinItemData2.InActiveMask = !heroSkins.Exists((int p) => p.Equals(info.Id));
			heroSkinItemList.Add(heroSkinItemData2);
			if (info.Id == skinId)
			{
				RefreshSkinData(heroSkinItemData2);
			}
		}
		HeroSkinItemData heroSkinItemData3 = new HeroSkinItemData(this);
		heroSkinItemData3.SetEmptyItem(999);
		heroSkinItemList.Add(heroSkinItemData3);
		heroSkinItemList.Sort((HeroSkinItemData x, HeroSkinItemData y) => x.Sort.CompareTo(y.Sort));
		if (skinId == 0)
		{
			RefreshSkinData(heroSkinItemList[1]);
		}
	}

	public void SelectSkinItem(int index)
	{
		if (index < heroSkinItemList.Count)
		{
			RefreshSkinData(heroSkinItemList[index]);
		}
	}

	private void RefreshSkinData(HeroSkinItemData data)
	{
		if (data != null)
		{
			curHeroSkinData?.SetSelect(value: false);
			curHeroSkinData = data;
			curHeroSkinData.SetSelect(value: true);
			HeroName = data.HeroName;
			SkinName = data.SkinName;
			SkinDesc = data.SkinDesc;
			SkinAssetPath = data.HeroSkinAssetPath;
			SkinTagIcon = data.SkinTagIcon;
			SetPressBtnState();
		}
	}

	private void SetPressBtnState()
	{
		heroEquipSkinId = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(heroId).SkinConfigId;
		IsUsingCurrentSkin = windowType == 1 && heroEquipSkinId == curHeroSkinData.ConfigId;
		if (IsUsingCurrentSkin)
		{
			ShowPressButton = false;
			SkinStateText = string.Empty;
			return;
		}
		if (!curHeroSkinData.InActiveMask)
		{
			ShowPressButton = true;
			PressButtonText = pressText;
			SkinStateText = string.Empty;
			return;
		}
		ShowPressButton = !string.IsNullOrEmpty(curHeroSkinData.TargetWindow);
		if (!ShowPressButton)
		{
			SkinStateText = curHeroSkinData.Achieve;
			return;
		}
		SkinStateText = string.Empty;
		PressButtonText = curHeroSkinData.Achieve;
	}

	public void SetWindowType(int type)
	{
		windowType = type;
		switch (windowType)
		{
		case 1:
			pressText = "投影";
			break;
		case 2:
			pressText = "已拥有";
			break;
		}
		SetPressBtnState();
	}

	private async void PressBtnOnClick()
	{
		if (curHeroSkinData.InActiveMask)
		{
			if (string.IsNullOrEmpty(curHeroSkinData.TargetWindow))
			{
				return;
			}
			List<object> list = new List<object>();
			foreach (int windowParam in curHeroSkinData.WindowParams)
			{
				list.Add(windowParam);
			}
			JumpWindowParams jumpParams = new JumpWindowParams(curHeroSkinData.TargetWindow, list);
			TryOpenWindow(jumpParams);
		}
		else
		{
			pressBtnCmd.Enabled = false;
			if (await Singleton<ServiceSystem>.Instance.GetService<IHeroService>().SetHeroSkinChangeRequest(curHeroSkinData.ConfigId))
			{
				heroEquipSkinId = curHeroSkinData.ConfigId;
				SetPressBtnState();
			}
			pressBtnCmd.Enabled = true;
		}
	}

	private async void TryOpenWindow(JumpWindowParams jumpParams)
	{
		if (parent.CheckOpen(this, jumpParams))
		{
			pressBtnCmd.Enabled = false;
			OpenViewArg openViewArg = await new UIJumpHelper().CreateViewJumpData(jumpParams, parent, "HeroSkinPreView", Cb);
			if (openViewArg == null)
			{
				Cb();
			}
			else
			{
				parent?.ItemOnClick(openViewArg);
			}
		}
		void Cb()
		{
			OnJumpWindowBack();
			pressBtnCmd.Enabled = true;
		}
	}

	private void OnJumpWindowBack()
	{
		if (curHeroSkinData != null)
		{
			List<int> heroSkins = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroSkins(heroId);
			curHeroSkinData.InActiveMask = !heroSkins.Exists((int p) => p.Equals(curHeroSkinData.ConfigId));
			SetPressBtnState();
		}
	}
}
