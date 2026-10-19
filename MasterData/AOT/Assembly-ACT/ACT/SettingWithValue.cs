using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT;

[Serializable]
public abstract class SettingWithValue<TValue> : ISettingWithValue<TValue>, ISetting
{
	[SerializeField]
	protected string m_Description;

	[SerializeField]
	protected string m_Id;

	[SerializeField]
	protected int m_Version;

	[SerializeField]
	protected bool m_Usable = true;

	[SerializeField]
	protected TValue m_DefalutValue;

	[SerializeField]
	protected bool m_ApplyImmediately = true;

	[SerializeField]
	protected ConnectionSO m_ConnectionSO;

	[SerializeField]
	protected bool m_ConnectionOverrideUsable;

	[SerializeField]
	protected bool m_ConnectionOverrideDefault;

	private bool m_Initialized;

	private TValue m_Value;

	private TValue m_AppliedValue;

	protected bool m_HasUnAppliedValue;

	private bool m_Modified;

	protected List<Action<TValue>> m_ApplyListeners;

	protected List<Action<TValue>> m_ChangeListeners;

	private GameSettings m_Owner;

	private IConnection<TValue> m_Connection;

	private bool m_IsInSetValuePhase;

	private TValue m_RuntimeDefaultValue;

	public Action<ISetting> OnChange { get; set; }

	public string Id => m_Id;

	public string Description => m_Description;

	public int Version => m_Version;

	public bool Usable => m_Usable;

	public bool Enabled { get; private set; } = true;

	public bool Modified => m_Modified;

	public GameSettings Owner => m_Owner;

	public abstract SettingData.DataType DataType { get; }

	private void CheckApplyListeners()
	{
		if (m_ApplyListeners == null)
		{
			m_ApplyListeners = new List<Action<TValue>>();
		}
	}

	private void CheckChangeListeners()
	{
		if (m_ChangeListeners == null)
		{
			m_ChangeListeners = new List<Action<TValue>>();
		}
	}

	protected virtual TValue VerifyValue(TValue value)
	{
		return value;
	}

	public void Initialize(GameSettings owner)
	{
		if (!m_Initialized)
		{
			m_Initialized = true;
			m_Owner = owner;
			m_Connection = (m_ConnectionSO as IConnectionSO<TValue>)?.CreateConnection(this);
			m_RuntimeDefaultValue = m_DefalutValue;
			if (HasConnection() && m_ConnectionOverrideUsable)
			{
				m_Usable = m_Connection.GetUsable();
			}
			if (HasConnection() && m_ConnectionOverrideDefault)
			{
				m_RuntimeDefaultValue = m_Connection.GetDefault();
			}
			try
			{
				m_RuntimeDefaultValue = VerifyValue(m_RuntimeDefaultValue);
			}
			catch (Exception message)
			{
				Debug.LogError(message);
			}
			m_Value = m_RuntimeDefaultValue;
			m_AppliedValue = m_RuntimeDefaultValue;
		}
	}

	public bool HasConnection()
	{
		return m_Connection != null;
	}

	public IConnection<TValue> GetConnection()
	{
		return m_Connection;
	}

	public void InitToConnection()
	{
		if (HasConnection())
		{
			m_Connection.Init(GetValue());
		}
	}

	public void PushToConnection()
	{
		if (HasConnection())
		{
			m_Connection.Set(GetValue());
		}
	}

	public void ResetToDefault()
	{
		SetValue(m_RuntimeDefaultValue, applyImmediatly: true);
		m_Modified = false;
	}

	public void SetRuntimeDefaultValue(TValue value)
	{
		m_RuntimeDefaultValue = VerifyValue(value);
	}

	internal void SetRuntimeValue(TValue value, bool forceValue = false, bool markAsModified = false)
	{
		value = VerifyValue(value);
		if (!m_Modified || forceValue)
		{
			m_Value = value;
			m_AppliedValue = value;
			m_HasUnAppliedValue = false;
			if (forceValue)
			{
				m_Modified = markAsModified;
			}
			else if (markAsModified)
			{
				m_Modified = true;
			}
		}
	}

