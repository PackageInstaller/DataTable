using System.Diagnostics;

namespace Ase;

public static class BattleCalculateLog
{
	public static bool Open;

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Log(object obj)
	{
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void FormulaLog(object obj)
	{
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void MonsterLog(object obj)
	{
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void LogError(object obj)
	{
	}
}
