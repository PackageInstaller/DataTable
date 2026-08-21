namespace Ase;

public class CopySecondType3ExtremeViewModel : CopySecondType3SingleModeViewModelBase
{
	private string currentHeroIcon;

	private string bestResult;

	private string bestRank;

	protected override string ModeNameText => "极限挑战";

	protected override string RuleDescText => "单人挑战，进入竞速排行模式";

	protected override bool UseType5StyleRankDisplay => true;

	public string CurrentHeroIcon
	{
		get
		{
			return currentHeroIcon;
		}
		private set
		{
			Set(ref currentHeroIcon, value, "CurrentHeroIcon");
		}
	}

	public string BestResult
	{
		get
		{
			return bestResult;
		}
		private set
		{
			Set(ref bestResult, value, "BestResult");
		}
	}

	public string BestRank
	{
		get
		{
			return bestRank;
		}
		private set
		{
			Set(ref bestRank, value, "BestRank");
		}
	}

	public override string PrimaryResultText => BestResult;

	public override string SecondaryResultText => string.Empty;

	public CopySecondType3ExtremeViewModel()
		: base(null, CopyType3Mode.ExtremeChallenge)
	{
	}

	public CopySecondType3ExtremeViewModel(OptionBase parent)
		: base(parent, CopyType3Mode.ExtremeChallenge)
	{
	}

	protected override int GetDesiredRankCount(int currentRankCount)
	{
		if (currentRankCount >= 3)
		{
			return currentRankCount;
		}
		return currentRankCount + 1;
	}

	protected override void RefreshBasicDisplayData()
	{
		base.RefreshBasicDisplayData();
		int currentHeroIdForDisplay = GetCurrentHeroIdForDisplay();
		CurrentHeroIcon = CopySecondType3SingleModeViewModelBase.GetHeroIcon(currentHeroIdForDisplay);
		BestResult = ((base.SelfRankScore > 0) ? base.SelfRankScore.ToString() : "0");
		BestRank = ((base.SelfRankPosition > 0) ? base.SelfRankPosition.ToString() : "未上榜");
	}
}
