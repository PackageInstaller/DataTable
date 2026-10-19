using System;
using UnityEngine;

namespace Bamboo.AssetField;

public interface IAssetAdapter
{
	bool AssetExists(string key);

	T Load<T>(string key) where T : UnityEngine.Object;

	void LoadAsync<T>(string key, Action<T> callback) where T : UnityEngine.Object;

	void Unload(string key);

	void WaitForCommit<T>(string key) where T : UnityEngine.Object;
}
