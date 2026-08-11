using System;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Linq;
using System.Reflection;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{m_Value} ({m_OverrideState})")]
public class ObjectParameter<T> : VolumeParameter<T>
{
	internal ReadOnlyCollection<VolumeParameter> parameters { get; private set; }

	public sealed override bool overrideState
	{
		get
		{
			return true;
		}
		set
		{
			m_OverrideState = true;
		}
	}

	public sealed override T value
	{
		get
		{
			return m_Value;
		}
		set
		{
			m_Value = value;
			if (m_Value == null)
			{
				parameters = null;
				return;
			}
			parameters = (from t in m_Value.GetType().GetFields(BindingFlags.Instance | BindingFlags.Public)
				where t.FieldType.IsSubclassOf(typeof(VolumeParameter))
				orderby t.MetadataToken
				select (VolumeParameter)t.GetValue(m_Value)).ToList().AsReadOnly();
		}
	}

	public ObjectParameter(T value)
	{
		m_OverrideState = true;
		this.value = value;
	}

	internal override void Interp(VolumeParameter from, VolumeParameter to, float t)
	{
		if (m_Value == null)
		{
			return;
		}
		ReadOnlyCollection<VolumeParameter> readOnlyCollection = parameters;
		ReadOnlyCollection<VolumeParameter> readOnlyCollection2 = ((ObjectParameter<T>)from).parameters;
		ReadOnlyCollection<VolumeParameter> readOnlyCollection3 = ((ObjectParameter<T>)to).parameters;
		for (int i = 0; i < readOnlyCollection2.Count; i++)
		{
			readOnlyCollection[i].overrideState = readOnlyCollection3[i].overrideState;
			if (readOnlyCollection3[i].overrideState)
			{
				readOnlyCollection[i].Interp(readOnlyCollection2[i], readOnlyCollection3[i], t);
			}
		}
	}
}
