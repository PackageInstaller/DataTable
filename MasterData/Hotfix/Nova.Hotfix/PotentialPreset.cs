using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PotentialPreset : IMessage<PotentialPreset>, IMessage, IEquatable<PotentialPreset>, IDeepCloneable<PotentialPreset>
{
	private static readonly MessageParser<PotentialPreset> _parser = new MessageParser<PotentialPreset>(() => new PotentialPreset());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CharacterIdFieldNumber = 2;

	private int characterId_;

	public const int NameFieldNumber = 3;

	private string name_ = "";

	public const int DescriptionFieldNumber = 4;

	private string description_ = "";

	public const int ShareCodeFieldNumber = 5;

	private string shareCode_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<PotentialPreset> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(662);

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
	public int CharacterId
	{
		get
		{
			return characterId_;
		}
		set
		{
			characterId_ = value;
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
	public string Description
	{
		get
		{
			return description_;
		}
		set
		{
			description_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ShareCode
	{
		get
		{
			return shareCode_;
		}
		set
		{
			shareCode_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public PotentialPreset()
	{
	}

	[DebuggerNonUserCode]
	public PotentialPreset(PotentialPreset other)
		: this()
	{
		id_ = other.id_;
		characterId_ = other.characterId_;
		name_ = other.name_;
		description_ = other.description_;
		shareCode_ = other.shareCode_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PotentialPreset Clone()
	{
		return new PotentialPreset(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PotentialPreset);
	}

	[DebuggerNonUserCode]
	public bool Equals(PotentialPreset other)
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
		if (CharacterId != other.CharacterId)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Description != other.Description)
		{
			return false;
		}
		if (ShareCode != other.ShareCode)
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
		if (CharacterId != 0)
		{
			num ^= CharacterId.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Description.Length != 0)
		{
			num ^= Description.GetHashCode();
		}
		if (ShareCode.Length != 0)
		{
			num ^= ShareCode.GetHashCode();
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
		if (CharacterId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CharacterId);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Name);
		}
		if (Description.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Description);
		}
		if (ShareCode.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(ShareCode);
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
		if (CharacterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharacterId);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Description.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Description);
		}
		if (ShareCode.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ShareCode);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PotentialPreset other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.CharacterId != 0)
			{
				CharacterId = other.CharacterId;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Description.Length != 0)
			{
				Description = other.Description;
			}
			if (other.ShareCode.Length != 0)
			{
				ShareCode = other.ShareCode;
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
				CharacterId = input.ReadInt32();
				break;
			case 26u:
				Name = input.ReadString();
				break;
			case 34u:
				Description = input.ReadString();
				break;
			case 42u:
				ShareCode = input.ReadString();
				break;
			}
		}
	}
}
