using UnityEngine.Events;

namespace UnityEngine.Localization.Components;

public class LocalizedAssetEvent<TObject, TReference, TEvent> : LocalizedAssetBehaviour<TObject, TReference> where TObject : Object where TReference : LocalizedAsset<TObject>, new() where TEvent : UnityEvent<TObject>, new()
{
	[SerializeField]
	private TEvent m_UpdateAsset = new TEvent();

	public TEvent OnUpdateAsset
	{
		get
		{
			return m_UpdateAsset;
		}
		set
		{
			m_UpdateAsset = value;
		}
	}

	protected override void UpdateAsset(TObject localizedAsset)
	{
		OnUpdateAsset.Invoke(localizedAsset);
	}
}
