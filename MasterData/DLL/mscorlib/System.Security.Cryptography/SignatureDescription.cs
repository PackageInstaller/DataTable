using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public class SignatureDescription
{
	private string _strKey;

	private string _strDigest;

	private string _strFormatter;

	private string _strDeformatter;

	public string KeyAlgorithm
	{
		set
		{
			_strKey = value;
		}
	}

	public string DigestAlgorithm
	{
		set
		{
			_strDigest = value;
		}
	}

	public string FormatterAlgorithm
	{
		set
		{
			_strFormatter = value;
		}
	}

	public string DeformatterAlgorithm
	{
		set
		{
			_strDeformatter = value;
		}
	}
}
