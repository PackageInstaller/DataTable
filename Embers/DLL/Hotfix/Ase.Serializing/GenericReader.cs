using System;

namespace Ase.Serializing;

public static class GenericReader<T>
{
	public static Func<Reader, T> Read { internal get; set; }

	public static Func<Reader, AutoPackType, T> ReadAutoPack { internal get; set; }
}
