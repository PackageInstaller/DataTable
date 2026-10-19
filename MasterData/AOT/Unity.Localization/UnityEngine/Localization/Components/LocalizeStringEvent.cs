using System.Collections.Generic;
using UnityEngine.Localization.Events;

namespace UnityEngine.Localization.Components;

[AddComponentMenu("Localization/Localize String Event")]
public class LocalizeStringEvent : LocalizedMonoBehaviour
{
	[SerializeField]
	private LocalizedString m_StringReference = new LocalizedString();

	[SerializeField]
	private List<Object> m_FormatArguments = new List<Object>();

	[SerializeField]
	private UnityEventString m_UpdateString = new UnityEventString();

	private LocalizedString.ChangeHandler m_ChangeHandler;

	public LocalizedString StringReference
	{
		get
		{
			return m_StringReference;
		}
		set
		{
			ClearChangeHandler();
			m_StringReference = value;
			if (isActiveAndEnabled)
			{
				RegisterChangeHandler();
			}
		}
	}

	public UnityEventString OnUpdateString
	{
		get
		{
			return m_UpdateString;
		}
		set
		{
			m_UpdateString = value;
		}
	}

	public void RefreshString()
	{
		StringReference.RefreshString();
	}

	public void SetTable(string tableReference)
	{
		StringReference.TableReference = tableReference;
	}

	public void SetEntry(string entryName)
	{
		StringReference.TableEntryReference = entryName;
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

	protected virtual void UpdateString(string value)
	{
		OnUpdateString.Invoke(value);
	}

	private void OnValidate()
	{
		RefreshString();
	}

	internal virtual void RegisterChangeHandler()
	{
		if (m_FormatArguments.Count > 0)
		{
			StringReference.Arguments = m_FormatArguments.ToArray();
			if (Application.isPlaying)
			{
				Debug.LogWarningFormat("LocalizeStringEvent({0}) is using the deprecated Format Arguments field which will be removed in the future. Consider upgrading to use String Reference Local Variables instead.", name, this);
			}
		}
		if (m_ChangeHandler == null)
		{
			m_ChangeHandler = UpdateString;
		}
		StringReference.StringChanged += m_ChangeHandler;
	}

	internal virtual void ClearChangeHandler()
	{
		StringReference.StringChanged -= m_ChangeHandler;
	}
}
