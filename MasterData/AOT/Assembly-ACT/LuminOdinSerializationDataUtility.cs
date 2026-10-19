using Sirenix.Serialization;

internal static class LuminOdinSerializationDataUtility
{
	public static int ExecuteCount { get; private set; }

	public static int ClearCount { get; private set; }

	public static bool ClearRedundantSerializedBytesString(ref SerializationData serializationData)
	{
		ExecuteCount++;
		byte[] serializedBytes = serializationData.SerializedBytes;
		if (serializedBytes == null || serializedBytes.Length <= 0)
		{
			return false;
		}
		serializationData.SerializedBytesString = null;
		ClearCount++;
		return true;
	}
}
