namespace ACT.Battle;

public class TaskInfo
{
	public int progress;

	public int status;

	public virtual bool IsComplete(int[] param)
	{
		return false;
	}

	public virtual float GetCompletePercent(int[] param)
	{
		return 1f;
	}

	public virtual int GetCompleteCount(int[] param)
	{
		return 0;
	}

	public virtual double GetDoubleCompleteCount(int[] param)
	{
		return 0.0;
	}

	public virtual int GetNeedCount(int[] param)
	{
		return 0;
	}

	public virtual double GetDoubleTypeNeedCount(int[] param)
	{
		return 0.0;
	}
}
