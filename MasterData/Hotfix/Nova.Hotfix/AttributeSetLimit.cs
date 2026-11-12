using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class AttributeSetLimit : IMessage<AttributeSetLimit>, IMessage, IEquatable<AttributeSetLimit>, IDeepCloneable<AttributeSetLimit>
{
	private static readonly MessageParser<AttributeSetLimit> _parser = new MessageParser<AttributeSetLimit>(() => new AttributeSetLimit());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int LowerFieldNumber = 2;

	private int lower_;

	public const int UpperFieldNumber = 3;

	private int upper_;

	public const int IsLimitedFieldNumber = 4;

	private bool isLimited_;

	public const int IsPlayerFieldNumber = 5;

	private bool isPlayer_;

	[DebuggerNonUserCode]
	public static MessageParser<AttributeSetLimit> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(106);

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
	public int Lower
	{
		get
		{
			return lower_;
		}
		set
		{
			lower_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Upper
	{
		get
		{
			return upper_;
		}
		set
		{
			upper_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsLimited
	{
		get
		{
			return isLimited_;
		}
		set
		{
			isLimited_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsPlayer
	{
		get
		{
			return isPlayer_;
		}
		set
		{
			isPlayer_ = value;
		}
	}

	[DebuggerNonUserCode]
	public AttributeSetLimit()
	{
	}

	[DebuggerNonUserCode]
	public AttributeSetLimit(AttributeSetLimit other)
		: this()
	{
		id_ = other.id_;
		lower_ = other.lower_;
		upper_ = other.upper_;
		isLimited_ = other.isLimited_;
		isPlayer_ = other.isPlayer_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public AttributeSetLimit Clone()
	{
		return new AttributeSetLimit(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as AttributeSetLimit);
	}

	[DebuggerNonUserCode]
	public bool Equals(AttributeSetLimit other)
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
		if (Lower != other.Lower)
		{
			return false;
		}
		if (Upper != other.Upper)
		{
			return false;
		}
		if (IsLimited != other.IsLimited)
		{
			return false;
		}
		if (IsPlayer != other.IsPlayer)
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
		if (Lower != 0)
		{
			num ^= Lower.GetHashCode();
		}
		if (Upper != 0)
		{
			num ^= Upper.GetHashCode();
		}
		if (IsLimited)
		{
			num ^= IsLimited.GetHashCode();
		}
		if (IsPlayer)
		{
			num ^= IsPlayer.GetHashCode();
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
		if (Lower != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Lower);
		}
		if (Upper != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Upper);
		}
		if (IsLimited)
		{
			output.WriteRawTag(32);
			output.WriteBool(IsLimited);
		}
		if (IsPlayer)
		{
			output.WriteRawTag(40);
			output.WriteBool(IsPlayer);
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
		if (Lower != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Lower);
		}
		if (Upper != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Upper);
		}
		if (IsLimited)
		{
			num += 2;
		}
		if (IsPlayer)
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
	public void MergeFrom(AttributeSetLimit other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Lower != 0)
			{
				Lower = other.Lower;
			}
			if (other.Upper != 0)
			{
				Upper = other.Upper;
			}
			if (other.IsLimited)
			{
				IsLimited = other.IsLimited;
			}
			if (other.IsPlayer)
			{
				IsPlayer = other.IsPlayer;
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
				Lower = input.ReadInt32();
				break;
			case 24u:
				Upper = input.ReadInt32();
				break;
			case 32u:
				IsLimited = input.ReadBool();
				break;
			case 40u:
				IsPlayer = input.ReadBool();
				break;
			}
		}
	}
}
