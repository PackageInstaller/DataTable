using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public sealed class KeySizes
{
	private int m_minSize;

	private int m_maxSize;

	private int m_skipSize;

	public int MinSize => m_minSize;

	public int MaxSize => m_maxSize;

	public int SkipSize => m_skipSize;

	public KeySizes(int minSize, int maxSize, int skipSize)
	{
		m_minSize = minSize;
		m_maxSize = maxSize;
		m_skipSize = skipSize;
	}

	internal bool IsLegal(int keySize)
	{
		int num = keySize - MinSize;
		bool flag = num >= 0 && keySize <= MaxSize;
		if (SkipSize != 0)
		{
			if (flag)
			{
				return num % SkipSize == 0;
			}
			return false;
		}
		return flag;
	}

	internal static bool IsLegalKeySize(KeySizes[] legalKeys, int size)
	{
		for (int i = 0; i < legalKeys.Length; i++)
		{
			if (legalKeys[i].IsLegal(size))
			{
				return true;
			}
		}
		return false;
	}
}
