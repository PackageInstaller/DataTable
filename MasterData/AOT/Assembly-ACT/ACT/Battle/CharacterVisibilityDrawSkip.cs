using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle;

public static class CharacterVisibilityDrawSkip
{
	private static readonly Dictionary<Renderer, int> s_SkipCounts = new Dictionary<Renderer, int>();

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.SubsystemRegistration)]
	private static void RegisterMaterialOverrideSkip()
	{
		MaterialOverride.ShouldSkipRenderer = IsSkipped;
	}

	public static void Add(Renderer renderer)
	{
		if (!(renderer == null))
		{
			s_SkipCounts.TryGetValue(renderer, out var value);
			s_SkipCounts[renderer] = value + 1;
		}
	}

	public static void Remove(Renderer renderer)
	{
		Remove(renderer, 1);
	}

	public static void Remove(Renderer renderer, int count)
	{
		if (!(renderer == null) && count > 0 && s_SkipCounts.TryGetValue(renderer, out var value))
		{
			value -= count;
			if (value <= 0)
			{
				s_SkipCounts.Remove(renderer);
			}
			else
			{
				s_SkipCounts[renderer] = value;
			}
		}
	}

	public static bool IsSkipped(Renderer renderer)
	{
		if (renderer != null && s_SkipCounts.TryGetValue(renderer, out var value))
		{
			return value > 0;
		}
		return false;
	}
}
