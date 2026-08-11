using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class RecommendItemViewModel : OptionBase
{
	private bool isSelect;

	private readonly List<CopyTeamItemViewModel> heroItems;

	private int buffId;

	private string name;

	private string desc;

	private string icon;

	public int BuffId
	{
		get
		{
			return buffId;
		}
		private set
		{
			Set(ref buffId, value, "BuffId");
		}
	}

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
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

	public string Icon
	{
		get
		{
			return icon;
		}
		private set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public ICommand OptCommand { get; }

	public List<CopyTeamItemViewModel> HeroItems => heroItems;

	public bool IsSelect
	{
		get
		{
			return isSelect;
		}
		set
		{
			Set(ref isSelect, value, "IsSelect");
		}
	}

	public RecommendItemViewModel()
	{
	}

	public RecommendItemViewModel(OptionBase parent, int buffId, string name, string desc, string icon, List<CopyTeamItemViewModel> heroItems)
	{
		base.parent = parent;
		BuffId = buffId;
		Name = name;
		Desc = desc;
		Icon = icon;
		this.heroItems = heroItems ?? new List<CopyTeamItemViewModel>();
		OptCommand = new SimpleCommand<string>(OnOpt);
	}

	private void OnOpt(string optName)
	{
		if ("Select".Equals(optName))
		{
			parent?.ItemOnClick(this);
		}
	}
}
