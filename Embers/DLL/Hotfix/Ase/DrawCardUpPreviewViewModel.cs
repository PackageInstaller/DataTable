using System.Collections.Generic;

namespace Ase;

public class DrawCardUpPreviewViewModel : OptionBase
{
	private string titleText;

	private string tipText;

	private string typeText;

	private int type;

	private List<TabItemNormalData> weaponSSRItemList;

	private List<TabItemNormalData> weaponSRItemList;

	private List<HeroItemViewModel> heroSSRItemList;

	private List<HeroItemViewModel> heroSRItemList;

	public string TitleText => titleText;

	public string TipText => tipText;

	public string TypeText => typeText;

	public int Type => type;

	public List<TabItemNormalData> WeaponSsrItemList => weaponSSRItemList;

	public List<TabItemNormalData> WeaponSrItemList => weaponSRItemList;

	public List<HeroItemViewModel> HeroSsrItemList => heroSSRItemList;

	public List<HeroItemViewModel> HeroSrItemList => heroSRItemList;

	public DrawCardUpPreviewViewModel(OptionBase parent, int type, List<int> ssrIdList, List<int> srIdList)
	{
		base.parent = parent;
		this.type = type;
		if (type == 5)
		{
			titleText = "武魂预览";
			tipText = "点击查看武魂详情";
			typeText = "武魂";
			LoadWeaponSSRItemList(ssrIdList);
			LoadWeaponSRItemList(srIdList);
		}
		else
		{
			titleText = "烬天使预览";
			tipText = "点击查看烬天使详情";
			typeText = "烬天使";
			LoadHeroSSRItemList(ssrIdList);
			LoadHeroSRItemList(srIdList);
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemNormalData tabItemNormalData)
		{
			OpenWeaponPreView(tabItemNormalData.ID);
		}
		else if (obj is HeroItemViewModel heroItemViewModel)
		{
			OpenHeroPreView(heroItemViewModel.HeroModel.Id, heroItemViewModel.HeroModel.SkinConfigId);
		}
	}

	private void OpenWeaponPreView(int weaponId)
	{
		WeaponPreviewViewModel userData = new WeaponPreviewViewModel(this, weaponId);
		openWindowRequest.Raise(new OpenViewArg(typeof(WeaponPreviewWindow), userData));
	}

	private void OpenHeroPreView(int heroId, int skinId)
	{
		HeroCultivatePreviewViewModel userData = new HeroCultivatePreviewViewModel(this, heroId, skinId);
		openWindowRequest.Raise(new OpenViewArg(typeof(HeroCultivatePreviewWindow), userData));
	}

	private void LoadWeaponSSRItemList(List<int> weaponIdList)
	{
		weaponSSRItemList = new List<TabItemNormalData>();
		foreach (int weaponId in weaponIdList)
		{
			DRWeapon dataRow = GameEntry.DataTable.GetDataRow<DRWeapon>(weaponId);
			if (dataRow != null)
			{
				TabItemNormalData item = new TabItemNormalData(this, dataRow.Icon, weaponId);
				weaponSSRItemList.Add(item);
			}
		}
	}

	private void LoadWeaponSRItemList(List<int> weaponIdList)
	{
		weaponSRItemList = new List<TabItemNormalData>();
		foreach (int weaponId in weaponIdList)
		{
			DRWeapon dataRow = GameEntry.DataTable.GetDataRow<DRWeapon>(weaponId);
			if (dataRow != null)
			{
				TabItemNormalData item = new TabItemNormalData(this, dataRow.Icon, weaponId);
				weaponSRItemList.Add(item);
			}
		}
	}

	private void LoadHeroSSRItemList(List<int> heroIdList)
	{
		heroSSRItemList = new List<HeroItemViewModel>();
		foreach (int heroId in heroIdList)
		{
			DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroInfo>(heroId);
			WeaponData heldWeapon = WeaponData.CreateWeaponData(dataRow.InitialWeapon);
			HeroModel heroModel = HeroModel.CreatePreview(heroId, heldWeapon, dataRow.InitialHeroSkin);
			HeroItemViewModel item = new HeroItemViewModel(this, heroModel);
			heroSSRItemList.Add(item);
		}
	}

	private void LoadHeroSRItemList(List<int> heroIdList)
	{
		heroSRItemList = new List<HeroItemViewModel>();
		foreach (int heroId in heroIdList)
		{
			DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroInfo>(heroId);
			WeaponData heldWeapon = WeaponData.CreateWeaponData(dataRow.InitialWeapon);
			HeroModel heroModel = HeroModel.CreatePreview(heroId, heldWeapon, dataRow.InitialHeroSkin);
			HeroItemViewModel item = new HeroItemViewModel(this, heroModel);
			heroSRItemList.Add(item);
		}
	}
}
