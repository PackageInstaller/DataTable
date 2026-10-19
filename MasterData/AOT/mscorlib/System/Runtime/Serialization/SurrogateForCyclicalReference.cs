namespace System.Runtime.Serialization;

internal sealed class SurrogateForCyclicalReference : ISerializationSurrogate
{
	private ISerializationSurrogate innerSurrogate;

	public void GetObjectData(object obj, SerializationInfo info, StreamingContext context)
	{
		innerSurrogate.GetObjectData(obj, info, context);
	}

	public object SetObjectData(object obj, SerializationInfo info, StreamingContext context, ISurrogateSelector selector)
	{
		return innerSurrogate.SetObjectData(obj, info, context, selector);
	}
}
