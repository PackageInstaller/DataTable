using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class JointDrill_2_FloorChange : IMessage<JointDrill_2_FloorChange>, IMessage, IEquatable<JointDrill_2_FloorChange>, IDeepCloneable<JointDrill_2_FloorChange>
{
	private static readonly MessageParser<JointDrill_2_FloorChange> _parser = new MessageParser<JointDrill_2_FloorChange>(() => new JointDrill_2_FloorChange());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int BossID1FieldNumber = 2;

	private int bossID1_;

	public const int BossID2FieldNumber = 3;

	private int bossID2_;

	public const int BossID3FieldNumber = 4;

	private int bossID3_;

	public const int FloorTypeFieldNumber = 5;

	private int floorType_;

	public const int BattleLvsToggleFieldNumber = 6;

	private int battleLvsToggle_;

	public const int BattleLvsToggleParam1FieldNumber = 7;

	private string battleLvsToggleParam1_ = "";

	public const int BattleLvsToggleParam1EndFieldNumber = 8;

	private string battleLvsToggleParam1End_ = "";

	public const int BattleLvsToggleParam2FieldNumber = 9;

	private string battleLvsToggleParam2_ = "";

	public const int BattleLvsToggleParam2EndFieldNumber = 10;

	private string battleLvsToggleParam2End_ = "";

	public const int BattleLvsToggleParam3FieldNumber = 11;

	private string battleLvsToggleParam3_ = "";

	public const int BattleLvsToggleParam3EndFieldNumber = 12;

	private string battleLvsToggleParam3End_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<JointDrill_2_FloorChange> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(486);

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
	public int BossID1
	{
		get
		{
			return bossID1_;
		}
		set
		{
			bossID1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BossID2
	{
		get
		{
			return bossID2_;
		}
		set
		{
			bossID2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BossID3
	{
		get
		{
			return bossID3_;
		}
		set
		{
			bossID3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FloorType
	{
		get
		{
			return floorType_;
		}
		set
		{
			floorType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BattleLvsToggle
	{
		get
		{
			return battleLvsToggle_;
		}
		set
		{
			battleLvsToggle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string BattleLvsToggleParam1
	{
		get
		{
			return battleLvsToggleParam1_;
		}
		set
		{
			battleLvsToggleParam1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BattleLvsToggleParam1End
	{
		get
		{
			return battleLvsToggleParam1End_;
		}
		set
		{
			battleLvsToggleParam1End_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BattleLvsToggleParam2
	{
		get
		{
			return battleLvsToggleParam2_;
		}
		set
		{
			battleLvsToggleParam2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BattleLvsToggleParam2End
	{
		get
		{
			return battleLvsToggleParam2End_;
		}
		set
		{
			battleLvsToggleParam2End_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BattleLvsToggleParam3
	{
		get
		{
			return battleLvsToggleParam3_;
		}
		set
		{
			battleLvsToggleParam3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BattleLvsToggleParam3End
	{
		get
		{
			return battleLvsToggleParam3End_;
		}
		set
		{
			battleLvsToggleParam3End_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public JointDrill_2_FloorChange()
	{
	}

	[DebuggerNonUserCode]
	public JointDrill_2_FloorChange(JointDrill_2_FloorChange other)
		: this()
	{
		id_ = other.id_;
		bossID1_ = other.bossID1_;
		bossID2_ = other.bossID2_;
		bossID3_ = other.bossID3_;
		floorType_ = other.floorType_;
		battleLvsToggle_ = other.battleLvsToggle_;
		battleLvsToggleParam1_ = other.battleLvsToggleParam1_;
		battleLvsToggleParam1End_ = other.battleLvsToggleParam1End_;
		battleLvsToggleParam2_ = other.battleLvsToggleParam2_;
		battleLvsToggleParam2End_ = other.battleLvsToggleParam2End_;
		battleLvsToggleParam3_ = other.battleLvsToggleParam3_;
		battleLvsToggleParam3End_ = other.battleLvsToggleParam3End_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public JointDrill_2_FloorChange Clone()
	{
		return new JointDrill_2_FloorChange(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as JointDrill_2_FloorChange);
	}

	[DebuggerNonUserCode]
	public bool Equals(JointDrill_2_FloorChange other)
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
		if (BossID1 != other.BossID1)
		{
			return false;
		}
		if (BossID2 != other.BossID2)
		{
			return false;
		}
		if (BossID3 != other.BossID3)
		{
			return false;
		}
		if (FloorType != other.FloorType)
		{
			return false;
		}
		if (BattleLvsToggle != other.BattleLvsToggle)
		{
			return false;
		}
		if (BattleLvsToggleParam1 != other.BattleLvsToggleParam1)
		{
			return false;
		}
		if (BattleLvsToggleParam1End != other.BattleLvsToggleParam1End)
		{
			return false;
		}
		if (BattleLvsToggleParam2 != other.BattleLvsToggleParam2)
		{
			return false;
		}
		if (BattleLvsToggleParam2End != other.BattleLvsToggleParam2End)
		{
			return false;
		}
		if (BattleLvsToggleParam3 != other.BattleLvsToggleParam3)
		{
			return false;
		}
		if (BattleLvsToggleParam3End != other.BattleLvsToggleParam3End)
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
		if (BossID1 != 0)
		{
			num ^= BossID1.GetHashCode();
		}
		if (BossID2 != 0)
		{
			num ^= BossID2.GetHashCode();
		}
		if (BossID3 != 0)
		{
			num ^= BossID3.GetHashCode();
		}
		if (FloorType != 0)
		{
			num ^= FloorType.GetHashCode();
		}
		if (BattleLvsToggle != 0)
		{
			num ^= BattleLvsToggle.GetHashCode();
		}
		if (BattleLvsToggleParam1.Length != 0)
		{
			num ^= BattleLvsToggleParam1.GetHashCode();
		}
		if (BattleLvsToggleParam1End.Length != 0)
		{
			num ^= BattleLvsToggleParam1End.GetHashCode();
		}
		if (BattleLvsToggleParam2.Length != 0)
		{
			num ^= BattleLvsToggleParam2.GetHashCode();
		}
		if (BattleLvsToggleParam2End.Length != 0)
		{
			num ^= BattleLvsToggleParam2End.GetHashCode();
		}
		if (BattleLvsToggleParam3.Length != 0)
		{
			num ^= BattleLvsToggleParam3.GetHashCode();
		}
		if (BattleLvsToggleParam3End.Length != 0)
		{
			num ^= BattleLvsToggleParam3End.GetHashCode();
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
		if (BossID1 != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(BossID1);
		}
		if (BossID2 != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(BossID2);
		}
		if (BossID3 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(BossID3);
		}
		if (FloorType != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(FloorType);
		}
		if (BattleLvsToggle != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(BattleLvsToggle);
		}
		if (BattleLvsToggleParam1.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(BattleLvsToggleParam1);
		}
		if (BattleLvsToggleParam1End.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(BattleLvsToggleParam1End);
		}
		if (BattleLvsToggleParam2.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(BattleLvsToggleParam2);
		}
		if (BattleLvsToggleParam2End.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(BattleLvsToggleParam2End);
		}
		if (BattleLvsToggleParam3.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(BattleLvsToggleParam3);
		}
		if (BattleLvsToggleParam3End.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(BattleLvsToggleParam3End);
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
		if (BossID1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BossID1);
		}
		if (BossID2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BossID2);
		}
		if (BossID3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BossID3);
		}
		if (FloorType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorType);
		}
		if (BattleLvsToggle != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BattleLvsToggle);
		}
		if (BattleLvsToggleParam1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BattleLvsToggleParam1);
		}
		if (BattleLvsToggleParam1End.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BattleLvsToggleParam1End);
		}
		if (BattleLvsToggleParam2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BattleLvsToggleParam2);
		}
		if (BattleLvsToggleParam2End.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BattleLvsToggleParam2End);
		}
		if (BattleLvsToggleParam3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BattleLvsToggleParam3);
		}
		if (BattleLvsToggleParam3End.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BattleLvsToggleParam3End);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(JointDrill_2_FloorChange other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.BossID1 != 0)
			{
				BossID1 = other.BossID1;
			}
			if (other.BossID2 != 0)
			{
				BossID2 = other.BossID2;
			}
			if (other.BossID3 != 0)
			{
				BossID3 = other.BossID3;
			}
			if (other.FloorType != 0)
			{
				FloorType = other.FloorType;
			}
			if (other.BattleLvsToggle != 0)
			{
				BattleLvsToggle = other.BattleLvsToggle;
			}
			if (other.BattleLvsToggleParam1.Length != 0)
			{
				BattleLvsToggleParam1 = other.BattleLvsToggleParam1;
			}
			if (other.BattleLvsToggleParam1End.Length != 0)
			{
				BattleLvsToggleParam1End = other.BattleLvsToggleParam1End;
			}
			if (other.BattleLvsToggleParam2.Length != 0)
			{
				BattleLvsToggleParam2 = other.BattleLvsToggleParam2;
			}
			if (other.BattleLvsToggleParam2End.Length != 0)
			{
				BattleLvsToggleParam2End = other.BattleLvsToggleParam2End;
			}
			if (other.BattleLvsToggleParam3.Length != 0)
			{
				BattleLvsToggleParam3 = other.BattleLvsToggleParam3;
			}
			if (other.BattleLvsToggleParam3End.Length != 0)
			{
				BattleLvsToggleParam3End = other.BattleLvsToggleParam3End;
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
				BossID1 = input.ReadInt32();
				break;
			case 24u:
				BossID2 = input.ReadInt32();
				break;
			case 32u:
				BossID3 = input.ReadInt32();
				break;
			case 40u:
				FloorType = input.ReadInt32();
				break;
			case 48u:
				BattleLvsToggle = input.ReadInt32();
				break;
			case 58u:
				BattleLvsToggleParam1 = input.ReadString();
				break;
			case 66u:
				BattleLvsToggleParam1End = input.ReadString();
				break;
			case 74u:
				BattleLvsToggleParam2 = input.ReadString();
				break;
			case 82u:
				BattleLvsToggleParam2End = input.ReadString();
				break;
			case 90u:
				BattleLvsToggleParam3 = input.ReadString();
				break;
			case 98u:
				BattleLvsToggleParam3End = input.ReadString();
				break;
			}
		}
	}
}
