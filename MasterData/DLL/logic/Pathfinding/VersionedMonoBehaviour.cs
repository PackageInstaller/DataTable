using UnityEngine;

namespace Pathfinding;

public abstract class VersionedMonoBehaviour : MonoBehaviour, ISerializationCallbackReceiver
{
	[SerializeField]
	[HideInInspector]
	private int version;

	protected virtual void Awake()
	{
		if (Application.isPlaying)
		{
			version = OnUpgradeSerializedData(int.MaxValue);
		}
	}

	private void Reset()
	{
		version = OnUpgradeSerializedData(int.MaxValue);
	}

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		version = OnUpgradeSerializedData(version);
	}

	protected virtual int OnUpgradeSerializedData(int version)
	{
		return 1;
	}
}
