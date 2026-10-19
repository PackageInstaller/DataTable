using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class RogueContinueGameAck : IMessage<RogueContinueGameAck>, IMessage, IEquatable<RogueContinueGameAck>, IDeepCloneable<RogueContinueGameAck>, IBufferMessage
{
	private static readonly MessageParser<RogueContinueGameAck> _parser = new MessageParser<RogueContinueGameAck>(() => new RogueContinueGameAck());

	private UnknownFieldSet _unknownFields;

	public const int BattleCharacterFieldNumber = 1;

	private CharacterRepository battleCharacter_;

	public const int RougeTeamFieldNumber = 2;

	private Team rougeTeam_;

	public const int BagItemsFieldNumber = 3;

	private static readonly MapField<int, RogueItem>.Codec _map_bagItems_codec = new MapField<int, RogueItem>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, RogueItem.Parser), 26u);

	private readonly MapField<int, RogueItem> bagItems_ = new MapField<int, RogueItem>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RogueContinueGameAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => RogueReflection.Descriptor.MessageTypes[16];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterRepository BattleCharacter
	{
		get
		{
			return battleCharacter_;
		}
		set
		{
			battleCharacter_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Team RougeTeam
	{
		get
		{
			return rougeTeam_;
		}
		set
		{
			rougeTeam_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, RogueItem> BagItems => bagItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueContinueGameAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueContinueGameAck(RogueContinueGameAck other)
		: this()
	{
		battleCharacter_ = ((other.battleCharacter_ != null) ? other.battleCharacter_.Clone() : null);
		rougeTeam_ = ((other.rougeTeam_ != null) ? other.rougeTeam_.Clone() : null);
		bagItems_ = other.bagItems_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueContinueGameAck Clone()
	{
		return new RogueContinueGameAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RogueContinueGameAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RogueContinueGameAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(BattleCharacter, other.BattleCharacter))
		{
			return false;
		}
		if (!object.Equals(RougeTeam, other.RougeTeam))
		{
			return false;
		}
		if (!BagItems.Equals(other.BagItems))
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
		if (battleCharacter_ != null)
		{
			num ^= BattleCharacter.GetHashCode();
		}
		if (rougeTeam_ != null)
		{
			num ^= RougeTeam.GetHashCode();
		}
		num ^= BagItems.GetHashCode();
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
		if (battleCharacter_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(BattleCharacter);
		}
		if (rougeTeam_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(RougeTeam);
		}
		bagItems_.WriteTo(ref output, _map_bagItems_codec);
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
		if (battleCharacter_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(BattleCharacter);
		}
		if (rougeTeam_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(RougeTeam);
		}
		num += bagItems_.CalculateSize(_map_bagItems_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RogueContinueGameAck other)
	{
		if (other == null)
		{
			return;
		}
		if (other.battleCharacter_ != null)
		{
			if (battleCharacter_ == null)
			{
				BattleCharacter = new CharacterRepository();
			}
			BattleCharacter.MergeFrom(other.BattleCharacter);
		}
		if (other.rougeTeam_ != null)
		{
			if (rougeTeam_ == null)
			{
				RougeTeam = new Team();
			}
			RougeTeam.MergeFrom(other.RougeTeam);
		}
		bagItems_.Add(other.bagItems_);
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
				if (battleCharacter_ == null)
				{
					BattleCharacter = new CharacterRepository();
				}
				input.ReadMessage(BattleCharacter);
				break;
			case 18u:
				if (rougeTeam_ == null)
				{
					RougeTeam = new Team();
				}
				input.ReadMessage(RougeTeam);
				break;
			case 26u:
				bagItems_.AddEntriesFrom(ref input, _map_bagItems_codec);
				break;
			}
		}
	}
}
