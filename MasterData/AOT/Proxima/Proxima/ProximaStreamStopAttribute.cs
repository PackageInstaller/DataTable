using System;
using UnityEngine.Scripting;

namespace Proxima;

[AttributeUsage(AttributeTargets.Method)]
internal class ProximaStreamStopAttribute : PreserveAttribute
{
	public string Name;

	public ProximaStreamStopAttribute(string name, bool hidden = false)
	{
		Name = name;
	}
}
