namespace System.Globalization;

[Serializable]
internal class CodePageDataItem
{
	internal int m_dataIndex;

	internal int m_uiFamilyCodePage;

	internal string m_webName;

	internal string m_headerName;

	internal string m_bodyName;

	internal uint m_flags;

	private static readonly char[] sep = new char[1] { '|' };

	public string WebName
	{
		get
		{
			if (m_webName == null)
			{
				m_webName = CreateString(EncodingTable.codePageDataPtr[m_dataIndex].Names, 0u);
			}
			return m_webName;
		}
	}

	public virtual int UIFamilyCodePage => m_uiFamilyCodePage;

	public string HeaderName
	{
		get
		{
			if (m_headerName == null)
			{
				m_headerName = CreateString(EncodingTable.codePageDataPtr[m_dataIndex].Names, 1u);
			}
			return m_headerName;
		}
	}

	public string BodyName
	{
		get
		{
			if (m_bodyName == null)
			{
				m_bodyName = CreateString(EncodingTable.codePageDataPtr[m_dataIndex].Names, 2u);
			}
			return m_bodyName;
		}
	}

	public uint Flags => m_flags;

	internal CodePageDataItem(int dataIndex)
	{
		m_dataIndex = dataIndex;
		m_uiFamilyCodePage = EncodingTable.codePageDataPtr[dataIndex].uiFamilyCodePage;
		m_flags = EncodingTable.codePageDataPtr[dataIndex].flags;
	}

	internal static string CreateString(string pStrings, uint index)
	{
		if (pStrings[0] == '|')
		{
			return pStrings.Split(sep, StringSplitOptions.RemoveEmptyEntries)[index];
		}
		return pStrings;
	}
}
