using System;
using System.Collections.Generic;
using GameFramework;

namespace Ase.ECS;

public interface IComponentData : IReference
{
	IDictionary<string, object> Data { get; }

	bool ContainsKey(string key);

	bool Remove(string key);

	T Get<T>(string key);

	Type GetKeyType(string key);

	T Get<T>(string key, T defaultValue);

	void Put<T>(string key, T value);

	void PutAll(IComponentData data);
}
