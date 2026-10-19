using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class GachaPoolEffectiveInfo : IMessage<GachaPoolEffectiveInfo>, IMessage, IEquatable<GachaPoolEffectiveInfo>, IDeepCloneable<GachaPoolEffectiveInfo>, IBufferMessage
{
	private static readonly MessageParser<GachaPoolEffectiveInfo> _parser = new MessageParser<GachaPoolEffectiveInfo>(() => new GachaPoolEffectiveInfo());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int BeginTimestampFieldNumber = 2;

	private long beginTimestamp_;

	public const int EndTimestampFieldNumber = 3;

	private long endTimestamp_;

	public const int StateFieldNumber = 4;

	private GachaPoolState state_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GachaPoolEffectiveInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[158];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long BeginTimestamp
	{
		get
		{
			return beginTimestamp_;
		}
		set
		{
			beginTimestamp_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long EndTimestamp
	{
		get
		{
			return endTimestamp_;
		}
		set
		{
			endTimestamp_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolState State
	{
		get
		{
			return state_;
		}
		set
		{
			state_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolEffectiveInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolEffectiveInfo(GachaPoolEffectiveInfo other)
		: this()
	{
		id_ = other.id_;
		beginTimestamp_ = other.beginTimestamp_;
		endTimestamp_ = other.endTimestamp_;
		state_ = other.state_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolEffectiveInfo Clone()
	{
		return new GachaPoolEffectiveInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GachaPoolEffectiveInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GachaPoolEffectiveInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (BeginTimestamp != other.BeginTimestamp)
		{
			return false;
		}
		if (EndTimestamp != other.EndTimestamp)
		{
			return false;
		}
		if (State != other.State)
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
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (BeginTimestamp != 0L)
		{
			num ^= BeginTimestamp.GetHashCode();
		}
		if (EndTimestamp != 0L)
		{
			num ^= EndTimestamp.GetHashCode();
		}
		if (State != GachaPoolState.Effective)
		{
			num ^= State.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (BeginTimestamp != 0L)
		{
			output.WriteRawTag(16);
			output.WriteInt64(BeginTimestamp);
		}
		if (EndTimestamp != 0L)
		{
			output.WriteRawTag(24);
			output.WriteInt64(EndTimestamp);
		}
		if (State != GachaPoolState.Effective)
		{
			output.WriteRawTag(32);
			output.WriteEnum((int)State);
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
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (BeginTimestamp != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(BeginTimestamp);
		}
		if (EndTimestamp != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(EndTimestamp);
		}
		if (State != GachaPoolState.Effective)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)State);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GachaPoolEffectiveInfo other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.BeginTimestamp != 0L)
			{
				BeginTimestamp = other.BeginTimestamp;
			}
			if (other.EndTimestamp != 0L)
			{
				EndTimestamp = other.EndTimestamp;
			}
			if (other.State != GachaPoolState.Effective)
			{
				State = other.State;
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
				Id = input.ReadInt32();
				break;
			case 16u:
				BeginTimestamp = input.ReadInt64();
				break;
			case 24u:
				EndTimestamp = input.ReadInt64();
				break;
			case 32u:
				State = (GachaPoolState)input.ReadEnum();
				break;
			}
		}
	}
}
