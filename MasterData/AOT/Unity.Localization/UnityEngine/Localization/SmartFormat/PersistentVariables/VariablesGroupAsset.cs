using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine.Localization.SmartFormat.Core.Extensions;

namespace UnityEngine.Localization.SmartFormat.PersistentVariables;

[CreateAssetMenu(menuName = "Localization/Variables Group")]
public class VariablesGroupAsset : ScriptableObject, IVariableGroup, IVariable, IDictionary<string, IVariable>, ICollection<KeyValuePair<string, IVariable>>, IEnumerable<KeyValuePair<string, IVariable>>, IEnumerable, ISerializationCallbackReceiver
{
	[SerializeField]
	internal List<VariableNameValuePair> m_Variables = new List<VariableNameValuePair>();

	private Dictionary<string, VariableNameValuePair> m_VariableLookup = new Dictionary<string, VariableNameValuePair>();

	public int Count => m_VariableLookup.Count;

	public ICollection<string> Keys => m_VariableLookup.Keys;

	public ICollection<IVariable> Values => m_VariableLookup.Values.Select((VariableNameValuePair s) => s.variable).ToList();

	public bool IsReadOnly => false;

	public IVariable this[string name]
	{
		get
		{
			return m_VariableLookup[name].variable;
		}
		set
		{
			Add(name, value);
		}
	}

	public object GetSourceValue(ISelectorInfo _)
	{
		return this;
	}

	public bool TryGetValue(string name, out IVariable value)
	{
		if (m_VariableLookup.TryGetValue(name, out var value2))
		{
			value = value2.variable;
			return true;
		}
		value = null;
		return false;
	}

	public void Add(string name, IVariable variable)
	{
		if (string.IsNullOrEmpty(name))
		{
			throw new ArgumentException("name", "Name must not be null or empty.");
		}
		if (variable == null)
		{
			throw new ArgumentNullException("variable");
		}
		name = name.ReplaceWhiteSpaces("-");
		VariableNameValuePair variableNameValuePair = new VariableNameValuePair
		{
			name = name,
			variable = variable
		};
		m_VariableLookup.Add(name, variableNameValuePair);
		m_Variables.Add(variableNameValuePair);
	}

	public void Add(KeyValuePair<string, IVariable> item)
	{
		Add(item.Key, item.Value);
	}

	public bool Remove(string name)
	{
		if (m_VariableLookup.TryGetValue(name, out var value))
		{
			m_Variables.Remove(value);
			m_VariableLookup.Remove(name);
			return true;
		}
		return false;
	}

	public bool Remove(KeyValuePair<string, IVariable> item)
	{
		return Remove(item.Key);
	}

	public bool ContainsKey(string name)
	{
		return m_VariableLookup.ContainsKey(name);
	}

	public bool Contains(KeyValuePair<string, IVariable> item)
	{
		if (TryGetValue(item.Key, out var value))
		{
			return value == item.Value;
		}
		return false;
	}

	public void CopyTo(KeyValuePair<string, IVariable>[] array, int arrayIndex)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		foreach (KeyValuePair<string, VariableNameValuePair> item in m_VariableLookup)
		{
			array[arrayIndex++] = new KeyValuePair<string, IVariable>(item.Key, item.Value.variable);
		}
	}

	IEnumerator<KeyValuePair<string, IVariable>> IEnumerable<KeyValuePair<string, IVariable>>.GetEnumerator()
	{
		foreach (KeyValuePair<string, VariableNameValuePair> item in m_VariableLookup)
		{
			yield return new KeyValuePair<string, IVariable>(item.Key, item.Value.variable);
		}
	}

	public IEnumerator GetEnumerator()
	{
		foreach (KeyValuePair<string, VariableNameValuePair> item in m_VariableLookup)
		{
			yield return new KeyValuePair<string, IVariable>(item.Key, item.Value.variable);
		}
	}

	[Obsolete("Please use ContainsKey instead.", false)]
	public bool ContainsName(string name)
	{
		return ContainsKey(name);
	}

	public void Clear()
	{
		m_VariableLookup.Clear();
		m_Variables.Clear();
	}

	public void OnBeforeSerialize()
	{
	}

	public void OnAfterDeserialize()
	{
		if (m_VariableLookup == null)
		{
			m_VariableLookup = new Dictionary<string, VariableNameValuePair>();
		}
		m_VariableLookup.Clear();
		foreach (VariableNameValuePair variable in m_Variables)
		{
			if (!string.IsNullOrEmpty(variable.name))
			{
				m_VariableLookup[variable.name] = variable;
			}
		}
	}
}
