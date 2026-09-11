using System.Runtime.Serialization;

namespace System;

[Serializable]
internal sealed class Empty : ISerializable
{
	public static readonly Empty Value = new Empty();

	private Empty()
	{
	}

	public override string ToString()
	{
		return string.Empty;
	}

	public void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		UnitySerializationHolder.GetUnitySerializationInfo(info, 1, null, null);
	}
}
