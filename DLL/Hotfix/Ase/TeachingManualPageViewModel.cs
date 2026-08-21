namespace Ase;

public class TeachingManualPageViewModel : OptionBase
{
	private string pageIcon = "";

	private string pageTitle;

	private string pageContent;

	private int curPage;

	private int totalPage;

	private bool readComplete;

	private TeachingPoint point;

	public string PageIcon
	{
		get
		{
			return pageIcon;
		}
		set
		{
			Set(ref pageIcon, value, "PageIcon");
		}
	}

	public string PageTitle
	{
		get
		{
			return pageTitle;
		}
		set
		{
			Set(ref pageTitle, value, "PageTitle");
		}
	}

	public string PageContent
	{
		get
		{
			return pageContent;
		}
		set
		{
			Set(ref pageContent, value, "PageContent");
		}
	}

	public int CurPage
	{
		get
		{
			return curPage;
		}
		set
		{
			Set(ref curPage, value, "CurPage");
		}
	}

	public int TotalPage
	{
		get
		{
			return totalPage;
		}
		set
		{
			Set(ref totalPage, value, "TotalPage");
		}
	}

	public bool ReadComplete
	{
		get
		{
			return readComplete;
		}
		set
		{
			Set(ref readComplete, value, "ReadComplete");
		}
	}

	public TeachingManualPageViewModel()
	{
	}

	public TeachingManualPageViewModel(OptionBase parent, TeachingPoint point)
	{
		base.parent = parent;
		this.point = point;
		if (point.Pages != null && point.Pages.Count > 0)
		{
			SetPageData(point.Pages[0]);
		}
		else
		{
			ReadComplete = true;
		}
	}

	private void SetPageData(TeachingPointPage page)
	{
		CurPage = page.PageIndex;
		TotalPage = page.TotalPage;
		PageIcon = page.PageIcon;
		PageTitle = page.PageTitle;
		PageContent = page.PageContent;
		if (!ReadComplete && CurPage == TotalPage)
		{
			ReadComplete = true;
		}
	}

	public void OnLastBtnClick()
	{
		if (CurPage - 1 > 0)
		{
			SetPageData(point.Pages[CurPage - 1 - 1]);
		}
	}

	public void OnNextBtnClick()
	{
		if (CurPage < TotalPage)
		{
			SetPageData(point.Pages[CurPage - 1 + 1]);
		}
	}
}
