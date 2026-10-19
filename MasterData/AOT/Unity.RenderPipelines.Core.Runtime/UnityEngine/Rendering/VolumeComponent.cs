using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Reflection;

namespace UnityEngine.Rendering;

[Serializable]
public class VolumeComponent : ScriptableObject
{
	public bool active = true;

	internal readonly List<VolumeParameter> parameterList = new List<VolumeParameter>();

	private ReadOnlyCollection<VolumeParameter> m_ParameterReadOnlyCollection;

	public string displayName { get; protected set; } = "";

	public ReadOnlyCollection<VolumeParameter> parameters
	{
		get
		{
			if (m_ParameterReadOnlyCollection == null)
			{
				m_ParameterReadOnlyCollection = parameterList.AsReadOnly();
			}
			return m_ParameterReadOnlyCollection;
		}
	}

	internal static void FindParameters(object o, List<VolumeParameter> parameters, Func<FieldInfo, bool> filter = null)
	{
		if (o == null)
		{
			return;
		}
		foreach (FieldInfo item in from t in o.GetType().GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)
			orderby t.MetadataToken
			select t)
		{
			if (item.FieldType.IsSubclassOf(typeof(VolumeParameter)))
			{
				if (filter == null || filter(item))
				{
					parameters.Add((VolumeParameter)item.GetValue(o));
				}
			}
			else if (!item.FieldType.IsArray && item.FieldType.IsClass)
			{
				FindParameters(item.GetValue(o), parameters, filter);
			}
		}
	}

	protected virtual void OnEnable()
	{
		parameterList.Clear();
		FindParameters(this, parameterList);
		foreach (VolumeParameter parameter in parameterList)
		{
			if (parameter != null)
			{
				parameter.OnEnable();
			}
			else
			{
				Debug.LogWarning("Volume Component " + GetType().Name + " contains a null parameter; please make sure all parameters are initialized to a default value. Until this is fixed the null parameters will not be considered by the system.");
			}
		}
	}

	protected virtual void OnDisable()
	{
		foreach (VolumeParameter parameter in parameterList)
		{
			parameter?.OnDisable();
		}
	}

	public virtual void Override(VolumeComponent state, float interpFactor)
	{
		int count = parameterList.Count;
		for (int i = 0; i < count; i++)
		{
			VolumeParameter volumeParameter = state.parameterList[i];
			VolumeParameter volumeParameter2 = parameterList[i];
			if (volumeParameter2.overrideState)
			{
				volumeParameter.overrideState = volumeParameter2.overrideState;
				volumeParameter.Interp(volumeParameter, volumeParameter2, interpFactor);
			}
		}
	}

	public void SetAllOverridesTo(bool state)
	{
		SetOverridesTo(parameterList, state);
	}

	internal void SetOverridesTo(IEnumerable<VolumeParameter> enumerable, bool state)
	{
		foreach (VolumeParameter item in enumerable)
		{
			item.overrideState = state;
			Type type = item.GetType();
			if (VolumeParameter.IsObjectParameter(type))
			{
				ReadOnlyCollection<VolumeParameter> readOnlyCollection = (ReadOnlyCollection<VolumeParameter>)type.GetProperty("parameters", BindingFlags.Instance | BindingFlags.NonPublic).GetValue(item, null);
				if (readOnlyCollection != null)
				{
					SetOverridesTo(readOnlyCollection, state);
				}
			}
		}
	}

	public override int GetHashCode()
	{
		int num = 17;
		for (int i = 0; i < parameterList.Count; i++)
		{
			num = num * 23 + parameterList[i].GetHashCode();
		}
		return num;
	}

	public bool AnyPropertiesIsOverridden()
	{
		for (int i = 0; i < parameterList.Count; i++)
		{
			if (parameterList[i].overrideState)
			{
				return true;
			}
		}
		return false;
	}

	protected virtual void OnDestroy()
	{
		Release();
	}

	public void Release()
	{
		if (parameterList == null)
		{
			return;
		}
		for (int i = 0; i < parameterList.Count; i++)
		{
			if (parameterList[i] != null)
			{
				parameterList[i].Release();
			}
		}
	}
}
