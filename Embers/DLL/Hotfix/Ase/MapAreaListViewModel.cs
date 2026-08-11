using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class MapAreaListViewModel : OptionBase
{
	private List<DRSectionMap> sectionDatas = new List<DRSectionMap>();

	private List<DRMap> levelDatas = new List<DRMap>();

	private List<MapAreaTabItemData> sectionTabDatas = new List<MapAreaTabItemData>();

	private List<MapAreaTabItemData> levelTabDatas = new List<MapAreaTabItemData>();

	private MapAreaTabItemData curSectionTabData;

	private MapAreaTabItemData curLevelTabData;

	private TabItemData tabToggleItemData;

	private string sectionName;

	private string levelName;

	private InteractionRequest<int> _onWorldDataChanged = new InteractionRequest<int>();

	private InteractionRequest<int> _onSectionDataChanged = new InteractionRequest<int>();

	private InteractionRequest updateTabItemsTags = new InteractionRequest();

	private MapViewModel parentMapViewModel;

	public TabItemData TabToggleItemData => tabToggleItemData;

	public string SectionName
	{
		get
		{
			return sectionName;
		}
		private set
		{
			Set(ref sectionName, value, "SectionName");
		}
	}

	public string LevelName
	{
		get
		{
			return levelName;
		}
		private set
		{
			Set(ref levelName, value, "LevelName");
		}
	}

	public List<DRSectionMap> SectionDatas
	{
		get
		{
			return sectionDatas;
		}
		set
		{
			sectionDatas = value;
		}
	}

	public List<DRMap> LevelDatas
	{
		get
		{
			return levelDatas;
		}
		set
		{
			levelDatas = value;
		}
	}

	public List<MapAreaTabItemData> SectionTabDatas
	{
		get
		{
			return sectionTabDatas;
		}
		set
		{
			sectionTabDatas = value;
		}
	}

	public List<MapAreaTabItemData> LevelTabDatas
	{
		get
		{
			return levelTabDatas;
		}
		set
		{
			levelTabDatas = value;
		}
	}

	public InteractionRequest<int> OnWorldDataChanged => _onWorldDataChanged;

	public InteractionRequest<int> OnSectionDataChanged => _onSectionDataChanged;

	public InteractionRequest UpdateTabItemsTags => updateTabItemsTags;

	public MapViewModel ParentMapViewModel => parentMapViewModel;

	public MapAreaListViewModel()
	{
	}

	public MapAreaListViewModel(MapViewModel parent)
	{
		base.parent = parent;
		parentMapViewModel = parent;
		tabToggleItemData = new TabItemData(this, 0);
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemData tabItemData)
		{
			visibleRequest.Raise(!tabItemData.IsSelected);
			parentMapViewModel.ItemOnClick(new OptionArg(!tabItemData.IsSelected, "MapAreaToggleClick"));
		}
		else if (obj is MapAreaTabItemData obj2)
		{
			parent?.ItemOnClick(obj2);
		}
	}

	public void SetSectionTabSelected(MapAreaTabItemData tabItemData)
	{
		if (curSectionTabData != null)
		{
			curSectionTabData.IsSelected = false;
		}
		curSectionTabData = tabItemData;
		curSectionTabData.IsSelected = true;
		RefreshAreaName();
	}

	public void SetLevelTabSelected(MapAreaTabItemData tabItemData)
	{
		if (curLevelTabData != null)
		{
			curLevelTabData.IsSelected = false;
		}
		curLevelTabData = tabItemData;
		curLevelTabData.IsSelected = true;
		RefreshAreaName();
	}

	private void RefreshAreaName()
	{
		SectionName = curSectionTabData?.Name ?? string.Empty;
		LevelName = curLevelTabData?.Name ?? string.Empty;
	}

	public void UpdateTabItemTags()
	{
		updateTabItemsTags.Raise();
	}
}
