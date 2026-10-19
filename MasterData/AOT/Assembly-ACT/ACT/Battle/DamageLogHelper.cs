using System.Diagnostics;

namespace ACT.Battle;

public static class DamageLogHelper
{
	[Conditional("UNITY_EDITOR")]
	public static void Log(ref DamagePhaseContext ctx)
	{
	}
}
