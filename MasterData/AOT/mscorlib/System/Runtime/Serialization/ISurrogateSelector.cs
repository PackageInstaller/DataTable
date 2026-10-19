namespace System.Runtime.Serialization;

public interface ISurrogateSelector
{
	ISerializationSurrogate GetSurrogate(Type type, StreamingContext context, out ISurrogateSelector selector);
}
