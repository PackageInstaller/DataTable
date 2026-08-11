namespace Ase;

public class BattleReadyData
{
	private BattleReadyTarget target;

	private BattleMode mode;

	private int targetId;

	private int targetLevel;

	private int copyDropType;

	private int dropRate = -1;

	private TeamModel teamModel;

	private int teamSetId;

	public BattleReadyTarget Target => target;

	public BattleMode BattleMode => mode;

	public int TargetId => targetId;

	public int TargetLevel => targetLevel;

	public TeamModel TeamModel => teamModel;

	public int CopyDropType => copyDropType;

	public int DropRate => dropRate;

	public int TeamSetId => teamSetId;

	private BattleReadyData()
	{
	}

	public BattleReadyData(BattleReadyTarget target, int targetId, int copyDropType = 0, int targetLevel = 0, BattleMode battleMode = BattleMode.None)
	{
		this.target = target;
		mode = battleMode;
		this.targetId = targetId;
		this.targetLevel = targetLevel;
		this.copyDropType = copyDropType;
	}

	public static BattleReadyData CreateByHeroTry(BattleReadyTarget target, int targetId, int teamSetId)
	{
		return new BattleReadyData
		{
			target = target,
			targetId = targetId,
			teamSetId = teamSetId
		};
	}

	public void SetBattleMode(BattleMode mode)
	{
		this.mode = mode;
	}

	public void SetTeamModel(TeamModel teamModel)
	{
		this.teamModel = teamModel;
	}

	public void SetDropRate(int dropRate)
	{
		this.dropRate = dropRate;
	}
}
