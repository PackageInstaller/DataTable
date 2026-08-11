using System.Collections.Generic;
using UnityEngine.Pool;

namespace Ase;

public static class BGMExtension
{
	public static List<AudioParameter> TransParameters(this List<AudioParameterSerializable> parameter)
	{
		List<AudioParameter> list = CollectionPool<List<AudioParameter>, AudioParameter>.Get();
		if (parameter != null)
		{
			foreach (AudioParameterSerializable item in parameter)
			{
				list.Add(new AudioParameter
				{
					key = item.Key,
					targetVal = item.Value,
					duration = item.Duration
				});
			}
		}
		return list;
	}
}
