using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Production : IMessage<Production>, IMessage, IEquatable<Production>, IDeepCloneable<Production>
{
	private static readonly MessageParser<Production> _parser = new MessageParser<Production>(() => new Production());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int ProductionIdFieldNumber = 4;

	private int productionId_;

	public const int ProductionPerBatchFieldNumber = 5;

	private int productionPerBatch_;

	public const int ShowProductionIdFieldNumber = 6;

	private int showProductionId_;

	public const int ShowProductionPerBatchFieldNumber = 7;

	private int showProductionPerBatch_;

	public const int GroupFieldNumber = 8;

	private int group_;

	public const int TagFieldNumber = 9;

	private int tag_;

	public const int RawMaterialId1FieldNumber = 10;

	private int rawMaterialId1_;

	public const int RawMaterialCount1FieldNumber = 11;

	private int rawMaterialCount1_;

	public const int RawMaterialId2FieldNumber = 12;

	private int rawMaterialId2_;

	public const int RawMaterialCount2FieldNumber = 13;

	private int rawMaterialCount2_;

	public const int RawMaterialId3FieldNumber = 14;

	private int rawMaterialId3_;

	public const int RawMaterialCount3FieldNumber = 15;

	private int rawMaterialCount3_;

	public const int RawMaterialId4FieldNumber = 16;

	private int rawMaterialId4_;

	public const int RawMaterialCount4FieldNumber = 17;

	private int rawMaterialCount4_;

	public const int IsShowWorldLevelFieldNumber = 18;

	private int isShowWorldLevel_;

	public const int UnlockWorldLevelFieldNumber = 19;

	private int unlockWorldLevel_;

	public const int UnlockTipFieldNumber = 20;

	private string unlockTip_ = "";

	public const int SortIdFieldNumber = 21;

	private int sortId_;

	public const int IsActivedFieldNumber = 22;

	private bool isActived_;

	[DebuggerNonUserCode]
	public static MessageParser<Production> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(668);

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
	public int ProductionId
	{
		get
		{
			return productionId_;
		}
		set
		{
			productionId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ProductionPerBatch
	{
		get
		{
			return productionPerBatch_;
		}
		set
		{
			productionPerBatch_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ShowProductionId
	{
		get
		{
			return showProductionId_;
		}
		set
		{
			showProductionId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ShowProductionPerBatch
	{
		get
		{
			return showProductionPerBatch_;
		}
		set
		{
			showProductionPerBatch_ = value;
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
	public int Tag
	{
		get
		{
			return tag_;
		}
		set
		{
			tag_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RawMaterialId1
	{
		get
		{
			return rawMaterialId1_;
		}
		set
		{
			rawMaterialId1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RawMaterialCount1
	{
		get
		{
			return rawMaterialCount1_;
		}
		set
		{
			rawMaterialCount1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RawMaterialId2
	{
		get
		{
			return rawMaterialId2_;
		}
		set
		{
			rawMaterialId2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RawMaterialCount2
	{
		get
		{
			return rawMaterialCount2_;
		}
		set
		{
			rawMaterialCount2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RawMaterialId3
	{
		get
		{
			return rawMaterialId3_;
		}
		set
		{
			rawMaterialId3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RawMaterialCount3
	{
		get
		{
			return rawMaterialCount3_;
		}
		set
		{
			rawMaterialCount3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RawMaterialId4
	{
		get
		{
			return rawMaterialId4_;
		}
		set
		{
			rawMaterialId4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RawMaterialCount4
	{
		get
		{
			return rawMaterialCount4_;
		}
		set
		{
			rawMaterialCount4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int IsShowWorldLevel
	{
		get
		{
			return isShowWorldLevel_;
		}
		set
		{
			isShowWorldLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UnlockWorldLevel
	{
		get
		{
			return unlockWorldLevel_;
		}
		set
		{
			unlockWorldLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string UnlockTip
	{
		get
		{
			return unlockTip_;
		}
		set
		{
			unlockTip_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int SortId
	{
		get
		{
			return sortId_;
		}
		set
		{
			sortId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsActived
	{
		get
		{
			return isActived_;
		}
		set
		{
			isActived_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Production()
	{
	}

	[DebuggerNonUserCode]
	public Production(Production other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		desc_ = other.desc_;
		productionId_ = other.productionId_;
		productionPerBatch_ = other.productionPerBatch_;
		showProductionId_ = other.showProductionId_;
		showProductionPerBatch_ = other.showProductionPerBatch_;
		group_ = other.group_;
		tag_ = other.tag_;
		rawMaterialId1_ = other.rawMaterialId1_;
		rawMaterialCount1_ = other.rawMaterialCount1_;
		rawMaterialId2_ = other.rawMaterialId2_;
		rawMaterialCount2_ = other.rawMaterialCount2_;
		rawMaterialId3_ = other.rawMaterialId3_;
		rawMaterialCount3_ = other.rawMaterialCount3_;
		rawMaterialId4_ = other.rawMaterialId4_;
		rawMaterialCount4_ = other.rawMaterialCount4_;
		isShowWorldLevel_ = other.isShowWorldLevel_;
		unlockWorldLevel_ = other.unlockWorldLevel_;
		unlockTip_ = other.unlockTip_;
		sortId_ = other.sortId_;
		isActived_ = other.isActived_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Production Clone()
	{
		return new Production(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Production);
	}

	[DebuggerNonUserCode]
	public bool Equals(Production other)
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
		if (Desc != other.Desc)
		{
			return false;
		}
		if (ProductionId != other.ProductionId)
		{
			return false;
		}
		if (ProductionPerBatch != other.ProductionPerBatch)
		{
			return false;
		}
		if (ShowProductionId != other.ShowProductionId)
		{
			return false;
		}
		if (ShowProductionPerBatch != other.ShowProductionPerBatch)
		{
			return false;
		}
		if (Group != other.Group)
		{
			return false;
		}
		if (Tag != other.Tag)
		{
			return false;
		}
		if (RawMaterialId1 != other.RawMaterialId1)
		{
			return false;
		}
		if (RawMaterialCount1 != other.RawMaterialCount1)
		{
			return false;
		}
		if (RawMaterialId2 != other.RawMaterialId2)
		{
			return false;
		}
		if (RawMaterialCount2 != other.RawMaterialCount2)
		{
			return false;
		}
		if (RawMaterialId3 != other.RawMaterialId3)
		{
			return false;
		}
		if (RawMaterialCount3 != other.RawMaterialCount3)
		{
			return false;
		}
		if (RawMaterialId4 != other.RawMaterialId4)
		{
			return false;
		}
		if (RawMaterialCount4 != other.RawMaterialCount4)
		{
			return false;
		}
		if (IsShowWorldLevel != other.IsShowWorldLevel)
		{
			return false;
		}
		if (UnlockWorldLevel != other.UnlockWorldLevel)
		{
			return false;
		}
		if (UnlockTip != other.UnlockTip)
		{
			return false;
		}
		if (SortId != other.SortId)
		{
			return false;
		}
		if (IsActived != other.IsActived)
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
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (ProductionId != 0)
		{
			num ^= ProductionId.GetHashCode();
		}
		if (ProductionPerBatch != 0)
		{
			num ^= ProductionPerBatch.GetHashCode();
		}
		if (ShowProductionId != 0)
		{
			num ^= ShowProductionId.GetHashCode();
		}
		if (ShowProductionPerBatch != 0)
		{
			num ^= ShowProductionPerBatch.GetHashCode();
		}
		if (Group != 0)
		{
			num ^= Group.GetHashCode();
		}
		if (Tag != 0)
		{
			num ^= Tag.GetHashCode();
		}
		if (RawMaterialId1 != 0)
		{
			num ^= RawMaterialId1.GetHashCode();
		}
		if (RawMaterialCount1 != 0)
		{
			num ^= RawMaterialCount1.GetHashCode();
		}
		if (RawMaterialId2 != 0)
		{
			num ^= RawMaterialId2.GetHashCode();
		}
		if (RawMaterialCount2 != 0)
		{
			num ^= RawMaterialCount2.GetHashCode();
		}
		if (RawMaterialId3 != 0)
		{
			num ^= RawMaterialId3.GetHashCode();
		}
		if (RawMaterialCount3 != 0)
		{
			num ^= RawMaterialCount3.GetHashCode();
		}
		if (RawMaterialId4 != 0)
		{
			num ^= RawMaterialId4.GetHashCode();
		}
		if (RawMaterialCount4 != 0)
		{
			num ^= RawMaterialCount4.GetHashCode();
		}
		if (IsShowWorldLevel != 0)
		{
			num ^= IsShowWorldLevel.GetHashCode();
		}
		if (UnlockWorldLevel != 0)
		{
			num ^= UnlockWorldLevel.GetHashCode();
		}
		if (UnlockTip.Length != 0)
		{
			num ^= UnlockTip.GetHashCode();
		}
		if (SortId != 0)
		{
			num ^= SortId.GetHashCode();
		}
		if (IsActived)
		{
			num ^= IsActived.GetHashCode();
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
		if (Desc.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Desc);
		}
		if (ProductionId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ProductionId);
		}
		if (ProductionPerBatch != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(ProductionPerBatch);
		}
		if (ShowProductionId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(ShowProductionId);
		}
		if (ShowProductionPerBatch != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(ShowProductionPerBatch);
		}
		if (Group != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Group);
		}
		if (Tag != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Tag);
		}
		if (RawMaterialId1 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(RawMaterialId1);
		}
		if (RawMaterialCount1 != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(RawMaterialCount1);
		}
		if (RawMaterialId2 != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(RawMaterialId2);
		}
		if (RawMaterialCount2 != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(RawMaterialCount2);
		}
		if (RawMaterialId3 != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(RawMaterialId3);
		}
		if (RawMaterialCount3 != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(RawMaterialCount3);
		}
		if (RawMaterialId4 != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(RawMaterialId4);
		}
		if (RawMaterialCount4 != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(RawMaterialCount4);
		}
		if (IsShowWorldLevel != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(IsShowWorldLevel);
		}
		if (UnlockWorldLevel != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(UnlockWorldLevel);
		}
		if (UnlockTip.Length != 0)
		{
			output.WriteRawTag(162, 1);
			output.WriteString(UnlockTip);
		}
		if (SortId != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(SortId);
		}
		if (IsActived)
		{
			output.WriteRawTag(176, 1);
			output.WriteBool(IsActived);
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
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (ProductionId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ProductionId);
		}
		if (ProductionPerBatch != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ProductionPerBatch);
		}
		if (ShowProductionId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ShowProductionId);
		}
		if (ShowProductionPerBatch != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ShowProductionPerBatch);
		}
		if (Group != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Group);
		}
		if (Tag != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tag);
		}
		if (RawMaterialId1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RawMaterialId1);
		}
		if (RawMaterialCount1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RawMaterialCount1);
		}
		if (RawMaterialId2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RawMaterialId2);
		}
		if (RawMaterialCount2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RawMaterialCount2);
		}
		if (RawMaterialId3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RawMaterialId3);
		}
		if (RawMaterialCount3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RawMaterialCount3);
		}
		if (RawMaterialId4 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RawMaterialId4);
		}
		if (RawMaterialCount4 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RawMaterialCount4);
		}
		if (IsShowWorldLevel != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(IsShowWorldLevel);
		}
		if (UnlockWorldLevel != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(UnlockWorldLevel);
		}
		if (UnlockTip.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(UnlockTip);
		}
		if (SortId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SortId);
		}
		if (IsActived)
		{
			num += 3;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Production other)
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
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.ProductionId != 0)
			{
				ProductionId = other.ProductionId;
			}
			if (other.ProductionPerBatch != 0)
			{
				ProductionPerBatch = other.ProductionPerBatch;
			}
			if (other.ShowProductionId != 0)
			{
				ShowProductionId = other.ShowProductionId;
			}
			if (other.ShowProductionPerBatch != 0)
			{
				ShowProductionPerBatch = other.ShowProductionPerBatch;
			}
			if (other.Group != 0)
			{
				Group = other.Group;
			}
			if (other.Tag != 0)
			{
				Tag = other.Tag;
			}
			if (other.RawMaterialId1 != 0)
			{
				RawMaterialId1 = other.RawMaterialId1;
			}
			if (other.RawMaterialCount1 != 0)
			{
				RawMaterialCount1 = other.RawMaterialCount1;
			}
			if (other.RawMaterialId2 != 0)
			{
				RawMaterialId2 = other.RawMaterialId2;
			}
			if (other.RawMaterialCount2 != 0)
			{
				RawMaterialCount2 = other.RawMaterialCount2;
			}
			if (other.RawMaterialId3 != 0)
			{
				RawMaterialId3 = other.RawMaterialId3;
			}
			if (other.RawMaterialCount3 != 0)
			{
				RawMaterialCount3 = other.RawMaterialCount3;
			}
			if (other.RawMaterialId4 != 0)
			{
				RawMaterialId4 = other.RawMaterialId4;
			}
			if (other.RawMaterialCount4 != 0)
			{
				RawMaterialCount4 = other.RawMaterialCount4;
			}
			if (other.IsShowWorldLevel != 0)
			{
				IsShowWorldLevel = other.IsShowWorldLevel;
			}
			if (other.UnlockWorldLevel != 0)
			{
				UnlockWorldLevel = other.UnlockWorldLevel;
			}
			if (other.UnlockTip.Length != 0)
			{
				UnlockTip = other.UnlockTip;
			}
			if (other.SortId != 0)
			{
				SortId = other.SortId;
			}
			if (other.IsActived)
			{
				IsActived = other.IsActived;
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
				Desc = input.ReadString();
				break;
			case 32u:
				ProductionId = input.ReadInt32();
				break;
			case 40u:
				ProductionPerBatch = input.ReadInt32();
				break;
			case 48u:
				ShowProductionId = input.ReadInt32();
				break;
			case 56u:
				ShowProductionPerBatch = input.ReadInt32();
				break;
			case 64u:
				Group = input.ReadInt32();
				break;
			case 72u:
				Tag = input.ReadInt32();
				break;
			case 80u:
				RawMaterialId1 = input.ReadInt32();
				break;
			case 88u:
				RawMaterialCount1 = input.ReadInt32();
				break;
			case 96u:
				RawMaterialId2 = input.ReadInt32();
				break;
			case 104u:
				RawMaterialCount2 = input.ReadInt32();
				break;
			case 112u:
				RawMaterialId3 = input.ReadInt32();
				break;
			case 120u:
				RawMaterialCount3 = input.ReadInt32();
				break;
			case 128u:
				RawMaterialId4 = input.ReadInt32();
				break;
			case 136u:
				RawMaterialCount4 = input.ReadInt32();
				break;
			case 144u:
				IsShowWorldLevel = input.ReadInt32();
				break;
			case 152u:
				UnlockWorldLevel = input.ReadInt32();
				break;
			case 162u:
				UnlockTip = input.ReadString();
				break;
			case 168u:
				SortId = input.ReadInt32();
				break;
			case 176u:
				IsActived = input.ReadBool();
				break;
			}
		}
	}
}
