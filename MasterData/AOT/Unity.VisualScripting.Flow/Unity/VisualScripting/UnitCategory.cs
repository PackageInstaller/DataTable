using System;
using System.Collections.Generic;
using Unity.VisualScripting.FullSerializer;

namespace Unity.VisualScripting;

[AttributeUsage(AttributeTargets.Class)]
[fsObject(Converter = typeof(UnitCategoryConverter))]
public class UnitCategory : Attribute
{
	public UnitCategory root { get; }

	public UnitCategory parent { get; }

	public string fullName { get; }

	public string name { get; }

	public bool isRoot { get; }

	public IEnumerable<UnitCategory> ancestors
	{
		get
		{
			UnitCategory ancestor = parent;
			while (ancestor != null)
			{
				yield return ancestor;
				ancestor = ancestor.parent;
			}
		}
	}

	public UnitCategory(string fullName)
	{
		Ensure.That("fullName").IsNotNull(fullName);
		fullName = fullName.Replace('\\', '/');
		this.fullName = fullName;
		string[] array = fullName.Split('/');
		name = array[array.Length - 1];
		if (array.Length > 1)
		{
			root = new UnitCategory(array[0]);
			parent = new UnitCategory(fullName.Substring(0, fullName.LastIndexOf('/')));
		}
		else
		{
			root = this;
			isRoot = true;
		}
	}

	public IEnumerable<UnitCategory> AndAncestors()
	{
		yield return this;
		foreach (UnitCategory ancestor in ancestors)
		{
			yield return ancestor;
		}
	}

	public override bool Equals(object obj)
	{
		if (obj is UnitCategory)
		{
			return ((UnitCategory)obj).fullName == fullName;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return fullName.GetHashCode();
	}

	public override string ToString()
	{
		return fullName;
	}

	public static bool operator ==(UnitCategory a, UnitCategory b)
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

	public static bool operator !=(UnitCategory a, UnitCategory b)
	{
		return !(a == b);
	}
}
