using System.Collections.Generic;

namespace System.Security.AccessControl;

public sealed class RawAcl : GenericAcl
{
	private byte revision;

	private List<GenericAce> list;

	public override int BinaryLength
	{
		get
		{
			int num = 8;
			foreach (GenericAce item in list)
			{
				num += item.BinaryLength;
			}
			return num;
		}
	}

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

	public override byte Revision => revision;

	public RawAcl(byte revision, int capacity)
	{
		this.revision = revision;
		list = new List<GenericAce>(capacity);
	}

	public RawAcl(byte[] binaryForm, int offset)
	{
		if (binaryForm == null)
		{
			throw new ArgumentNullException("binaryForm");
		}
		if (offset < 0 || offset > binaryForm.Length - 8)
		{
			throw new ArgumentOutOfRangeException("offset", offset, "Offset out of range");
		}
		revision = binaryForm[offset];
		if (revision != GenericAcl.AclRevision && revision != GenericAcl.AclRevisionDS)
		{
			throw new ArgumentException("Invalid ACL - unknown revision", "binaryForm");
		}
		int num = ReadUShort(binaryForm, offset + 2);
		if (offset > binaryForm.Length - num)
		{
			throw new ArgumentException("Invalid ACL - truncated", "binaryForm");
		}
		int num2 = offset + 8;
		int num3 = ReadUShort(binaryForm, offset + 4);
		list = new List<GenericAce>(num3);
		for (int i = 0; i < num3; i++)
		{
			GenericAce genericAce = GenericAce.CreateFromBinaryForm(binaryForm, num2);
			list.Add(genericAce);
			num2 += genericAce.BinaryLength;
		}
	}

	public override void GetBinaryForm(byte[] binaryForm, int offset)
	{
		if (binaryForm == null)
		{
			throw new ArgumentNullException("binaryForm");
		}
		if (offset < 0 || offset > binaryForm.Length - BinaryLength)
		{
			throw new ArgumentException("Offset out of range", "offset");
		}
		binaryForm[offset] = Revision;
		binaryForm[offset + 1] = 0;
		WriteUShort((ushort)BinaryLength, binaryForm, offset + 2);
		WriteUShort((ushort)list.Count, binaryForm, offset + 4);
		WriteUShort(0, binaryForm, offset + 6);
		int num = offset + 8;
		foreach (GenericAce item in list)
		{
			item.GetBinaryForm(binaryForm, num);
			num += item.BinaryLength;
		}
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

	private void WriteUShort(ushort val, byte[] buffer, int offset)
	{
		buffer[offset] = (byte)val;
		buffer[offset + 1] = (byte)(val >> 8);
	}

	private ushort ReadUShort(byte[] buffer, int offset)
	{
		return (ushort)(buffer[offset] | (buffer[offset + 1] << 8));
	}
}
