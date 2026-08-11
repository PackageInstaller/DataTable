using System;
using System.Collections.Generic;

namespace UnityEngine.Experimental.Rendering;

[AddComponentMenu("")]
[ExecuteAlways]
internal class ProbeVolumePerSceneData : MonoBehaviour, ISerializationCallbackReceiver
{
	[Serializable]
	private struct SerializableAssetItem
	{
		[SerializeField]
		public ProbeVolumeState state;

		[SerializeField]
		public ProbeVolumeAsset asset;
	}

	internal Dictionary<ProbeVolumeState, ProbeVolumeAsset> assets = new Dictionary<ProbeVolumeState, ProbeVolumeAsset>();

	[SerializeField]
	private List<SerializableAssetItem> serializedAssets;

	private ProbeVolumeState m_CurrentState;

	private ProbeVolumeState m_PreviousState = ProbeVolumeState.Invalid;

	public void OnAfterDeserialize()
	{
		if (serializedAssets == null)
		{
			return;
		}
		assets = new Dictionary<ProbeVolumeState, ProbeVolumeAsset>();
		foreach (SerializableAssetItem serializedAsset in serializedAssets)
		{
			assets.Add(serializedAsset.state, serializedAsset.asset);
		}
	}

	public void OnBeforeSerialize()
	{
		if (assets == null || serializedAssets == null)
		{
			return;
		}
		serializedAssets.Clear();
		SerializableAssetItem item = default(SerializableAssetItem);
		foreach (ProbeVolumeState key2 in assets.Keys)
		{
			ProbeVolumeState key = (item.state = key2);
			item.asset = assets[key];
			serializedAssets.Add(item);
		}
	}

	internal void StoreAssetForState(ProbeVolumeState state, ProbeVolumeAsset asset)
	{
		assets[state] = asset;
	}

	internal void InvalidateAllAssets()
	{
		foreach (ProbeVolumeAsset value in assets.Values)
		{
			if (value != null)
			{
				ProbeReferenceVolume.instance.AddPendingAssetRemoval(value);
			}
		}
		assets.Clear();
	}

	internal ProbeVolumeAsset GetCurrentStateAsset()
	{
		if (assets.ContainsKey(m_CurrentState))
		{
			return assets[m_CurrentState];
		}
		return null;
	}

	internal void QueueAssetLoading()
	{
		ProbeReferenceVolume instance = ProbeReferenceVolume.instance;
		if (assets.ContainsKey(m_CurrentState) && assets[m_CurrentState] != null)
		{
			instance.AddPendingAssetLoading(assets[m_CurrentState]);
			m_PreviousState = m_CurrentState;
		}
	}

	internal void QueueAssetRemoval()
	{
		if (assets.ContainsKey(m_CurrentState) && assets[m_CurrentState] != null)
		{
			ProbeReferenceVolume.instance.AddPendingAssetRemoval(assets[m_CurrentState]);
		}
	}

	private void OnEnable()
	{
		QueueAssetLoading();
	}

	private void OnDisable()
	{
		QueueAssetRemoval();
	}

	private void OnDestroy()
	{
		QueueAssetRemoval();
	}

	private void Update()
	{
		m_CurrentState = ProbeVolumeState.Default;
		if (m_PreviousState != m_CurrentState)
		{
			if (assets.ContainsKey(m_PreviousState) && assets[m_PreviousState] != null)
			{
				ProbeReferenceVolume.instance.AddPendingAssetRemoval(assets[m_PreviousState]);
			}
			QueueAssetLoading();
		}
	}
}
