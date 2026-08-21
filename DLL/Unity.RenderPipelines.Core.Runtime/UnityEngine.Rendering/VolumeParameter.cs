using System;
using System.Collections.Generic;
using System.Diagnostics;

namespace UnityEngine.Rendering;

public abstract class VolumeParameter
{
	public const string k_DebuggerDisplay = "{m_Value} ({m_OverrideState})";

	[SerializeField]
	protected bool m_OverrideState;

	public virtual bool overrideState
	{
		get
		{
			return m_OverrideState;
		}
		set
		{
			m_OverrideState = value;
		}
	}

	internal abstract void Interp(VolumeParameter from, VolumeParameter to, float t);

	public T GetValue<T>()
	{
		return ((VolumeParameter<T>)this).value;
	}

	public abstract void SetValue(VolumeParameter parameter);

	protected internal virtual void OnEnable()
	{
	}

	protected internal virtual void OnDisable()
	{
	}

	public static bool IsObjectParameter(Type type)
	{
		if (type.IsGenericType && type.GetGenericTypeDefinition() == typeof(ObjectParameter<>))
		{
			return true;
		}
		if (type.BaseType != null)
		{
			return IsObjectParameter(type.BaseType);
		}
		return false;
	}

	public virtual void Release()
	{
	}
}
[Serializable]
[DebuggerDisplay("{m_Value} ({m_OverrideState})")]
public class VolumeParameter<T> : VolumeParameter, IEquatable<VolumeParameter<T>>
{
	[SerializeField]
	protected T m_Value;

	public virtual T value
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

	public VolumeParameter()
		: this(default(T), false)
	{
	}

	protected VolumeParameter(T value, bool overrideState)
	{
		m_Value = value;
		this.overrideState = overrideState;
	}

	internal override void Interp(VolumeParameter from, VolumeParameter to, float t)
	{
		Interp(from.GetValue<T>(), to.GetValue<T>(), t);
	}

	public virtual void Interp(T from, T to, float t)
	{
		m_Value = ((t > 0f) ? to : from);
	}

	public void Override(T x)
	{
		overrideState = true;
		m_Value = x;
	}

	public override void SetValue(VolumeParameter parameter)
	{
		m_Value = parameter.GetValue<T>();
	}

	public override int GetHashCode()
	{
		int num = 17;
		num = num * 23 + overrideState.GetHashCode();
		if (!EqualityComparer<T>.Default.Equals(value, default(T)))
		{
			num = num * 23 + value.GetHashCode();
		}
		return num;
	}

	public override string ToString()
	{
		return $"{value} ({overrideState})";
	}

	public static bool operator ==(VolumeParameter<T> lhs, T rhs)
	{
		if (lhs != null && lhs.value != null)
		{
			return lhs.value.Equals(rhs);
		}
		return false;
	}

	public static bool operator !=(VolumeParameter<T> lhs, T rhs)
	{
		return !(lhs == rhs);
	}

	public bool Equals(VolumeParameter<T> other)
	{
		if (other == null)
		{
			return false;
		}
		if (this == other)
		{
			return true;
		}
		return EqualityComparer<T>.Default.Equals(m_Value, other.m_Value);
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (this == obj)
		{
			return true;
		}
		if (obj.GetType() != GetType())
		{
			return false;
		}
		return Equals((VolumeParameter<T>)obj);
	}

	public static explicit operator T(VolumeParameter<T> prop)
	{
		return prop.m_Value;
	}
}
