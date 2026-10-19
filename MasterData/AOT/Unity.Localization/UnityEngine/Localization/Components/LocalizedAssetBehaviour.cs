namespace UnityEngine.Localization.Components;

[ExecuteAlways]
public abstract class LocalizedAssetBehaviour<TObject, TReference> : LocalizedMonoBehaviour where TObject : Object where TReference : LocalizedAsset<TObject>, new()
{
	[SerializeField]
	private TReference m_LocalizedAssetReference = new TReference();

	private LocalizedAsset<TObject>.ChangeHandler m_ChangeHandler;

	public TReference AssetReference
	{
		get
		{
			return m_LocalizedAssetReference;
		}
		set
		{
			ClearChangeHandler();
			m_LocalizedAssetReference = value;
			if (isActiveAndEnabled)
			{
				RegisterChangeHandler();
			}
		}
	}

	protected virtual void OnEnable()
	{
		RegisterChangeHandler();
	}

	protected virtual void OnDisable()
	{
		ClearChangeHandler();
	}

	private void OnDestroy()
	{
		ClearChangeHandler();
	}

	private void OnValidate()
	{
		AssetReference.ForceUpdate();
	}

	internal virtual void RegisterChangeHandler()
	{
		if (m_ChangeHandler == null)
		{
			m_ChangeHandler = UpdateAsset;
		}
		AssetReference.AssetChanged += m_ChangeHandler;
	}

	internal virtual void ClearChangeHandler()
	{
		AssetReference.AssetChanged -= m_ChangeHandler;
	}

	protected abstract void UpdateAsset(TObject localizedAsset);
}
