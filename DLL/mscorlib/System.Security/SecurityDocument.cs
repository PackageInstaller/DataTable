using System.Security.Util;
using System.Text;

namespace System.Security;

[Serializable]
internal sealed class SecurityDocument
{
	internal byte[] m_data;

	public SecurityDocument(int numData)
	{
		m_data = new byte[numData];
	}

	public void GuaranteeSize(int size)
	{
		if (m_data.Length < size)
		{
			byte[] array = new byte[(size / 32 + 1) * 32];
			Array.Copy(m_data, 0, array, 0, m_data.Length);
			m_data = array;
		}
	}

	public void AddString(string str, ref int position)
	{
		GuaranteeSize(position + str.Length * 2 + 2);
		for (int i = 0; i < str.Length; i++)
		{
			m_data[position + 2 * i] = (byte)((int)str[i] >> 8);
			m_data[position + 2 * i + 1] = (byte)(str[i] & 0xFF);
		}
		m_data[position + str.Length * 2] = 0;
		m_data[position + str.Length * 2 + 1] = 0;
		position += str.Length * 2 + 2;
	}

	public void AppendString(string str, ref int position)
	{
		if (position <= 1 || m_data[position - 1] != 0 || m_data[position - 2] != 0)
		{
			throw new XmlSyntaxException();
		}
		position -= 2;
		AddString(str, ref position);
	}

	public static int EncodedStringSize(string str)
	{
		return str.Length * 2 + 2;
	}

	public string GetString(ref int position, bool bCreate)
	{
		int i;
		for (i = position; i < m_data.Length - 1 && (m_data[i] != 0 || m_data[i + 1] != 0); i += 2)
		{
		}
		Tokenizer.StringMaker maker = SharedStatics.GetSharedStringMaker();
		try
		{
			if (bCreate)
			{
				maker._outStringBuilder = null;
				maker._outIndex = 0;
				for (int j = position; j < i; j += 2)
				{
					char c = (char)((m_data[j] << 8) | m_data[j + 1]);
					if (maker._outIndex < 512)
					{
						maker._outChars[maker._outIndex++] = c;
						continue;
					}
					if (maker._outStringBuilder == null)
					{
						maker._outStringBuilder = new StringBuilder();
					}
					maker._outStringBuilder.Append(maker._outChars, 0, 512);
					maker._outChars[0] = c;
					maker._outIndex = 1;
				}
			}
			position = i + 2;
			if (bCreate)
			{
				return maker.MakeString();
			}
			return null;
		}
		finally
		{
			SharedStatics.ReleaseSharedStringMaker(ref maker);
		}
	}

	public void AddToken(byte b, ref int position)
	{
		GuaranteeSize(position + 1);
		m_data[position++] = b;
	}

	public SecurityElement GetRootElement()
	{
		return GetElement(0, bCreate: true);
	}

	public SecurityElement GetElement(int position, bool bCreate)
	{
		return InternalGetElement(ref position, bCreate);
	}

	internal SecurityElement InternalGetElement(ref int position, bool bCreate)
	{
		if (m_data.Length <= position)
		{
			throw new XmlSyntaxException();
		}
		if (m_data[position++] != 1)
		{
			throw new XmlSyntaxException();
		}
		SecurityElement securityElement = null;
		string tag = GetString(ref position, bCreate);
		if (bCreate)
		{
			securityElement = new SecurityElement(tag);
		}
		while (m_data[position] == 2)
		{
			position++;
			string name = GetString(ref position, bCreate);
			string value = GetString(ref position, bCreate);
			if (bCreate)
			{
				securityElement.AddAttribute(name, value);
			}
		}
		if (m_data[position] == 3)
		{
			position++;
			string strText = GetString(ref position, bCreate);
			if (bCreate)
			{
				securityElement.m_strText = strText;
			}
		}
		while (m_data[position] != 4)
		{
			SecurityElement child = InternalGetElement(ref position, bCreate);
			if (bCreate)
			{
				securityElement.AddChild(child);
			}
		}
		position++;
		return securityElement;
	}
}
