using Ase.ECS;
using UnityEngine;

namespace Ase;

public interface IMapDataNodeParadoxParameter
{
	void InjectData(string key, ref AIParadoxComponent aiParadoxComponent);

	void SetValue(int value);

	void SetValue(string value);

	void SetValue(bool value);

	void SetValue(float value);

	void SetValue(Vector3 value);

	object GetValue();
}
