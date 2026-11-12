using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Force : IMessage<Force>, IMessage, IEquatable<Force>, IDeepCloneable<Force>
{
	private static readonly MessageParser<Force> _parser = new MessageParser<Force>(() => new Force());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TitleFieldNumber = 2;

	private string title_ = "";

	public const int Icon1FieldNumber = 3;

	private string icon1_ = "";

	public const int Icon2FieldNumber = 4;

	private string icon2_ = "";

	public const int TalentPosFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_talentPos_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> talentPos_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<Force> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(358);

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
	public string Icon1
	{
		get
		{
			return icon1_;
		}
		set
		{
			icon1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Icon2
	{
		get
		{
			return icon2_;
		}
		set
		{
			icon2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> TalentPos => talentPos_;

	[DebuggerNonUserCode]
	public Force()
	{
	}

	[DebuggerNonUserCode]
	public Force(Force other)
		: this()
	{
		id_ = other.id_;
		title_ = other.title_;
		icon1_ = other.icon1_;
		icon2_ = other.icon2_;
		talentPos_ = other.talentPos_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Force Clone()
	{
		return new Force(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Force);
	}

	[DebuggerNonUserCode]
	public bool Equals(Force other)
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
		if (Title != other.Title)
		{
			return false;
		}
		if (Icon1 != other.Icon1)
		{
			return false;
		}
		if (Icon2 != other.Icon2)
		{
			return false;
		}
		if (!talentPos_.Equals(other.talentPos_))
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
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Icon1.Length != 0)
		{
			num ^= Icon1.GetHashCode();
		}
		if (Icon2.Length != 0)
		{
			num ^= Icon2.GetHashCode();
		}
		num ^= talentPos_.GetHashCode();
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
		if (Title.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Title);
		}
		if (Icon1.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Icon1);
		}
		if (Icon2.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Icon2);
		}
		talentPos_.WriteTo(output, _repeated_talentPos_codec);
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
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Icon1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon1);
		}
		if (Icon2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon2);
		}
		num += talentPos_.CalculateSize(_repeated_talentPos_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Force other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Icon1.Length != 0)
			{
				Icon1 = other.Icon1;
			}
			if (other.Icon2.Length != 0)
			{
				Icon2 = other.Icon2;
			}
			talentPos_.Add(other.talentPos_);
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
				Title = input.ReadString();
				break;
			case 26u:
				Icon1 = input.ReadString();
				break;
			case 34u:
				Icon2 = input.ReadString();
				break;
			case 40u:
			case 42u:
				talentPos_.AddEntriesFrom(input, _repeated_talentPos_codec);
				break;
			}
		}
	}
}
