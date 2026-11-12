using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class JointDrill_2_MonsterGroup : IMessage<JointDrill_2_MonsterGroup>, IMessage, IEquatable<JointDrill_2_MonsterGroup>, IDeepCloneable<JointDrill_2_MonsterGroup>
{
	private static readonly MessageParser<JointDrill_2_MonsterGroup> _parser = new MessageParser<JointDrill_2_MonsterGroup>(() => new JointDrill_2_MonsterGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int MateId1FieldNumber = 2;

	private int mateId1_;

	public const int MateId2FieldNumber = 3;

	private int mateId2_;

	public const int MateId3FieldNumber = 4;

	private int mateId3_;

	public const int MateId4FieldNumber = 5;

	private int mateId4_;

	public const int MateId5FieldNumber = 6;

	private int mateId5_;

	public const int MateId6FieldNumber = 7;

	private int mateId6_;

	public const int MateId7FieldNumber = 8;

	private int mateId7_;

	public const int MateId8FieldNumber = 9;

	private int mateId8_;

	public const int MateId9FieldNumber = 10;

	private int mateId9_;

	public const int MateId10FieldNumber = 11;

	private int mateId10_;

	public const int MateId11FieldNumber = 12;

	private int mateId11_;

	public const int MateId12FieldNumber = 13;

	private int mateId12_;

	[DebuggerNonUserCode]
	public static MessageParser<JointDrill_2_MonsterGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(490);

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
	public int MateId1
	{
		get
		{
			return mateId1_;
		}
		set
		{
			mateId1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MateId2
	{
		get
		{
			return mateId2_;
		}
		set
		{
			mateId2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MateId3
	{
		get
		{
			return mateId3_;
		}
		set
		{
			mateId3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MateId4
	{
		get
		{
			return mateId4_;
		}
		set
		{
			mateId4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MateId5
	{
		get
		{
			return mateId5_;
		}
		set
		{
			mateId5_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MateId6
	{
		get
		{
			return mateId6_;
		}
		set
		{
			mateId6_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MateId7
	{
		get
		{
			return mateId7_;
		}
		set
		{
			mateId7_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MateId8
	{
		get
		{
			return mateId8_;
		}
		set
		{
			mateId8_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MateId9
	{
		get
		{
			return mateId9_;
		}
		set
		{
			mateId9_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MateId10
	{
		get
		{
			return mateId10_;
		}
		set
		{
			mateId10_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MateId11
	{
		get
		{
			return mateId11_;
		}
		set
		{
			mateId11_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MateId12
	{
		get
		{
			return mateId12_;
		}
		set
		{
			mateId12_ = value;
		}
	}

	[DebuggerNonUserCode]
	public JointDrill_2_MonsterGroup()
	{
	}

	[DebuggerNonUserCode]
	public JointDrill_2_MonsterGroup(JointDrill_2_MonsterGroup other)
		: this()
	{
		id_ = other.id_;
		mateId1_ = other.mateId1_;
		mateId2_ = other.mateId2_;
		mateId3_ = other.mateId3_;
		mateId4_ = other.mateId4_;
		mateId5_ = other.mateId5_;
		mateId6_ = other.mateId6_;
		mateId7_ = other.mateId7_;
		mateId8_ = other.mateId8_;
		mateId9_ = other.mateId9_;
		mateId10_ = other.mateId10_;
		mateId11_ = other.mateId11_;
		mateId12_ = other.mateId12_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public JointDrill_2_MonsterGroup Clone()
	{
		return new JointDrill_2_MonsterGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as JointDrill_2_MonsterGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(JointDrill_2_MonsterGroup other)
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
		if (MateId1 != other.MateId1)
		{
			return false;
		}
		if (MateId2 != other.MateId2)
		{
			return false;
		}
		if (MateId3 != other.MateId3)
		{
			return false;
		}
		if (MateId4 != other.MateId4)
		{
			return false;
		}
		if (MateId5 != other.MateId5)
		{
			return false;
		}
		if (MateId6 != other.MateId6)
		{
			return false;
		}
		if (MateId7 != other.MateId7)
		{
			return false;
		}
		if (MateId8 != other.MateId8)
		{
			return false;
		}
		if (MateId9 != other.MateId9)
		{
			return false;
		}
		if (MateId10 != other.MateId10)
		{
			return false;
		}
		if (MateId11 != other.MateId11)
		{
			return false;
		}
		if (MateId12 != other.MateId12)
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
		if (MateId1 != 0)
		{
			num ^= MateId1.GetHashCode();
		}
		if (MateId2 != 0)
		{
			num ^= MateId2.GetHashCode();
		}
		if (MateId3 != 0)
		{
			num ^= MateId3.GetHashCode();
		}
		if (MateId4 != 0)
		{
			num ^= MateId4.GetHashCode();
		}
		if (MateId5 != 0)
		{
			num ^= MateId5.GetHashCode();
		}
		if (MateId6 != 0)
		{
			num ^= MateId6.GetHashCode();
		}
		if (MateId7 != 0)
		{
			num ^= MateId7.GetHashCode();
		}
		if (MateId8 != 0)
		{
			num ^= MateId8.GetHashCode();
		}
		if (MateId9 != 0)
		{
			num ^= MateId9.GetHashCode();
		}
		if (MateId10 != 0)
		{
			num ^= MateId10.GetHashCode();
		}
		if (MateId11 != 0)
		{
			num ^= MateId11.GetHashCode();
		}
		if (MateId12 != 0)
		{
			num ^= MateId12.GetHashCode();
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
		if (MateId1 != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(MateId1);
		}
		if (MateId2 != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(MateId2);
		}
		if (MateId3 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(MateId3);
		}
		if (MateId4 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(MateId4);
		}
		if (MateId5 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(MateId5);
		}
		if (MateId6 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(MateId6);
		}
		if (MateId7 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(MateId7);
		}
		if (MateId8 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(MateId8);
		}
		if (MateId9 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(MateId9);
		}
		if (MateId10 != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(MateId10);
		}
		if (MateId11 != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(MateId11);
		}
		if (MateId12 != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(MateId12);
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
		if (MateId1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MateId1);
		}
		if (MateId2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MateId2);
		}
		if (MateId3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MateId3);
		}
		if (MateId4 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MateId4);
		}
		if (MateId5 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MateId5);
		}
		if (MateId6 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MateId6);
		}
		if (MateId7 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MateId7);
		}
		if (MateId8 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MateId8);
		}
		if (MateId9 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MateId9);
		}
		if (MateId10 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MateId10);
		}
		if (MateId11 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MateId11);
		}
		if (MateId12 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MateId12);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(JointDrill_2_MonsterGroup other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.MateId1 != 0)
			{
				MateId1 = other.MateId1;
			}
			if (other.MateId2 != 0)
			{
				MateId2 = other.MateId2;
			}
			if (other.MateId3 != 0)
			{
				MateId3 = other.MateId3;
			}
			if (other.MateId4 != 0)
			{
				MateId4 = other.MateId4;
			}
			if (other.MateId5 != 0)
			{
				MateId5 = other.MateId5;
			}
			if (other.MateId6 != 0)
			{
				MateId6 = other.MateId6;
			}
			if (other.MateId7 != 0)
			{
				MateId7 = other.MateId7;
			}
			if (other.MateId8 != 0)
			{
				MateId8 = other.MateId8;
			}
			if (other.MateId9 != 0)
			{
				MateId9 = other.MateId9;
			}
			if (other.MateId10 != 0)
			{
				MateId10 = other.MateId10;
			}
			if (other.MateId11 != 0)
			{
				MateId11 = other.MateId11;
			}
			if (other.MateId12 != 0)
			{
				MateId12 = other.MateId12;
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
				MateId1 = input.ReadInt32();
				break;
			case 24u:
				MateId2 = input.ReadInt32();
				break;
			case 32u:
				MateId3 = input.ReadInt32();
				break;
			case 40u:
				MateId4 = input.ReadInt32();
				break;
			case 48u:
				MateId5 = input.ReadInt32();
				break;
			case 56u:
				MateId6 = input.ReadInt32();
				break;
			case 64u:
				MateId7 = input.ReadInt32();
				break;
			case 72u:
				MateId8 = input.ReadInt32();
				break;
			case 80u:
				MateId9 = input.ReadInt32();
				break;
			case 88u:
				MateId10 = input.ReadInt32();
				break;
			case 96u:
				MateId11 = input.ReadInt32();
				break;
			case 104u:
				MateId12 = input.ReadInt32();
				break;
			}
		}
	}
}
