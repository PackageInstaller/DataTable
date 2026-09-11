public readonly struct SummerRaceAudioCue(string cueSheet, string cueName, bool useStream = false)
{
	public readonly string CueSheet = cueSheet ?? string.Empty;

	public readonly string CueName = cueName ?? string.Empty;

	public readonly bool UseStream = useStream;

	public bool IsValid
	{
		get
		{
			if (!string.IsNullOrEmpty(CueSheet))
			{
				return !string.IsNullOrEmpty(CueName);
			}
			return false;
		}
	}
}
