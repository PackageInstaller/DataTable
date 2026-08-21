using System.Collections.Generic;
using System.Linq;
using GameFramework.Runtime;

namespace Ase;

public class ArmourRecommendViewModel : OptionBase
{
	private readonly SimpleCommand<string> optCmd;

	private readonly InteractionRequest<string> optRequest;

	private readonly InteractionRequest<EntryItemData> showEntryDetailRequest;

	private readonly InteractionRequest hideEntryDetailRequest;

	private string heroName;

	private string heroPortraitPath;

	private WeaponEnum weapon;

	private HeroAttributeEnum attribute;

	private readonly ObservableList<StatusAttrItemViewModel> recommendAttrList = new ObservableList<StatusAttrItemViewModel>();

	private readonly ObservableList<EntryItemData> recommendEntryList = new ObservableList<EntryItemData>();

	private readonly List<int> recommendAttrIds = new List<int>();

	private readonly List<int> recommendEntryIds = new List<int>();

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

	public string HeroPortraitPath
	{
		get
		{
			return heroPortraitPath;
		}
		set
		{
			Set(ref heroPortraitPath, value, "HeroPortraitPath");
		}
	}

	public WeaponEnum Weapon
	{
		get
		{
			return weapon;
		}
		set
		{
			Set(ref weapon, value, "Weapon");
		}
	}

	public HeroAttributeEnum Attribute
	{
		get
		{
			return attribute;
		}
		set
		{
			Set(ref attribute, value, "Attribute");
		}
	}

	public ObservableList<StatusAttrItemViewModel> RecommendAttrList => recommendAttrList;

	public ObservableList<EntryItemData> RecommendEntryList => recommendEntryList;

	public List<int> RecommendAttrIds => recommendAttrIds;

	public List<int> RecommendMainAttrIds => recommendAttrIds;

	public List<int> RecommendEntryIds => recommendEntryIds;

	public ICommand OptCmd => optCmd;

	public IInteractionRequest OptRequest => optRequest;

	public InteractionRequest<EntryItemData> ShowEntryDetailRequest => showEntryDetailRequest;

	public InteractionRequest HideEntryDetailRequest => hideEntryDetailRequest;

	public ArmourRecommendViewModel()
	{
		optCmd = new SimpleCommand<string>(OnOpt);
		optRequest = new InteractionRequest<string>();
		showEntryDetailRequest = new InteractionRequest<EntryItemData>();
		hideEntryDetailRequest = new InteractionRequest();
	}

	public ArmourRecommendViewModel(OptionBase parent, HeroModel heroModel)
		: this()
	{
		base.parent = parent;
		RefreshHero(heroModel);
	}

	public void RefreshHero(HeroModel heroModel)
	{
		recommendAttrList.Clear();
		recommendAttrIds.Clear();
		recommendEntryList.Clear();
		recommendEntryIds.Clear();
		if (heroModel == null)
		{
			optRequest.Raise("RefreshRecommendList");
		}
		else
		{
			LoadData(heroModel);
		}
	}

	private void LoadData(HeroModel heroModel)
	{
		HeroName = heroModel.Name;
		HeroPortraitPath = "ItemIcons/HeroHeadImage/Rectangle/" + HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.RectangleHorizontal, heroModel);
		Weapon = heroModel.Weapon;
		Attribute = heroModel.Attribute;
		DRHeroGuide dataRow = GameEntry.DataTable.GetDataRow<DRHeroGuide>(heroModel.Id);
		if (dataRow == null)
		{
			optRequest.Raise("RefreshRecommendList");
			return;
		}
		if (dataRow.RecommendAffix != null)
		{
			for (int i = 0; i < dataRow.RecommendAffix.Count; i++)
			{
				int attrId = dataRow.RecommendAffix[i];
				DRAttributeTotal dataRow2 = GameEntry.DataTable.GetDataRow((DRAttributeTotal p) => p.Uid == attrId);
				if (dataRow2 != null)
				{
					recommendAttrIds.Add(attrId);
					recommendAttrList.Add(StatusAttrItemViewModel.CreateBasic(dataRow2.Name, string.Empty, GetRecommendAttrIcon(dataRow2, attrId), recommendAttrList.Count));
				}
			}
		}
		HashSet<int> suitBoxMainEntryIds = GetSuitBoxMainEntryIds();
		if (dataRow.RecommendEntry != null)
		{
			for (int num = 0; num < dataRow.RecommendEntry.Count; num++)
			{
				int entryId = dataRow.RecommendEntry[num];
				if (GameEntry.DataTable.GetDataRow((DREntry p) => p.EntryId == entryId && p.Level == 1) != null)
				{
					recommendEntryIds.Add(entryId);
					EntryItemData entryItemData = new EntryItemData(this, new EntryData(entryId, 1));
					if (suitBoxMainEntryIds.Contains(entryId))
					{
						entryItemData.IsMainEntry = true;
						entryItemData.EntryData.IsFixed = true;
						entryItemData.SetEntryTextType(1);
					}
					recommendEntryList.Add(entryItemData);
				}
			}
		}
		optRequest.Raise("RefreshRecommendList");
	}

	private void OnOpt(string optName)
	{
		if (optCmd.Enabled)
		{
			optCmd.Enabled = false;
			if ("QuickFilter".Equals(optName))
			{
				parent?.ItemOnClick(new OptionArg(this, "QuickFilterRecommend"));
			}
			else if ("QuickFilterWithoutOtherEntry".Equals(optName))
			{
				parent?.ItemOnClick(new OptionArg(this, "QuickFilterRecommendWithoutOtherEntry"));
			}
			else if ("Back".Equals(optName))
			{
				parent?.ItemOnClick(new OptionArg(this, "CloseRecommend"));
			}
			optCmd.Enabled = true;
		}
	}

	private string GetRecommendAttrIcon(DRAttributeTotal attrConfig, int attrId)
	{
		DRAffix dataRow = GameEntry.DataTable.GetDataRow<DRAffix>(attrId);
		if (dataRow != null)
		{
			return dataRow.Icon.ToString();
		}
		if (attrConfig == null)
		{
			return string.Empty;
		}
		return attrConfig.EntryIcon;
	}

	private HashSet<int> GetSuitBoxMainEntryIds()
	{
		DRSuitboxMainStore[] dataRows = GameEntry.DataTable.GetDataRows((DRSuitboxMainStore p) => p.EntryId > 0);
		if (dataRows == null || dataRows.Length == 0)
		{
			return new HashSet<int>();
		}
		return new HashSet<int>(dataRows.Select((DRSuitboxMainStore p) => p.EntryId));
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg)
		{
			if ("OnShowEntryPanel".Equals(optionArg.OptionName) && optionArg.Obj is EntryItem entryItem)
			{
				showEntryDetailRequest.Raise(entryItem.ViewModel);
				return;
			}
			if ("HideEntryPanelLevel".Equals(optionArg.OptionName))
			{
				hideEntryDetailRequest.Raise();
				return;
			}
		}
		base.ItemOnClick(obj);
	}
}
