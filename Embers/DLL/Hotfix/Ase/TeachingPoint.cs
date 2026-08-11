using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class TeachingPoint : ViewModelBase
{
	private int id;

	private int index;

	private int type;

	private string pointName;

	private int openType;

	private int openArg;

	private bool unRead;

	private List<TeachingPointPage> pages;

	public int Id
	{
		get
		{
			return id;
		}
		set
		{
			Set(ref id, value, "Id");
		}
	}

	public int Index
	{
		get
		{
			return index;
		}
		set
		{
			Set(ref index, value, "Index");
		}
	}

	public int Type
	{
		get
		{
			return type;
		}
		set
		{
			Set(ref type, value, "Type");
		}
	}

	public string PointName
	{
		get
		{
			return pointName;
		}
		set
		{
			Set(ref pointName, value, "PointName");
		}
	}

	public int OpenType
	{
		get
		{
			return openType;
		}
		set
		{
			Set(ref openType, value, "OpenType");
		}
	}

	public int OpenArg
	{
		get
		{
			return openArg;
		}
		set
		{
			Set(ref openArg, value, "OpenArg");
		}
	}

	public bool UnRead
	{
		get
		{
			return unRead;
		}
		set
		{
			Set(ref unRead, value, "UnRead");
		}
	}

	public List<TeachingPointPage> Pages => pages;

	public TeachingPoint()
	{
	}

	public TeachingPoint(DRManual drManual)
	{
		Id = drManual.Id;
		Index = drManual.Index;
		Type = drManual.Type;
		PointName = drManual.Name;
		OpenType = drManual.Release;
		OpenArg = drManual.ReleaseConfig;
		pages = new List<TeachingPointPage>();
		for (int i = 0; i < drManual.PageName.Count; i++)
		{
			pages.Add(new TeachingPointPage
			{
				PageIcon = ((drManual.Img.Count > i) ? drManual.Img[i] : ""),
				PageTitle = drManual.PageName[i],
				PageContent = ((drManual.Desc.Count > i) ? drManual.Desc[i] : ""),
				PageIndex = i + 1,
				TotalPage = drManual.PageName.Count
			});
		}
	}
}
