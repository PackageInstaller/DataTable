using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class LoungeTriggerPointAck : IMessage<LoungeTriggerPointAck>, IMessage, IEquatable<LoungeTriggerPointAck>, IDeepCloneable<LoungeTriggerPointAck>, IBufferMessage
{
	private static readonly MessageParser<LoungeTriggerPointAck> _parser = new MessageParser<LoungeTriggerPointAck>(() => new LoungeTriggerPointAck());

	private UnknownFieldSet _unknownFields;

	public const int LoungeInfoFieldNumber = 1;

	private Lounge loungeInfo_;

	public const int PointIDFieldNumber = 2;

	private int pointID_;

	public const int GotLikeabilityFieldNumber = 3;

	private int gotLikeability_;

	public const int CurLikeabilityLvFieldNumber = 4;

	private int curLikeabilityLv_;

	public const int CurLikeabilityExpFieldNumber = 5;

	private int curLikeabilityExp_;

	public const int LikeabilityRewardsFieldNumber = 6;

	private static readonly FieldCodec<UniversalItem> _repeated_likeabilityRewards_codec = FieldCodec.ForMessage(50u, UniversalItem.Parser);

	private readonly RepeatedField<UniversalItem> likeabilityRewards_ = new RepeatedField<UniversalItem>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<LoungeTriggerPointAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => LoungeReflection.Descriptor.MessageTypes[7];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Lounge LoungeInfo
	{
		get
		{
			return loungeInfo_;
		}
		set
		{
			loungeInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PointID
	{
		get
		{
			return pointID_;
		}
		set
		{
			pointID_ = value;
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
	public LoungeTriggerPointAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoungeTriggerPointAck(LoungeTriggerPointAck other)
		: this()
	{
		loungeInfo_ = ((other.loungeInfo_ != null) ? other.loungeInfo_.Clone() : null);
		pointID_ = other.pointID_;
		gotLikeability_ = other.gotLikeability_;
		curLikeabilityLv_ = other.curLikeabilityLv_;
		curLikeabilityExp_ = other.curLikeabilityExp_;
		likeabilityRewards_ = other.likeabilityRewards_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoungeTriggerPointAck Clone()
	{
		return new LoungeTriggerPointAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as LoungeTriggerPointAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(LoungeTriggerPointAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(LoungeInfo, other.LoungeInfo))
		{
			return false;
		}
		if (PointID != other.PointID)
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
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		if (loungeInfo_ != null)
		{
			num ^= LoungeInfo.GetHashCode();
		}
		if (PointID != 0)
		{
			num ^= PointID.GetHashCode();
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
		if (loungeInfo_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(LoungeInfo);
		}
		if (PointID != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(PointID);
		}
		if (GotLikeability != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(GotLikeability);
		}
		if (CurLikeabilityLv != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(CurLikeabilityLv);
		}
		if (CurLikeabilityExp != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(CurLikeabilityExp);
		}
		likeabilityRewards_.WriteTo(ref output, _repeated_likeabilityRewards_codec);
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
		if (loungeInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(LoungeInfo);
		}
		if (PointID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PointID);
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
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(LoungeTriggerPointAck other)
	{
		if (other == null)
		{
			return;
		}
		if (other.loungeInfo_ != null)
		{
			if (loungeInfo_ == null)
			{
				LoungeInfo = new Lounge();
			}
			LoungeInfo.MergeFrom(other.LoungeInfo);
		}
		if (other.PointID != 0)
		{
			PointID = other.PointID;
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
				if (loungeInfo_ == null)
				{
					LoungeInfo = new Lounge();
				}
				input.ReadMessage(LoungeInfo);
				break;
			case 16u:
				PointID = input.ReadInt32();
				break;
			case 24u:
				GotLikeability = input.ReadInt32();
				break;
			case 32u:
				CurLikeabilityLv = input.ReadInt32();
				break;
			case 40u:
				CurLikeabilityExp = input.ReadInt32();
				break;
			case 50u:
				likeabilityRewards_.AddEntriesFrom(ref input, _repeated_likeabilityRewards_codec);
				break;
			}
		}
	}
}
