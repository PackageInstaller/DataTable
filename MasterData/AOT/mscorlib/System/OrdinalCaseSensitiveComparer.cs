using System.Runtime.Serialization;

namespace System;

[Serializable]
internal sealed class OrdinalCaseSensitiveComparer : OrdinalComparer, ISerializable
{
	public OrdinalCaseSensitiveComparer()
		: base(ignoreCase: false)
	{
	}

	public override int Compare(string x, string y)
	{
		return string.CompareOrdinal(x, y);
	}

	public override bool Equals(string x, string y)
	{
		return string.Equals(x, y);
	}

	public override int GetHashCode(string obj)
	{
		if (obj == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.obj);
		}
		return obj.GetHashCode();
	}

	public void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		info.SetType(typeof(OrdinalComparer));
		info.AddValue("_ignoreCase", value: false);
	}
}
