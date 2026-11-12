using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class GMTeam : IMessage<GMTeam>, IMessage, IEquatable<GMTeam>, IDeepCloneable<GMTeam>
{
	private static readonly MessageParser<GMTeam> _parser = new MessageParser<GMTeam>(() => new GMTeam());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int TeamCharacterFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_teamCharacter_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> teamCharacter_ = new RepeatedField<int>();

	public const int TeamDiscFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_teamDisc_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> teamDisc_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<GMTeam> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(386);

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
	public RepeatedField<int> TeamCharacter => teamCharacter_;

	[DebuggerNonUserCode]
	public RepeatedField<int> TeamDisc => teamDisc_;

	[DebuggerNonUserCode]
	public GMTeam()
	{
	}

	[DebuggerNonUserCode]
	public GMTeam(GMTeam other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		teamCharacter_ = other.teamCharacter_.Clone();
		teamDisc_ = other.teamDisc_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public GMTeam Clone()
	{
		return new GMTeam(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as GMTeam);
	}

	[DebuggerNonUserCode]
	public bool Equals(GMTeam other)
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
		if (!teamCharacter_.Equals(other.teamCharacter_))
		{
			return false;
		}
		if (!teamDisc_.Equals(other.teamDisc_))
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
		num ^= teamCharacter_.GetHashCode();
		num ^= teamDisc_.GetHashCode();
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
		teamCharacter_.WriteTo(output, _repeated_teamCharacter_codec);
		teamDisc_.WriteTo(output, _repeated_teamDisc_codec);
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
		num += teamCharacter_.CalculateSize(_repeated_teamCharacter_codec);
		num += teamDisc_.CalculateSize(_repeated_teamDisc_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(GMTeam other)
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
			teamCharacter_.Add(other.teamCharacter_);
			teamDisc_.Add(other.teamDisc_);
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
				teamCharacter_.AddEntriesFrom(input, _repeated_teamCharacter_codec);
				break;
			case 32u:
			case 34u:
				teamDisc_.AddEntriesFrom(input, _repeated_teamDisc_codec);
				break;
			}
		}
	}
}
