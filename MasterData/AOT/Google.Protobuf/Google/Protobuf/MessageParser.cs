using System;
using System.Buffers;
using System.IO;

namespace Google.Protobuf;

public class MessageParser
{
	private Func<IMessage> factory;

	internal bool DiscardUnknownFields { get; }

	internal ExtensionRegistry Extensions { get; }

	internal MessageParser(Func<IMessage> factory, bool discardUnknownFields, ExtensionRegistry extensions)
	{
		this.factory = factory;
		DiscardUnknownFields = discardUnknownFields;
		Extensions = extensions;
	}

	internal IMessage CreateTemplate()
	{
		return factory();
	}

	public IMessage ParseFrom(byte[] data)
	{
		IMessage message = factory();
		message.MergeFrom(data, DiscardUnknownFields, Extensions);
		return message;
	}

	public IMessage ParseFrom(byte[] data, int offset, int length)
	{
		IMessage message = factory();
		message.MergeFrom(data, offset, length, DiscardUnknownFields, Extensions);
		return message;
	}

	public IMessage ParseFrom(ByteString data)
	{
		IMessage message = factory();
		message.MergeFrom(data, DiscardUnknownFields, Extensions);
		return message;
	}

	public IMessage ParseFrom(Stream input)
	{
		IMessage message = factory();
		message.MergeFrom(input, DiscardUnknownFields, Extensions);
		return message;
	}

	public IMessage ParseFrom(ReadOnlySequence<byte> data)
	{
		IMessage message = factory();
		message.MergeFrom(data, DiscardUnknownFields, Extensions);
		return message;
	}

	public IMessage ParseFrom(ReadOnlySpan<byte> data)
	{
		IMessage message = factory();
		message.MergeFrom(data, DiscardUnknownFields, Extensions);
		return message;
	}

	public IMessage ParseDelimitedFrom(Stream input)
	{
		IMessage message = factory();
		message.MergeDelimitedFrom(input, DiscardUnknownFields, Extensions);
		return message;
	}

	public IMessage ParseFrom(CodedInputStream input)
	{
		IMessage message = factory();
		MergeFrom(message, input);
		return message;
	}

	public IMessage ParseJson(string json)
	{
		IMessage message = factory();
		JsonParser.Default.Merge(message, json);
		return message;
	}

	internal void MergeFrom(IMessage message, CodedInputStream codedInput)
	{
		bool discardUnknownFields = codedInput.DiscardUnknownFields;
		ExtensionRegistry extensionRegistry = codedInput.ExtensionRegistry;
		try
		{
			codedInput.DiscardUnknownFields = DiscardUnknownFields;
			codedInput.ExtensionRegistry = Extensions;
			message.MergeFrom(codedInput);
		}
		finally
		{
			codedInput.DiscardUnknownFields = discardUnknownFields;
			codedInput.ExtensionRegistry = extensionRegistry;
		}
	}

	public MessageParser WithDiscardUnknownFields(bool discardUnknownFields)
	{
		return new MessageParser(factory, discardUnknownFields, Extensions);
	}

	public MessageParser WithExtensionRegistry(ExtensionRegistry registry)
	{
		return new MessageParser(factory, DiscardUnknownFields, registry);
	}
}
public sealed class MessageParser<T> : MessageParser where T : IMessage<T>
{
	private readonly Func<T> factory;

	public MessageParser(Func<T> factory)
		: this(factory, false, (ExtensionRegistry)null)
	{
	}

	internal MessageParser(Func<T> factory, bool discardUnknownFields, ExtensionRegistry extensions)
		: base(() => factory(), discardUnknownFields, extensions)
	{
		this.factory = factory;
	}

	internal new T CreateTemplate()
	{
		return factory();
	}

	public new T ParseFrom(byte[] data)
	{
		T val = factory();
		val.MergeFrom(data, DiscardUnknownFields, Extensions);
		return val;
	}

	public new T ParseFrom(byte[] data, int offset, int length)
	{
		T val = factory();
		val.MergeFrom(data, offset, length, DiscardUnknownFields, Extensions);
		return val;
	}

	public new T ParseFrom(ByteString data)
	{
		T val = factory();
		val.MergeFrom(data, DiscardUnknownFields, Extensions);
		return val;
	}

	public new T ParseFrom(Stream input)
	{
		T val = factory();
		val.MergeFrom(input, DiscardUnknownFields, Extensions);
		return val;
	}

	public new T ParseFrom(ReadOnlySequence<byte> data)
	{
		T val = factory();
		val.MergeFrom(data, DiscardUnknownFields, Extensions);
		return val;
	}

	public new T ParseFrom(ReadOnlySpan<byte> data)
	{
		T val = factory();
		val.MergeFrom(data, DiscardUnknownFields, Extensions);
		return val;
	}

	public new T ParseDelimitedFrom(Stream input)
	{
		T val = factory();
		val.MergeDelimitedFrom(input, DiscardUnknownFields, Extensions);
		return val;
	}

	public new T ParseFrom(CodedInputStream input)
	{
		T val = factory();
		MergeFrom(val, input);
		return val;
	}

	public new T ParseJson(string json)
	{
		T val = factory();
		JsonParser.Default.Merge(val, json);
		return val;
	}

	public new MessageParser<T> WithDiscardUnknownFields(bool discardUnknownFields)
	{
		return new MessageParser<T>(factory, discardUnknownFields, Extensions);
	}

	public new MessageParser<T> WithExtensionRegistry(ExtensionRegistry registry)
	{
		return new MessageParser<T>(factory, DiscardUnknownFields, registry);
	}
}
