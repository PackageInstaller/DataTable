using System;

namespace Ase.Serializing.Helping;

public class GeneratedComparer<T>
{
	public static Func<T, bool> IsDefault { internal get; set; }

	public static Func<T, T, bool> Compare { internal get; set; }
}
