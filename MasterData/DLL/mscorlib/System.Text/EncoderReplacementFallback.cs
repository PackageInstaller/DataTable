using System.Runtime.Serialization;

namespace System.Text;

[Serializable]
public sealed class EncoderReplacementFallback : EncoderFallback, ISerializable
{
	private string _strDefault;

	public string DefaultString => _strDefault;

	public override int MaxCharCount => _strDefault.Length;

	public EncoderReplacementFallback()
		: this("?")
	{
	}

	internal EncoderReplacementFallback(SerializationInfo info, StreamingContext context)
	{
		try
		{
			_strDefault = info.GetString("strDefault");
		}
		catch
		{
			_strDefault = info.GetString("_strDefault");
		}
	}

	void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
	{
		info.AddValue("strDefault", _strDefault);
	}

	public EncoderReplacementFallback(string replacement)
	{
		if (replacement == null)
		{
			throw new ArgumentNullException("replacement");
		}
		bool flag = false;
		for (int i = 0; i < replacement.Length; i++)
		{
			if (char.IsSurrogate(replacement, i))
			{
				if (char.IsHighSurrogate(replacement, i))
				{
					if (flag)
					{
						break;
					}
					flag = true;
					continue;
				}
				if (!flag)
				{
					flag = true;
					break;
				}
				flag = false;
			}
			else if (flag)
			{
				break;
			}
		}
		if (flag)
		{
			throw new ArgumentException(SR.Format("String contains invalid Unicode code points.", "replacement"));
		}
		_strDefault = replacement;
	}

	public override EncoderFallbackBuffer CreateFallbackBuffer()
	{
		return new EncoderReplacementFallbackBuffer(this);
	}

	public override bool Equals(object value)
	{
		if (value is EncoderReplacementFallback encoderReplacementFallback)
		{
			return _strDefault == encoderReplacementFallback._strDefault;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return _strDefault.GetHashCode();
	}
}
