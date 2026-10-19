using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace Unity.VisualScripting;

[SerializationVersion("A", new Type[] { })]
public sealed class VariableDeclarationCollection : KeyedCollection<string, VariableDeclaration>, IKeyedCollection<string, VariableDeclaration>, ICollection<VariableDeclaration>, IEnumerable<VariableDeclaration>, IEnumerable
{
	protected override string GetKeyForItem(VariableDeclaration item)
	{
		return item.name;
	}

	public void EditorRename(VariableDeclaration item, string newName)
	{
		ChangeItemKey(item, newName);
	}

	public new bool TryGetValue(string key, out VariableDeclaration value)
	{
		if (Dictionary == null)
		{
			value = null;
			return false;
		}
		return Dictionary.TryGetValue(key, out value);
	}

	VariableDeclaration IKeyedCollection<string, VariableDeclaration>.get_Item(string key)
	{
		return base[key];
	}

	bool IKeyedCollection<string, VariableDeclaration>.Contains(string key)
	{
		return Contains(key);
	}

	bool IKeyedCollection<string, VariableDeclaration>.Remove(string key)
	{
		return Remove(key);
	}
}
