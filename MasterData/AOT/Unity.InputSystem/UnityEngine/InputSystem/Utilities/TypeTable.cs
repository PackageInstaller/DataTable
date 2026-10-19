using System;
using System.Collections.Generic;
using System.Linq;

namespace UnityEngine.InputSystem.Utilities;

internal struct TypeTable
{
	public Dictionary<InternedString, Type> table;

	private InputManager m_Manager;

	public IEnumerable<string> names => table.Keys.Select((InternedString x) => x.ToString());

	public IEnumerable<InternedString> internedNames => table.Keys;

	public void Initialize(InputManager manager)
	{
		table = new Dictionary<InternedString, Type>();
		m_Manager = manager;
	}

	public InternedString FindNameForType(Type type)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		foreach (KeyValuePair<InternedString, Type> item in table)
		{
			if (item.Value == type)
			{
				return item.Key;
			}
		}
		return default;
	}

	public void AddTypeRegistration(string name, Type type)
	{
		if (string.IsNullOrEmpty(name))
		{
			throw new ArgumentException("Name cannot be null or empty", "name");
		}
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		InternedString key = new InternedString(name);
		table[key] = type;
	}

	public Type LookupTypeRegistration(string name)
	{
		if (string.IsNullOrEmpty(name))
		{
			return null;
		}
		if (table == null)
		{
			throw new InvalidOperationException("Input System not yet initialized");
		}
		return TryLookupTypeRegistration(new InternedString(name));
	}

	private Type TryLookupTypeRegistration(InternedString internedName)
	{
		if (!table.TryGetValue(internedName, out var value) && m_Manager != null && m_Manager.RegisterCustomTypes())
		{
			table.TryGetValue(internedName, out value);
		}
		return value;
	}
}
