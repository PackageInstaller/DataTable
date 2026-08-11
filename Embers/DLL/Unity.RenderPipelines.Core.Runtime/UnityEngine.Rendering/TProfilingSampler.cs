using System;
using System.Collections.Generic;

namespace UnityEngine.Rendering;

internal class TProfilingSampler<TEnum> : ProfilingSampler where TEnum : Enum
{
	internal static Dictionary<TEnum, TProfilingSampler<TEnum>> samples;

	static TProfilingSampler()
	{
		samples = new Dictionary<TEnum, TProfilingSampler<TEnum>>();
		string[] names = Enum.GetNames(typeof(TEnum));
		Array values = Enum.GetValues(typeof(TEnum));
		for (int i = 0; i < names.Length; i++)
		{
			TProfilingSampler<TEnum> value = new TProfilingSampler<TEnum>(names[i]);
			samples.Add((TEnum)values.GetValue(i), value);
		}
	}

	public TProfilingSampler(string name)
		: base(name)
	{
	}
}
