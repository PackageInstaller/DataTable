namespace ACT;

public readonly struct GraphicPerformanceAdjustment
{
	public string OptionId { get; }

	public int CurrentOption { get; }

	public string CurrentOptionLabel { get; }

	public int CandidateOption { get; }

	public string CandidateOptionLabel { get; }

	public float CandidateSettingWeight { get; }

	public float CandidateRequiredRating { get; }

	public float CandidateLoadRatio { get; }

	public float LoadRatioDelta { get; }

	internal GraphicPerformanceAdjustment(string optionId, int currentOption, string currentOptionLabel, int candidateOption, string candidateOptionLabel, float candidateSettingWeight, float candidateRequiredRating, float candidateLoadRatio, float loadRatioDelta)
	{
		OptionId = optionId;
		CurrentOption = currentOption;
		CurrentOptionLabel = currentOptionLabel;
		CandidateOption = candidateOption;
		CandidateOptionLabel = candidateOptionLabel;
		CandidateSettingWeight = candidateSettingWeight;
		CandidateRequiredRating = candidateRequiredRating;
		CandidateLoadRatio = candidateLoadRatio;
		LoadRatioDelta = loadRatioDelta;
	}
}
