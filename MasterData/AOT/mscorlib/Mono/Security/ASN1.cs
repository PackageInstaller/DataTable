using System;
using System.Collections;
using System.Reflection;
using System.Text;

namespace Mono.Security;

[DefaultMember("Item")]
internal class ASN1
{
	private byte m_nTag;

	private byte[] m_aValue;

	private ArrayList elist;

	public int Count
	{
		get
		{
			if (elist == null)
			{
				return 0;
			}
			return elist.Count;
		}
	}

	public byte[] Value
	{
		get
		{
			if (m_aValue == null)
			{
				GetBytes();
			}
			return (byte[])m_aValue.Clone();
		}
	}

	public ASN1(byte tag)
		: this(tag, null)
	{
	}

	public ASN1(byte tag, byte[] data)
	{
		m_nTag = tag;
		m_aValue = data;
	}

	public ASN1(byte[] data)
	{
		m_nTag = data[0];
		int num = 0;
		int num2 = data[1];
		if (num2 > 128)
		{
			num = num2 - 128;
			num2 = 0;
			for (int i = 0; i < num; i++)
			{
				num2 *= 256;
				num2 += data[i + 2];
			}
		}
		else if (num2 == 128)
		{
			throw new NotSupportedException("Undefined length encoding.");
		}
		m_aValue = new byte[num2];
		Buffer.BlockCopy(data, 2 + num, m_aValue, 0, num2);
		if ((m_nTag & 0x20) == 32)
		{
			int anPos = 0;
			Decode(m_aValue, ref anPos, m_aValue.Length);
		}
	}

	public ASN1 Add(ASN1 asn1)
	{
		if (asn1 != null)
		{
			if (elist == null)
			{
				elist = new ArrayList();
			}
			elist.Add(asn1);
		}
		return asn1;
	}

	public virtual byte[] GetBytes()
	{
		byte[] array = null;
		if (Count > 0)
		{
			int num = 0;
			ArrayList arrayList = new ArrayList();
			foreach (ASN1 item in elist)
			{
				byte[] bytes = item.GetBytes();
				arrayList.Add(bytes);
				num += bytes.Length;
			}
			array = new byte[num];
			int num2 = 0;
			for (int i = 0; i < elist.Count; i++)
			{
				byte[] array2 = (byte[])arrayList[i];
				Buffer.BlockCopy(array2, 0, array, num2, array2.Length);
				num2 += array2.Length;
			}
		}
		else if (m_aValue != null)
		{
			array = m_aValue;
		}
		int num3 = 0;
		byte[] array3;
		if (array != null)
		{
			int num4 = array.Length;
			if (num4 > 127)
			{
				if (num4 <= 255)
				{
					array3 = new byte[3 + num4];
					Buffer.BlockCopy(array, 0, array3, 3, num4);
					num3 = 129;
					array3[2] = (byte)num4;
				}
				else if (num4 <= 65535)
				{
					array3 = new byte[4 + num4];
					Buffer.BlockCopy(array, 0, array3, 4, num4);
					num3 = 130;
					array3[2] = (byte)(num4 >> 8);
					array3[3] = (byte)num4;
				}
				else if (num4 <= 16777215)
				{
					array3 = new byte[5 + num4];
					Buffer.BlockCopy(array, 0, array3, 5, num4);
					num3 = 131;
					array3[2] = (byte)(num4 >> 16);
					array3[3] = (byte)(num4 >> 8);
					array3[4] = (byte)num4;
				}
				else
				{
					array3 = new byte[6 + num4];
					Buffer.BlockCopy(array, 0, array3, 6, num4);
					num3 = 132;
					array3[2] = (byte)(num4 >> 24);
					array3[3] = (byte)(num4 >> 16);
					array3[4] = (byte)(num4 >> 8);
					array3[5] = (byte)num4;
				}
			}
			else
			{
				array3 = new byte[2 + num4];
				Buffer.BlockCopy(array, 0, array3, 2, num4);
				num3 = num4;
			}
			if (m_aValue == null)
			{
				m_aValue = array;
			}
		}
		else
		{
			array3 = new byte[2];
		}
		array3[0] = m_nTag;
		array3[1] = (byte)num3;
		return array3;
	}

	protected void Decode(byte[] asn1, ref int anPos, int anLength)
	{
		while (anPos < anLength - 1)
		{
			DecodeTLV(asn1, ref anPos, out var tag, out var length, out var content);
			if (tag != 0)
			{
				ASN1 aSN = Add(new ASN1(tag, content));
				if ((tag & 0x20) == 32)
				{
					int anPos2 = anPos;
					aSN.Decode(asn1, ref anPos2, anPos2 + length);
				}
				anPos += length;
			}
		}
	}

	protected void DecodeTLV(byte[] asn1, ref int pos, out byte tag, out int length, out byte[] content)
	{
		tag = asn1[pos++];
		length = asn1[pos++];
		if ((length & 0x80) == 128)
		{
			int num = length & 0x7F;
			length = 0;
			for (int i = 0; i < num; i++)
			{
				length = length * 256 + asn1[pos++];
			}
		}
		content = new byte[length];
		Buffer.BlockCopy(asn1, pos, content, 0, length);
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.AppendFormat("Tag: {0} {1}", m_nTag.ToString("X2"), Environment.NewLine);
		stringBuilder.AppendFormat("Length: {0} {1}", Value.Length, Environment.NewLine);
		stringBuilder.Append("Value: ");
		stringBuilder.Append(Environment.NewLine);
		for (int i = 0; i < Value.Length; i++)
		{
			stringBuilder.AppendFormat("{0} ", Value[i].ToString("X2"));
			if ((i + 1) % 16 == 0)
			{
				stringBuilder.AppendFormat(Environment.NewLine);
			}
		}
		return stringBuilder.ToString();
	}
}
