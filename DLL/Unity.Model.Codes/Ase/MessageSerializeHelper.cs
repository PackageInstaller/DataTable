using System;

namespace Ase;

public static class MessageSerializeHelper
{
	private const int MaxMemoryBufferSize = 1024;

	public static byte[] Serialize(MessageObject message)
	{
		return MemoryPackHelper.Serialize(message);
	}

	public static void Serialize(MessageObject message, MemoryBuffer stream)
	{
		MemoryPackHelper.Serialize(message, stream);
	}

	public static MessageObject Deserialize(Type type, byte[] bytes, int index, int count)
	{
		object o = Singleton<ObjectPool>.Instance.Fetch(type);
		try
		{
			MemoryPackHelper.Deserialize(type, bytes, index, count, ref o);
		}
		catch (Exception)
		{
			if (o is MessageObject messageObject)
			{
				messageObject.Dispose();
			}
			throw;
		}
		return o as MessageObject;
	}
}
