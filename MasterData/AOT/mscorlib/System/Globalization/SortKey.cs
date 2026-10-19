using System.Runtime.InteropServices;
using Unity;

namespace System.Globalization;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
[ComVisible(true)]
public class SortKey
{
	private readonly string source;

	private readonly byte[] key;

	private readonly CompareOptions options;

	private readonly int lcid;

	public virtual string OriginalString => source;

	public virtual byte[] KeyData => key;

	public static int Compare(SortKey sortkey1, SortKey sortkey2)
	{
		if (sortkey1 == null)
		{
			throw new ArgumentNullException("sortkey1");
		}
		if (sortkey2 == null)
		{
			throw new ArgumentNullException("sortkey2");
		}
		if (sortkey1 == sortkey2 || (object)sortkey1.OriginalString == sortkey2.OriginalString)
		{
			return 0;
		}
		byte[] keyData = sortkey1.KeyData;
		byte[] keyData2 = sortkey2.KeyData;
		int num = ((keyData.Length > keyData2.Length) ? keyData2.Length : keyData.Length);
		for (int i = 0; i < num; i++)
		{
			if (keyData[i] != keyData2[i])
			{
				if (keyData[i] >= keyData2[i])
				{
					return 1;
				}
				return -1;
			}
		}
		if (keyData.Length != keyData2.Length)
		{
			if (keyData.Length >= keyData2.Length)
			{
				return 1;
			}
			return -1;
		}
		return 0;
	}

	internal SortKey(int lcid, string source, CompareOptions opt)
	{
		this.lcid = lcid;
		this.source = source;
		options = opt;
		int length = source.Length;
		byte[] array = new byte[length];
		for (int i = 0; i < length; i++)
		{
			array[i] = (byte)source[i];
		}
		key = array;
	}

	internal SortKey(int lcid, string source, byte[] buffer, CompareOptions opt, int lv1Length, int lv2Length, int lv3Length, int kanaSmallLength, int markTypeLength, int katakanaLength, int kanaWidthLength, int identLength)
	{
		this.lcid = lcid;
		this.source = source;
		key = buffer;
		options = opt;
	}

	internal SortKey(string localeName, string str, CompareOptions options, byte[] keyData)
	{
		throw new NotImplementedException();
	}

	public override bool Equals(object value)
	{
		if (value is SortKey sortKey && lcid == sortKey.lcid && options == sortKey.options && Compare(this, sortKey) == 0)
		{
			return true;
		}
		return false;
	}

	public override int GetHashCode()
	{
		if (key.Length == 0)
		{
			return 0;
		}
		int num = key[0];
		for (int i = 1; i < key.Length; i++)
		{
			num ^= key[i] << (i & 3);
		}
		return num;
	}

	public override string ToString()
	{
		return "SortKey - " + lcid + ", " + options.ToString() + ", " + source;
	}

	internal SortKey()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
