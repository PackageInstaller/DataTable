namespace Ase;

public struct TaskTargetData(string desc, int progressValue, int targetValue)
{
	private string _targetDesc = desc;

	private int _targetValue = targetValue;

	private int _progressValue = progressValue;

	public string TargetDesc => _targetDesc;

	public int TargetValue => _targetValue;

	public int ProgressValue => _progressValue;
}
