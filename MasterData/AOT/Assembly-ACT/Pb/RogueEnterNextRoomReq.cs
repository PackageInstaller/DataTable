using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class RogueEnterNextRoomReq : IMessage<RogueEnterNextRoomReq>, IMessage, IEquatable<RogueEnterNextRoomReq>, IDeepCloneable<RogueEnterNextRoomReq>, IBufferMessage
{
	private static readonly MessageParser<RogueEnterNextRoomReq> _parser = new MessageParser<RogueEnterNextRoomReq>(() => new RogueEnterNextRoomReq());

	private UnknownFieldSet _unknownFields;

	public const int RoomTypeFieldNumber = 1;

	private RogueRoomType roomType_;

	public const int ItemFieldNumber = 2;

	private static readonly MapField<int, RogueItem>.Codec _map_item_codec = new MapField<int, RogueItem>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, RogueItem.Parser), 18u);

	private readonly MapField<int, RogueItem> item_ = new MapField<int, RogueItem>();

	public const int LeftUseFieldNumber = 3;

	private static readonly MapField<int, int>.Codec _map_leftUse_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 26u);

	private readonly MapField<int, int> leftUse_ = new MapField<int, int>();

	public const int BattleInfoFieldNumber = 4;

	private static readonly MapField<int, int>.Codec _map_battleInfo_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 34u);

	private readonly MapField<int, int> battleInfo_ = new MapField<int, int>();

	public const int EffectInfoFieldNumber = 5;

	private static readonly MapField<int, int>.Codec _map_effectInfo_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 42u);

	private readonly MapField<int, int> effectInfo_ = new MapField<int, int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RogueEnterNextRoomReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => RogueReflection.Descriptor.MessageTypes[7];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueRoomType RoomType
	{
		get
		{
			return roomType_;
		}
		set
		{
			roomType_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, RogueItem> Item => item_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> LeftUse => leftUse_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> BattleInfo => battleInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> EffectInfo => effectInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueEnterNextRoomReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueEnterNextRoomReq(RogueEnterNextRoomReq other)
		: this()
	{
		roomType_ = other.roomType_;
		item_ = other.item_.Clone();
		leftUse_ = other.leftUse_.Clone();
		battleInfo_ = other.battleInfo_.Clone();
		effectInfo_ = other.effectInfo_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueEnterNextRoomReq Clone()
	{
		return new RogueEnterNextRoomReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RogueEnterNextRoomReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RogueEnterNextRoomReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (RoomType != other.RoomType)
		{
			return false;
		}
		if (!Item.Equals(other.Item))
		{
			return false;
		}
		if (!LeftUse.Equals(other.LeftUse))
		{
			return false;
		}
		if (!BattleInfo.Equals(other.BattleInfo))
		{
			return false;
		}
		if (!EffectInfo.Equals(other.EffectInfo))
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
		if (RoomType != RogueRoomType.Null)
		{
			num ^= RoomType.GetHashCode();
		}
		num ^= Item.GetHashCode();
		num ^= LeftUse.GetHashCode();
		num ^= BattleInfo.GetHashCode();
		num ^= EffectInfo.GetHashCode();
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
		if (RoomType != RogueRoomType.Null)
		{
			output.WriteRawTag(8);
			output.WriteEnum((int)RoomType);
		}
		item_.WriteTo(ref output, _map_item_codec);
		leftUse_.WriteTo(ref output, _map_leftUse_codec);
		battleInfo_.WriteTo(ref output, _map_battleInfo_codec);
		effectInfo_.WriteTo(ref output, _map_effectInfo_codec);
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
		if (RoomType != RogueRoomType.Null)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)RoomType);
		}
		num += item_.CalculateSize(_map_item_codec);
		num += leftUse_.CalculateSize(_map_leftUse_codec);
		num += battleInfo_.CalculateSize(_map_battleInfo_codec);
		num += effectInfo_.CalculateSize(_map_effectInfo_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RogueEnterNextRoomReq other)
	{
		if (other != null)
		{
			if (other.RoomType != RogueRoomType.Null)
			{
				RoomType = other.RoomType;
			}
			item_.Add(other.item_);
			leftUse_.Add(other.leftUse_);
			battleInfo_.Add(other.battleInfo_);
			effectInfo_.Add(other.effectInfo_);
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
				RoomType = (RogueRoomType)input.ReadEnum();
				break;
			case 18u:
				item_.AddEntriesFrom(ref input, _map_item_codec);
				break;
			case 26u:
				leftUse_.AddEntriesFrom(ref input, _map_leftUse_codec);
				break;
			case 34u:
				battleInfo_.AddEntriesFrom(ref input, _map_battleInfo_codec);
				break;
			case 42u:
				effectInfo_.AddEntriesFrom(ref input, _map_effectInfo_codec);
				break;
			}
		}
	}
}
