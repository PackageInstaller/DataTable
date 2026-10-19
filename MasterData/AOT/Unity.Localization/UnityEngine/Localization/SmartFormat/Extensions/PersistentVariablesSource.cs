using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using UnityEngine.Localization.SmartFormat.Core.Extensions;
using UnityEngine.Localization.SmartFormat.Core.Formatting;
using UnityEngine.Localization.SmartFormat.PersistentVariables;

namespace UnityEngine.Localization.SmartFormat.Extensions;

[Serializable]
public class PersistentVariablesSource : ISource, IDictionary<string, VariablesGroupAsset>, ICollection<KeyValuePair<string, VariablesGroupAsset>>, IEnumerable<KeyValuePair<string, VariablesGroupAsset>>, IEnumerable, ISerializationCallbackReceiver
{
	[Serializable]
	private class NameValuePair
	{
		public string name;

		[SerializeReference]
		public VariablesGroupAsset group;
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	public struct ScopedUpdate : IDisposable
	{
		public void Dispose()
		{
			EndUpdating();
		}
	}

	[SerializeField]
	private List<NameValuePair> m_Groups = new List<NameValuePair>();

	private Dictionary<string, NameValuePair> m_GroupLookup = new Dictionary<string, NameValuePair>();

	internal static int s_IsUpdating;

	public static bool IsUpdating => s_IsUpdating != 0;

	public int Count => m_Groups.Count;

	public bool IsReadOnly => false;

	public ICollection<string> Keys => m_GroupLookup.Keys;

	public ICollection<VariablesGroupAsset> Values => m_GroupLookup.Values.Select((NameValuePair k) => k.group).ToList();

	public VariablesGroupAsset this[string name]
	{
		get
		{
			return m_GroupLookup[name].group;
		}
		set
		{
			Add(name, value);
		}
	}

	public static event Action EndUpdate;

	public PersistentVariablesSource(SmartFormatter formatter)
	{
		formatter.Parser.AddOperators(".");
	}

	public static void BeginUpdating()
	{
		s_IsUpdating++;
	}

	public static void EndUpdating()
	{
		s_IsUpdating--;
		if (s_IsUpdating == 0)
		{
			EndUpdate?.Invoke();
		}
		else if (s_IsUpdating < 0)
		{
			Debug.LogWarning("Incorrect number of Begin and End calls to PersistentVariablesSource. BeginUpdating must be called before EndUpdating.");
			s_IsUpdating = 0;
		}
	}

	public static IDisposable UpdateScope()
	{
		BeginUpdating();
		return default(ScopedUpdate);
	}

	public bool TryGetValue(string name, out VariablesGroupAsset value)
	{
		if (m_GroupLookup.TryGetValue(name, out var value2))
		{
			value = value2.group;
			return true;
		}
		value = null;
		return false;
	}

	public void Add(string name, VariablesGroupAsset group)
	{
		if (string.IsNullOrEmpty(name))
		{
			throw new ArgumentException("name", "Name must not be null or empty.");
		}
		if (group == null)
		{
			throw new ArgumentNullException("group");
		}
		NameValuePair nameValuePair = new NameValuePair
		{
			name = name,
			group = group
		};
		name = name.ReplaceWhiteSpaces("-");
		m_GroupLookup[name] = nameValuePair;
		m_Groups.Add(nameValuePair);
	}

	public void Add(KeyValuePair<string, VariablesGroupAsset> item)
	{
		Add(item.Key, item.Value);
	}

	public bool Remove(string name)
	{
		if (m_GroupLookup.TryGetValue(name, out var value))
		{
			m_Groups.Remove(value);
			m_GroupLookup.Remove(name);
			return true;
		}
		return false;
	}

	public bool Remove(KeyValuePair<string, VariablesGroupAsset> item)
	{
		return Remove(item.Key);
	}

	public void Clear()
	{
		m_GroupLookup.Clear();
		m_Groups.Clear();
	}

	public bool ContainsKey(string name)
	{
		return m_GroupLookup.ContainsKey(name);
	}

	public bool Contains(KeyValuePair<string, VariablesGroupAsset> item)
	{
		if (TryGetValue(item.Key, out var value))
		{
			return value == item.Value;
		}
		return false;
	}

	public void CopyTo(KeyValuePair<string, VariablesGroupAsset>[] array, int arrayIndex)
	{
		foreach (KeyValuePair<string, NameValuePair> item in m_GroupLookup)
		{
			array[arrayIndex++] = new KeyValuePair<string, VariablesGroupAsset>(item.Key, item.Value.group);
		}
	}

	IEnumerator<KeyValuePair<string, VariablesGroupAsset>> IEnumerable<KeyValuePair<string, VariablesGroupAsset>>.GetEnumerator()
	{
		foreach (KeyValuePair<string, NameValuePair> item in m_GroupLookup)
		{
			yield return new KeyValuePair<string, VariablesGroupAsset>(item.Key, item.Value.group);
		}
	}

	public IEnumerator GetEnumerator()
	{
		foreach (KeyValuePair<string, NameValuePair> item in m_GroupLookup)
		{
			yield return new KeyValuePair<string, VariablesGroupAsset>(item.Key, item.Value.group);
		}
	}

	public bool TryEvaluateSelector(ISelectorInfo selectorInfo)
	{
		string selectorText = selectorInfo.SelectorText;
		if (selectorInfo.CurrentValue is IVariableGroup variablleGroup && EvaluateLocalGroup(selectorInfo, variablleGroup))
		{
			return true;
		}
		if (selectorInfo.SelectorOperator == "" && EvaluateLocalGroup(selectorInfo, selectorInfo.FormatDetails.FormatCache?.LocalVariables))
		{
			return true;
		}
		if (TryGetValue(selectorText, out var value))
		{
			selectorInfo.Result = value;
			return true;
		}
		return false;
	}

	private static bool EvaluateLocalGroup(ISelectorInfo selectorInfo, IVariableGroup variablleGroup)
	{
		if (variablleGroup == null)
		{
			return false;
		}
		if (variablleGroup != null && variablleGroup.TryGetValue(selectorInfo.SelectorText, out var value))
		{
			FormatCache formatCache = selectorInfo.FormatDetails.FormatCache;
			if (formatCache != null && value is IVariableValueChanged item && !formatCache.VariableTriggers.Contains(item))
			{
				formatCache.VariableTriggers.Add(item);
			}
			selectorInfo.Result = value.GetSourceValue(selectorInfo);
			return true;
		}
		return false;
	}

	public void OnBeforeSerialize()
	{
	}

	public void OnAfterDeserialize()
	{
		if (m_GroupLookup == null)
		{
			m_GroupLookup = new Dictionary<string, NameValuePair>();
		}
		m_GroupLookup.Clear();
		foreach (NameValuePair group in m_Groups)
		{
			if (!string.IsNullOrEmpty(group.name))
			{
				m_GroupLookup[group.name] = group;
			}
		}
	}
}
