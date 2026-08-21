namespace Ase;

public class CopySecondType3FirePowerViewModel : CopySecondType3SingleModeViewModelBase
{
	private string currentHeroIcon;

	private string personalBestScore;

	private string personalBestRank;

	protected override string ModeNameText => "火力试炼";

	protected override string RuleDescText => "单人挑战，进入伤害排行模式";

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

	public string PersonalBestScore
	{
		get
		{
			return personalBestScore;
		}
		private set
		{
			Set(ref personalBestScore, value, "PersonalBestScore");
		}
	}

	public string PersonalBestRank
	{
		get
		{
			return personalBestRank;
		}
		private set
		{
			Set(ref personalBestRank, value, "PersonalBestRank");
		}
	}

	public override string PrimaryResultText => PersonalBestScore;

	public override string SecondaryResultText => string.Empty;

	public CopySecondType3FirePowerViewModel()
		: base(null, CopyType3Mode.FirePower)
	{
	}

	public CopySecondType3FirePowerViewModel(OptionBase parent)
		: base(parent, CopyType3Mode.FirePower)
	{
	}

	protected override void RefreshBasicDisplayData()
	{
		base.RefreshBasicDisplayData();
		int heroIdForCopyType3FirePower = Singleton<ServiceSystem>.Instance.GetService<ITeamService>().GetHeroIdForCopyType3FirePower();
		heroIdForCopyType3FirePower = ((heroIdForCopyType3FirePower == 0) ? 1104 : heroIdForCopyType3FirePower);
		base.CurrentHeroName = CopySecondType3SingleModeViewModelBase.GetHeroName(heroIdForCopyType3FirePower);
		CurrentHeroIcon = CopySecondType3SingleModeViewModelBase.GetHeroIcon(heroIdForCopyType3FirePower);
		PersonalBestScore = ((base.SelfRankScore > 0) ? base.SelfRankScore.ToString() : "0");
		PersonalBestRank = ((base.SelfRankPosition > 0) ? base.SelfRankPosition.ToString() : "未上榜");
	}

	protected override void OnRankRequestUnavailable()
	{
		base.OnRankRequestUnavailable();
		PersonalBestScore = "0";
		PersonalBestRank = "未上榜";
	}
}
