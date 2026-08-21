using System;

namespace Ase;

public class SailHeroItemData : OptionBase
{
	private bool isEmpty;

	private int heroId;

	private string heroIcon;

	public bool IsEmpty
	{
		get
		{
			return isEmpty;
		}
		set
		{
			Set(ref isEmpty, value, "IsEmpty");
		}
	}

	public int HeroId
	{
		get
		{
			return heroId;
		}
		private set
		{
			Set(ref heroId, value, "HeroId");
		}
	}

	public string HeroIcon
	{
		get
		{
			return heroIcon;
		}
		set
		{
			Set(ref heroIcon, value, "HeroIcon");
		}
	}

	public SailHeroItemData(OptionBase parent, int heroId = 0)
	{
		base.parent = parent;
		IsEmpty = heroId == 0;
		GetHeroIcon(heroId);
	}

	public void SetHeroId(int heroId = 0)
	{
		GetHeroIcon(heroId);
	}

	private void GetHeroIcon(int heroId)
	{
		try
		{
			HeroId = heroId;
			HeroModel heroById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(HeroId);
			HeroIcon = ((heroById != null) ? $"UserHead{heroById.Id}{heroById.SkinSuffix}" : "empty");
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
			throw;
		}
	}

	public void OnClick()
	{
		parent?.ItemOnClick(new OptionArg(this, "OpenHeroView"));
	}
}
