using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierPartnerGroup : IMessage<SoldierPartnerGroup>, IMessage, IEquatable<SoldierPartnerGroup>, IDeepCloneable<SoldierPartnerGroup>
{
	private static readonly MessageParser<SoldierPartnerGroup> _parser = new MessageParser<SoldierPartnerGroup>(() => new SoldierPartnerGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int PartnerTypeFieldNumber = 2;

	private int partnerType_;

	public const int NameFieldNumber = 3;

	private string name_ = "";

	public const int IconFieldNumber = 4;

	private string icon_ = "";

	public const int DescFieldNumber = 5;

	private string desc_ = "";

	public const int ChessCharacterIdsFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_chessCharacterIds_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> chessCharacterIds_ = new RepeatedField<int>();

	public const int PathFieldNumber = 7;

	private string path_ = "";

	public const int PartnerCatalogueFieldNumber = 8;

	private int partnerCatalogue_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierPartnerGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(778);

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
	public int PartnerType
	{
		get
		{
			return partnerType_;
		}
		set
		{
			partnerType_ = value;
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
	public RepeatedField<int> ChessCharacterIds => chessCharacterIds_;

	[DebuggerNonUserCode]
	public string Path
	{
		get
		{
			return path_;
		}
		set
		{
			path_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int PartnerCatalogue
	{
		get
		{
			return partnerCatalogue_;
		}
		set
		{
			partnerCatalogue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierPartnerGroup()
	{
	}

	[DebuggerNonUserCode]
	public SoldierPartnerGroup(SoldierPartnerGroup other)
		: this()
	{
		id_ = other.id_;
		partnerType_ = other.partnerType_;
		name_ = other.name_;
		icon_ = other.icon_;
		desc_ = other.desc_;
		chessCharacterIds_ = other.chessCharacterIds_.Clone();
		path_ = other.path_;
		partnerCatalogue_ = other.partnerCatalogue_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierPartnerGroup Clone()
	{
		return new SoldierPartnerGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierPartnerGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierPartnerGroup other)
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
		if (PartnerType != other.PartnerType)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (!chessCharacterIds_.Equals(other.chessCharacterIds_))
		{
			return false;
		}
		if (Path != other.Path)
		{
			return false;
		}
		if (PartnerCatalogue != other.PartnerCatalogue)
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
		if (PartnerType != 0)
		{
			num ^= PartnerType.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		num ^= chessCharacterIds_.GetHashCode();
		if (Path.Length != 0)
		{
			num ^= Path.GetHashCode();
		}
		if (PartnerCatalogue != 0)
		{
			num ^= PartnerCatalogue.GetHashCode();
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
		if (PartnerType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(PartnerType);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Name);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Icon);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Desc);
		}
		chessCharacterIds_.WriteTo(output, _repeated_chessCharacterIds_codec);
		if (Path.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Path);
		}
		if (PartnerCatalogue != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(PartnerCatalogue);
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
		if (PartnerType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PartnerType);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		num += chessCharacterIds_.CalculateSize(_repeated_chessCharacterIds_codec);
		if (Path.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Path);
		}
		if (PartnerCatalogue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PartnerCatalogue);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierPartnerGroup other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.PartnerType != 0)
			{
				PartnerType = other.PartnerType;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			chessCharacterIds_.Add(other.chessCharacterIds_);
			if (other.Path.Length != 0)
			{
				Path = other.Path;
			}
			if (other.PartnerCatalogue != 0)
			{
				PartnerCatalogue = other.PartnerCatalogue;
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
				PartnerType = input.ReadInt32();
				break;
			case 26u:
				Name = input.ReadString();
				break;
			case 34u:
				Icon = input.ReadString();
				break;
			case 42u:
				Desc = input.ReadString();
				break;
			case 48u:
			case 50u:
				chessCharacterIds_.AddEntriesFrom(input, _repeated_chessCharacterIds_codec);
				break;
			case 58u:
				Path = input.ReadString();
				break;
			case 64u:
				PartnerCatalogue = input.ReadInt32();
				break;
			}
		}
	}
}
