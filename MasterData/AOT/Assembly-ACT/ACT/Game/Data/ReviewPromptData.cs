using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ReviewPromptData : IMessage<ReviewPromptData>, IMessage, IEquatable<ReviewPromptData>, IDeepCloneable<ReviewPromptData>, IBufferMessage
{
	private static readonly MessageParser<ReviewPromptData> _parser = new MessageParser<ReviewPromptData>(() => new ReviewPromptData());

	private UnknownFieldSet _unknownFields;

	public const int LastNotifyTsFieldNumber = 1;

	private long lastNotifyTs_;

	public const int IsNeedDisplayFieldNumber = 2;

	private bool isNeedDisplay_;

	public const int ChannelDataFieldNumber = 3;

	private static readonly MapField<int, ReviewPromptChannelData>.Codec _map_channelData_codec = new MapField<int, ReviewPromptChannelData>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ReviewPromptChannelData.Parser), 26u);

	private readonly MapField<int, ReviewPromptChannelData> channelData_ = new MapField<int, ReviewPromptChannelData>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ReviewPromptData> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[173];

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
	public MapField<int, ReviewPromptChannelData> ChannelData => channelData_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ReviewPromptData()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ReviewPromptData(ReviewPromptData other)
		: this()
	{
		lastNotifyTs_ = other.lastNotifyTs_;
		isNeedDisplay_ = other.isNeedDisplay_;
		channelData_ = other.channelData_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ReviewPromptData Clone()
	{
		return new ReviewPromptData(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ReviewPromptData);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ReviewPromptData other)
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
		if (!ChannelData.Equals(other.ChannelData))
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
		num ^= ChannelData.GetHashCode();
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
		channelData_.WriteTo(ref output, _map_channelData_codec);
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
		num += channelData_.CalculateSize(_map_channelData_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ReviewPromptData other)
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
			channelData_.Add(other.channelData_);
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
			case 26u:
				channelData_.AddEntriesFrom(ref input, _map_channelData_codec);
				break;
			}
		}
	}
}
