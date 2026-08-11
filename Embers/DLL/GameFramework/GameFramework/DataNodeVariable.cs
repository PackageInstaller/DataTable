using System;

namespace GameFramework;

public abstract class DataNodeVariable : IReference
{
	public abstract Type Type { get; }

	public DataNodeVariable()
	{
	}

	public abstract object GetValue();

	public abstract void SetValue(object value);

	public abstract void Clear();
}
public abstract class DataNodeVariable<T> : DataNodeVariable
{
	private T m_Value;

	public override Type Type => typeof(T);

	public T Value
	{
		get
		{
			return m_Value;
		}
		set
		{
			m_Value = value;
		}
	}

	public DataNodeVariable()
	{
		m_Value = default(T);
	}

	public override object GetValue()
	{
		return m_Value;
	}

	public override void SetValue(object value)
	{
		m_Value = (T)value;
	}

	public override void Clear()
	{
		m_Value = default(T);
	}

	public override string ToString()
	{
		return (m_Value != null) ? m_Value.ToString() : "<Null>";
	}
}
