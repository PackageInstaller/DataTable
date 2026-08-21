using System;
using System.Collections.Generic;

namespace Ase;

public class PropData : PropDataBase
{
	private DRProp drProp;

	private string function;

	private List<int> useType;

	private int ex1;

	private int sort;

	private List<string> sourceName;

	private List<string> sourceWindow;

	private List<List<int>> sourceParams;

	private string title;

	private string illustration;

	private string content;

	public DRProp DrProp => drProp;

	public string Function
	{
		get
		{
			return function;
		}
		set
		{
			Set(ref function, value, "Function");
		}
	}

	public List<int> UseType
	{
		get
		{
			return useType;
		}
		set
		{
			Set(ref useType, value, "UseType");
		}
	}

	public int Ex1
	{
		get
		{
			return ex1;
		}
		set
		{
			Set(ref ex1, value, "Ex1");
		}
	}

	public int Sort
	{
		get
		{
			return sort;
		}
		set
		{
			Set(ref sort, value, "Sort");
		}
	}

	public List<string> SourceName
	{
		get
		{
			return sourceName;
		}
		set
		{
			Set(ref sourceName, value, "SourceName");
		}
	}

	public List<string> SourceWindow
	{
		get
		{
			return sourceWindow;
		}
		set
		{
			Set(ref sourceWindow, value, "SourceWindow");
		}
	}

	public List<List<int>> SourceParams
	{
		get
		{
			return sourceParams;
		}
		set
		{
			Set(ref sourceParams, value, "SourceParams");
		}
	}

	public string Title
	{
		get
		{
			return title;
		}
		set
		{
			Set(ref title, value, "Title");
		}
	}

	public string Illustration
	{
		get
		{
			return illustration;
		}
		set
		{
			Set(ref illustration, value, "Illustration");
		}
	}

	public string Content
	{
		get
		{
			return content;
		}
		set
		{
			Set(ref content, value, "Content");
		}
	}

	public PropData()
	{
	}

	public PropData(DRProp drProp, int amount = 1)
	{
		Init(drProp, amount);
	}

	protected override void Init(DRProp drProp, int amount = 1)
	{
		base.Init(drProp, amount);
		this.drProp = drProp;
		base.Quality = drProp.Quality;
		Function = drProp.Function;
		UseType = drProp.UseType;
		Ex1 = drProp.EX1;
		Sort = drProp.Sort;
		SourceName = drProp.SourceName;
		SourceWindow = drProp.SourceWindow;
		SourceParams = drProp.SourceParams;
		Title = drProp.Title;
		Illustration = drProp.Illustration;
		Content = drProp.Content;
	}

	public override int GetRarity()
	{
		return base.Quality;
	}

	public override bool CanDecompose()
	{
		if (UseType.Contains(6))
		{
			HeroModel hero = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(Ex1);
			if (!hero.IsNullOrEmpty())
			{
				DRHeroSeat[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroSeat p) => p.HeroId.Equals(hero.Id));
				if (dataRows == null)
				{
					return false;
				}
				int maxDestinyLevel = 0;
				dataRows.ToList().ForEach(delegate(DRHeroSeat p)
				{
					maxDestinyLevel = Math.Max(maxDestinyLevel, p.TargetSeat);
				});
				return hero.DestinyLevel >= maxDestinyLevel;
			}
		}
		return false;
	}
}
