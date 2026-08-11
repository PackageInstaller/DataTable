using System.Collections.Generic;

namespace GameFramework.Runtime;

public interface IBundle
{
	IDictionary<string, object> Data { get; }

	ICollection<string> Keys { get; }

	ICollection<object> Values { get; }

	int Count { get; }

	void Clear();

	bool ContainsKey(string key);

	bool Remove(string key);

	object Get(string key);

	T Get<T>(string key);

	T Get<T>(string key, T defaultValue);

	void Put<T>(string key, T value);

	void PutAll(IBundle bundle);
}
