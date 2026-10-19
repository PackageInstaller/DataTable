using System;

namespace ACT;

[Serializable]
public class PlatformConfig<T>
{
	public bool Usable = true;

	public T Default;
}
