using System;

namespace Ase.Serializing;

public static class GenericWriter<T>
{
	public static Action<Writer, T> Write { get; set; }

	public static Action<Writer, T, AutoPackType> WriteAutoPack { get; set; }
}