	public void ResetToAppliedValue()
	{
		if (HasUnAppliedChanges())
		{
			SetValue(m_AppliedValue);
			m_HasUnAppliedValue = false;
		}
	}

	public bool HasUnAppliedChanges()
	{
		return m_HasUnAppliedValue;
	}

	public void Apply()
	{
		if (!HasUnAppliedChanges())
		{
			return;
		}
		m_AppliedValue = m_Value;
		m_HasUnAppliedValue = false;
		m_Modified = true;
		PushToConnection();
		m_Owner?.NotifySettingApplied(this);
		if (m_ApplyListeners == null)
		{
			return;
		}
		foreach (Action<TValue> applyListener in m_ApplyListeners)
		{
			applyListener?.Invoke(GetValue());
		}
	}

	public TValue GetValue()
	{
		return m_Value;
	}

	public TValue GetAppliedValue()
	{
		return m_AppliedValue;
	}

	public void SetValue(TValue value, bool applyImmediatly = false)
	{
		SetValueInternal(value, applyImmediatly, ignoreUsable: false);
	}

	internal void SetValueFromPreset(TValue value)
	{
		SetValueInternal(value, applyImmediatly: false, ignoreUsable: true);
	}

	internal void ResetToValueFromPreset(TValue value)
	{
		value = VerifyValue(value);
		if (EqualityComparer<TValue>.Default.Equals(value, m_Value))
		{
			if (m_HasUnAppliedValue)
			{
				Apply();
			}
		}
		else
		{
			SetValueInternal(value, applyImmediatly: true, ignoreUsable: true);
		}
		m_Modified = false;
	}

	private void SetValueInternal(TValue value, bool applyImmediatly, bool ignoreUsable)
	{
		if ((!m_Usable && !ignoreUsable) || EqualityComparer<TValue>.Default.Equals(value, m_Value) || m_IsInSetValuePhase)
		{
			return;
		}
		m_IsInSetValuePhase = true;
		value = VerifyValue(value);
		try
		{
			m_Value = value;
			m_HasUnAppliedValue = true;
			if (m_ChangeListeners != null)
			{
				foreach (Action<TValue> changeListener in m_ChangeListeners)
				{
					changeListener?.Invoke(GetValue());
				}
			}
			OnChange?.Invoke(this);
			if (applyImmediatly || m_ApplyImmediately)
			{
				Apply();
			}
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
		finally
		{
			m_IsInSetValuePhase = false;
		}
	}

	public void AddChangedListener(Action<TValue> onChanged)
	{
		CheckChangeListeners();
		m_ChangeListeners.Add(onChanged);
	}

	public void RemoveChangedListener(Action<TValue> onChanged)
	{
		if (m_ChangeListeners != null)
		{
			m_ChangeListeners.Remove(onChanged);
		}
	}

	public void AddApplyListener(Action<TValue> onApply)
	{
		CheckApplyListeners();
		m_ApplyListeners.Add(onApply);
	}

	public void RemoveApplyListener(Action<TValue> onApply)
	{
		if (m_ApplyListeners != null)
		{
			m_ApplyListeners.Remove(onApply);
		}
	}

	public SettingData SerializeValueToData()
	{
		return DoSerializeValueToData();
	}

	public void DeserializeValueFromData(SettingData data)
	{
		DeserializeValueFromDataInternal(data, ignoreUsable: false);
	}

	internal void DeserializeValueFromDataIgnoringUsable(SettingData data)
	{
		DeserializeValueFromDataInternal(data, ignoreUsable: true);
	}

	private void DeserializeValueFromDataInternal(SettingData data, bool ignoreUsable)
	{
		if ((m_Usable || ignoreUsable) && data.Version == m_Version && DoDeserializeValueFromData(data, out var value))
		{
			m_AppliedValue = (m_Value = VerifyValue(value));
			m_Modified = true;
		}
	}

	protected abstract SettingData DoSerializeValueToData();

	protected abstract bool DoDeserializeValueFromData(SettingData data, out TValue value);

	public abstract bool CheckMatchValue(string value);
}
