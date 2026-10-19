using System;
using System.Collections.Generic;

namespace ACT;

[Serializable]
public class OptionsPlatformConfig<T>
{
	public bool Usable = true;

	public int Default;

	public List<T> Options = new List<T>();
}
