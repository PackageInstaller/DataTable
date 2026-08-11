namespace Ase;

public class CampaignNodeBase
{
	public CampaignNodeState State { get; protected set; }

	public bool IsWaiting => State == CampaignNodeState.Waiting;

	public bool IsActive => State == CampaignNodeState.Active;

	public bool IsCompleted => State == CampaignNodeState.Completed;

	public virtual void Activate()
	{
		if (State != CampaignNodeState.Completed)
		{
			State = CampaignNodeState.Active;
		}
	}

	public virtual void Complete()
	{
		State = CampaignNodeState.Completed;
	}

	public virtual void Reset()
	{
		State = CampaignNodeState.Waiting;
	}
}
