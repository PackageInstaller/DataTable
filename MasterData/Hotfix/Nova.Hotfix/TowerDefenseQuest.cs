using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TowerDefenseQuest : IMessage<TowerDefenseQuest>, IMessage, IEquatable<TowerDefenseQuest>, IDeepCloneable<TowerDefenseQuest>
{
	private static readonly MessageParser<TowerDefenseQuest> _parser = new MessageParser<TowerDefenseQuest>(() => new TowerDefenseQuest());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int QuestGroupIdFieldNumber = 2;

	private int questGroupId_;

	public const int QuestTypeFieldNumber = 3;

	private int questType_;

	public const int QuestParamFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_questParam_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> questParam_ = new RepeatedField<int>();

	public const int DescFieldNumber = 5;

	private string desc_ = "";

	public const int Item1FieldNumber = 6;

	private int item1_;

	public const int Qty1FieldNumber = 7;

	private int qty1_;

	public const int Item2FieldNumber = 8;

	private int item2_;

	public const int Qty2FieldNumber = 9;

	private int qty2_;

	[DebuggerNonUserCode]
	public static MessageParser<TowerDefenseQuest> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(966);

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
	public int QuestGroupId
	{
		get
		{
			return questGroupId_;
		}
		set
		{
			questGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int QuestType
	{
		get
		{
			return questType_;
		}
		set
		{
			questType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> QuestParam => questParam_;

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
	public TowerDefenseQuest()
	{
	}

	[DebuggerNonUserCode]
	public TowerDefenseQuest(TowerDefenseQuest other)
		: this()
	{
		id_ = other.id_;
		questGroupId_ = other.questGroupId_;
		questType_ = other.questType_;
		questParam_ = other.questParam_.Clone();
		desc_ = other.desc_;
		item1_ = other.item1_;
		qty1_ = other.qty1_;
		item2_ = other.item2_;
		qty2_ = other.qty2_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TowerDefenseQuest Clone()
	{
		return new TowerDefenseQuest(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TowerDefenseQuest);
	}

	[DebuggerNonUserCode]
	public bool Equals(TowerDefenseQuest other)
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
		if (QuestGroupId != other.QuestGroupId)
		{
			return false;
		}
		if (QuestType != other.QuestType)
		{
			return false;
		}
		if (!questParam_.Equals(other.questParam_))
		{
			return false;
		}
		if (Desc != other.Desc)
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
		if (QuestGroupId != 0)
		{
			num ^= QuestGroupId.GetHashCode();
		}
		if (QuestType != 0)
		{
			num ^= QuestType.GetHashCode();
		}
		num ^= questParam_.GetHashCode();
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
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
		if (QuestGroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(QuestGroupId);
		}
		if (QuestType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(QuestType);
		}
		questParam_.WriteTo(output, _repeated_questParam_codec);
		if (Desc.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Desc);
		}
		if (Item1 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Item1);
		}
		if (Qty1 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Qty1);
		}
		if (Item2 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Item2);
		}
		if (Qty2 != 0)
		{
			output.WriteRawTag(72);
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
		if (QuestGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(QuestGroupId);
		}
		if (QuestType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(QuestType);
		}
		num += questParam_.CalculateSize(_repeated_questParam_codec);
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
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
	public void MergeFrom(TowerDefenseQuest other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.QuestGroupId != 0)
			{
				QuestGroupId = other.QuestGroupId;
			}
			if (other.QuestType != 0)
			{
				QuestType = other.QuestType;
			}
			questParam_.Add(other.questParam_);
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
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
				QuestGroupId = input.ReadInt32();
				break;
			case 24u:
				QuestType = input.ReadInt32();
				break;
			case 32u:
			case 34u:
				questParam_.AddEntriesFrom(input, _repeated_questParam_codec);
				break;
			case 42u:
				Desc = input.ReadString();
				break;
			case 48u:
				Item1 = input.ReadInt32();
				break;
			case 56u:
				Qty1 = input.ReadInt32();
				break;
			case 64u:
				Item2 = input.ReadInt32();
				break;
			case 72u:
				Qty2 = input.ReadInt32();
				break;
			}
		}
	}
}
