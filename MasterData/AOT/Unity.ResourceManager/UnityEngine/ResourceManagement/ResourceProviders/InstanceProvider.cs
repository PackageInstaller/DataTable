using System.Collections.Generic;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.ResourceManagement.ResourceProviders;

public class InstanceProvider : IInstanceProvider
{
	private Dictionary<GameObject, AsyncOperationHandle<GameObject>> m_InstanceObjectToPrefabHandle = new Dictionary<GameObject, AsyncOperationHandle<GameObject>>();

	public GameObject ProvideInstance(ResourceManager resourceManager, AsyncOperationHandle<GameObject> prefabHandle, InstantiationParameters instantiateParameters)
	{
		GameObject gameObject = instantiateParameters.Instantiate(prefabHandle.Result);
		m_InstanceObjectToPrefabHandle.Add(gameObject, prefabHandle);
		return gameObject;
	}

	public void ReleaseInstance(ResourceManager resourceManager, GameObject instance)
	{
		if ((object)instance == null)
		{
			return;
		}
		if (!m_InstanceObjectToPrefabHandle.TryGetValue(instance, out var value))
		{
			Debug.LogWarningFormat("Releasing unknown GameObject {0} to InstanceProvider.", instance);
		}
		else
		{
			value.Release();
			m_InstanceObjectToPrefabHandle.Remove(instance);
		}
		if (instance != null)
		{
			if (Application.isPlaying)
			{
				Object.Destroy(instance);
			}
			else
			{
				Object.DestroyImmediate(instance);
			}
		}
	}
}
