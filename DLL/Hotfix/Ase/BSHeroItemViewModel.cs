using System.Collections.Generic;

namespace Ase;

public class BSHeroItemViewModel : OptionBase
{
	private HeroModel hero;

	private string name;

	private bool showLine = true;

	private bool isSelf;

	private int memberId;

	private List<BSItemViewModel> bsItemVMs;

	public HeroModel Hero
	{
		get
		{
			return hero;
		}
		private set
		{
			Set(ref hero, value, "Hero");
		}
	}

	public int MemberId => memberId;

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

	public bool ShowLine
	{
		get
		{
			return showLine;
		}
		private set
		{
			Set(ref showLine, value, "ShowLine");
		}
	}

	public bool IsSelf
	{
		get
		{
			return isSelf;
		}
		private set
		{
			Set(ref isSelf, value, "IsSelf");
		}
	}

	public List<BSItemViewModel> BSItemVMs => bsItemVMs;

	public BSHeroItemViewModel(OptionBase parent, int memberId, HeroModel heroModel, string name, bool showLine, bool isSelf, List<BSItemViewModel> bsItemVMs)
	{
		base.parent = parent;
		this.memberId = memberId;
		hero = heroModel;
		this.name = name;
		this.showLine = showLine;
		this.isSelf = isSelf;
		this.bsItemVMs = bsItemVMs;
	}

	public void OnSelect()
	{
		parent.ItemOnClick(this);
	}
}
