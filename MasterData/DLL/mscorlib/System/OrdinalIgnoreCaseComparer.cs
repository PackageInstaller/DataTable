using System.Globalization;
using System.Runtime.Serialization;

namespace System;

[Serializable]
internal sealed class OrdinalIgnoreCaseComparer : OrdinalComparer, ISerializable
{
	public OrdinalIgnoreCaseComparer()
		: base(ignoreCase: true)
	{
	}

	public override int Compare(string x, string y)
	{
		return string.Compare(x, y, StringComparison.OrdinalIgnoreCase);
	}

	public override bool Equals(string x, string y)
	{
		return string.Equals(x, y, StringComparison.OrdinalIgnoreCase);
	}

	public override int GetHashCode(string obj)
	{
		if (obj == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.obj);
		}
		return CompareInfo.GetIgnoreCaseHash(obj);
	}

	public void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		info.SetType(typeof(OrdinalComparer));
		info.AddValue("_ignoreCase", value: true);
	}
}
