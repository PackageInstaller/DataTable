namespace Ase;

public class HeroBookViewModel : OptionBase
{
	private HeroModel _heroModel;

	private int curTabType = 1;

	public HeroModel HeroModel
	{
		get
		{
			return _heroModel;
		}
		set
		{
			Set(ref _heroModel, value, "HeroModel");
		}
	}

	public int CurTabType
	{
		get
		{
			return curTabType;
		}
		set
		{
			Set(ref curTabType, value, "CurTabType");
		}
	}

	public HeroBookViewModel(OptionBase parentVm, HeroModel heroModel, int defaultTab = 1)
	{
		parent = parentVm;
		HeroModel = heroModel;
		CurTabType = defaultTab;
	}
}
