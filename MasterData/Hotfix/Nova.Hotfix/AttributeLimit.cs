using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class AttributeLimit : IMessage<AttributeLimit>, IMessage, IEquatable<AttributeLimit>, IDeepCloneable<AttributeLimit>
{
	private static readonly MessageParser<AttributeLimit> _parser = new MessageParser<AttributeLimit>(() => new AttributeLimit());

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

	public const int LowerPreFieldNumber = 6;

	private int lowerPre_;

	public const int UpperPreFieldNumber = 7;

	private int upperPre_;

	public const int IsLimitedPreFieldNumber = 8;

	private bool isLimitedPre_;

	public const int IsPlayerPreFieldNumber = 9;

	private bool isPlayerPre_;

	[DebuggerNonUserCode]
	public static MessageParser<AttributeLimit> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(104);

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
	public int LowerPre
	{
		get
		{
			return lowerPre_;
		}
		set
		{
			lowerPre_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UpperPre
	{
		get
		{
			return upperPre_;
		}
		set
		{
			upperPre_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsLimitedPre
	{
		get
		{
			return isLimitedPre_;
		}
		set
		{
			isLimitedPre_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsPlayerPre
	{
		get
		{
			return isPlayerPre_;
		}
		set
		{
			isPlayerPre_ = value;
		}
	}

	[DebuggerNonUserCode]
	public AttributeLimit()
	{
	}

	[DebuggerNonUserCode]
	public AttributeLimit(AttributeLimit other)
		: this()
	{
		id_ = other.id_;
		lower_ = other.lower_;
		upper_ = other.upper_;
		isLimited_ = other.isLimited_;
		isPlayer_ = other.isPlayer_;
		lowerPre_ = other.lowerPre_;
		upperPre_ = other.upperPre_;
		isLimitedPre_ = other.isLimitedPre_;
		isPlayerPre_ = other.isPlayerPre_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public AttributeLimit Clone()
	{
		return new AttributeLimit(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as AttributeLimit);
	}

	[DebuggerNonUserCode]
	public bool Equals(AttributeLimit other)
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
		if (LowerPre != other.LowerPre)
		{
			return false;
		}
		if (UpperPre != other.UpperPre)
		{
			return false;
		}
		if (IsLimitedPre != other.IsLimitedPre)
		{
			return false;
		}
		if (IsPlayerPre != other.IsPlayerPre)
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
		if (LowerPre != 0)
		{
			num ^= LowerPre.GetHashCode();
		}
		if (UpperPre != 0)
		{
			num ^= UpperPre.GetHashCode();
		}
		if (IsLimitedPre)
		{
			num ^= IsLimitedPre.GetHashCode();
		}
		if (IsPlayerPre)
		{
			num ^= IsPlayerPre.GetHashCode();
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
		if (LowerPre != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(LowerPre);
		}
		if (UpperPre != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(UpperPre);
		}
		if (IsLimitedPre)
		{
			output.WriteRawTag(64);
			output.WriteBool(IsLimitedPre);
		}
		if (IsPlayerPre)
		{
			output.WriteRawTag(72);
			output.WriteBool(IsPlayerPre);
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
		if (LowerPre != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LowerPre);
		}
		if (UpperPre != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UpperPre);
		}
		if (IsLimitedPre)
		{
			num += 2;
		}
		if (IsPlayerPre)
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
	public void MergeFrom(AttributeLimit other)
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
			if (other.LowerPre != 0)
			{
				LowerPre = other.LowerPre;
			}
			if (other.UpperPre != 0)
			{
				UpperPre = other.UpperPre;
			}
			if (other.IsLimitedPre)
			{
				IsLimitedPre = other.IsLimitedPre;
			}
			if (other.IsPlayerPre)
			{
				IsPlayerPre = other.IsPlayerPre;
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
			case 48u:
				LowerPre = input.ReadInt32();
				break;
			case 56u:
				UpperPre = input.ReadInt32();
				break;
			case 64u:
				IsLimitedPre = input.ReadBool();
				break;
			case 72u:
				IsPlayerPre = input.ReadBool();
				break;
			}
		}
	}
}
