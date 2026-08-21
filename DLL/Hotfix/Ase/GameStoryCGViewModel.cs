using System.Collections.Generic;

namespace Ase;

public class GameStoryCGViewModel : OptionBase
{
	private string img;

	private string title;

	private string desc;

	private int index;

	private int count;

	private string countText;

	private RollingViewModel rollingViewModel;

	private List<GameStoryGuideItemData> photoList1;

	private List<GameHeroInfoItemData> photoList2;

	public string Img
	{
		get
		{
			return img;
		}
		private set
		{
			Set(ref img, value, "Img");
		}
	}

	public string Title
	{
		get
		{
			return title;
		}
		private set
		{
			Set(ref title, value, "Title");
		}
	}

	public string Desc
	{
		get
		{
			return desc;
		}
		private set
		{
			Set(ref desc, value, "Desc");
		}
	}

	public string CountText
	{
		get
		{
			return countText;
		}
		private set
		{
			Set(ref countText, value, "CountText");
		}
	}

	public int Count => count;

	public RollingViewModel RollingViewModel => rollingViewModel;

	public GameStoryCGViewModel(OptionBase parent, int index, List<GameStoryGuideItemData> photoList, GameStoryGuideItemData gameStoryGuideItemData)
	{
		base.parent = parent;
		this.index = index;
		count = photoList.Count;
		SetNewCG(gameStoryGuideItemData);
		CountText = $"{index}/{count}";
		photoList1 = photoList;
		List<string> list = new List<string>();
		foreach (GameStoryGuideItemData photo in photoList)
		{
			list.Add(photo.Prefix + "/" + photo.IconPath);
		}
		rollingViewModel = new RollingViewModel(this, list, 3, 1, index - 1);
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is RollingViewModel rollingViewModel)
		{
			index = rollingViewModel.Index + 1;
			if (photoList1 != null && photoList1.Count > rollingViewModel.Index)
			{
				SetNewCG(photoList1[rollingViewModel.Index]);
			}
			else if (photoList2 != null && photoList2.Count > rollingViewModel.Index)
			{
				SetNewCG(photoList2[rollingViewModel.Index]);
			}
			CountText = $"{index}/{count}";
		}
	}

	public void Previous()
	{
		rollingViewModel.Left();
	}

	public void Next()
	{
		rollingViewModel.Right();
	}

	private void SetNewCG(GameStoryGuideItemData gameStoryGuideItemData)
	{
		Img = gameStoryGuideItemData.IconPath;
		Title = gameStoryGuideItemData.Title;
		Desc = gameStoryGuideItemData.Desc;
	}

	public void SetNewCG(GameHeroInfoItemData gameHeroInfoItemData)
	{
		Img = gameHeroInfoItemData.Icon;
		Title = gameHeroInfoItemData.Title;
		Desc = gameHeroInfoItemData.Desc;
	}
}
