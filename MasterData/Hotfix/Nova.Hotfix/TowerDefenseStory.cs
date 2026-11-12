using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TowerDefenseStory : IMessage<TowerDefenseStory>, IMessage, IEquatable<TowerDefenseStory>, IDeepCloneable<TowerDefenseStory>
{
	private static readonly MessageParser<TowerDefenseStory> _parser = new MessageParser<TowerDefenseStory>(() => new TowerDefenseStory());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ActivityIdIdFieldNumber = 2;

	private int activityIdId_;

	public const int LevelIdFieldNumber = 3;

	private int levelId_;

	public const int PreStoryIdFieldNumber = 4;

	private int preStoryId_;

	public const int PreviewIconFieldNumber = 5;

	private string previewIcon_ = "";

	public const int NameFieldNumber = 6;

	private string name_ = "";

	public const int AvgIdFieldNumber = 7;

	private string avgId_ = "";

	public const int Item1FieldNumber = 8;

	private int item1_;

	public const int Qty1FieldNumber = 9;

	private int qty1_;

	public const int Item2FieldNumber = 10;

	private int item2_;

	public const int Qty2FieldNumber = 11;

	private int qty2_;

	[DebuggerNonUserCode]
	public static MessageParser<TowerDefenseStory> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(970);

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
	public int ActivityIdId
	{
		get
		{
			return activityIdId_;
		}
		set
		{
			activityIdId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LevelId
	{
		get
		{
			return levelId_;
		}
		set
		{
			levelId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PreStoryId
	{
		get
		{
			return preStoryId_;
		}
		set
		{
			preStoryId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string PreviewIcon
	{
		get
		{
			return previewIcon_;
		}
		set
		{
			previewIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AvgId
	{
		get
		{
			return avgId_;
		}
		set
		{
			avgId_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public TowerDefenseStory()
	{
	}

	[DebuggerNonUserCode]
	public TowerDefenseStory(TowerDefenseStory other)
		: this()
	{
		id_ = other.id_;
		activityIdId_ = other.activityIdId_;
		levelId_ = other.levelId_;
		preStoryId_ = other.preStoryId_;
		previewIcon_ = other.previewIcon_;
		name_ = other.name_;
		avgId_ = other.avgId_;
		item1_ = other.item1_;
		qty1_ = other.qty1_;
		item2_ = other.item2_;
		qty2_ = other.qty2_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TowerDefenseStory Clone()
	{
		return new TowerDefenseStory(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TowerDefenseStory);
	}

	[DebuggerNonUserCode]
	public bool Equals(TowerDefenseStory other)
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
		if (ActivityIdId != other.ActivityIdId)
		{
			return false;
		}
		if (LevelId != other.LevelId)
		{
			return false;
		}
		if (PreStoryId != other.PreStoryId)
		{
			return false;
		}
		if (PreviewIcon != other.PreviewIcon)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (AvgId != other.AvgId)
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
		if (ActivityIdId != 0)
		{
			num ^= ActivityIdId.GetHashCode();
		}
		if (LevelId != 0)
		{
			num ^= LevelId.GetHashCode();
		}
		if (PreStoryId != 0)
		{
			num ^= PreStoryId.GetHashCode();
		}
		if (PreviewIcon.Length != 0)
		{
			num ^= PreviewIcon.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (AvgId.Length != 0)
		{
			num ^= AvgId.GetHashCode();
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
		if (ActivityIdId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ActivityIdId);
		}
		if (LevelId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(LevelId);
		}
		if (PreStoryId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(PreStoryId);
		}
		if (PreviewIcon.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(PreviewIcon);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Name);
		}
		if (AvgId.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(AvgId);
		}
		if (Item1 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Item1);
		}
		if (Qty1 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Qty1);
		}
		if (Item2 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Item2);
		}
		if (Qty2 != 0)
		{
			output.WriteRawTag(88);
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
		if (ActivityIdId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityIdId);
		}
		if (LevelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelId);
		}
		if (PreStoryId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreStoryId);
		}
		if (PreviewIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PreviewIcon);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (AvgId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AvgId);
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
	public void MergeFrom(TowerDefenseStory other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ActivityIdId != 0)
			{
				ActivityIdId = other.ActivityIdId;
			}
			if (other.LevelId != 0)
			{
				LevelId = other.LevelId;
			}
			if (other.PreStoryId != 0)
			{
				PreStoryId = other.PreStoryId;
			}
			if (other.PreviewIcon.Length != 0)
			{
				PreviewIcon = other.PreviewIcon;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.AvgId.Length != 0)
			{
				AvgId = other.AvgId;
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
				ActivityIdId = input.ReadInt32();
				break;
			case 24u:
				LevelId = input.ReadInt32();
				break;
			case 32u:
				PreStoryId = input.ReadInt32();
				break;
			case 42u:
				PreviewIcon = input.ReadString();
				break;
			case 50u:
				Name = input.ReadString();
				break;
			case 58u:
				AvgId = input.ReadString();
				break;
			case 64u:
				Item1 = input.ReadInt32();
				break;
			case 72u:
				Qty1 = input.ReadInt32();
				break;
			case 80u:
				Item2 = input.ReadInt32();
				break;
			case 88u:
				Qty2 = input.ReadInt32();
				break;
			}
		}
	}
}
