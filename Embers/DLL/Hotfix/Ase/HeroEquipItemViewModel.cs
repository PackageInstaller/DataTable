using GameFramework.Runtime;

namespace Ase;

public class HeroEquipItemViewModel : ViewModelBase
{
	private int heroId;

	private bool isUp;

	public bool IsUp
	{
		get
		{
			return isUp;
		}
		private set
		{
			Set(ref isUp, value, "IsUp");
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

	public HeroEquipItemViewModel(int heroId, bool isUp)
	{
		this.heroId = heroId;
		this.isUp = isUp;
	}

	public void SetData(int heroId, bool isUp)
	{
		HeroId = heroId;
		IsUp = isUp;
	}
}
