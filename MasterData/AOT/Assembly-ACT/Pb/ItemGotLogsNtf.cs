using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ItemGotLogsNtf : IMessage<ItemGotLogsNtf>, IMessage, IEquatable<ItemGotLogsNtf>, IDeepCloneable<ItemGotLogsNtf>, IBufferMessage
{
	private static readonly MessageParser<ItemGotLogsNtf> _parser = new MessageParser<ItemGotLogsNtf>(() => new ItemGotLogsNtf());

	private UnknownFieldSet _unknownFields;

	public const int ItemGotLogsFieldNumber = 1;

	private ItemGotLogs itemGotLogs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ItemGotLogsNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[79];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ItemGotLogs ItemGotLogs
	{
		get
		{
			return itemGotLogs_;
		}
		set
		{
			itemGotLogs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ItemGotLogsNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ItemGotLogsNtf(ItemGotLogsNtf other)
		: this()
	{
		itemGotLogs_ = ((other.itemGotLogs_ != null) ? other.itemGotLogs_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ItemGotLogsNtf Clone()
	{
		return new ItemGotLogsNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ItemGotLogsNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ItemGotLogsNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(ItemGotLogs, other.ItemGotLogs))
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		if (itemGotLogs_ != null)
		{
			num ^= ItemGotLogs.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (itemGotLogs_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(ItemGotLogs);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CalculateSize()
	{
		int num = 0;
		if (itemGotLogs_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ItemGotLogs);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ItemGotLogsNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.itemGotLogs_ != null)
		{
			if (itemGotLogs_ == null)
			{
				ItemGotLogs = new ItemGotLogs();
			}
			ItemGotLogs.MergeFrom(other.ItemGotLogs);
		}
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			if (num != 10)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				continue;
			}
			if (itemGotLogs_ == null)
			{
				ItemGotLogs = new ItemGotLogs();
			}
			input.ReadMessage(ItemGotLogs);
		}
	}
}
