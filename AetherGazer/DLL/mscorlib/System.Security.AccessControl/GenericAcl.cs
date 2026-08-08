using System.Collections;

namespace System.Security.AccessControl;

public abstract class GenericAcl : ICollection, IEnumerable
{
	public static readonly byte AclRevision;

	public static readonly byte AclRevisionDS;

	public static readonly int MaxBinaryLength;

	public abstract int BinaryLength { get; }

	public abstract int Count { get; }

	public bool IsSynchronized => false;

	public abstract GenericAce this[int index] { get; set; }

	public abstract byte Revision { get; }

	public virtual object SyncRoot => this;

	static GenericAcl()
	{
		AclRevision = 2;
		AclRevisionDS = 4;
		MaxBinaryLength = 65536;
	}

	public void CopyTo(GenericAce[] array, int index)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (index < 0 || array.Length - index < Count)
		{
			throw new ArgumentOutOfRangeException("index", "Index must be non-negative integer and must not exceed array length - count");
		}
		for (int i = 0; i < Count; i++)
		{
			array[i + index] = this[i];
		}
	}

	void ICollection.CopyTo(Array array, int index)
	{
		CopyTo((GenericAce[])array, index);
	}

	public abstract void GetBinaryForm(byte[] binaryForm, int offset);

	public AceEnumerator GetEnumerator()
	{
		return new AceEnumerator(this);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}
}
