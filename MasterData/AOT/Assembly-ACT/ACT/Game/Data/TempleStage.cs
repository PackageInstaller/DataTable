using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class TempleStage : IMessage<TempleStage>, IMessage, IEquatable<TempleStage>, IDeepCloneable<TempleStage>, IBufferMessage
{
	private static readonly MessageParser<TempleStage> _parser = new MessageParser<TempleStage>(() => new TempleStage());

	private UnknownFieldSet _unknownFields;

	public const int TempleIdFieldNumber = 1;

	private int templeId_;

	public const int TeamCharacterIdsFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_teamCharacterIds_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> teamCharacterIds_ = new RepeatedField<int>();

	public const int EntryWorldIdFieldNumber = 3;

	private int entryWorldId_;

	public const int StateFieldNumber = 4;

	private TempleStageState state_;

	public const int ObtainRobotsFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_obtainRobots_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> obtainRobots_ = new RepeatedField<int>();

	public const int OpenTreasureNumFieldNumber = 7;

	private int openTreasureNum_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TempleStage> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[139];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TempleId
	{
		get
		{
			return templeId_;
		}
		set
		{
			templeId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> TeamCharacterIds => teamCharacterIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int EntryWorldId
	{
		get
		{
			return entryWorldId_;
		}
		set
		{
			entryWorldId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleStageState State
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
	public RepeatedField<int> ObtainRobots => obtainRobots_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int OpenTreasureNum
	{
		get
		{
			return openTreasureNum_;
		}
		set
		{
			openTreasureNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleStage()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleStage(TempleStage other)
		: this()
	{
		templeId_ = other.templeId_;
		teamCharacterIds_ = other.teamCharacterIds_.Clone();
		entryWorldId_ = other.entryWorldId_;
		state_ = other.state_;
		obtainRobots_ = other.obtainRobots_.Clone();
		openTreasureNum_ = other.openTreasureNum_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleStage Clone()
	{
		return new TempleStage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TempleStage);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TempleStage other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (TempleId != other.TempleId)
		{
			return false;
		}
		if (!teamCharacterIds_.Equals(other.teamCharacterIds_))
		{
			return false;
		}
		if (EntryWorldId != other.EntryWorldId)
		{
			return false;
		}
		if (State != other.State)
		{
			return false;
		}
		if (!obtainRobots_.Equals(other.obtainRobots_))
		{
			return false;
		}
		if (OpenTreasureNum != other.OpenTreasureNum)
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
		if (TempleId != 0)
		{
			num ^= TempleId.GetHashCode();
		}
		num ^= teamCharacterIds_.GetHashCode();
		if (EntryWorldId != 0)
		{
			num ^= EntryWorldId.GetHashCode();
		}
		if (State != TempleStageState.TempleStageInit)
		{
			num ^= State.GetHashCode();
		}
		num ^= obtainRobots_.GetHashCode();
		if (OpenTreasureNum != 0)
		{
			num ^= OpenTreasureNum.GetHashCode();
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
		if (TempleId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(TempleId);
		}
		teamCharacterIds_.WriteTo(ref output, _repeated_teamCharacterIds_codec);
		if (EntryWorldId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(EntryWorldId);
		}
		if (State != TempleStageState.TempleStageInit)
		{
			output.WriteRawTag(32);
			output.WriteEnum((int)State);
		}
		obtainRobots_.WriteTo(ref output, _repeated_obtainRobots_codec);
		if (OpenTreasureNum != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(OpenTreasureNum);
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
		if (TempleId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TempleId);
		}
		num += teamCharacterIds_.CalculateSize(_repeated_teamCharacterIds_codec);
		if (EntryWorldId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EntryWorldId);
		}
		if (State != TempleStageState.TempleStageInit)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)State);
		}
		num += obtainRobots_.CalculateSize(_repeated_obtainRobots_codec);
		if (OpenTreasureNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OpenTreasureNum);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TempleStage other)
	{
		if (other != null)
		{
			if (other.TempleId != 0)
			{
				TempleId = other.TempleId;
			}
			teamCharacterIds_.Add(other.teamCharacterIds_);
			if (other.EntryWorldId != 0)
			{
				EntryWorldId = other.EntryWorldId;
			}
			if (other.State != TempleStageState.TempleStageInit)
			{
				State = other.State;
			}
			obtainRobots_.Add(other.obtainRobots_);
			if (other.OpenTreasureNum != 0)
			{
				OpenTreasureNum = other.OpenTreasureNum;
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
				TempleId = input.ReadInt32();
				break;
			case 16u:
			case 18u:
				teamCharacterIds_.AddEntriesFrom(ref input, _repeated_teamCharacterIds_codec);
				break;
			case 24u:
				EntryWorldId = input.ReadInt32();
				break;
			case 32u:
				State = (TempleStageState)input.ReadEnum();
				break;
			case 48u:
			case 50u:
				obtainRobots_.AddEntriesFrom(ref input, _repeated_obtainRobots_codec);
				break;
			case 56u:
				OpenTreasureNum = input.ReadInt32();
				break;
			}
		}
	}
}
