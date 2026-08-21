using System.Collections.Generic;
using UnityEngine.SceneManagement;

namespace Ase.Serializing.Helping;

internal class SceneComparer : IEqualityComparer<Scene>
{
	public bool Equals(Scene a, Scene b)
	{
		if (!a.IsValid() || !b.IsValid())
		{
			return false;
		}
		if (a.handle != 0 || b.handle != 0)
		{
			return a.handle == b.handle;
		}
		return a.name == b.name;
	}

	public int GetHashCode(Scene obj)
	{
		return obj.GetHashCode();
	}
}
