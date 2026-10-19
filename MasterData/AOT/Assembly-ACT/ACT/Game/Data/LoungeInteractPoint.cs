using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class LoungeInteractPoint : IMessage<LoungeInteractPoint>, IMessage, IEquatable<LoungeInteractPoint>, IDeepCloneable<LoungeInteractPoint>, IBufferMessage
{
	private static readonly MessageParser<LoungeInteractPoint> _parser = new MessageParser<LoungeInteractPoint>(() => new LoungeInteractPoint());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CharacterFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_character_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> character_ = new RepeatedField<int>();

	public const int WaitStoryFieldNumber = 3;

	private int waitStory_;

	public const int PerformIDFieldNumber = 4;

	private int performID_;

	public const int IdleIDFieldNumber = 5;

	private int idleID_;

	public const int UseTypeFieldNumber = 6;

	private LoungeInteractPointUseType useType_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<LoungeInteractPoint> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[285];

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
	public RepeatedField<int> Character => character_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int WaitStory
	{
		get
		{
			return waitStory_;
		}
		set
		{
			waitStory_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PerformID
	{
		get
		{
			return performID_;
		}
		set
		{
			performID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int IdleID
	{
		get
		{
			return idleID_;
		}
		set
		{
			idleID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoungeInteractPointUseType UseType
	{
		get
		{
			return useType_;
		}
		set
		{
			useType_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoungeInteractPoint()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoungeInteractPoint(LoungeInteractPoint other)
		: this()
	{
		id_ = other.id_;
		character_ = other.character_.Clone();
		waitStory_ = other.waitStory_;
		performID_ = other.performID_;
		idleID_ = other.idleID_;
		useType_ = other.useType_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoungeInteractPoint Clone()
	{
		return new LoungeInteractPoint(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as LoungeInteractPoint);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(LoungeInteractPoint other)
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
		if (!character_.Equals(other.character_))
		{
			return false;
		}
		if (WaitStory != other.WaitStory)
		{
			return false;
		}
		if (PerformID != other.PerformID)
		{
			return false;
		}
		if (IdleID != other.IdleID)
		{
			return false;
		}
		if (UseType != other.UseType)
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
		num ^= character_.GetHashCode();
		if (WaitStory != 0)
		{
			num ^= WaitStory.GetHashCode();
		}
		if (PerformID != 0)
		{
			num ^= PerformID.GetHashCode();
		}
		if (IdleID != 0)
		{
			num ^= IdleID.GetHashCode();
		}
		if (UseType != LoungeInteractPointUseType.LoungeInteractPointUseEmpty)
		{
			num ^= UseType.GetHashCode();
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
		character_.WriteTo(ref output, _repeated_character_codec);
		if (WaitStory != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(WaitStory);
		}
		if (PerformID != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(PerformID);
		}
		if (IdleID != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(IdleID);
		}
		if (UseType != LoungeInteractPointUseType.LoungeInteractPointUseEmpty)
		{
			output.WriteRawTag(48);
			output.WriteEnum((int)UseType);
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
		num += character_.CalculateSize(_repeated_character_codec);
		if (WaitStory != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WaitStory);
		}
		if (PerformID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PerformID);
		}
		if (IdleID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(IdleID);
		}
		if (UseType != LoungeInteractPointUseType.LoungeInteractPointUseEmpty)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)UseType);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(LoungeInteractPoint other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			character_.Add(other.character_);
			if (other.WaitStory != 0)
			{
				WaitStory = other.WaitStory;
			}
			if (other.PerformID != 0)
			{
				PerformID = other.PerformID;
			}
			if (other.IdleID != 0)
			{
				IdleID = other.IdleID;
			}
			if (other.UseType != LoungeInteractPointUseType.LoungeInteractPointUseEmpty)
			{
				UseType = other.UseType;
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
			case 18u:
				character_.AddEntriesFrom(ref input, _repeated_character_codec);
				break;
			case 24u:
				WaitStory = input.ReadInt32();
				break;
			case 32u:
				PerformID = input.ReadInt32();
				break;
			case 40u:
				IdleID = input.ReadInt32();
				break;
			case 48u:
				UseType = (LoungeInteractPointUseType)input.ReadEnum();
				break;
			}
		}
	}
}
