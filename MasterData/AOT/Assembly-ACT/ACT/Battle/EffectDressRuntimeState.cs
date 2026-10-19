using System.Collections.Generic;

namespace ACT.Battle;

public class EffectDressRuntimeState
{
	public readonly Dictionary<int, EffectDressRuntime> activeRuntimes = new Dictionary<int, EffectDressRuntime>();

	public readonly Dictionary<int, int> activeDressIdByDressType = new Dictionary<int, int>();

	public int runtimeVersion;

	public void Reset()
	{
		activeRuntimes.Clear();
		activeDressIdByDressType.Clear();
		runtimeVersion = 0;
	}
}
