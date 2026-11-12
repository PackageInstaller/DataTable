using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PotentialPassiveSkill : IMessage<PotentialPassiveSkill>, IMessage, IEquatable<PotentialPassiveSkill>, IDeepCloneable<PotentialPassiveSkill>
{
	private static readonly MessageParser<PotentialPassiveSkill> _parser = new MessageParser<PotentialPassiveSkill>(() => new PotentialPassiveSkill());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ShareCDFieldNumber = 2;

	private bool shareCD_;

	public const int ShareTimesFieldNumber = 3;

	private bool shareTimes_;

	public const int EffectId1FieldNumber = 4;

	private int effectId1_;

	public const int EffectId2FieldNumber = 5;

	private int effectId2_;

	public const int EffectId3FieldNumber = 6;

	private int effectId3_;

	public const int EffectId4FieldNumber = 7;

	private int effectId4_;

	public const int BriefDescFieldNumber = 8;

	private string briefDesc_ = "";

	public const int DescFieldNumber = 9;

	private string desc_ = "";

	public const int Param1FieldNumber = 10;

	private string param1_ = "";

	public const int Param2FieldNumber = 11;

	private string param2_ = "";

	public const int Param3FieldNumber = 12;

	private string param3_ = "";

	public const int Param4FieldNumber = 13;

	private string param4_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<PotentialPassiveSkill> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(660);

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
	public bool ShareCD
	{
		get
		{
			return shareCD_;
		}
		set
		{
			shareCD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool ShareTimes
	{
		get
		{
			return shareTimes_;
		}
		set
		{
			shareTimes_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EffectId1
	{
		get
		{
			return effectId1_;
		}
		set
		{
			effectId1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EffectId2
	{
		get
		{
			return effectId2_;
		}
		set
		{
			effectId2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EffectId3
	{
		get
		{
			return effectId3_;
		}
		set
		{
			effectId3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EffectId4
	{
		get
		{
			return effectId4_;
		}
		set
		{
			effectId4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string BriefDesc
	{
		get
		{
			return briefDesc_;
		}
		set
		{
			briefDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

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
	public string Param1
	{
		get
		{
			return param1_;
		}
		set
		{
			param1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param2
	{
		get
		{
			return param2_;
		}
		set
		{
			param2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param3
	{
		get
		{
			return param3_;
		}
		set
		{
			param3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param4
	{
		get
		{
			return param4_;
		}
		set
		{
			param4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public PotentialPassiveSkill()
	{
	}

	[DebuggerNonUserCode]
	public PotentialPassiveSkill(PotentialPassiveSkill other)
		: this()
	{
		id_ = other.id_;
		shareCD_ = other.shareCD_;
		shareTimes_ = other.shareTimes_;
		effectId1_ = other.effectId1_;
		effectId2_ = other.effectId2_;
		effectId3_ = other.effectId3_;
		effectId4_ = other.effectId4_;
		briefDesc_ = other.briefDesc_;
		desc_ = other.desc_;
		param1_ = other.param1_;
		param2_ = other.param2_;
		param3_ = other.param3_;
		param4_ = other.param4_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PotentialPassiveSkill Clone()
	{
		return new PotentialPassiveSkill(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PotentialPassiveSkill);
	}

	[DebuggerNonUserCode]
	public bool Equals(PotentialPassiveSkill other)
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
		if (ShareCD != other.ShareCD)
		{
			return false;
		}
		if (ShareTimes != other.ShareTimes)
		{
			return false;
		}
		if (EffectId1 != other.EffectId1)
		{
			return false;
		}
		if (EffectId2 != other.EffectId2)
		{
			return false;
		}
		if (EffectId3 != other.EffectId3)
		{
			return false;
		}
		if (EffectId4 != other.EffectId4)
		{
			return false;
		}
		if (BriefDesc != other.BriefDesc)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Param1 != other.Param1)
		{
			return false;
		}
		if (Param2 != other.Param2)
		{
			return false;
		}
		if (Param3 != other.Param3)
		{
			return false;
		}
		if (Param4 != other.Param4)
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
		if (ShareCD)
		{
			num ^= ShareCD.GetHashCode();
		}
		if (ShareTimes)
		{
			num ^= ShareTimes.GetHashCode();
		}
		if (EffectId1 != 0)
		{
			num ^= EffectId1.GetHashCode();
		}
		if (EffectId2 != 0)
		{
			num ^= EffectId2.GetHashCode();
		}
		if (EffectId3 != 0)
		{
			num ^= EffectId3.GetHashCode();
		}
		if (EffectId4 != 0)
		{
			num ^= EffectId4.GetHashCode();
		}
		if (BriefDesc.Length != 0)
		{
			num ^= BriefDesc.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Param1.Length != 0)
		{
			num ^= Param1.GetHashCode();
		}
		if (Param2.Length != 0)
		{
			num ^= Param2.GetHashCode();
		}
		if (Param3.Length != 0)
		{
			num ^= Param3.GetHashCode();
		}
		if (Param4.Length != 0)
		{
			num ^= Param4.GetHashCode();
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
		if (ShareCD)
		{
			output.WriteRawTag(16);
			output.WriteBool(ShareCD);
		}
		if (ShareTimes)
		{
			output.WriteRawTag(24);
			output.WriteBool(ShareTimes);
		}
		if (EffectId1 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(EffectId1);
		}
		if (EffectId2 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(EffectId2);
		}
		if (EffectId3 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(EffectId3);
		}
		if (EffectId4 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(EffectId4);
		}
		if (BriefDesc.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(BriefDesc);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Desc);
		}
		if (Param1.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(Param1);
		}
		if (Param2.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(Param2);
		}
		if (Param3.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(Param3);
		}
		if (Param4.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(Param4);
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
		if (ShareCD)
		{
			num += 2;
		}
		if (ShareTimes)
		{
			num += 2;
		}
		if (EffectId1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EffectId1);
		}
		if (EffectId2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EffectId2);
		}
		if (EffectId3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EffectId3);
		}
		if (EffectId4 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EffectId4);
		}
		if (BriefDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BriefDesc);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Param1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param1);
		}
		if (Param2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param2);
		}
		if (Param3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param3);
		}
		if (Param4.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param4);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PotentialPassiveSkill other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ShareCD)
			{
				ShareCD = other.ShareCD;
			}
			if (other.ShareTimes)
			{
				ShareTimes = other.ShareTimes;
			}
			if (other.EffectId1 != 0)
			{
				EffectId1 = other.EffectId1;
			}
			if (other.EffectId2 != 0)
			{
				EffectId2 = other.EffectId2;
			}
			if (other.EffectId3 != 0)
			{
				EffectId3 = other.EffectId3;
			}
			if (other.EffectId4 != 0)
			{
				EffectId4 = other.EffectId4;
			}
			if (other.BriefDesc.Length != 0)
			{
				BriefDesc = other.BriefDesc;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Param1.Length != 0)
			{
				Param1 = other.Param1;
			}
			if (other.Param2.Length != 0)
			{
				Param2 = other.Param2;
			}
			if (other.Param3.Length != 0)
			{
				Param3 = other.Param3;
			}
			if (other.Param4.Length != 0)
			{
				Param4 = other.Param4;
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
				ShareCD = input.ReadBool();
				break;
			case 24u:
				ShareTimes = input.ReadBool();
				break;
			case 32u:
				EffectId1 = input.ReadInt32();
				break;
			case 40u:
				EffectId2 = input.ReadInt32();
				break;
			case 48u:
				EffectId3 = input.ReadInt32();
				break;
			case 56u:
				EffectId4 = input.ReadInt32();
				break;
			case 66u:
				BriefDesc = input.ReadString();
				break;
			case 74u:
				Desc = input.ReadString();
				break;
			case 82u:
				Param1 = input.ReadString();
				break;
			case 90u:
				Param2 = input.ReadString();
				break;
			case 98u:
				Param3 = input.ReadString();
				break;
			case 106u:
				Param4 = input.ReadString();
				break;
			}
		}
	}
}
