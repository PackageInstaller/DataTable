namespace Google.Protobuf;

public interface IBufferMessage : IMessage
{
	void InternalMergeFrom(ref ParseContext ctx);

	void InternalWriteTo(ref WriteContext ctx);
}
