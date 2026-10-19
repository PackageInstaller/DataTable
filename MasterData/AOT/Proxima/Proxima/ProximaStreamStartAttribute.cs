using System;
using UnityEngine.Scripting;

namespace Proxima;

[AttributeUsage(AttributeTargets.Method)]
internal class ProximaStreamStartAttribute : PreserveAttribute
{
	public string Name;

	public ProximaStreamStartAttribute(string name, bool hidden = false)
	{
		Name = name;
	}
}
