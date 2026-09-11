using System.IO;
using System.Runtime.Remoting.Messaging;
using System.Runtime.Serialization.Formatters.Binary;

namespace System.Runtime.Remoting.Channels;

internal class CADSerializer
{
	internal static IMessage DeserializeMessage(MemoryStream mem, IMethodCallMessage msg)
	{
		throw new NotSupportedException();
	}

	internal static MemoryStream SerializeMessage(IMessage msg)
	{
		MemoryStream memoryStream = new MemoryStream();
		BinaryFormatter binaryFormatter = new BinaryFormatter();
		binaryFormatter.SurrogateSelector = new RemotingSurrogateSelector();
		binaryFormatter.Serialize(memoryStream, msg);
		memoryStream.Position = 0L;
		return memoryStream;
	}

	internal static object DeserializeObjectSafe(byte[] mem)
	{
		byte[] array = new byte[mem.Length];
		Array.Copy(mem, array, mem.Length);
		return DeserializeObject(new MemoryStream(array));
	}

	internal static MemoryStream SerializeObject(object obj)
	{
		MemoryStream memoryStream = new MemoryStream();
		BinaryFormatter binaryFormatter = new BinaryFormatter();
		binaryFormatter.SurrogateSelector = new RemotingSurrogateSelector();
		binaryFormatter.Serialize(memoryStream, obj);
		memoryStream.Position = 0L;
		return memoryStream;
	}

	internal static object DeserializeObject(MemoryStream mem)
	{
		BinaryFormatter obj = new BinaryFormatter
		{
			SurrogateSelector = null
		};
		mem.Position = 0L;
		return obj.Deserialize(mem);
	}
}
