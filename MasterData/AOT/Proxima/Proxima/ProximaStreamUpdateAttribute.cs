using System;
using UnityEngine.Scripting;

namespace Proxima;

[AttributeUsage(AttributeTargets.Method)]
internal class ProximaStreamUpdateAttribute : PreserveAttribute
{
	public string Name;

	public ProximaStreamUpdateAttribute(string name, bool hidden = false)
	{
		Name = name;
	}
}
