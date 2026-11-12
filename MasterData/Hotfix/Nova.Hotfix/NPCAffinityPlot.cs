using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class NPCAffinityPlot : IMessage<NPCAffinityPlot>, IMessage, IEquatable<NPCAffinityPlot>, IDeepCloneable<NPCAffinityPlot>
{
	private static readonly MessageParser<NPCAffinityPlot> _parser = new MessageParser<NPCAffinityPlot>(() => new NPCAffinityPlot());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int PlotSumFieldNumber = 4;

	private string plotSum_ = "";

	public const int AvgIdFieldNumber = 5;

	private string avgId_ = "";

	public const int NPCIdFieldNumber = 6;

	private int nPCId_;

	public const int AffinityLevelFieldNumber = 7;

	private int affinityLevel_;

	public const int ItemIdFieldNumber = 8;

	private int itemId_;

	public const int ItemQtyFieldNumber = 9;

	private int itemQty_;

	[DebuggerNonUserCode]
	public static MessageParser<NPCAffinityPlot> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(598);

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
	public string PlotSum
	{
		get
		{
			return plotSum_;
		}
		set
		{
			plotSum_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int AffinityLevel
	{
		get
		{
			return affinityLevel_;
		}
		set
		{
			affinityLevel_ = value;
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
	public NPCAffinityPlot()
	{
	}

	[DebuggerNonUserCode]
	public NPCAffinityPlot(NPCAffinityPlot other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		desc_ = other.desc_;
		plotSum_ = other.plotSum_;
		avgId_ = other.avgId_;
		nPCId_ = other.nPCId_;
		affinityLevel_ = other.affinityLevel_;
		itemId_ = other.itemId_;
		itemQty_ = other.itemQty_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public NPCAffinityPlot Clone()
	{
		return new NPCAffinityPlot(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as NPCAffinityPlot);
	}

	[DebuggerNonUserCode]
	public bool Equals(NPCAffinityPlot other)
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
		if (PlotSum != other.PlotSum)
		{
			return false;
		}
		if (AvgId != other.AvgId)
		{
			return false;
		}
		if (NPCId != other.NPCId)
		{
			return false;
		}
		if (AffinityLevel != other.AffinityLevel)
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
		if (PlotSum.Length != 0)
		{
			num ^= PlotSum.GetHashCode();
		}
		if (AvgId.Length != 0)
		{
			num ^= AvgId.GetHashCode();
		}
		if (NPCId != 0)
		{
			num ^= NPCId.GetHashCode();
		}
		if (AffinityLevel != 0)
		{
			num ^= AffinityLevel.GetHashCode();
		}
		if (ItemId != 0)
		{
			num ^= ItemId.GetHashCode();
		}
		if (ItemQty != 0)
		{
			num ^= ItemQty.GetHashCode();
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
		if (PlotSum.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(PlotSum);
		}
		if (AvgId.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(AvgId);
		}
		if (NPCId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(NPCId);
		}
		if (AffinityLevel != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(AffinityLevel);
		}
		if (ItemId != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(ItemId);
		}
		if (ItemQty != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(ItemQty);
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
		if (PlotSum.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PlotSum);
		}
		if (AvgId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AvgId);
		}
		if (NPCId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NPCId);
		}
		if (AffinityLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AffinityLevel);
		}
		if (ItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemId);
		}
		if (ItemQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemQty);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(NPCAffinityPlot other)
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
			if (other.PlotSum.Length != 0)
			{
				PlotSum = other.PlotSum;
			}
			if (other.AvgId.Length != 0)
			{
				AvgId = other.AvgId;
			}
			if (other.NPCId != 0)
			{
				NPCId = other.NPCId;
			}
			if (other.AffinityLevel != 0)
			{
				AffinityLevel = other.AffinityLevel;
			}
			if (other.ItemId != 0)
			{
				ItemId = other.ItemId;
			}
			if (other.ItemQty != 0)
			{
				ItemQty = other.ItemQty;
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
			case 34u:
				PlotSum = input.ReadString();
				break;
			case 42u:
				AvgId = input.ReadString();
				break;
			case 48u:
				NPCId = input.ReadInt32();
				break;
			case 56u:
				AffinityLevel = input.ReadInt32();
				break;
			case 64u:
				ItemId = input.ReadInt32();
				break;
			case 72u:
				ItemQty = input.ReadInt32();
				break;
			}
		}
	}
}
