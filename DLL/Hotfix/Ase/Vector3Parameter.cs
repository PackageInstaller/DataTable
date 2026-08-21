using Ase.ECS;
using UnityEngine;

namespace Ase;

public struct Vector3Parameter : IMapDataNodeParadoxParameter
{
	public Vector3 value;

	public void SetValue(int value)
	{
	}

	public void SetValue(string value)
	{
	}

	public void SetValue(bool value)
	{
	}

	public void SetValue(float value)
	{
	}

	public void SetValue(Vector3 value)
	{
		this.value = value;
	}

	public object GetValue()
	{
		return value;
	}

	public void InjectData(string key, ref AIParadoxComponent aiParadoxComponent)
	{
		aiParadoxComponent.SetVariableValues(key, value);
	}
}
