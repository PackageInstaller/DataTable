using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class MonsterHandbook : IMessage<MonsterHandbook>, IMessage, IEquatable<MonsterHandbook>, IDeepCloneable<MonsterHandbook>, IBufferMessage
{
	private static readonly MessageParser<MonsterHandbook> _parser = new MessageParser<MonsterHandbook>(() => new MonsterHandbook());

	private UnknownFieldSet _unknownFields;

	public const int TypeKilledCountFieldNumber = 1;

	private static readonly MapField<int, int>.Codec _map_typeKilledCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 10u);

	private readonly MapField<int, int> typeKilledCount_ = new MapField<int, int>();

	public const int UnlockedMonsterIdsFieldNumber = 2;

	private static readonly MapField<int, bool>.Codec _map_unlockedMonsterIds_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 18u);

	private readonly MapField<int, bool> unlockedMonsterIds_ = new MapField<int, bool>();

	public const int UnlockedWildbossIdsFieldNumber = 3;

	private static readonly MapField<int, bool>.Codec _map_unlockedWildbossIds_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 26u);

	private readonly MapField<int, bool> unlockedWildbossIds_ = new MapField<int, bool>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MonsterHandbook> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[127];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> TypeKilledCount => typeKilledCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> UnlockedMonsterIds => unlockedMonsterIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> UnlockedWildbossIds => unlockedWildbossIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MonsterHandbook()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MonsterHandbook(MonsterHandbook other)
		: this()
	{
		typeKilledCount_ = other.typeKilledCount_.Clone();
		unlockedMonsterIds_ = other.unlockedMonsterIds_.Clone();
		unlockedWildbossIds_ = other.unlockedWildbossIds_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MonsterHandbook Clone()
	{
		return new MonsterHandbook(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MonsterHandbook);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MonsterHandbook other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!TypeKilledCount.Equals(other.TypeKilledCount))
		{
			return false;
		}
		if (!UnlockedMonsterIds.Equals(other.UnlockedMonsterIds))
		{
			return false;
		}
		if (!UnlockedWildbossIds.Equals(other.UnlockedWildbossIds))
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
		num ^= TypeKilledCount.GetHashCode();
		num ^= UnlockedMonsterIds.GetHashCode();
		num ^= UnlockedWildbossIds.GetHashCode();
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
		typeKilledCount_.WriteTo(ref output, _map_typeKilledCount_codec);
		unlockedMonsterIds_.WriteTo(ref output, _map_unlockedMonsterIds_codec);
		unlockedWildbossIds_.WriteTo(ref output, _map_unlockedWildbossIds_codec);
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
		num += typeKilledCount_.CalculateSize(_map_typeKilledCount_codec);
		num += unlockedMonsterIds_.CalculateSize(_map_unlockedMonsterIds_codec);
		num += unlockedWildbossIds_.CalculateSize(_map_unlockedWildbossIds_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MonsterHandbook other)
	{
		if (other != null)
		{
			typeKilledCount_.Add(other.typeKilledCount_);
			unlockedMonsterIds_.Add(other.unlockedMonsterIds_);
			unlockedWildbossIds_.Add(other.unlockedWildbossIds_);
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
				typeKilledCount_.AddEntriesFrom(ref input, _map_typeKilledCount_codec);
				break;
			case 18u:
				unlockedMonsterIds_.AddEntriesFrom(ref input, _map_unlockedMonsterIds_codec);
				break;
			case 26u:
				unlockedWildbossIds_.AddEntriesFrom(ref input, _map_unlockedWildbossIds_codec);
				break;
			}
		}
	}
}
