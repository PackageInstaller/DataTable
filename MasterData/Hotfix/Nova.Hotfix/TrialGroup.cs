using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TrialGroup : IMessage<TrialGroup>, IMessage, IEquatable<TrialGroup>, IDeepCloneable<TrialGroup>
{
	private static readonly MessageParser<TrialGroup> _parser = new MessageParser<TrialGroup>(() => new TrialGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TrialCharFieldNumber = 2;

	private int trialChar_;

	public const int MasterPotentialFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_masterPotential_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> masterPotential_ = new RepeatedField<int>();

	public const int AssistPotentialFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_assistPotential_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> assistPotential_ = new RepeatedField<int>();

	public const int RewardId1FieldNumber = 5;

	private int rewardId1_;

	public const int Qty1FieldNumber = 6;

	private int qty1_;

	public const int RewardId2FieldNumber = 7;

	private int rewardId2_;

	public const int Qty2FieldNumber = 8;

	private int qty2_;

	public const int RewardId3FieldNumber = 9;

	private int rewardId3_;

	public const int Qty3FieldNumber = 10;

	private int qty3_;

	[DebuggerNonUserCode]
	public static MessageParser<TrialGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1036);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
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
	public int TrialChar
	{
		get
		{
			return trialChar_;
		}
		set
		{
			trialChar_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> MasterPotential => masterPotential_;

	[DebuggerNonUserCode]
	public RepeatedField<int> AssistPotential => assistPotential_;

	[DebuggerNonUserCode]
	public int RewardId1
	{
		get
		{
			return rewardId1_;
		}
		set
		{
			rewardId1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty1
	{
		get
		{
			return qty1_;
		}
		set
		{
			qty1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardId2
	{
		get
		{
			return rewardId2_;
		}
		set
		{
			rewardId2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty2
	{
		get
		{
			return qty2_;
		}
		set
		{
			qty2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardId3
	{
		get
		{
			return rewardId3_;
		}
		set
		{
			rewardId3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty3
	{
		get
		{
			return qty3_;
		}
		set
		{
			qty3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TrialGroup()
	{
	}

	[DebuggerNonUserCode]
	public TrialGroup(TrialGroup other)
		: this()
	{
		id_ = other.id_;
		trialChar_ = other.trialChar_;
		masterPotential_ = other.masterPotential_.Clone();
		assistPotential_ = other.assistPotential_.Clone();
		rewardId1_ = other.rewardId1_;
		qty1_ = other.qty1_;
		rewardId2_ = other.rewardId2_;
		qty2_ = other.qty2_;
		rewardId3_ = other.rewardId3_;
		qty3_ = other.qty3_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TrialGroup Clone()
	{
		return new TrialGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TrialGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(TrialGroup other)
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
		if (TrialChar != other.TrialChar)
		{
			return false;
		}
		if (!masterPotential_.Equals(other.masterPotential_))
		{
			return false;
		}
		if (!assistPotential_.Equals(other.assistPotential_))
		{
			return false;
		}
		if (RewardId1 != other.RewardId1)
		{
			return false;
		}
		if (Qty1 != other.Qty1)
		{
			return false;
		}
		if (RewardId2 != other.RewardId2)
		{
			return false;
		}
		if (Qty2 != other.Qty2)
		{
			return false;
		}
		if (RewardId3 != other.RewardId3)
		{
			return false;
		}
		if (Qty3 != other.Qty3)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (TrialChar != 0)
		{
			num ^= TrialChar.GetHashCode();
		}
		num ^= masterPotential_.GetHashCode();
		num ^= assistPotential_.GetHashCode();
		if (RewardId1 != 0)
		{
			num ^= RewardId1.GetHashCode();
		}
		if (Qty1 != 0)
		{
			num ^= Qty1.GetHashCode();
		}
		if (RewardId2 != 0)
		{
			num ^= RewardId2.GetHashCode();
		}
		if (Qty2 != 0)
		{
			num ^= Qty2.GetHashCode();
		}
		if (RewardId3 != 0)
		{
			num ^= RewardId3.GetHashCode();
		}
		if (Qty3 != 0)
		{
			num ^= Qty3.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (TrialChar != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(TrialChar);
		}
		masterPotential_.WriteTo(output, _repeated_masterPotential_codec);
		assistPotential_.WriteTo(output, _repeated_assistPotential_codec);
		if (RewardId1 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(RewardId1);
		}
		if (Qty1 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Qty1);
		}
		if (RewardId2 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(RewardId2);
		}
		if (Qty2 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Qty2);
		}
		if (RewardId3 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(RewardId3);
		}
		if (Qty3 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Qty3);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(output);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (TrialChar != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TrialChar);
		}
		num += masterPotential_.CalculateSize(_repeated_masterPotential_codec);
		num += assistPotential_.CalculateSize(_repeated_assistPotential_codec);
		if (RewardId1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardId1);
		}
		if (Qty1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty1);
		}
		if (RewardId2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardId2);
		}
		if (Qty2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty2);
		}
		if (RewardId3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardId3);
		}
		if (Qty3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty3);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TrialGroup other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.TrialChar != 0)
			{
				TrialChar = other.TrialChar;
			}
			masterPotential_.Add(other.masterPotential_);
			assistPotential_.Add(other.assistPotential_);
			if (other.RewardId1 != 0)
			{
				RewardId1 = other.RewardId1;
			}
			if (other.Qty1 != 0)
			{
				Qty1 = other.Qty1;
			}
			if (other.RewardId2 != 0)
			{
				RewardId2 = other.RewardId2;
			}
			if (other.Qty2 != 0)
			{
				Qty2 = other.Qty2;
			}
			if (other.RewardId3 != 0)
			{
				RewardId3 = other.RewardId3;
			}
			if (other.Qty3 != 0)
			{
				Qty3 = other.Qty3;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 16u:
				TrialChar = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				masterPotential_.AddEntriesFrom(input, _repeated_masterPotential_codec);
				break;
			case 32u:
			case 34u:
				assistPotential_.AddEntriesFrom(input, _repeated_assistPotential_codec);
				break;
			case 40u:
				RewardId1 = input.ReadInt32();
				break;
			case 48u:
				Qty1 = input.ReadInt32();
				break;
			case 56u:
				RewardId2 = input.ReadInt32();
				break;
			case 64u:
				Qty2 = input.ReadInt32();
				break;
			case 72u:
				RewardId3 = input.ReadInt32();
				break;
			case 80u:
				Qty3 = input.ReadInt32();
				break;
			}
		}
	}
}
