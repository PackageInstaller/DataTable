using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CharGem : IMessage<CharGem>, IMessage, IEquatable<CharGem>, IDeepCloneable<CharGem>
{
	private static readonly MessageParser<CharGem> _parser = new MessageParser<CharGem>(() => new CharGem());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GenerateCostTidFieldNumber = 2;

	private int generateCostTid_;

	public const int RefreshCostTidFieldNumber = 3;

	private int refreshCostTid_;

	public const int OverlockCostTidFieldNumber = 4;

	private int overlockCostTid_;

	public const int IconFieldNumber = 5;

	private string icon_ = "";

	public const int IconBgFieldNumber = 6;

	private string iconBg_ = "";

	public const int TypeFieldNumber = 7;

	private int type_;

	public const int TitleFieldNumber = 8;

	private string title_ = "";

	public const int DescFieldNumber = 9;

	private string desc_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<CharGem> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(186);

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
	public int GenerateCostTid
	{
		get
		{
			return generateCostTid_;
		}
		set
		{
			generateCostTid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RefreshCostTid
	{
		get
		{
			return refreshCostTid_;
		}
		set
		{
			refreshCostTid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int OverlockCostTid
	{
		get
		{
			return overlockCostTid_;
		}
		set
		{
			overlockCostTid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Icon
	{
		get
		{
			return icon_;
		}
		set
		{
			icon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string IconBg
	{
		get
		{
			return iconBg_;
		}
		set
		{
			iconBg_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public CharGem()
	{
	}

	[DebuggerNonUserCode]
	public CharGem(CharGem other)
		: this()
	{
		id_ = other.id_;
		generateCostTid_ = other.generateCostTid_;
		refreshCostTid_ = other.refreshCostTid_;
		overlockCostTid_ = other.overlockCostTid_;
		icon_ = other.icon_;
		iconBg_ = other.iconBg_;
		type_ = other.type_;
		title_ = other.title_;
		desc_ = other.desc_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CharGem Clone()
	{
		return new CharGem(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharGem);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharGem other)
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
		if (GenerateCostTid != other.GenerateCostTid)
		{
			return false;
		}
		if (RefreshCostTid != other.RefreshCostTid)
		{
			return false;
		}
		if (OverlockCostTid != other.OverlockCostTid)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (IconBg != other.IconBg)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (Desc != other.Desc)
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
		if (GenerateCostTid != 0)
		{
			num ^= GenerateCostTid.GetHashCode();
		}
		if (RefreshCostTid != 0)
		{
			num ^= RefreshCostTid.GetHashCode();
		}
		if (OverlockCostTid != 0)
		{
			num ^= OverlockCostTid.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (IconBg.Length != 0)
		{
			num ^= IconBg.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
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
		if (GenerateCostTid != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GenerateCostTid);
		}
		if (RefreshCostTid != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(RefreshCostTid);
		}
		if (OverlockCostTid != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(OverlockCostTid);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Icon);
		}
		if (IconBg.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(IconBg);
		}
		if (Type != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Type);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Title);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Desc);
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
		if (GenerateCostTid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GenerateCostTid);
		}
		if (RefreshCostTid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RefreshCostTid);
		}
		if (OverlockCostTid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OverlockCostTid);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (IconBg.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IconBg);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CharGem other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.GenerateCostTid != 0)
			{
				GenerateCostTid = other.GenerateCostTid;
			}
			if (other.RefreshCostTid != 0)
			{
				RefreshCostTid = other.RefreshCostTid;
			}
			if (other.OverlockCostTid != 0)
			{
				OverlockCostTid = other.OverlockCostTid;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.IconBg.Length != 0)
			{
				IconBg = other.IconBg;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
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
				GenerateCostTid = input.ReadInt32();
				break;
			case 24u:
				RefreshCostTid = input.ReadInt32();
				break;
			case 32u:
				OverlockCostTid = input.ReadInt32();
				break;
			case 42u:
				Icon = input.ReadString();
				break;
			case 50u:
				IconBg = input.ReadString();
				break;
			case 56u:
				Type = input.ReadInt32();
				break;
			case 66u:
				Title = input.ReadString();
				break;
			case 74u:
				Desc = input.ReadString();
				break;
			}
		}
	}
}
