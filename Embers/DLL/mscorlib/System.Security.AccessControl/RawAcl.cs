using System.Collections.Generic;

namespace System.Security.AccessControl;

public sealed class RawAcl : GenericAcl
{
	private byte revision;

	private List<GenericAce> list;

	public override int Count => list.Count;

	public override GenericAce this[int index]
	{
		get
		{
			return list[index];
		}
		set
		{
			list[index] = value;
		}
	}

	public RawAcl(byte revision, int capacity)
	{
		this.revision = revision;
		list = new List<GenericAce>(capacity);
	}

	public void InsertAce(int index, GenericAce ace)
	{
		if (ace == null)
		{
			throw new ArgumentNullException("ace");
		}
		list.Insert(index, ace);
	}

	public void RemoveAce(int index)
	{
		list.RemoveAt(index);
	}
}
