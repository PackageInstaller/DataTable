using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class PlayerDeadAck : IMessage<PlayerDeadAck>, IMessage, IEquatable<PlayerDeadAck>, IDeepCloneable<PlayerDeadAck>, IBufferMessage
{
	private static readonly MessageParser<PlayerDeadAck> _parser = new MessageParser<PlayerDeadAck>(() => new PlayerDeadAck());

	private UnknownFieldSet _unknownFields;

	public const int BloodstainInfoFieldNumber = 1;

	private BloodstainInfo bloodstainInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<PlayerDeadAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[151];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BloodstainInfo BloodstainInfo
	{
		get
		{
			return bloodstainInfo_;
		}
		set
		{
			bloodstainInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PlayerDeadAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PlayerDeadAck(PlayerDeadAck other)
		: this()
	{
		bloodstainInfo_ = ((other.bloodstainInfo_ != null) ? other.bloodstainInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PlayerDeadAck Clone()
	{
		return new PlayerDeadAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as PlayerDeadAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(PlayerDeadAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(BloodstainInfo, other.BloodstainInfo))
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
		if (bloodstainInfo_ != null)
		{
			num ^= BloodstainInfo.GetHashCode();
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
		if (bloodstainInfo_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(BloodstainInfo);
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
		if (bloodstainInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(BloodstainInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(PlayerDeadAck other)
	{
		if (other == null)
		{
			return;
		}
		if (other.bloodstainInfo_ != null)
		{
			if (bloodstainInfo_ == null)
			{
				BloodstainInfo = new BloodstainInfo();
			}
			BloodstainInfo.MergeFrom(other.BloodstainInfo);
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
			if (bloodstainInfo_ == null)
			{
				BloodstainInfo = new BloodstainInfo();
			}
			input.ReadMessage(BloodstainInfo);
		}
	}
}
