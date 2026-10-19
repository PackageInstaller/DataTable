namespace Google.Protobuf;

internal struct WriterInternalState
{
	internal int limit;

	internal int position;

	internal WriteBufferHelper writeBufferHelper;

	internal CodedOutputStream CodedOutputStream => writeBufferHelper.CodedOutputStream;
}
