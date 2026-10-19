using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Abyss : IMessage<Abyss>, IMessage, IEquatable<Abyss>, IDeepCloneable<Abyss>, IBufferMessage
{
	private static readonly MessageParser<Abyss> _parser = new MessageParser<Abyss>(() => new Abyss());

	private UnknownFieldSet _unknownFields;

	public const int StagesFieldNumber = 1;

	private static readonly FieldCodec<AbyssStage> _repeated_stages_codec = FieldCodec.ForMessage(10u, AbyssStage.Parser);

	private readonly RepeatedField<AbyssStage> stages_ = new RepeatedField<AbyssStage>();

	public const int TakenRewardsFieldNumber = 2;

	private static readonly MapField<int, bool>.Codec _map_takenRewards_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 18u);

	private readonly MapField<int, bool> takenRewards_ = new MapField<int, bool>();

	public const int IdFieldNumber = 3;

	private int id_;

	public const int CurChallengeStageFieldNumber = 4;

	private int curChallengeStage_;

	public const int LastChallengeStageFieldNumber = 5;

	private int lastChallengeStage_;

	public const int RecycleFieldNumber = 6;

	private bool recycle_;

	public const int JumpStartFloorFieldNumber = 7;

	private int jumpStartFloor_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Abyss> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[136];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<AbyssStage> Stages => stages_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> TakenRewards => takenRewards_;

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
	public int CurChallengeStage
	{
		get
		{
			return curChallengeStage_;
		}
		set
		{
			curChallengeStage_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int LastChallengeStage
	{
		get
		{
			return lastChallengeStage_;
		}
		set
		{
			lastChallengeStage_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Recycle
	{
		get
		{
			return recycle_;
		}
		set
		{
			recycle_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int JumpStartFloor
	{
		get
		{
			return jumpStartFloor_;
		}
		set
		{
			jumpStartFloor_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Abyss()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Abyss(Abyss other)
		: this()
	{
		stages_ = other.stages_.Clone();
		takenRewards_ = other.takenRewards_.Clone();
		id_ = other.id_;
		curChallengeStage_ = other.curChallengeStage_;
		lastChallengeStage_ = other.lastChallengeStage_;
		recycle_ = other.recycle_;
		jumpStartFloor_ = other.jumpStartFloor_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Abyss Clone()
	{
		return new Abyss(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Abyss);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Abyss other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!stages_.Equals(other.stages_))
		{
			return false;
		}
		if (!TakenRewards.Equals(other.TakenRewards))
		{
			return false;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (CurChallengeStage != other.CurChallengeStage)
		{
			return false;
		}
		if (LastChallengeStage != other.LastChallengeStage)
		{
			return false;
		}
		if (Recycle != other.Recycle)
		{
			return false;
		}
		if (JumpStartFloor != other.JumpStartFloor)
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
		num ^= stages_.GetHashCode();
		num ^= TakenRewards.GetHashCode();
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (CurChallengeStage != 0)
		{
			num ^= CurChallengeStage.GetHashCode();
		}
		if (LastChallengeStage != 0)
		{
			num ^= LastChallengeStage.GetHashCode();
		}
		if (Recycle)
		{
			num ^= Recycle.GetHashCode();
		}
		if (JumpStartFloor != 0)
		{
			num ^= JumpStartFloor.GetHashCode();
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
		stages_.WriteTo(ref output, _repeated_stages_codec);
		takenRewards_.WriteTo(ref output, _map_takenRewards_codec);
		if (Id != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Id);
		}
		if (CurChallengeStage != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(CurChallengeStage);
		}
		if (LastChallengeStage != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(LastChallengeStage);
		}
		if (Recycle)
		{
			output.WriteRawTag(48);
			output.WriteBool(Recycle);
		}
		if (JumpStartFloor != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(JumpStartFloor);
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
		num += stages_.CalculateSize(_repeated_stages_codec);
		num += takenRewards_.CalculateSize(_map_takenRewards_codec);
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (CurChallengeStage != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurChallengeStage);
		}
		if (LastChallengeStage != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LastChallengeStage);
		}
		if (Recycle)
		{
			num += 2;
		}
		if (JumpStartFloor != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(JumpStartFloor);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Abyss other)
	{
		if (other != null)
		{
			stages_.Add(other.stages_);
			takenRewards_.Add(other.takenRewards_);
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.CurChallengeStage != 0)
			{
				CurChallengeStage = other.CurChallengeStage;
			}
			if (other.LastChallengeStage != 0)
			{
				LastChallengeStage = other.LastChallengeStage;
			}
			if (other.Recycle)
			{
				Recycle = other.Recycle;
			}
			if (other.JumpStartFloor != 0)
			{
				JumpStartFloor = other.JumpStartFloor;
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
			case 10u:
				stages_.AddEntriesFrom(ref input, _repeated_stages_codec);
				break;
			case 18u:
				takenRewards_.AddEntriesFrom(ref input, _map_takenRewards_codec);
				break;
			case 24u:
				Id = input.ReadInt32();
				break;
			case 32u:
				CurChallengeStage = input.ReadInt32();
				break;
			case 40u:
				LastChallengeStage = input.ReadInt32();
				break;
			case 48u:
				Recycle = input.ReadBool();
				break;
			case 56u:
				JumpStartFloor = input.ReadInt32();
				break;
			}
		}
	}
}
