using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class AbyssBattleReport : IMessage<AbyssBattleReport>, IMessage, IEquatable<AbyssBattleReport>, IDeepCloneable<AbyssBattleReport>, IBufferMessage
{
	private static readonly MessageParser<AbyssBattleReport> _parser = new MessageParser<AbyssBattleReport>(() => new AbyssBattleReport());

	private UnknownFieldSet _unknownFields;

	public const int CharacterBattleCountFieldNumber = 1;

	private static readonly MapField<int, int>.Codec _map_characterBattleCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 10u);

	private readonly MapField<int, int> characterBattleCount_ = new MapField<int, int>();

	public const int CharacterUsePotionMaximumCountFieldNumber = 2;

	private static readonly MapField<int, int>.Codec _map_characterUsePotionMaximumCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 18u);

	private readonly MapField<int, int> characterUsePotionMaximumCount_ = new MapField<int, int>();

	public const int CharacterMaximumDamageFieldNumber = 3;

	private static readonly MapField<int, int>.Codec _map_characterMaximumDamage_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 26u);

	private readonly MapField<int, int> characterMaximumDamage_ = new MapField<int, int>();

	public const int CharacterMaximumExSkillCountFieldNumber = 4;

	private static readonly MapField<int, int>.Codec _map_characterMaximumExSkillCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 34u);

	private readonly MapField<int, int> characterMaximumExSkillCount_ = new MapField<int, int>();

	public const int CharacterMaximumDodgeCountFieldNumber = 5;

	private static readonly MapField<int, int>.Codec _map_characterMaximumDodgeCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 42u);

	private readonly MapField<int, int> characterMaximumDodgeCount_ = new MapField<int, int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AbyssBattleReport> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[134];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> CharacterBattleCount => characterBattleCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> CharacterUsePotionMaximumCount => characterUsePotionMaximumCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> CharacterMaximumDamage => characterMaximumDamage_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> CharacterMaximumExSkillCount => characterMaximumExSkillCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> CharacterMaximumDodgeCount => characterMaximumDodgeCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssBattleReport()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssBattleReport(AbyssBattleReport other)
		: this()
	{
		characterBattleCount_ = other.characterBattleCount_.Clone();
		characterUsePotionMaximumCount_ = other.characterUsePotionMaximumCount_.Clone();
		characterMaximumDamage_ = other.characterMaximumDamage_.Clone();
		characterMaximumExSkillCount_ = other.characterMaximumExSkillCount_.Clone();
		characterMaximumDodgeCount_ = other.characterMaximumDodgeCount_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssBattleReport Clone()
	{
		return new AbyssBattleReport(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AbyssBattleReport);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AbyssBattleReport other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!CharacterBattleCount.Equals(other.CharacterBattleCount))
		{
			return false;
		}
		if (!CharacterUsePotionMaximumCount.Equals(other.CharacterUsePotionMaximumCount))
		{
			return false;
		}
		if (!CharacterMaximumDamage.Equals(other.CharacterMaximumDamage))
		{
			return false;
		}
		if (!CharacterMaximumExSkillCount.Equals(other.CharacterMaximumExSkillCount))
		{
			return false;
		}
		if (!CharacterMaximumDodgeCount.Equals(other.CharacterMaximumDodgeCount))
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
		num ^= CharacterBattleCount.GetHashCode();
		num ^= CharacterUsePotionMaximumCount.GetHashCode();
		num ^= CharacterMaximumDamage.GetHashCode();
		num ^= CharacterMaximumExSkillCount.GetHashCode();
		num ^= CharacterMaximumDodgeCount.GetHashCode();
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
		characterBattleCount_.WriteTo(ref output, _map_characterBattleCount_codec);
		characterUsePotionMaximumCount_.WriteTo(ref output, _map_characterUsePotionMaximumCount_codec);
		characterMaximumDamage_.WriteTo(ref output, _map_characterMaximumDamage_codec);
		characterMaximumExSkillCount_.WriteTo(ref output, _map_characterMaximumExSkillCount_codec);
		characterMaximumDodgeCount_.WriteTo(ref output, _map_characterMaximumDodgeCount_codec);
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
		num += characterBattleCount_.CalculateSize(_map_characterBattleCount_codec);
		num += characterUsePotionMaximumCount_.CalculateSize(_map_characterUsePotionMaximumCount_codec);
		num += characterMaximumDamage_.CalculateSize(_map_characterMaximumDamage_codec);
		num += characterMaximumExSkillCount_.CalculateSize(_map_characterMaximumExSkillCount_codec);
		num += characterMaximumDodgeCount_.CalculateSize(_map_characterMaximumDodgeCount_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(AbyssBattleReport other)
	{
		if (other != null)
		{
			characterBattleCount_.Add(other.characterBattleCount_);
			characterUsePotionMaximumCount_.Add(other.characterUsePotionMaximumCount_);
			characterMaximumDamage_.Add(other.characterMaximumDamage_);
			characterMaximumExSkillCount_.Add(other.characterMaximumExSkillCount_);
			characterMaximumDodgeCount_.Add(other.characterMaximumDodgeCount_);
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
				characterBattleCount_.AddEntriesFrom(ref input, _map_characterBattleCount_codec);
				break;
			case 18u:
				characterUsePotionMaximumCount_.AddEntriesFrom(ref input, _map_characterUsePotionMaximumCount_codec);
				break;
			case 26u:
				characterMaximumDamage_.AddEntriesFrom(ref input, _map_characterMaximumDamage_codec);
				break;
			case 34u:
				characterMaximumExSkillCount_.AddEntriesFrom(ref input, _map_characterMaximumExSkillCount_codec);
				break;
			case 42u:
				characterMaximumDodgeCount_.AddEntriesFrom(ref input, _map_characterMaximumDodgeCount_codec);
				break;
			}
		}
	}
}
