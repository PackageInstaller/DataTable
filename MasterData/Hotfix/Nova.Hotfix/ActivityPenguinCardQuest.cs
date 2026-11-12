using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityPenguinCardQuest : IMessage<ActivityPenguinCardQuest>, IMessage, IEquatable<ActivityPenguinCardQuest>, IDeepCloneable<ActivityPenguinCardQuest>
{
	private static readonly MessageParser<ActivityPenguinCardQuest> _parser = new MessageParser<ActivityPenguinCardQuest>(() => new ActivityPenguinCardQuest());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupFieldNumber = 2;

	private int group_;

	public const int FinishTypeFieldNumber = 3;

	private int finishType_;

	public const int FinishParamsFieldNumber = 4;

	private string finishParams_ = "";

	public const int DescFieldNumber = 5;

	private string desc_ = "";

	public const int AimNumShowFieldNumber = 6;

	private int aimNumShow_;

	public const int Item1FieldNumber = 7;

	private int item1_;

	public const int Qty1FieldNumber = 8;

	private int qty1_;

	public const int Item2FieldNumber = 9;

	private int item2_;

	public const int Qty2FieldNumber = 10;

	private int qty2_;

	[DebuggerNonUserCode]
	public static MessageParser<ActivityPenguinCardQuest> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(28);

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
	public int Group
	{
		get
		{
			return group_;
		}
		set
		{
			group_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FinishType
	{
		get
		{
			return finishType_;
		}
		set
		{
			finishType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string FinishParams
	{
		get
		{
			return finishParams_;
		}
		set
		{
			finishParams_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc
	{
		get
		{
			return desc_;
		}
		set
		{
			desc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int AimNumShow
	{
		get
		{
			return aimNumShow_;
		}
		set
		{
			aimNumShow_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Item1
	{
		get
		{
			return item1_;
		}
		set
		{
			item1_ = value;
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
	public int Item2
	{
		get
		{
			return item2_;
		}
		set
		{
			item2_ = value;
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
	public ActivityPenguinCardQuest()
	{
	}

	[DebuggerNonUserCode]
	public ActivityPenguinCardQuest(ActivityPenguinCardQuest other)
		: this()
	{
		id_ = other.id_;
		group_ = other.group_;
		finishType_ = other.finishType_;
		finishParams_ = other.finishParams_;
		desc_ = other.desc_;
		aimNumShow_ = other.aimNumShow_;
		item1_ = other.item1_;
		qty1_ = other.qty1_;
		item2_ = other.item2_;
		qty2_ = other.qty2_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityPenguinCardQuest Clone()
	{
		return new ActivityPenguinCardQuest(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityPenguinCardQuest);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityPenguinCardQuest other)
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
		if (Group != other.Group)
		{
			return false;
		}
		if (FinishType != other.FinishType)
		{
			return false;
		}
		if (FinishParams != other.FinishParams)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (AimNumShow != other.AimNumShow)
		{
			return false;
		}
		if (Item1 != other.Item1)
		{
			return false;
		}
		if (Qty1 != other.Qty1)
		{
			return false;
		}
		if (Item2 != other.Item2)
		{
			return false;
		}
		if (Qty2 != other.Qty2)
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
		if (Group != 0)
		{
			num ^= Group.GetHashCode();
		}
		if (FinishType != 0)
		{
			num ^= FinishType.GetHashCode();
		}
		if (FinishParams.Length != 0)
		{
			num ^= FinishParams.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (AimNumShow != 0)
		{
			num ^= AimNumShow.GetHashCode();
		}
		if (Item1 != 0)
		{
			num ^= Item1.GetHashCode();
		}
		if (Qty1 != 0)
		{
			num ^= Qty1.GetHashCode();
		}
		if (Item2 != 0)
		{
			num ^= Item2.GetHashCode();
		}
		if (Qty2 != 0)
		{
			num ^= Qty2.GetHashCode();
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
		if (Group != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Group);
		}
		if (FinishType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(FinishType);
		}
		if (FinishParams.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(FinishParams);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Desc);
		}
		if (AimNumShow != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(AimNumShow);
		}
		if (Item1 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Item1);
		}
		if (Qty1 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Qty1);
		}
		if (Item2 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Item2);
		}
		if (Qty2 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Qty2);
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
		if (Group != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Group);
		}
		if (FinishType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FinishType);
		}
		if (FinishParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FinishParams);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (AimNumShow != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AimNumShow);
		}
		if (Item1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Item1);
		}
		if (Qty1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty1);
		}
		if (Item2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Item2);
		}
		if (Qty2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty2);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityPenguinCardQuest other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Group != 0)
			{
				Group = other.Group;
			}
			if (other.FinishType != 0)
			{
				FinishType = other.FinishType;
			}
			if (other.FinishParams.Length != 0)
			{
				FinishParams = other.FinishParams;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.AimNumShow != 0)
			{
				AimNumShow = other.AimNumShow;
			}
			if (other.Item1 != 0)
			{
				Item1 = other.Item1;
			}
			if (other.Qty1 != 0)
			{
				Qty1 = other.Qty1;
			}
			if (other.Item2 != 0)
			{
				Item2 = other.Item2;
			}
			if (other.Qty2 != 0)
			{
				Qty2 = other.Qty2;
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
				Group = input.ReadInt32();
				break;
			case 24u:
				FinishType = input.ReadInt32();
				break;
			case 34u:
				FinishParams = input.ReadString();
				break;
			case 42u:
				Desc = input.ReadString();
				break;
			case 48u:
				AimNumShow = input.ReadInt32();
				break;
			case 56u:
				Item1 = input.ReadInt32();
				break;
			case 64u:
				Qty1 = input.ReadInt32();
				break;
			case 72u:
				Item2 = input.ReadInt32();
				break;
			case 80u:
				Qty2 = input.ReadInt32();
				break;
			}
		}
	}
}
