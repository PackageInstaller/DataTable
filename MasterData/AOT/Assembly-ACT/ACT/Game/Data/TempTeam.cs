using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class TempTeam : IMessage<TempTeam>, IMessage, IEquatable<TempTeam>, IDeepCloneable<TempTeam>, IBufferMessage
{
	private static readonly MessageParser<TempTeam> _parser = new MessageParser<TempTeam>(() => new TempTeam());

	private UnknownFieldSet _unknownFields;

	public const int CharactersFieldNumber = 1;

	private static readonly FieldCodec<Character> _repeated_characters_codec = FieldCodec.ForMessage(10u, Character.Parser);

	private readonly RepeatedField<Character> characters_ = new RepeatedField<Character>();

	public const int BattleCharacterIdxFieldNumber = 2;

	private int battleCharacterIdx_;

	public const int PotionFieldNumber = 3;

	private PotionItem potion_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TempTeam> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[76];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Character> Characters => characters_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int BattleCharacterIdx
	{
		get
		{
			return battleCharacterIdx_;
		}
		set
		{
			battleCharacterIdx_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PotionItem Potion
	{
		get
		{
			return potion_;
		}
		set
		{
			potion_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempTeam()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempTeam(TempTeam other)
		: this()
	{
		characters_ = other.characters_.Clone();
		battleCharacterIdx_ = other.battleCharacterIdx_;
		potion_ = ((other.potion_ != null) ? other.potion_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempTeam Clone()
	{
		return new TempTeam(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TempTeam);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TempTeam other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!characters_.Equals(other.characters_))
		{
			return false;
		}
		if (BattleCharacterIdx != other.BattleCharacterIdx)
		{
			return false;
		}
		if (!object.Equals(Potion, other.Potion))
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
		num ^= characters_.GetHashCode();
		if (BattleCharacterIdx != 0)
		{
			num ^= BattleCharacterIdx.GetHashCode();
		}
		if (potion_ != null)
		{
			num ^= Potion.GetHashCode();
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
		characters_.WriteTo(ref output, _repeated_characters_codec);
		if (BattleCharacterIdx != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(BattleCharacterIdx);
		}
		if (potion_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(Potion);
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
		num += characters_.CalculateSize(_repeated_characters_codec);
		if (BattleCharacterIdx != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BattleCharacterIdx);
		}
		if (potion_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Potion);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TempTeam other)
	{
		if (other == null)
		{
			return;
		}
		characters_.Add(other.characters_);
		if (other.BattleCharacterIdx != 0)
		{
			BattleCharacterIdx = other.BattleCharacterIdx;
		}
		if (other.potion_ != null)
		{
			if (potion_ == null)
			{
				Potion = new PotionItem();
			}
			Potion.MergeFrom(other.Potion);
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
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 10u:
				characters_.AddEntriesFrom(ref input, _repeated_characters_codec);
				break;
			case 16u:
				BattleCharacterIdx = input.ReadInt32();
				break;
			case 26u:
				if (potion_ == null)
				{
					Potion = new PotionItem();
				}
				input.ReadMessage(Potion);
				break;
			}
		}
	}
}
