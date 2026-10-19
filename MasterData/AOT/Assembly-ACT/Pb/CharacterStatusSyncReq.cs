using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class CharacterStatusSyncReq : IMessage<CharacterStatusSyncReq>, IMessage, IEquatable<CharacterStatusSyncReq>, IDeepCloneable<CharacterStatusSyncReq>, IBufferMessage
{
	private static readonly MessageParser<CharacterStatusSyncReq> _parser = new MessageParser<CharacterStatusSyncReq>(() => new CharacterStatusSyncReq());

	private UnknownFieldSet _unknownFields;

	public const int CsFieldNumber = 1;

	private static readonly MapField<int, CharacterStatus>.Codec _map_cs_codec = new MapField<int, CharacterStatus>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, CharacterStatus.Parser), 10u);

	private readonly MapField<int, CharacterStatus> cs_ = new MapField<int, CharacterStatus>();

	public const int BattleCharacterIdFieldNumber = 2;

	private int battleCharacterId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<CharacterStatusSyncReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CharacterReflection.Descriptor.MessageTypes[9];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, CharacterStatus> Cs => cs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int BattleCharacterId
	{
		get
		{
			return battleCharacterId_;
		}
		set
		{
			battleCharacterId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterStatusSyncReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterStatusSyncReq(CharacterStatusSyncReq other)
		: this()
	{
		cs_ = other.cs_.Clone();
		battleCharacterId_ = other.battleCharacterId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterStatusSyncReq Clone()
	{
		return new CharacterStatusSyncReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterStatusSyncReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(CharacterStatusSyncReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Cs.Equals(other.Cs))
		{
			return false;
		}
		if (BattleCharacterId != other.BattleCharacterId)
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
		num ^= Cs.GetHashCode();
		if (BattleCharacterId != 0)
		{
			num ^= BattleCharacterId.GetHashCode();
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
		cs_.WriteTo(ref output, _map_cs_codec);
		if (BattleCharacterId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(BattleCharacterId);
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
		num += cs_.CalculateSize(_map_cs_codec);
		if (BattleCharacterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BattleCharacterId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CharacterStatusSyncReq other)
	{
		if (other != null)
		{
			cs_.Add(other.cs_);
			if (other.BattleCharacterId != 0)
			{
				BattleCharacterId = other.BattleCharacterId;
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
				cs_.AddEntriesFrom(ref input, _map_cs_codec);
				break;
			case 16u:
				BattleCharacterId = input.ReadInt32();
				break;
			}
		}
	}
}
