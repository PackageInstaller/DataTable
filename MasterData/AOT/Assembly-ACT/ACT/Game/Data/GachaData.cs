using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class GachaData : IMessage<GachaData>, IMessage, IEquatable<GachaData>, IDeepCloneable<GachaData>, IBufferMessage
{
	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static class Types
	{
		public sealed class CardPoolUniqueData : IMessage<CardPoolUniqueData>, IMessage, IEquatable<CardPoolUniqueData>, IDeepCloneable<CardPoolUniqueData>, IBufferMessage
		{
			private static readonly MessageParser<CardPoolUniqueData> _parser = new MessageParser<CardPoolUniqueData>(() => new CardPoolUniqueData());

			private UnknownFieldSet _unknownFields;

			public const int HasDrewNotChoseFiveStarNumFieldNumber = 1;

			private int hasDrewNotChoseFiveStarNum_;

			public const int ChoseItemIDFieldNumber = 2;

			private int choseItemID_;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public static MessageParser<CardPoolUniqueData> Parser => _parser;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public static MessageDescriptor Descriptor => GachaData.Descriptor.NestedTypes[0];

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			MessageDescriptor IMessage.Descriptor => Descriptor;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public int HasDrewNotChoseFiveStarNum
			{
				get
				{
					return hasDrewNotChoseFiveStarNum_;
				}
				set
				{
					hasDrewNotChoseFiveStarNum_ = value;
				}
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public int ChoseItemID
			{
				get
				{
					return choseItemID_;
				}
				set
				{
					choseItemID_ = value;
				}
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public CardPoolUniqueData()
			{
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public CardPoolUniqueData(CardPoolUniqueData other)
				: this()
			{
				hasDrewNotChoseFiveStarNum_ = other.hasDrewNotChoseFiveStarNum_;
				choseItemID_ = other.choseItemID_;
				_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public CardPoolUniqueData Clone()
			{
				return new CardPoolUniqueData(this);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public override bool Equals(object other)
			{
				return Equals(other as CardPoolUniqueData);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public bool Equals(CardPoolUniqueData other)
			{
				if (other == null)
				{
					return false;
				}
				if (other == this)
				{
					return true;
				}
				if (HasDrewNotChoseFiveStarNum != other.HasDrewNotChoseFiveStarNum)
				{
					return false;
				}
				if (ChoseItemID != other.ChoseItemID)
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
				if (HasDrewNotChoseFiveStarNum != 0)
				{
					num ^= HasDrewNotChoseFiveStarNum.GetHashCode();
				}
				if (ChoseItemID != 0)
				{
					num ^= ChoseItemID.GetHashCode();
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
				if (HasDrewNotChoseFiveStarNum != 0)
				{
					output.WriteRawTag(8);
					output.WriteInt32(HasDrewNotChoseFiveStarNum);
				}
				if (ChoseItemID != 0)
				{
					output.WriteRawTag(16);
					output.WriteInt32(ChoseItemID);
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
				if (HasDrewNotChoseFiveStarNum != 0)
				{
					num += 1 + CodedOutputStream.ComputeInt32Size(HasDrewNotChoseFiveStarNum);
				}
				if (ChoseItemID != 0)
				{
					num += 1 + CodedOutputStream.ComputeInt32Size(ChoseItemID);
				}
				if (_unknownFields != null)
				{
					num += _unknownFields.CalculateSize();
				}
				return num;
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public void MergeFrom(CardPoolUniqueData other)
			{
				if (other != null)
				{
					if (other.HasDrewNotChoseFiveStarNum != 0)
					{
						HasDrewNotChoseFiveStarNum = other.HasDrewNotChoseFiveStarNum;
					}
					if (other.ChoseItemID != 0)
					{
						ChoseItemID = other.ChoseItemID;
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
						HasDrewNotChoseFiveStarNum = input.ReadInt32();
						break;
					case 16u:
						ChoseItemID = input.ReadInt32();
						break;
					}
				}
			}
		}

		public sealed class CardPoolShareData : IMessage<CardPoolShareData>, IMessage, IEquatable<CardPoolShareData>, IDeepCloneable<CardPoolShareData>, IBufferMessage
		{
			private static readonly MessageParser<CardPoolShareData> _parser = new MessageParser<CardPoolShareData>(() => new CardPoolShareData());

			private UnknownFieldSet _unknownFields;

			public const int DrawNumFieldNumber = 1;

			private int drawNum_;

			public const int HasDrewNotFiveStarNumFieldNumber = 2;

			private int hasDrewNotFiveStarNum_;

			public const int HasDrewNotFourStarNumFieldNumber = 3;

			private int hasDrewNotFourStarNum_;

			public const int HasDrewNotUpFiveStarNumFieldNumber = 4;

			private int hasDrewNotUpFiveStarNum_;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public static MessageParser<CardPoolShareData> Parser => _parser;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public static MessageDescriptor Descriptor => GachaData.Descriptor.NestedTypes[1];

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			MessageDescriptor IMessage.Descriptor => Descriptor;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public int DrawNum
			{
				get
				{
					return drawNum_;
				}
				set
				{
					drawNum_ = value;
				}
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public int HasDrewNotFiveStarNum
			{
				get
				{
					return hasDrewNotFiveStarNum_;
				}
				set
				{
					hasDrewNotFiveStarNum_ = value;
				}
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public int HasDrewNotFourStarNum
			{
				get
				{
					return hasDrewNotFourStarNum_;
				}
				set
				{
					hasDrewNotFourStarNum_ = value;
				}
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public int HasDrewNotUpFiveStarNum
			{
				get
				{
					return hasDrewNotUpFiveStarNum_;
				}
				set
				{
					hasDrewNotUpFiveStarNum_ = value;
				}
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public CardPoolShareData()
			{
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public CardPoolShareData(CardPoolShareData other)
				: this()
			{
				drawNum_ = other.drawNum_;
				hasDrewNotFiveStarNum_ = other.hasDrewNotFiveStarNum_;
				hasDrewNotFourStarNum_ = other.hasDrewNotFourStarNum_;
				hasDrewNotUpFiveStarNum_ = other.hasDrewNotUpFiveStarNum_;
				_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public CardPoolShareData Clone()
			{
				return new CardPoolShareData(this);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public override bool Equals(object other)
			{
				return Equals(other as CardPoolShareData);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public bool Equals(CardPoolShareData other)
			{
				if (other == null)
				{
					return false;
				}
				if (other == this)
				{
					return true;
				}
				if (DrawNum != other.DrawNum)
				{
					return false;
				}
				if (HasDrewNotFiveStarNum != other.HasDrewNotFiveStarNum)
				{
					return false;
				}
				if (HasDrewNotFourStarNum != other.HasDrewNotFourStarNum)
				{
					return false;
				}
				if (HasDrewNotUpFiveStarNum != other.HasDrewNotUpFiveStarNum)
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
				if (DrawNum != 0)
				{
					num ^= DrawNum.GetHashCode();
				}
				if (HasDrewNotFiveStarNum != 0)
				{
					num ^= HasDrewNotFiveStarNum.GetHashCode();
				}
				if (HasDrewNotFourStarNum != 0)
				{
					num ^= HasDrewNotFourStarNum.GetHashCode();
				}
				if (HasDrewNotUpFiveStarNum != 0)
				{
					num ^= HasDrewNotUpFiveStarNum.GetHashCode();
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
				if (DrawNum != 0)
				{
					output.WriteRawTag(8);
					output.WriteInt32(DrawNum);
				}
				if (HasDrewNotFiveStarNum != 0)
				{
					output.WriteRawTag(16);
					output.WriteInt32(HasDrewNotFiveStarNum);
				}
				if (HasDrewNotFourStarNum != 0)
				{
					output.WriteRawTag(24);
					output.WriteInt32(HasDrewNotFourStarNum);
				}
				if (HasDrewNotUpFiveStarNum != 0)
				{
					output.WriteRawTag(32);
					output.WriteInt32(HasDrewNotUpFiveStarNum);
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
				if (DrawNum != 0)
				{
					num += 1 + CodedOutputStream.ComputeInt32Size(DrawNum);
				}
				if (HasDrewNotFiveStarNum != 0)
				{
					num += 1 + CodedOutputStream.ComputeInt32Size(HasDrewNotFiveStarNum);
				}
				if (HasDrewNotFourStarNum != 0)
				{
					num += 1 + CodedOutputStream.ComputeInt32Size(HasDrewNotFourStarNum);
				}
				if (HasDrewNotUpFiveStarNum != 0)
				{
					num += 1 + CodedOutputStream.ComputeInt32Size(HasDrewNotUpFiveStarNum);
				}
				if (_unknownFields != null)
				{
					num += _unknownFields.CalculateSize();
				}
				return num;
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public void MergeFrom(CardPoolShareData other)
			{
				if (other != null)
				{
					if (other.DrawNum != 0)
					{
						DrawNum = other.DrawNum;
					}
					if (other.HasDrewNotFiveStarNum != 0)
					{
						HasDrewNotFiveStarNum = other.HasDrewNotFiveStarNum;
					}
					if (other.HasDrewNotFourStarNum != 0)
					{
						HasDrewNotFourStarNum = other.HasDrewNotFourStarNum;
					}
					if (other.HasDrewNotUpFiveStarNum != 0)
					{
						HasDrewNotUpFiveStarNum = other.HasDrewNotUpFiveStarNum;
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
						DrawNum = input.ReadInt32();
						break;
					case 16u:
						HasDrewNotFiveStarNum = input.ReadInt32();
						break;
					case 24u:
						HasDrewNotFourStarNum = input.ReadInt32();
						break;
					case 32u:
						HasDrewNotUpFiveStarNum = input.ReadInt32();
						break;
					}
				}
			}
		}
	}

	private static readonly MessageParser<GachaData> _parser = new MessageParser<GachaData>(() => new GachaData());

	private UnknownFieldSet _unknownFields;

	public const int CardPoolDatasByTypeFieldNumber = 1;

	private static readonly MapField<int, Types.CardPoolShareData>.Codec _map_cardPoolDatasByType_codec = new MapField<int, Types.CardPoolShareData>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Types.CardPoolShareData.Parser), 10u);

	private readonly MapField<int, Types.CardPoolShareData> cardPoolDatasByType_ = new MapField<int, Types.CardPoolShareData>();

	public const int CardPoolDatasByIdFieldNumber = 2;

	private static readonly MapField<int, Types.CardPoolUniqueData>.Codec _map_cardPoolDatasById_codec = new MapField<int, Types.CardPoolUniqueData>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Types.CardPoolUniqueData.Parser), 18u);

	private readonly MapField<int, Types.CardPoolUniqueData> cardPoolDatasById_ = new MapField<int, Types.CardPoolUniqueData>();

	public const int PoolShareDataFieldNumber = 3;

	private GachaPoolShareData poolShareData_;

	public const int PoolUniqueDataFieldNumber = 4;

	private static readonly MapField<int, GachaPoolUniqueData>.Codec _map_poolUniqueData_codec = new MapField<int, GachaPoolUniqueData>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, GachaPoolUniqueData.Parser), 34u);

	private readonly MapField<int, GachaPoolUniqueData> poolUniqueData_ = new MapField<int, GachaPoolUniqueData>();

	public const int PoolHistoryFieldNumber = 5;

	private static readonly MapField<int, GachaHistoryItems>.Codec _map_poolHistory_codec = new MapField<int, GachaHistoryItems>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, GachaHistoryItems.Parser), 42u);

	private readonly MapField<int, GachaHistoryItems> poolHistory_ = new MapField<int, GachaHistoryItems>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GachaData> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[159];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, Types.CardPoolShareData> CardPoolDatasByType => cardPoolDatasByType_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, Types.CardPoolUniqueData> CardPoolDatasById => cardPoolDatasById_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolShareData PoolShareData
	{
		get
		{
			return poolShareData_;
		}
		set
		{
			poolShareData_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, GachaPoolUniqueData> PoolUniqueData => poolUniqueData_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, GachaHistoryItems> PoolHistory => poolHistory_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaData()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaData(GachaData other)
		: this()
	{
		cardPoolDatasByType_ = other.cardPoolDatasByType_.Clone();
		cardPoolDatasById_ = other.cardPoolDatasById_.Clone();
		poolShareData_ = ((other.poolShareData_ != null) ? other.poolShareData_.Clone() : null);
		poolUniqueData_ = other.poolUniqueData_.Clone();
		poolHistory_ = other.poolHistory_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaData Clone()
	{
		return new GachaData(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GachaData);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GachaData other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!CardPoolDatasByType.Equals(other.CardPoolDatasByType))
		{
			return false;
		}
		if (!CardPoolDatasById.Equals(other.CardPoolDatasById))
		{
			return false;
		}
		if (!object.Equals(PoolShareData, other.PoolShareData))
		{
			return false;
		}
		if (!PoolUniqueData.Equals(other.PoolUniqueData))
		{
			return false;
		}
		if (!PoolHistory.Equals(other.PoolHistory))
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
		num ^= CardPoolDatasByType.GetHashCode();
		num ^= CardPoolDatasById.GetHashCode();
		if (poolShareData_ != null)
		{
			num ^= PoolShareData.GetHashCode();
		}
		num ^= PoolUniqueData.GetHashCode();
		num ^= PoolHistory.GetHashCode();
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
		cardPoolDatasByType_.WriteTo(ref output, _map_cardPoolDatasByType_codec);
		cardPoolDatasById_.WriteTo(ref output, _map_cardPoolDatasById_codec);
		if (poolShareData_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(PoolShareData);
		}
		poolUniqueData_.WriteTo(ref output, _map_poolUniqueData_codec);
		poolHistory_.WriteTo(ref output, _map_poolHistory_codec);
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
		num += cardPoolDatasByType_.CalculateSize(_map_cardPoolDatasByType_codec);
		num += cardPoolDatasById_.CalculateSize(_map_cardPoolDatasById_codec);
		if (poolShareData_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(PoolShareData);
		}
		num += poolUniqueData_.CalculateSize(_map_poolUniqueData_codec);
		num += poolHistory_.CalculateSize(_map_poolHistory_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GachaData other)
	{
		if (other == null)
		{
			return;
		}
		cardPoolDatasByType_.Add(other.cardPoolDatasByType_);
		cardPoolDatasById_.Add(other.cardPoolDatasById_);
		if (other.poolShareData_ != null)
		{
			if (poolShareData_ == null)
			{
				PoolShareData = new GachaPoolShareData();
			}
			PoolShareData.MergeFrom(other.PoolShareData);
		}
		poolUniqueData_.Add(other.poolUniqueData_);
		poolHistory_.Add(other.poolHistory_);
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
				cardPoolDatasByType_.AddEntriesFrom(ref input, _map_cardPoolDatasByType_codec);
				break;
			case 18u:
				cardPoolDatasById_.AddEntriesFrom(ref input, _map_cardPoolDatasById_codec);
				break;
			case 26u:
				if (poolShareData_ == null)
				{
					PoolShareData = new GachaPoolShareData();
				}
				input.ReadMessage(PoolShareData);
				break;
			case 34u:
				poolUniqueData_.AddEntriesFrom(ref input, _map_poolUniqueData_codec);
				break;
			case 42u:
				poolHistory_.AddEntriesFrom(ref input, _map_poolHistory_codec);
				break;
			}
		}
	}
}
