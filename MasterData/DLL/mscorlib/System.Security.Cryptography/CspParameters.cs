using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public sealed class CspParameters
{
	public int ProviderType;

	public string ProviderName;

	public string KeyContainerName;

	public int KeyNumber;

	private int m_flags;

	public CspProviderFlags Flags
	{
		get
		{
			return (CspProviderFlags)m_flags;
		}
		set
		{
			int num = 255;
			if (((uint)value & (uint)(~num)) != 0)
			{
				throw new ArgumentException(Environment.GetResourceString("Illegal enum value: {0}.", (int)value), "value");
			}
			m_flags = (int)value;
		}
	}

	public CspParameters()
		: this(1, null, null)
	{
	}

	public CspParameters(int dwTypeIn)
		: this(dwTypeIn, null, null)
	{
	}

	public CspParameters(int dwTypeIn, string strProviderNameIn, string strContainerNameIn)
		: this(dwTypeIn, strProviderNameIn, strContainerNameIn, CspProviderFlags.NoFlags)
	{
	}

	internal CspParameters(int providerType, string providerName, string keyContainerName, CspProviderFlags flags)
	{
		ProviderType = providerType;
		ProviderName = providerName;
		KeyContainerName = keyContainerName;
		KeyNumber = -1;
		Flags = flags;
	}
}
