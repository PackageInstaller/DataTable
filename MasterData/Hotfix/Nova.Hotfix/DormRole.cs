using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DormRole : IMessage<DormRole>, IMessage, IEquatable<DormRole>, IDeepCloneable<DormRole>
{
	private static readonly MessageParser<DormRole> _parser = new MessageParser<DormRole>(() => new DormRole());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int RoleTypeFieldNumber = 2;

	private int roleType_;

	public const int ExclusionsFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_exclusions_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> exclusions_ = new RepeatedField<int>();

	public const int AIFieldNumber = 4;

	private string aI_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<DormRole> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(304);

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
	public int RoleType
	{
		get
		{
			return roleType_;
		}
		set
		{
			roleType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Exclusions => exclusions_;

	[DebuggerNonUserCode]
	public string AI
	{
		get
		{
			return aI_;
		}
		set
		{
			aI_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public DormRole()
	{
	}

	[DebuggerNonUserCode]
	public DormRole(DormRole other)
		: this()
	{
		id_ = other.id_;
		roleType_ = other.roleType_;
		exclusions_ = other.exclusions_.Clone();
		aI_ = other.aI_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DormRole Clone()
	{
		return new DormRole(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DormRole);
	}

	[DebuggerNonUserCode]
	public bool Equals(DormRole other)
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
		if (RoleType != other.RoleType)
		{
			return false;
		}
		if (!exclusions_.Equals(other.exclusions_))
		{
			return false;
		}
		if (AI != other.AI)
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
		if (RoleType != 0)
		{
			num ^= RoleType.GetHashCode();
		}
		num ^= exclusions_.GetHashCode();
		if (AI.Length != 0)
		{
			num ^= AI.GetHashCode();
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
		if (RoleType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(RoleType);
		}
		exclusions_.WriteTo(output, _repeated_exclusions_codec);
		if (AI.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(AI);
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
		if (RoleType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RoleType);
		}
		num += exclusions_.CalculateSize(_repeated_exclusions_codec);
		if (AI.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AI);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DormRole other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.RoleType != 0)
			{
				RoleType = other.RoleType;
			}
			exclusions_.Add(other.exclusions_);
			if (other.AI.Length != 0)
			{
				AI = other.AI;
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
				RoleType = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				exclusions_.AddEntriesFrom(input, _repeated_exclusions_codec);
				break;
			case 34u:
				AI = input.ReadString();
				break;
			}
		}
	}
}
