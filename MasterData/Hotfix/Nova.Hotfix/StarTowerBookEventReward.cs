using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerBookEventReward : IMessage<StarTowerBookEventReward>, IMessage, IEquatable<StarTowerBookEventReward>, IDeepCloneable<StarTowerBookEventReward>
{
	private static readonly MessageParser<StarTowerBookEventReward> _parser = new MessageParser<StarTowerBookEventReward>(() => new StarTowerBookEventReward());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int StoryFieldNumber = 3;

	private string story_ = "";

	public const int TypeFieldNumber = 4;

	private int type_;

	public const int NPCIdFieldNumber = 5;

	private int nPCId_;

	public const int SortFieldNumber = 6;

	private int sort_;

	public const int SourceFieldNumber = 7;

	private string source_ = "";

	public const int CompleteCondFieldNumber = 8;

	private int completeCond_;

	public const int CompleteCondParamsFieldNumber = 9;

	private string completeCondParams_ = "";

	public const int ItemIdFieldNumber = 10;

	private int itemId_;

	public const int ItemQtyFieldNumber = 11;

	private int itemQty_;

	public const int IsBannedFieldNumber = 12;

	private bool isBanned_;

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerBookEventReward> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(820);

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
	public string Story
	{
		get
		{
			return story_;
		}
		set
		{
			story_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NPCId
	{
		get
		{
			return nPCId_;
		}
		set
		{
			nPCId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Sort
	{
		get
		{
			return sort_;
		}
		set
		{
			sort_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Source
	{
		get
		{
			return source_;
		}
		set
		{
			source_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int ItemId
	{
		get
		{
			return itemId_;
		}
		set
		{
			itemId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ItemQty
	{
		get
		{
			return itemQty_;
		}
		set
		{
			itemQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsBanned
	{
		get
		{
			return isBanned_;
		}
		set
		{
			isBanned_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StarTowerBookEventReward()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerBookEventReward(StarTowerBookEventReward other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		story_ = other.story_;
		type_ = other.type_;
		nPCId_ = other.nPCId_;
		sort_ = other.sort_;
		source_ = other.source_;
		completeCond_ = other.completeCond_;
		completeCondParams_ = other.completeCondParams_;
		itemId_ = other.itemId_;
		itemQty_ = other.itemQty_;
		isBanned_ = other.isBanned_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerBookEventReward Clone()
	{
		return new StarTowerBookEventReward(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerBookEventReward);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerBookEventReward other)
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
		if (Name != other.Name)
		{
			return false;
		}
		if (Story != other.Story)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (NPCId != other.NPCId)
		{
			return false;
		}
		if (Sort != other.Sort)
		{
			return false;
		}
		if (Source != other.Source)
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
		if (ItemId != other.ItemId)
		{
			return false;
		}
		if (ItemQty != other.ItemQty)
		{
			return false;
		}
		if (IsBanned != other.IsBanned)
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
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Story.Length != 0)
		{
			num ^= Story.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (NPCId != 0)
		{
			num ^= NPCId.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
		}
		if (Source.Length != 0)
		{
			num ^= Source.GetHashCode();
		}
		if (CompleteCond != 0)
		{
			num ^= CompleteCond.GetHashCode();
		}
		if (CompleteCondParams.Length != 0)
		{
			num ^= CompleteCondParams.GetHashCode();
		}
		if (ItemId != 0)
		{
			num ^= ItemId.GetHashCode();
		}
		if (ItemQty != 0)
		{
			num ^= ItemQty.GetHashCode();
		}
		if (IsBanned)
		{
			num ^= IsBanned.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (Story.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Story);
		}
		if (Type != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Type);
		}
		if (NPCId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(NPCId);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Sort);
		}
		if (Source.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Source);
		}
		if (CompleteCond != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(CompleteCond);
		}
		if (CompleteCondParams.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(CompleteCondParams);
		}
		if (ItemId != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(ItemId);
		}
		if (ItemQty != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(ItemQty);
		}
		if (IsBanned)
		{
			output.WriteRawTag(96);
			output.WriteBool(IsBanned);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Story.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Story);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (NPCId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NPCId);
		}
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		if (Source.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Source);
		}
		if (CompleteCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CompleteCond);
		}
		if (CompleteCondParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CompleteCondParams);
		}
		if (ItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemId);
		}
		if (ItemQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemQty);
		}
		if (IsBanned)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerBookEventReward other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Story.Length != 0)
			{
				Story = other.Story;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.NPCId != 0)
			{
				NPCId = other.NPCId;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
			}
			if (other.Source.Length != 0)
			{
				Source = other.Source;
			}
			if (other.CompleteCond != 0)
			{
				CompleteCond = other.CompleteCond;
			}
			if (other.CompleteCondParams.Length != 0)
			{
				CompleteCondParams = other.CompleteCondParams;
			}
			if (other.ItemId != 0)
			{
				ItemId = other.ItemId;
			}
			if (other.ItemQty != 0)
			{
				ItemQty = other.ItemQty;
			}
			if (other.IsBanned)
			{
				IsBanned = other.IsBanned;
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
				Name = input.ReadString();
				break;
			case 26u:
				Story = input.ReadString();
				break;
			case 32u:
				Type = input.ReadInt32();
				break;
			case 40u:
				NPCId = input.ReadInt32();
				break;
			case 48u:
				Sort = input.ReadInt32();
				break;
			case 58u:
				Source = input.ReadString();
				break;
			case 64u:
				CompleteCond = input.ReadInt32();
				break;
			case 74u:
				CompleteCondParams = input.ReadString();
				break;
			case 80u:
				ItemId = input.ReadInt32();
				break;
			case 88u:
				ItemQty = input.ReadInt32();
				break;
			case 96u:
				IsBanned = input.ReadBool();
				break;
			}
		}
	}
}
