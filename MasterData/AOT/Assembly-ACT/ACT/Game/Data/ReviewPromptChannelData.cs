using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ReviewPromptChannelData : IMessage<ReviewPromptChannelData>, IMessage, IEquatable<ReviewPromptChannelData>, IDeepCloneable<ReviewPromptChannelData>, IBufferMessage
{
	private static readonly MessageParser<ReviewPromptChannelData> _parser = new MessageParser<ReviewPromptChannelData>(() => new ReviewPromptChannelData());

	private UnknownFieldSet _unknownFields;

	public const int LastNotifyTsFieldNumber = 1;

	private long lastNotifyTs_;

	public const int IsNeedDisplayFieldNumber = 2;

	private bool isNeedDisplay_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ReviewPromptChannelData> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[172];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long LastNotifyTs
	{
		get
		{
			return lastNotifyTs_;
		}
		set
		{
			lastNotifyTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool IsNeedDisplay
	{
		get
		{
			return isNeedDisplay_;
		}
		set
		{
			isNeedDisplay_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ReviewPromptChannelData()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ReviewPromptChannelData(ReviewPromptChannelData other)
		: this()
	{
		lastNotifyTs_ = other.lastNotifyTs_;
		isNeedDisplay_ = other.isNeedDisplay_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ReviewPromptChannelData Clone()
	{
		return new ReviewPromptChannelData(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ReviewPromptChannelData);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ReviewPromptChannelData other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (LastNotifyTs != other.LastNotifyTs)
		{
			return false;
		}
		if (IsNeedDisplay != other.IsNeedDisplay)
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
		if (LastNotifyTs != 0L)
		{
			num ^= LastNotifyTs.GetHashCode();
		}
		if (IsNeedDisplay)
		{
			num ^= IsNeedDisplay.GetHashCode();
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
		if (LastNotifyTs != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(LastNotifyTs);
		}
		if (IsNeedDisplay)
		{
			output.WriteRawTag(16);
			output.WriteBool(IsNeedDisplay);
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
		if (LastNotifyTs != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(LastNotifyTs);
		}
		if (IsNeedDisplay)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ReviewPromptChannelData other)
	{
		if (other != null)
		{
			if (other.LastNotifyTs != 0L)
			{
				LastNotifyTs = other.LastNotifyTs;
			}
			if (other.IsNeedDisplay)
			{
				IsNeedDisplay = other.IsNeedDisplay;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
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
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				LastNotifyTs = input.ReadInt64();
				break;
			case 16u:
				IsNeedDisplay = input.ReadBool();
				break;
			}
		}
	}
}
