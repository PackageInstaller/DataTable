using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DormQuest : IMessage<DormQuest>, IMessage, IEquatable<DormQuest>, IDeepCloneable<DormQuest>
{
	private static readonly MessageParser<DormQuest> _parser = new MessageParser<DormQuest>(() => new DormQuest());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TitleFieldNumber = 2;

	private string title_ = "";

	public const int JumpToFieldNumber = 3;

	private int jumpTo_;

	public const int DormQuestGroupFieldNumber = 4;

	private int dormQuestGroup_;

	public const int PreDormQuestIdsFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_preDormQuestIds_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> preDormQuestIds_ = new RepeatedField<int>();

	public const int Reward1FieldNumber = 6;

	private int reward1_;

	public const int RewardQty1FieldNumber = 7;

	private int rewardQty1_;

	public const int Reward2FieldNumber = 8;

	private int reward2_;

	public const int RewardQty2FieldNumber = 9;

	private int rewardQty2_;

	public const int Reward3FieldNumber = 10;

	private int reward3_;

	public const int RewardQty3FieldNumber = 11;

	private int rewardQty3_;

	[DebuggerNonUserCode]
	public static MessageParser<DormQuest> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(298);

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
	public string Title
	{
		get
		{
			return title_;
		}
		set
		{
			title_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int JumpTo
	{
		get
		{
			return jumpTo_;
		}
		set
		{
			jumpTo_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DormQuestGroup
	{
		get
		{
			return dormQuestGroup_;
		}
		set
		{
			dormQuestGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> PreDormQuestIds => preDormQuestIds_;

	[DebuggerNonUserCode]
	public int Reward1
	{
		get
		{
			return reward1_;
		}
		set
		{
			reward1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardQty1
	{
		get
		{
			return rewardQty1_;
		}
		set
		{
			rewardQty1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward2
	{
		get
		{
			return reward2_;
		}
		set
		{
			reward2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardQty2
	{
		get
		{
			return rewardQty2_;
		}
		set
		{
			rewardQty2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward3
	{
		get
		{
			return reward3_;
		}
		set
		{
			reward3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardQty3
	{
		get
		{
			return rewardQty3_;
		}
		set
		{
			rewardQty3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public DormQuest()
	{
	}

	[DebuggerNonUserCode]
	public DormQuest(DormQuest other)
		: this()
	{
		id_ = other.id_;
		title_ = other.title_;
		jumpTo_ = other.jumpTo_;
		dormQuestGroup_ = other.dormQuestGroup_;
		preDormQuestIds_ = other.preDormQuestIds_.Clone();
		reward1_ = other.reward1_;
		rewardQty1_ = other.rewardQty1_;
		reward2_ = other.reward2_;
		rewardQty2_ = other.rewardQty2_;
		reward3_ = other.reward3_;
		rewardQty3_ = other.rewardQty3_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DormQuest Clone()
	{
		return new DormQuest(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DormQuest);
	}

	[DebuggerNonUserCode]
	public bool Equals(DormQuest other)
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
		if (Title != other.Title)
		{
			return false;
		}
		if (JumpTo != other.JumpTo)
		{
			return false;
		}
		if (DormQuestGroup != other.DormQuestGroup)
		{
			return false;
		}
		if (!preDormQuestIds_.Equals(other.preDormQuestIds_))
		{
			return false;
		}
		if (Reward1 != other.Reward1)
		{
			return false;
		}
		if (RewardQty1 != other.RewardQty1)
		{
			return false;
		}
		if (Reward2 != other.Reward2)
		{
			return false;
		}
		if (RewardQty2 != other.RewardQty2)
		{
			return false;
		}
		if (Reward3 != other.Reward3)
		{
			return false;
		}
		if (RewardQty3 != other.RewardQty3)
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
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (JumpTo != 0)
		{
			num ^= JumpTo.GetHashCode();
		}
		if (DormQuestGroup != 0)
		{
			num ^= DormQuestGroup.GetHashCode();
		}
		num ^= preDormQuestIds_.GetHashCode();
		if (Reward1 != 0)
		{
			num ^= Reward1.GetHashCode();
		}
		if (RewardQty1 != 0)
		{
			num ^= RewardQty1.GetHashCode();
		}
		if (Reward2 != 0)
		{
			num ^= Reward2.GetHashCode();
		}
		if (RewardQty2 != 0)
		{
			num ^= RewardQty2.GetHashCode();
		}
		if (Reward3 != 0)
		{
			num ^= Reward3.GetHashCode();
		}
		if (RewardQty3 != 0)
		{
			num ^= RewardQty3.GetHashCode();
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
		if (Title.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Title);
		}
		if (JumpTo != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(JumpTo);
		}
		if (DormQuestGroup != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(DormQuestGroup);
		}
		preDormQuestIds_.WriteTo(output, _repeated_preDormQuestIds_codec);
		if (Reward1 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Reward1);
		}
		if (RewardQty1 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(RewardQty1);
		}
		if (Reward2 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Reward2);
		}
		if (RewardQty2 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(RewardQty2);
		}
		if (Reward3 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Reward3);
		}
		if (RewardQty3 != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(RewardQty3);
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
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (JumpTo != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(JumpTo);
		}
		if (DormQuestGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DormQuestGroup);
		}
		num += preDormQuestIds_.CalculateSize(_repeated_preDormQuestIds_codec);
		if (Reward1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward1);
		}
		if (RewardQty1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardQty1);
		}
		if (Reward2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward2);
		}
		if (RewardQty2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardQty2);
		}
		if (Reward3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward3);
		}
		if (RewardQty3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardQty3);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DormQuest other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.JumpTo != 0)
			{
				JumpTo = other.JumpTo;
			}
			if (other.DormQuestGroup != 0)
			{
				DormQuestGroup = other.DormQuestGroup;
			}
			preDormQuestIds_.Add(other.preDormQuestIds_);
			if (other.Reward1 != 0)
			{
				Reward1 = other.Reward1;
			}
			if (other.RewardQty1 != 0)
			{
				RewardQty1 = other.RewardQty1;
			}
			if (other.Reward2 != 0)
			{
				Reward2 = other.Reward2;
			}
			if (other.RewardQty2 != 0)
			{
				RewardQty2 = other.RewardQty2;
			}
			if (other.Reward3 != 0)
			{
				Reward3 = other.Reward3;
			}
			if (other.RewardQty3 != 0)
			{
				RewardQty3 = other.RewardQty3;
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
			case 18u:
				Title = input.ReadString();
				break;
			case 24u:
				JumpTo = input.ReadInt32();
				break;
			case 32u:
				DormQuestGroup = input.ReadInt32();
				break;
			case 40u:
			case 42u:
				preDormQuestIds_.AddEntriesFrom(input, _repeated_preDormQuestIds_codec);
				break;
			case 48u:
				Reward1 = input.ReadInt32();
				break;
			case 56u:
				RewardQty1 = input.ReadInt32();
				break;
			case 64u:
				Reward2 = input.ReadInt32();
				break;
			case 72u:
				RewardQty2 = input.ReadInt32();
				break;
			case 80u:
				Reward3 = input.ReadInt32();
				break;
			case 88u:
				RewardQty3 = input.ReadInt32();
				break;
			}
		}
	}
}
