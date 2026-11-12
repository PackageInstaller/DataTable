using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class JointDrillQuest : IMessage<JointDrillQuest>, IMessage, IEquatable<JointDrillQuest>, IDeepCloneable<JointDrillQuest>
{
	private static readonly MessageParser<JointDrillQuest> _parser = new MessageParser<JointDrillQuest>(() => new JointDrillQuest());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int TitleFieldNumber = 3;

	private string title_ = "";

	public const int OrderFieldNumber = 4;

	private int order_;

	public const int CompleteCondFieldNumber = 5;

	private int completeCond_;

	public const int CompleteCondParamsFieldNumber = 6;

	private string completeCondParams_ = "";

	public const int AwardItemTid1FieldNumber = 7;

	private int awardItemTid1_;

	public const int AwardItemNum1FieldNumber = 8;

	private int awardItemNum1_;

	public const int AwardItemTid2FieldNumber = 9;

	private int awardItemTid2_;

	public const int AwardItemNum2FieldNumber = 10;

	private int awardItemNum2_;

	public const int AwardItemTid3FieldNumber = 11;

	private int awardItemTid3_;

	public const int AwardItemNum3FieldNumber = 12;

	private int awardItemNum3_;

	[DebuggerNonUserCode]
	public static MessageParser<JointDrillQuest> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(480);

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
	public int GroupId
	{
		get
		{
			return groupId_;
		}
		set
		{
			groupId_ = value;
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
	public int Order
	{
		get
		{
			return order_;
		}
		set
		{
			order_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CompleteCond
	{
		get
		{
			return completeCond_;
		}
		set
		{
			completeCond_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string CompleteCondParams
	{
		get
		{
			return completeCondParams_;
		}
		set
		{
			completeCondParams_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int AwardItemTid1
	{
		get
		{
			return awardItemTid1_;
		}
		set
		{
			awardItemTid1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AwardItemNum1
	{
		get
		{
			return awardItemNum1_;
		}
		set
		{
			awardItemNum1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AwardItemTid2
	{
		get
		{
			return awardItemTid2_;
		}
		set
		{
			awardItemTid2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AwardItemNum2
	{
		get
		{
			return awardItemNum2_;
		}
		set
		{
			awardItemNum2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AwardItemTid3
	{
		get
		{
			return awardItemTid3_;
		}
		set
		{
			awardItemTid3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AwardItemNum3
	{
		get
		{
			return awardItemNum3_;
		}
		set
		{
			awardItemNum3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public JointDrillQuest()
	{
	}

	[DebuggerNonUserCode]
	public JointDrillQuest(JointDrillQuest other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		title_ = other.title_;
		order_ = other.order_;
		completeCond_ = other.completeCond_;
		completeCondParams_ = other.completeCondParams_;
		awardItemTid1_ = other.awardItemTid1_;
		awardItemNum1_ = other.awardItemNum1_;
		awardItemTid2_ = other.awardItemTid2_;
		awardItemNum2_ = other.awardItemNum2_;
		awardItemTid3_ = other.awardItemTid3_;
		awardItemNum3_ = other.awardItemNum3_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public JointDrillQuest Clone()
	{
		return new JointDrillQuest(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as JointDrillQuest);
	}

	[DebuggerNonUserCode]
	public bool Equals(JointDrillQuest other)
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
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (Order != other.Order)
		{
			return false;
		}
		if (CompleteCond != other.CompleteCond)
		{
			return false;
		}
		if (CompleteCondParams != other.CompleteCondParams)
		{
			return false;
		}
		if (AwardItemTid1 != other.AwardItemTid1)
		{
			return false;
		}
		if (AwardItemNum1 != other.AwardItemNum1)
		{
			return false;
		}
		if (AwardItemTid2 != other.AwardItemTid2)
		{
			return false;
		}
		if (AwardItemNum2 != other.AwardItemNum2)
		{
			return false;
		}
		if (AwardItemTid3 != other.AwardItemTid3)
		{
			return false;
		}
		if (AwardItemNum3 != other.AwardItemNum3)
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
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Order != 0)
		{
			num ^= Order.GetHashCode();
		}
		if (CompleteCond != 0)
		{
			num ^= CompleteCond.GetHashCode();
		}
		if (CompleteCondParams.Length != 0)
		{
			num ^= CompleteCondParams.GetHashCode();
		}
		if (AwardItemTid1 != 0)
		{
			num ^= AwardItemTid1.GetHashCode();
		}
		if (AwardItemNum1 != 0)
		{
			num ^= AwardItemNum1.GetHashCode();
		}
		if (AwardItemTid2 != 0)
		{
			num ^= AwardItemTid2.GetHashCode();
		}
		if (AwardItemNum2 != 0)
		{
			num ^= AwardItemNum2.GetHashCode();
		}
		if (AwardItemTid3 != 0)
		{
			num ^= AwardItemTid3.GetHashCode();
		}
		if (AwardItemNum3 != 0)
		{
			num ^= AwardItemNum3.GetHashCode();
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
		if (GroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GroupId);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Title);
		}
		if (Order != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Order);
		}
		if (CompleteCond != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(CompleteCond);
		}
		if (CompleteCondParams.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(CompleteCondParams);
		}
		if (AwardItemTid1 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(AwardItemTid1);
		}
		if (AwardItemNum1 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(AwardItemNum1);
		}
		if (AwardItemTid2 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(AwardItemTid2);
		}
		if (AwardItemNum2 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(AwardItemNum2);
		}
		if (AwardItemTid3 != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(AwardItemTid3);
		}
		if (AwardItemNum3 != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(AwardItemNum3);
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
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Order != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Order);
		}
		if (CompleteCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CompleteCond);
		}
		if (CompleteCondParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CompleteCondParams);
		}
		if (AwardItemTid1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AwardItemTid1);
		}
		if (AwardItemNum1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AwardItemNum1);
		}
		if (AwardItemTid2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AwardItemTid2);
		}
		if (AwardItemNum2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AwardItemNum2);
		}
		if (AwardItemTid3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AwardItemTid3);
		}
		if (AwardItemNum3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AwardItemNum3);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(JointDrillQuest other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Order != 0)
			{
				Order = other.Order;
			}
			if (other.CompleteCond != 0)
			{
				CompleteCond = other.CompleteCond;
			}
			if (other.CompleteCondParams.Length != 0)
			{
				CompleteCondParams = other.CompleteCondParams;
			}
			if (other.AwardItemTid1 != 0)
			{
				AwardItemTid1 = other.AwardItemTid1;
			}
			if (other.AwardItemNum1 != 0)
			{
				AwardItemNum1 = other.AwardItemNum1;
			}
			if (other.AwardItemTid2 != 0)
			{
				AwardItemTid2 = other.AwardItemTid2;
			}
			if (other.AwardItemNum2 != 0)
			{
				AwardItemNum2 = other.AwardItemNum2;
			}
			if (other.AwardItemTid3 != 0)
			{
				AwardItemTid3 = other.AwardItemTid3;
			}
			if (other.AwardItemNum3 != 0)
			{
				AwardItemNum3 = other.AwardItemNum3;
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
				GroupId = input.ReadInt32();
				break;
			case 26u:
				Title = input.ReadString();
				break;
			case 32u:
				Order = input.ReadInt32();
				break;
			case 40u:
				CompleteCond = input.ReadInt32();
				break;
			case 50u:
				CompleteCondParams = input.ReadString();
				break;
			case 56u:
				AwardItemTid1 = input.ReadInt32();
				break;
			case 64u:
				AwardItemNum1 = input.ReadInt32();
				break;
			case 72u:
				AwardItemTid2 = input.ReadInt32();
				break;
			case 80u:
				AwardItemNum2 = input.ReadInt32();
				break;
			case 88u:
				AwardItemTid3 = input.ReadInt32();
				break;
			case 96u:
				AwardItemNum3 = input.ReadInt32();
				break;
			}
		}
	}
}
