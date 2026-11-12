using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DatingLandmark : IMessage<DatingLandmark>, IMessage, IEquatable<DatingLandmark>, IDeepCloneable<DatingLandmark>
{
	private static readonly MessageParser<DatingLandmark> _parser = new MessageParser<DatingLandmark>(() => new DatingLandmark());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int CharAvailableSetTagFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_charAvailableSetTag_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> charAvailableSetTag_ = new RepeatedField<int>();

	public const int DescFieldNumber = 4;

	private string desc_ = "";

	public const int IconFieldNumber = 5;

	private string icon_ = "";

	public const int BgFieldNumber = 6;

	private string bg_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<DatingLandmark> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(250);

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
	public RepeatedField<int> CharAvailableSetTag => charAvailableSetTag_;

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
	public string Bg
	{
		get
		{
			return bg_;
		}
		set
		{
			bg_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public DatingLandmark()
	{
	}

	[DebuggerNonUserCode]
	public DatingLandmark(DatingLandmark other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		charAvailableSetTag_ = other.charAvailableSetTag_.Clone();
		desc_ = other.desc_;
		icon_ = other.icon_;
		bg_ = other.bg_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DatingLandmark Clone()
	{
		return new DatingLandmark(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DatingLandmark);
	}

	[DebuggerNonUserCode]
	public bool Equals(DatingLandmark other)
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
		if (!charAvailableSetTag_.Equals(other.charAvailableSetTag_))
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Bg != other.Bg)
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
		num ^= charAvailableSetTag_.GetHashCode();
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Bg.Length != 0)
		{
			num ^= Bg.GetHashCode();
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
		charAvailableSetTag_.WriteTo(output, _repeated_charAvailableSetTag_codec);
		if (Desc.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Desc);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Icon);
		}
		if (Bg.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Bg);
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
		num += charAvailableSetTag_.CalculateSize(_repeated_charAvailableSetTag_codec);
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Bg.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Bg);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DatingLandmark other)
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
			charAvailableSetTag_.Add(other.charAvailableSetTag_);
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Bg.Length != 0)
			{
				Bg = other.Bg;
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
			case 24u:
			case 26u:
				charAvailableSetTag_.AddEntriesFrom(input, _repeated_charAvailableSetTag_codec);
				break;
			case 34u:
				Desc = input.ReadString();
				break;
			case 42u:
				Icon = input.ReadString();
				break;
			case 50u:
				Bg = input.ReadString();
				break;
			}
		}
	}
}
