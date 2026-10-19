using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class GiftToCharacterAck : IMessage<GiftToCharacterAck>, IMessage, IEquatable<GiftToCharacterAck>, IDeepCloneable<GiftToCharacterAck>, IBufferMessage
{
	private static readonly MessageParser<GiftToCharacterAck> _parser = new MessageParser<GiftToCharacterAck>(() => new GiftToCharacterAck());

	private UnknownFieldSet _unknownFields;

	public const int CharacterIDFieldNumber = 1;

	private int characterID_;

	public const int GotLikeabilityFieldNumber = 2;

	private int gotLikeability_;

	public const int CurLikeabilityLvFieldNumber = 3;

	private int curLikeabilityLv_;

	public const int CurLikeabilityExpFieldNumber = 4;

	private int curLikeabilityExp_;

	public const int LikeabilityRewardsFieldNumber = 5;

	private static readonly FieldCodec<UniversalItem> _repeated_likeabilityRewards_codec = FieldCodec.ForMessage(42u, UniversalItem.Parser);

	private readonly RepeatedField<UniversalItem> likeabilityRewards_ = new RepeatedField<UniversalItem>();

	public const int TodayGiftCountFieldNumber = 6;

	private int todayGiftCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GiftToCharacterAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => LoungeReflection.Descriptor.MessageTypes[5];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CharacterID
	{
		get
		{
			return characterID_;
		}
		set
		{
			characterID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int GotLikeability
	{
		get
		{
			return gotLikeability_;
		}
		set
		{
			gotLikeability_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CurLikeabilityLv
	{
		get
		{
			return curLikeabilityLv_;
		}
		set
		{
			curLikeabilityLv_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CurLikeabilityExp
	{
		get
		{
			return curLikeabilityExp_;
		}
		set
		{
			curLikeabilityExp_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<UniversalItem> LikeabilityRewards => likeabilityRewards_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TodayGiftCount
	{
		get
		{
			return todayGiftCount_;
		}
		set
		{
			todayGiftCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GiftToCharacterAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GiftToCharacterAck(GiftToCharacterAck other)
		: this()
	{
		characterID_ = other.characterID_;
		gotLikeability_ = other.gotLikeability_;
		curLikeabilityLv_ = other.curLikeabilityLv_;
		curLikeabilityExp_ = other.curLikeabilityExp_;
		likeabilityRewards_ = other.likeabilityRewards_.Clone();
		todayGiftCount_ = other.todayGiftCount_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GiftToCharacterAck Clone()
	{
		return new GiftToCharacterAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GiftToCharacterAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GiftToCharacterAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (CharacterID != other.CharacterID)
		{
			return false;
		}
		if (GotLikeability != other.GotLikeability)
		{
			return false;
		}
		if (CurLikeabilityLv != other.CurLikeabilityLv)
		{
			return false;
		}
		if (CurLikeabilityExp != other.CurLikeabilityExp)
		{
			return false;
		}
		if (!likeabilityRewards_.Equals(other.likeabilityRewards_))
		{
			return false;
		}
		if (TodayGiftCount != other.TodayGiftCount)
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
		if (CharacterID != 0)
		{
			num ^= CharacterID.GetHashCode();
		}
		if (GotLikeability != 0)
		{
			num ^= GotLikeability.GetHashCode();
		}
		if (CurLikeabilityLv != 0)
		{
			num ^= CurLikeabilityLv.GetHashCode();
		}
		if (CurLikeabilityExp != 0)
		{
			num ^= CurLikeabilityExp.GetHashCode();
		}
		num ^= likeabilityRewards_.GetHashCode();
		if (TodayGiftCount != 0)
		{
			num ^= TodayGiftCount.GetHashCode();
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
		if (CharacterID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(CharacterID);
		}
		if (GotLikeability != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GotLikeability);
		}
		if (CurLikeabilityLv != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CurLikeabilityLv);
		}
		if (CurLikeabilityExp != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(CurLikeabilityExp);
		}
		likeabilityRewards_.WriteTo(ref output, _repeated_likeabilityRewards_codec);
		if (TodayGiftCount != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(TodayGiftCount);
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
		if (CharacterID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharacterID);
		}
		if (GotLikeability != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GotLikeability);
		}
		if (CurLikeabilityLv != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurLikeabilityLv);
		}
		if (CurLikeabilityExp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurLikeabilityExp);
		}
		num += likeabilityRewards_.CalculateSize(_repeated_likeabilityRewards_codec);
		if (TodayGiftCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TodayGiftCount);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GiftToCharacterAck other)
	{
		if (other != null)
		{
			if (other.CharacterID != 0)
			{
				CharacterID = other.CharacterID;
			}
			if (other.GotLikeability != 0)
			{
				GotLikeability = other.GotLikeability;
			}
			if (other.CurLikeabilityLv != 0)
			{
				CurLikeabilityLv = other.CurLikeabilityLv;
			}
			if (other.CurLikeabilityExp != 0)
			{
				CurLikeabilityExp = other.CurLikeabilityExp;
			}
			likeabilityRewards_.Add(other.likeabilityRewards_);
			if (other.TodayGiftCount != 0)
			{
				TodayGiftCount = other.TodayGiftCount;
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
				CharacterID = input.ReadInt32();
				break;
			case 16u:
				GotLikeability = input.ReadInt32();
				break;
			case 24u:
				CurLikeabilityLv = input.ReadInt32();
				break;
			case 32u:
				CurLikeabilityExp = input.ReadInt32();
				break;
			case 42u:
				likeabilityRewards_.AddEntriesFrom(ref input, _repeated_likeabilityRewards_codec);
				break;
			case 48u:
				TodayGiftCount = input.ReadInt32();
				break;
			}
		}
	}
}
