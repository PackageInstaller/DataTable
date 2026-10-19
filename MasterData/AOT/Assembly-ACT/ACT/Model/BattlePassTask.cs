namespace ACT.Model;

public class BattlePassTask
{
	public int TaskId { get; set; }

	public int TaskGroupId { get; set; }

	public BattlePassTaskType TaskType { get; set; }

	public BattlePassTaskRefreshType RefreshType { get; set; }

	public string Description { get; set; }

	public int Exp { get; set; }

	public int CurrentProgress { get; set; }

	public int TargetProgress { get; set; }

	public BattlePassTaskStatus Status { get; set; }

	public int SortWeight { get; set; }

	public int JumpId { get; set; }

	public bool IsDone => Status != BattlePassTaskStatus.UnDone;

	public bool CanClaim => Status == BattlePassTaskStatus.DoneUnClaimed;
}
