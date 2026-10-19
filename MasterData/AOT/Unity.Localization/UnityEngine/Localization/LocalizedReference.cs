using System;
using UnityEngine.Localization.Settings;
using UnityEngine.Localization.Tables;

namespace UnityEngine.Localization;

[Serializable]
public abstract class LocalizedReference : ISerializationCallbackReceiver
{
	[SerializeField]
	private TableReference m_TableReference;

	[SerializeField]
	private TableEntryReference m_TableEntryReference;

	[SerializeField]
	private FallbackBehavior m_FallbackState;

	[SerializeField]
	private bool m_WaitForCompletion;

	private Locale m_LocaleOverride;

	public TableReference TableReference
	{
		get
		{
			return m_TableReference;
		}
		set
		{
			if (!value.Equals(m_TableReference))
			{
				m_TableReference = value;
				ForceUpdate();
			}
		}
	}

	public TableEntryReference TableEntryReference
	{
		get
		{
			return m_TableEntryReference;
		}
		set
		{
			if (!value.Equals(m_TableEntryReference))
			{
				m_TableEntryReference = value;
				ForceUpdate();
			}
		}
	}

	public FallbackBehavior FallbackState
	{
		get
		{
			return m_FallbackState;
		}
		set
		{
			m_FallbackState = value;
		}
	}

	public Locale LocaleOverride
	{
		get
		{
			return m_LocaleOverride;
		}
		set
		{
			if (!(m_LocaleOverride == value))
			{
				m_LocaleOverride = value;
				ForceUpdate();
			}
		}
	}

	public virtual bool WaitForCompletion
	{
		get
		{
			return m_WaitForCompletion;
		}
		set
		{
			m_WaitForCompletion = value;
		}
	}

	public bool IsEmpty
	{
		get
		{
			if (TableReference.ReferenceType != TableReference.Type.Empty)
			{
				return TableEntryReference.ReferenceType == TableEntryReference.Type.Empty;
			}
			return true;
		}
	}

	public void SetReference(TableReference table, TableEntryReference entry)
	{
		bool flag = false;
		if (!m_TableReference.Equals(table))
		{
			m_TableReference = table;
			flag = true;
		}
		if (!m_TableEntryReference.Equals(entry))
		{
			m_TableEntryReference = entry;
			flag = true;
		}
		if (flag)
		{
			ForceUpdate();
		}
	}

	public override string ToString()
	{
		return $"{TableReference}/{TableEntryReference.ToString(TableReference)}";
	}

	protected internal abstract void ForceUpdate();

	protected abstract void Reset();

	public virtual void OnBeforeSerialize()
	{
	}

	public virtual void OnAfterDeserialize()
	{
	}
}
