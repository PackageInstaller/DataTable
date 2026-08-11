using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class HeroSkillSkinViewModel : OptionBase
{
	private string heroName;

	private string heroImgPath;

	private string countTxt;

	private string skillDesc;

	private string skinVideoPath;

	private string btnTxt;

	private bool isActive;

	private int heroId;

	private int rarity;

	private string propIcon;

	private bool propNotEnough;

	private HeroModel heroModel;

	private HeroSkillItemData curSkill;

	private HeroSkillSkinItemData curSkin;

	private List<HeroSkillItemData> skills = new List<HeroSkillItemData>();

	private List<HeroSkillSkinItemData> skins = new List<HeroSkillSkinItemData>();

	private SimpleCommand onOpenPropCmd;

	private SimpleCommand changeSkinCmd;

	private SimpleCommand activeSkinCmd;

	private InteractionRequest refreshSkinsRst = new InteractionRequest();

	private InteractionRequest refreshVideoRst = new InteractionRequest();

	public SimpleCommand OnOpenPropCmd => onOpenPropCmd;

	public SimpleCommand ChangeSkinCmd => changeSkinCmd;

	public SimpleCommand ActiveSkinCmd => activeSkinCmd;

	public InteractionRequest RefreshSkinsRst => refreshSkinsRst;

	public InteractionRequest RefreshVideoRst => refreshVideoRst;

	public HeroSkillItemData CurSkill => curSkill;

	public HeroSkillSkinItemData CurSkin
	{
		get
		{
			return curSkin;
		}
		set
		{
			Set(ref curSkin, value, "CurSkin");
		}
	}

	public List<HeroSkillItemData> Skills => skills;

	public List<HeroSkillSkinItemData> Skins => skins;

	public string HeroName
	{
		get
		{
			return heroName;
		}
		set
		{
			Set(ref heroName, value, "HeroName");
		}
	}

	public string HeroImgPath
	{
		get
		{
			return heroImgPath;
		}
		set
		{
			Set(ref heroImgPath, value, "HeroImgPath");
		}
	}

	public string CountTxt
	{
		get
		{
			return countTxt;
		}
		set
		{
			Set(ref countTxt, value, "CountTxt");
		}
	}

	public string SkillDesc
	{
		get
		{
			return skillDesc;
		}
		set
		{
			Set(ref skillDesc, value, "SkillDesc");
		}
	}

	public string BtnTxt
	{
		get
		{
			return btnTxt;
		}
		set
		{
			Set(ref btnTxt, value, "BtnTxt");
		}
	}

	public bool IsActive
	{
		get
		{
			return isActive;
		}
		set
		{
			Set(ref isActive, value, "IsActive");
		}
	}

	public string SkinVideoPath
	{
		get
		{
			return skinVideoPath;
		}
		set
		{
			Set(ref skinVideoPath, value, "SkinVideoPath");
		}
	}

	public int Rarity
	{
		get
		{
			return rarity;
		}
		set
		{
			Set(ref rarity, value, "Rarity");
		}
	}

	public string PropIcon
	{
		get
		{
			return propIcon;
		}
		set
		{
			Set(ref propIcon, value, "PropIcon");
		}
	}

	public bool PropNotEnough
	{
		get
		{
			return propNotEnough;
		}
		set
		{
			Set(ref propNotEnough, value, "PropNotEnough");
		}
	}

	public HeroSkillSkinViewModel()
	{
	}

	public HeroSkillSkinViewModel(OptionBase parent, HeroSkillSkinOpenArg openArg)
	{
		base.parent = parent;
		onOpenPropCmd = new SimpleCommand(OnOpenProp);
		changeSkinCmd = new SimpleCommand(ChangeSkin);
		activeSkinCmd = new SimpleCommand(ActiveSkin);
		heroId = openArg.HeroId;
		heroModel = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(heroId, emptyCreateNew: true, saveNew: false);
		InitialHeroInfo();
		InitialSkill();
	}

	public HeroSkillSkinViewModel(OptionBase parent, HeroModel hero)
	{
		base.parent = parent;
		onOpenPropCmd = new SimpleCommand(OnOpenProp);
		changeSkinCmd = new SimpleCommand(ChangeSkin);
		activeSkinCmd = new SimpleCommand(ActiveSkin);
		heroModel = hero;
		heroId = hero.Id;
		InitialHeroInfo();
		InitialSkill();
	}

	private void InitSkillSkinState()
	{
		IBFBEService service = Singleton<ServiceSystem>.Instance.GetService<IBFBEService>();
		foreach (HeroSkillSkinItemData skin in skins)
		{
			int value;
			if (heroModel.UseSkillCameraSkinId == null)
			{
				if (skin.SkinName == "默认")
				{
					skin.ChangeState(SkillSkinToHaveStateEnum.Use);
				}
				else if (service.HeroSkillCameraSkinIsLock(skin.Cfs.Id))
				{
					skin.ChangeState(SkillSkinToHaveStateEnum.Change);
				}
				else
				{
					skin.ChangeState(SkillSkinToHaveStateEnum.Locked);
				}
			}
			else if (heroModel.UseSkillCameraSkinId.TryGetValue(skin.Cfs.SkillId, out value))
			{
				if (value == skin.Cfs.Id)
				{
					skin.ChangeState(SkillSkinToHaveStateEnum.Use);
				}
				else if (skin.SkinName == "默认")
				{
					skin.ChangeState(SkillSkinToHaveStateEnum.Change);
				}
				else if (service.HeroSkillCameraSkinIsLock(skin.Cfs.Id))
				{
					skin.ChangeState(SkillSkinToHaveStateEnum.Change);
				}
				else
				{
					skin.ChangeState(SkillSkinToHaveStateEnum.Locked);
				}
			}
			else if (skin.SkinName == "默认")
			{
				skin.ChangeState(SkillSkinToHaveStateEnum.Use);
			}
			else if (service.HeroSkillCameraSkinIsLock(skin.Cfs.Id))
			{
				skin.ChangeState(SkillSkinToHaveStateEnum.Change);
			}
			else
			{
				skin.ChangeState(SkillSkinToHaveStateEnum.Locked);
			}
		}
	}

	private void InitialHeroInfo()
	{
		HeroName = GameEntry.DataTable.GetDataRow<DRHeroInfo>(heroId)?.Name;
		HeroImgPath = HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.RectangleHorizontal, heroId);
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is HeroSkillItemData data)
		{
			SelectSkill(data);
		}
		else if (obj is HeroSkillSkinItemData data2)
		{
			SelectSkin(data2);
		}
	}

	private void SelectSkill(HeroSkillItemData data)
	{
		if (data != null && (curSkill == null || curSkill.SkillId != data.SkillId))
		{
			if (curSkill != null)
			{
				curSkill.IsSelected = false;
			}
			curSkill = data;
			curSkill.IsSelected = true;
			RefreshSkin();
		}
	}

	private void SelectSkin(HeroSkillSkinItemData data)
	{
		if (data != null && (CurSkin == null || CurSkin.Cfs == null || data.Cfs == null || CurSkin.Cfs.Id != data.Cfs.Id))
		{
			if (CurSkin != null)
			{
				CurSkin.IsSelected = false;
			}
			CurSkin = data;
			CurSkin.IsSelected = true;
			RefreshActiveBtn();
			SkillDesc = CurSkin.Cfs.SkillSkinDesc;
			SkinVideoPath = CurSkin.Cfs.SkillSkinVideo;
			RefreshVideoRst.Raise();
		}
	}

	private void RefreshSkin()
	{
		if (curSkill == null)
		{
			return;
		}
		skins.Clear();
		DRHeroSkillSkin[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroSkillSkin p) => p.SkillId == curSkill.SkillId);
		for (int num = 0; num < dataRows.Length; num++)
		{
			HeroSkillSkinItemData item = new HeroSkillSkinItemData(this, dataRows[num]);
			skins.Add(item);
		}
		InitSkillSkinState();
		int index = 0;
		for (int num2 = 0; num2 < skins.Count; num2++)
		{
			if (skins[num2].State == SkillSkinToHaveStateEnum.Use)
			{
				index = num2;
			}
		}
		SelectSkin(skins[index]);
		RefreshSkinsRst.Raise();
	}

	private void InitialSkill()
	{
		DRSkillSkinList[] dataRows = GameEntry.DataTable.GetDataRows((DRSkillSkinList p) => p.HeroId == heroId);
		for (int num = 0; num < dataRows.Length; num++)
		{
			HeroSkillItemData item = new HeroSkillItemData(this, dataRows[num]);
			skills.Add(item);
		}
		SelectSkill(skills[0]);
	}

	private void RefreshActiveBtn()
	{
		if (CurSkin.State == SkillSkinToHaveStateEnum.Locked)
		{
			DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(CurSkin.Cfs.PropId);
			Rarity = dataRow.Quality;
			PropIcon = dataRow.Icon;
			IsActive = true;
			BtnTxt = "激活";
			int propOwnedCount = PropHelper.GetPropOwnedCount(CurSkin.Cfs.PropId);
			IsActive = propOwnedCount > 0;
			PropNotEnough = propOwnedCount > 0;
			CountTxt = propOwnedCount + "/1";
			if (!IsActive)
			{
				BtnTxt = "道具不足";
			}
			IsActive = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().HasHero(heroId);
			if (!IsActive)
			{
				BtnTxt = "未拥有对应的烬天使";
			}
		}
	}

	private async void ActiveSkin()
	{
		if (await Singleton<ServiceSystem>.Instance.GetService<IBFBEService>().UnlockSkillSkinInfoRst(CurSkin.Cfs.Id))
		{
			CurSkin.ChangeState(SkillSkinToHaveStateEnum.Change);
		}
	}

	private async void ChangeSkin()
	{
		if (!(await Singleton<ServiceSystem>.Instance.GetService<IBFBEService>().SetOrChangeSkillSkinInfoRst(heroId, CurSkin.Cfs.Id)))
		{
			return;
		}
		foreach (HeroSkillSkinItemData skin in skins)
		{
			if (skin.IsUse)
			{
				skin.IsUse = false;
				skin.ChangeState(SkillSkinToHaveStateEnum.Change);
			}
		}
		CurSkin.IsUse = true;
		CurSkin.ChangeState(SkillSkinToHaveStateEnum.Use);
		heroModel.SetUseSkillSkin(CurSkill.SkillId, CurSkin.Cfs.Id);
	}

	private void OnOpenProp()
	{
		if (CurSkin != null)
		{
			OpenViewArg openViewArg = PropHelper.OpenPopupWindow(PropDataBase.CreateByType(PropTypeEnum.HeroSkillSkinProp, CurSkin.Cfs.PropId), this);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
	}
}
