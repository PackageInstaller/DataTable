using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CharGrade : IMessage<CharGrade>, IMessage, IEquatable<CharGrade>, IDeepCloneable<CharGrade>
{
	private static readonly MessageParser<CharGrade> _parser = new MessageParser<CharGrade>(() => new CharGrade());

	private UnknownFieldSet _unknownFields;

	public const int GradeFieldNumber = 1;

	private int grade_;

	public const int FragmentsQtyFieldNumber = 2;

	private int fragmentsQty_;

	public const int GeneralFragmentIdFieldNumber = 3;

	private int generalFragmentId_;

	public const int SubstituteItemIdFieldNumber = 4;

	private int substituteItemId_;

	public const int SubstituteItemQtyFieldNumber = 5;

	private int substituteItemQty_;

	[DebuggerNonUserCode]
	public static MessageParser<CharGrade> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(202);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Grade
	{
		get
		{
			return grade_;
		}
		set
		{
			grade_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FragmentsQty
	{
		get
		{
			return fragmentsQty_;
		}
		set
		{
			fragmentsQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GeneralFragmentId
	{
		get
		{
			return generalFragmentId_;
		}
		set
		{
			generalFragmentId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SubstituteItemId
	{
		get
		{
			return substituteItemId_;
		}
		set
		{
			substituteItemId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SubstituteItemQty
	{
		get
		{
			return substituteItemQty_;
		}
		set
		{
			substituteItemQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public CharGrade()
	{
	}

	[DebuggerNonUserCode]
	public CharGrade(CharGrade other)
		: this()
	{
		grade_ = other.grade_;
		fragmentsQty_ = other.fragmentsQty_;
		generalFragmentId_ = other.generalFragmentId_;
		substituteItemId_ = other.substituteItemId_;
		substituteItemQty_ = other.substituteItemQty_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CharGrade Clone()
	{
		return new CharGrade(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharGrade);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharGrade other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Grade != other.Grade)
		{
			return false;
		}
		if (FragmentsQty != other.FragmentsQty)
		{
			return false;
		}
		if (GeneralFragmentId != other.GeneralFragmentId)
		{
			return false;
		}
		if (SubstituteItemId != other.SubstituteItemId)
		{
			return false;
		}
		if (SubstituteItemQty != other.SubstituteItemQty)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Grade != 0)
		{
			num ^= Grade.GetHashCode();
		}
		if (FragmentsQty != 0)
		{
			num ^= FragmentsQty.GetHashCode();
		}
		if (GeneralFragmentId != 0)
		{
			num ^= GeneralFragmentId.GetHashCode();
		}
		if (SubstituteItemId != 0)
		{
			num ^= SubstituteItemId.GetHashCode();
		}
		if (SubstituteItemQty != 0)
		{
			num ^= SubstituteItemQty.GetHashCode();
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
		if (Grade != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Grade);
		}
		if (FragmentsQty != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(FragmentsQty);
		}
		if (GeneralFragmentId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(GeneralFragmentId);
		}
		if (SubstituteItemId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(SubstituteItemId);
		}
		if (SubstituteItemQty != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(SubstituteItemQty);
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
		if (Grade != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Grade);
		}
		if (FragmentsQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FragmentsQty);
		}
		if (GeneralFragmentId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GeneralFragmentId);
		}
		if (SubstituteItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SubstituteItemId);
		}
		if (SubstituteItemQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SubstituteItemQty);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CharGrade other)
	{
		if (other != null)
		{
			if (other.Grade != 0)
			{
				Grade = other.Grade;
			}
			if (other.FragmentsQty != 0)
			{
				FragmentsQty = other.FragmentsQty;
			}
			if (other.GeneralFragmentId != 0)
			{
				GeneralFragmentId = other.GeneralFragmentId;
			}
			if (other.SubstituteItemId != 0)
			{
				SubstituteItemId = other.SubstituteItemId;
			}
			if (other.SubstituteItemQty != 0)
			{
				SubstituteItemQty = other.SubstituteItemQty;
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
				Grade = input.ReadInt32();
				break;
			case 16u:
				FragmentsQty = input.ReadInt32();
				break;
			case 24u:
				GeneralFragmentId = input.ReadInt32();
				break;
			case 32u:
				SubstituteItemId = input.ReadInt32();
				break;
			case 40u:
				SubstituteItemQty = input.ReadInt32();
				break;
			}
		}
	}
}
