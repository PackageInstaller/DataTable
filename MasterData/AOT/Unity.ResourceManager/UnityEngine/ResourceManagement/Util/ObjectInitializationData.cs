using System;
using UnityEngine.ResourceManagement.AsyncOperations;
using UnityEngine.Serialization;

namespace UnityEngine.ResourceManagement.Util;

[Serializable]
public struct ObjectInitializationData
{
	[SerializeField]
	[FormerlySerializedAs("m_id")]
	private string m_Id;

	[SerializeField]
	[FormerlySerializedAs("m_objectType")]
	private SerializedType m_ObjectType;

	[SerializeField]
	[FormerlySerializedAs("m_data")]
	private string m_Data;

	public string Id => m_Id;

	public SerializedType ObjectType => m_ObjectType;

	public string Data => m_Data;

	public override string ToString()
	{
		return $"ObjectInitializationData: id={m_Id}, type={m_ObjectType}";
	}

	public TObject CreateInstance<TObject>(string idOverride = null)
	{
		try
		{
			Type value = m_ObjectType.Value;
			if (value == null)
			{
				return default;
			}
			object obj = Activator.CreateInstance(value, nonPublic: true);
			if (obj is IInitializableObject initializableObject && !initializableObject.Initialize((idOverride == null) ? m_Id : idOverride, m_Data))
			{
				return default;
			}
			return (TObject)obj;
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			return default;
		}
	}

	public AsyncOperationHandle GetAsyncInitHandle(ResourceManager rm, string idOverride = null)
	{
		try
		{
			Type value = m_ObjectType.Value;
			if (value == null)
			{
				return default;
			}
			if (Activator.CreateInstance(value, nonPublic: true) is IInitializableObject initializableObject)
			{
				return initializableObject.InitializeAsync(rm, (idOverride == null) ? m_Id : idOverride, m_Data);
			}
			return default;
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			return default;
		}
	}
}
