namespace ACT.Model;

public class SubworldModel : Model<SubworldModel>
{
	private int _totalTime;

	public int TotalTime => _totalTime;

	protected override void Init()
	{
	}

	protected override void UnInit()
	{
	}

	public void UpdateTime()
	{
		_totalTime++;
	}

	public void ResetTime()
	{
		_totalTime = 0;
	}
}
