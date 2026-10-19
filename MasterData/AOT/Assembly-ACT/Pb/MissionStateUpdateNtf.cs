using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MissionStateUpdateNtf : IMessage<MissionStateUpdateNtf>, IMessage, IEquatable<MissionStateUpdateNtf>, IDeepCloneable<MissionStateUpdateNtf>, IBufferMessage
{
	private static readonly MessageParser<MissionStateUpdateNtf> _parser = new MessageParser<MissionStateUpdateNtf>(() => new MissionStateUpdateNtf());

	private UnknownFieldSet _unknownFields;

	public const int MissionIDFieldNumber = 1;

	private long missionID_;

	public const int StateFieldNumber = 2;

	private MissionStateEnum state_;

	public const int RewardsFieldNumber = 3;

	private static readonly FieldCodec<UniversalItem> _repeated_rewards_codec = FieldCodec.ForMessage(26u, UniversalItem.Parser);

	private readonly RepeatedField<UniversalItem> rewards_ = new RepeatedField<UniversalItem>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MissionStateUpdateNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MissionReflection.Descriptor.MessageTypes[13];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long MissionID
	{
		get
		{
			return missionID_;
		}
		set
		{
			missionID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionStateEnum State
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
	public RepeatedField<UniversalItem> Rewards => rewards_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionStateUpdateNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionStateUpdateNtf(MissionStateUpdateNtf other)
		: this()
	{
		missionID_ = other.missionID_;
		state_ = other.state_;
		rewards_ = other.rewards_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionStateUpdateNtf Clone()
	{
		return new MissionStateUpdateNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MissionStateUpdateNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MissionStateUpdateNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (MissionID != other.MissionID)
		{
			return false;
		}
		if (State != other.State)
		{
			return false;
		}
		if (!rewards_.Equals(other.rewards_))
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
		if (MissionID != 0L)
		{
			num ^= MissionID.GetHashCode();
		}
		if (State != MissionStateEnum.MissionStateWaitAccept)
		{
			num ^= State.GetHashCode();
		}
		num ^= rewards_.GetHashCode();
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
		if (MissionID != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(MissionID);
		}
		if (State != MissionStateEnum.MissionStateWaitAccept)
		{
			output.WriteRawTag(16);
			output.WriteEnum((int)State);
		}
		rewards_.WriteTo(ref output, _repeated_rewards_codec);
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
		if (MissionID != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(MissionID);
		}
		if (State != MissionStateEnum.MissionStateWaitAccept)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)State);
		}
		num += rewards_.CalculateSize(_repeated_rewards_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MissionStateUpdateNtf other)
	{
		if (other != null)
		{
			if (other.MissionID != 0L)
			{
				MissionID = other.MissionID;
			}
			if (other.State != MissionStateEnum.MissionStateWaitAccept)
			{
				State = other.State;
			}
			rewards_.Add(other.rewards_);
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
				MissionID = input.ReadInt64();
				break;
			case 16u:
				State = (MissionStateEnum)input.ReadEnum();
				break;
			case 26u:
				rewards_.AddEntriesFrom(ref input, _repeated_rewards_codec);
				break;
			}
		}
	}
}
