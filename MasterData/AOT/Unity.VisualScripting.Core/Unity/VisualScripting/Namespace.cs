using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace Unity.VisualScripting;

public sealed class Namespace
{
	private class Collection : KeyedCollection<string, Namespace>, IKeyedCollection<string, Namespace>, ICollection<Namespace>, IEnumerable<Namespace>, IEnumerable
	{
		protected override string GetKeyForItem(Namespace item)
		{
			return item.FullName;
		}

		public new bool TryGetValue(string key, out Namespace value)
		{
			if (Dictionary == null)
			{
				value = null;
				return false;
			}
			return Dictionary.TryGetValue(key, out value);
		}

		Namespace IKeyedCollection<string, Namespace>.get_Item(string key)
		{
			return base[key];
		}

		bool IKeyedCollection<string, Namespace>.Contains(string key)
		{
			return Contains(key);
		}

		bool IKeyedCollection<string, Namespace>.Remove(string key)
		{
			return Remove(key);
		}
	}

	private static readonly Collection collection;

	public Namespace Root { get; }

	public Namespace Parent { get; }

	public string FullName { get; }

	public string Name { get; }

	public bool IsRoot { get; }

	public bool IsGlobal { get; }

	public IEnumerable<Namespace> Ancestors
	{
		get
		{
			Namespace ancestor = Parent;
			while (ancestor != null)
			{
				yield return ancestor;
				ancestor = ancestor.Parent;
			}
		}
	}

	public static Namespace Global { get; }

	private Namespace(string fullName)
	{
		FullName = fullName;
		if (fullName != null)
		{
			string[] array = fullName.Split('.');
			Name = array[array.Length - 1];
			if (array.Length > 1)
			{
				Root = array[0];
				Parent = fullName.Substring(0, fullName.LastIndexOf('.'));
			}
			else
			{
				Root = this;
				IsRoot = true;
				Parent = Global;
			}
		}
		else
		{
			Root = this;
			IsRoot = true;
			IsGlobal = true;
		}
	}

	public IEnumerable<Namespace> AndAncestors()
	{
		yield return this;
		foreach (Namespace ancestor in Ancestors)
		{
			yield return ancestor;
		}
	}

	public override int GetHashCode()
	{
		if (FullName == null)
		{
			return 0;
		}
		return FullName.GetHashCode();
	}

	public override string ToString()
	{
		return FullName;
	}

	static Namespace()
	{
		Global = new Namespace(null);
		collection = new Collection();
	}

	public static Namespace FromFullName(string fullName)
	{
		if (fullName == null)
		{
			return Global;
		}
		if (!collection.TryGetValue(fullName, out var value))
		{
			value = new Namespace(fullName);
			collection.Add(value);
		}
		return value;
	}

	public override bool Equals(object obj)
	{
		Namespace obj2 = obj as Namespace;
		if (obj2 == null)
		{
			return false;
		}
		return FullName == obj2.FullName;
	}

	public static implicit operator Namespace(string fullName)
	{
		return FromFullName(fullName);
	}

	public static implicit operator string(Namespace @namespace)
	{
		return @namespace.FullName;
	}

	public static bool operator ==(Namespace a, Namespace b)
	{
		if ((object)a == b)
		{
			return true;
		}
		if ((object)a == null || (object)b == null)
		{
			return false;
		}
		return a.Equals(b);
	}

	public static bool operator !=(Namespace a, Namespace b)
	{
		return !(a == b);
	}
}
