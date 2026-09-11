namespace MusicGame;

public struct MusicGameTiming
{
	public double constant;

	public double speed;

	public int startTime;

	public int endTime;

	public static readonly MusicGameTiming y_zero = new MusicGameTiming
	{
		constant = 0.0,
		endTime = int.MaxValue,
		speed = 1.0,
		startTime = 0
	};
}
