namespace UnityEngine.Playables;

public static class PlayableExtensions
{
	public static bool IsValid<U>(this U playable) where U : struct, IPlayable
	{
		return playable.GetHandle().IsValid();
	}

	public static PlayableGraph GetGraph<U>(this U playable) where U : struct, IPlayable
	{
		return playable.GetHandle().GetGraph();
	}

	public static PlayState GetPlayState<U>(this U playable) where U : struct, IPlayable
	{
		return playable.GetHandle().GetPlayState();
	}

	public static void Play<U>(this U playable) where U : struct, IPlayable
	{
		playable.GetHandle().Play();
	}

	public static void Pause<U>(this U playable) where U : struct, IPlayable
	{
		playable.GetHandle().Pause();
	}

	public static void SetSpeed<U>(this U playable, double value) where U : struct, IPlayable
	{
		playable.GetHandle().SetSpeed(value);
	}

	public static double GetSpeed<U>(this U playable) where U : struct, IPlayable
	{
		return playable.GetHandle().GetSpeed();
	}

	public static void SetDuration<U>(this U playable, double value) where U : struct, IPlayable
	{
		playable.GetHandle().SetDuration(value);
	}

	public static double GetDuration<U>(this U playable) where U : struct, IPlayable
	{
		return playable.GetHandle().GetDuration();
	}

	public static void SetTime<U>(this U playable, double value) where U : struct, IPlayable
	{
		playable.GetHandle().SetTime(value);
	}

	public static double GetTime<U>(this U playable) where U : struct, IPlayable
	{
		return playable.GetHandle().GetTime();
	}

	public static double GetPreviousTime<U>(this U playable) where U : struct, IPlayable
	{
		return playable.GetHandle().GetPreviousTime();
	}

	public static bool IsDone<U>(this U playable) where U : struct, IPlayable
	{
		return playable.GetHandle().IsDone();
	}

	public static void SetPropagateSetTime<U>(this U playable, bool value) where U : struct, IPlayable
	{
		playable.GetHandle().SetPropagateSetTime(value);
	}

	public static void SetInputCount<U>(this U playable, int value) where U : struct, IPlayable
	{
		playable.GetHandle().SetInputCount(value);
	}

	public static int GetInputCount<U>(this U playable) where U : struct, IPlayable
	{
		return playable.GetHandle().GetInputCount();
	}

	public static Playable GetInput<U>(this U playable, int inputPort) where U : struct, IPlayable
	{
		return playable.GetHandle().GetInput(inputPort);
	}

	public static void SetInputWeight<U>(this U playable, int inputIndex, float weight) where U : struct, IPlayable
	{
		playable.GetHandle().SetInputWeight(inputIndex, weight);
	}

	public static void SetInputWeight<U, V>(this U playable, V input, float weight) where U : struct, IPlayable where V : struct, IPlayable
	{
		playable.GetHandle().SetInputWeight(input.GetHandle(), weight);
	}

	public static float GetInputWeight<U>(this U playable, int inputIndex) where U : struct, IPlayable
	{
		return playable.GetHandle().GetInputWeight(inputIndex);
	}

	public static void SetTraversalMode<U>(this U playable, PlayableTraversalMode mode) where U : struct, IPlayable
	{
		playable.GetHandle().SetTraversalMode(mode);
	}

	internal static DirectorWrapMode GetTimeWrapMode<U>(this U playable) where U : struct, IPlayable
	{
		return playable.GetHandle().GetTimeWrapMode();
	}

	internal static void SetTimeWrapMode<U>(this U playable, DirectorWrapMode value) where U : struct, IPlayable
	{
		playable.GetHandle().SetTimeWrapMode(value);
	}
}
