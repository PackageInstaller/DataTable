using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class VampireBattleThreshold : IMessage<VampireBattleThreshold>, IMessage, IEquatable<VampireBattleThreshold>, IDeepCloneable<VampireBattleThreshold>
{
	private static readonly MessageParser<VampireBattleThreshold> _parser = new MessageParser<VampireBattleThreshold>(() => new VampireBattleThreshold());

	private UnknownFieldSet _unknownFields;

	public const int MissionIdFieldNumber = 1;

	private int missionId_;

	public const int VersionFieldNumber = 2;

	private int version_;

	public const int FromSrcAtkFieldNumber = 3;

	private int fromSrcAtk_;

	public const int FromPerkIntensityRatioFieldNumber = 4;

	private int fromPerkIntensityRatio_;

	public const int FromSlotDmgRatioFieldNumber = 5;

	private int fromSlotDmgRatio_;

	public const int FromEEFieldNumber = 6;

	private int fromEE_;

	public const int FromGenDmgRatioFieldNumber = 7;

	private int fromGenDmgRatio_;

	public const int FromDmgPlusFieldNumber = 8;

	private int fromDmgPlus_;

	public const int FromCritRatioFieldNumber = 9;

	private int fromCritRatio_;

	public const int FromFinalDmgRatioFieldNumber = 10;

	private int fromFinalDmgRatio_;

	public const int FromFinalDmgPlusFieldNumber = 11;

	private int fromFinalDmgPlus_;

	public const int ToErAmendFieldNumber = 12;

	private int toErAmend_;

	public const int ToDefAmendFieldNumber = 13;

	private int toDefAmend_;

	public const int ToRcdSlotDmgRatioFieldNumber = 14;

	private int toRcdSlotDmgRatio_;

	public const int ToEERCDFieldNumber = 15;

	private int toEERCD_;

	public const int ToGenDmgRcdRatioFieldNumber = 16;

	private int toGenDmgRcdRatio_;

	public const int ToDmgPlusRcdFieldNumber = 17;

	private int toDmgPlusRcd_;

	public const int DmgFieldNumber = 18;

	private int dmg_;

	public const int CritRateFieldNumber = 19;

	private int critRate_;

	public const int HpFieldNumber = 20;

	private int hp_;

	[DebuggerNonUserCode]
	public static MessageParser<VampireBattleThreshold> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1046);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int MissionId
	{
		get
		{
			return missionId_;
		}
		set
		{
			missionId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Version
	{
		get
		{
			return version_;
		}
		set
		{
			version_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FromSrcAtk
	{
		get
		{
			return fromSrcAtk_;
		}
		set
		{
			fromSrcAtk_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FromPerkIntensityRatio
	{
		get
		{
			return fromPerkIntensityRatio_;
		}
		set
		{
			fromPerkIntensityRatio_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FromSlotDmgRatio
	{
		get
		{
			return fromSlotDmgRatio_;
		}
		set
		{
			fromSlotDmgRatio_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FromEE
	{
		get
		{
			return fromEE_;
		}
		set
		{
			fromEE_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FromGenDmgRatio
	{
		get
		{
			return fromGenDmgRatio_;
		}
		set
		{
			fromGenDmgRatio_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FromDmgPlus
	{
		get
		{
			return fromDmgPlus_;
		}
		set
		{
			fromDmgPlus_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FromCritRatio
	{
		get
		{
			return fromCritRatio_;
		}
		set
		{
			fromCritRatio_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FromFinalDmgRatio
	{
		get
		{
			return fromFinalDmgRatio_;
		}
		set
		{
			fromFinalDmgRatio_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FromFinalDmgPlus
	{
		get
		{
			return fromFinalDmgPlus_;
		}
		set
		{
			fromFinalDmgPlus_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ToErAmend
	{
		get
		{
			return toErAmend_;
		}
		set
		{
			toErAmend_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ToDefAmend
	{
		get
		{
			return toDefAmend_;
		}
		set
		{
			toDefAmend_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ToRcdSlotDmgRatio
	{
		get
		{
			return toRcdSlotDmgRatio_;
		}
		set
		{
			toRcdSlotDmgRatio_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ToEERCD
	{
		get
		{
			return toEERCD_;
		}
		set
		{
			toEERCD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ToGenDmgRcdRatio
	{
		get
		{
			return toGenDmgRcdRatio_;
		}
		set
		{
			toGenDmgRcdRatio_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ToDmgPlusRcd
	{
		get
		{
			return toDmgPlusRcd_;
		}
		set
		{
			toDmgPlusRcd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Dmg
	{
		get
		{
			return dmg_;
		}
		set
		{
			dmg_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CritRate
	{
		get
		{
			return critRate_;
		}
		set
		{
			critRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Hp
	{
		get
		{
			return hp_;
		}
		set
		{
			hp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public VampireBattleThreshold()
	{
	}

	[DebuggerNonUserCode]
	public VampireBattleThreshold(VampireBattleThreshold other)
		: this()
	{
		missionId_ = other.missionId_;
		version_ = other.version_;
		fromSrcAtk_ = other.fromSrcAtk_;
		fromPerkIntensityRatio_ = other.fromPerkIntensityRatio_;
		fromSlotDmgRatio_ = other.fromSlotDmgRatio_;
		fromEE_ = other.fromEE_;
		fromGenDmgRatio_ = other.fromGenDmgRatio_;
		fromDmgPlus_ = other.fromDmgPlus_;
		fromCritRatio_ = other.fromCritRatio_;
		fromFinalDmgRatio_ = other.fromFinalDmgRatio_;
		fromFinalDmgPlus_ = other.fromFinalDmgPlus_;
		toErAmend_ = other.toErAmend_;
		toDefAmend_ = other.toDefAmend_;
		toRcdSlotDmgRatio_ = other.toRcdSlotDmgRatio_;
		toEERCD_ = other.toEERCD_;
		toGenDmgRcdRatio_ = other.toGenDmgRcdRatio_;
		toDmgPlusRcd_ = other.toDmgPlusRcd_;
		dmg_ = other.dmg_;
		critRate_ = other.critRate_;
		hp_ = other.hp_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public VampireBattleThreshold Clone()
	{
		return new VampireBattleThreshold(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as VampireBattleThreshold);
	}

	[DebuggerNonUserCode]
	public bool Equals(VampireBattleThreshold other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (MissionId != other.MissionId)
		{
			return false;
		}
		if (Version != other.Version)
		{
			return false;
		}
		if (FromSrcAtk != other.FromSrcAtk)
		{
			return false;
		}
		if (FromPerkIntensityRatio != other.FromPerkIntensityRatio)
		{
			return false;
		}
		if (FromSlotDmgRatio != other.FromSlotDmgRatio)
		{
			return false;
		}
		if (FromEE != other.FromEE)
		{
			return false;
		}
		if (FromGenDmgRatio != other.FromGenDmgRatio)
		{
			return false;
		}
		if (FromDmgPlus != other.FromDmgPlus)
		{
			return false;
		}
		if (FromCritRatio != other.FromCritRatio)
		{
			return false;
		}
		if (FromFinalDmgRatio != other.FromFinalDmgRatio)
		{
			return false;
		}
		if (FromFinalDmgPlus != other.FromFinalDmgPlus)
		{
			return false;
		}
		if (ToErAmend != other.ToErAmend)
		{
			return false;
		}
		if (ToDefAmend != other.ToDefAmend)
		{
			return false;
		}
		if (ToRcdSlotDmgRatio != other.ToRcdSlotDmgRatio)
		{
			return false;
		}
		if (ToEERCD != other.ToEERCD)
		{
			return false;
		}
		if (ToGenDmgRcdRatio != other.ToGenDmgRcdRatio)
		{
			return false;
		}
		if (ToDmgPlusRcd != other.ToDmgPlusRcd)
		{
			return false;
		}
		if (Dmg != other.Dmg)
		{
			return false;
		}
		if (CritRate != other.CritRate)
		{
			return false;
		}
		if (Hp != other.Hp)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (MissionId != 0)
		{
			num ^= MissionId.GetHashCode();
		}
		if (Version != 0)
		{
			num ^= Version.GetHashCode();
		}
		if (FromSrcAtk != 0)
		{
			num ^= FromSrcAtk.GetHashCode();
		}
		if (FromPerkIntensityRatio != 0)
		{
			num ^= FromPerkIntensityRatio.GetHashCode();
		}
		if (FromSlotDmgRatio != 0)
		{
			num ^= FromSlotDmgRatio.GetHashCode();
		}
		if (FromEE != 0)
		{
			num ^= FromEE.GetHashCode();
		}
		if (FromGenDmgRatio != 0)
		{
			num ^= FromGenDmgRatio.GetHashCode();
		}
		if (FromDmgPlus != 0)
		{
			num ^= FromDmgPlus.GetHashCode();
		}
		if (FromCritRatio != 0)
		{
			num ^= FromCritRatio.GetHashCode();
		}
		if (FromFinalDmgRatio != 0)
		{
			num ^= FromFinalDmgRatio.GetHashCode();
		}
		if (FromFinalDmgPlus != 0)
		{
			num ^= FromFinalDmgPlus.GetHashCode();
		}
		if (ToErAmend != 0)
		{
			num ^= ToErAmend.GetHashCode();
		}
		if (ToDefAmend != 0)
		{
			num ^= ToDefAmend.GetHashCode();
		}
		if (ToRcdSlotDmgRatio != 0)
		{
			num ^= ToRcdSlotDmgRatio.GetHashCode();
		}
		if (ToEERCD != 0)
		{
			num ^= ToEERCD.GetHashCode();
		}
		if (ToGenDmgRcdRatio != 0)
		{
			num ^= ToGenDmgRcdRatio.GetHashCode();
		}
		if (ToDmgPlusRcd != 0)
		{
			num ^= ToDmgPlusRcd.GetHashCode();
		}
		if (Dmg != 0)
		{
			num ^= Dmg.GetHashCode();
		}
		if (CritRate != 0)
		{
			num ^= CritRate.GetHashCode();
		}
		if (Hp != 0)
		{
			num ^= Hp.GetHashCode();
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
		if (MissionId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(MissionId);
		}
		if (Version != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Version);
		}
		if (FromSrcAtk != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(FromSrcAtk);
		}
		if (FromPerkIntensityRatio != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(FromPerkIntensityRatio);
		}
		if (FromSlotDmgRatio != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(FromSlotDmgRatio);
		}
		if (FromEE != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(FromEE);
		}
		if (FromGenDmgRatio != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(FromGenDmgRatio);
		}
		if (FromDmgPlus != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(FromDmgPlus);
		}
		if (FromCritRatio != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(FromCritRatio);
		}
		if (FromFinalDmgRatio != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(FromFinalDmgRatio);
		}
		if (FromFinalDmgPlus != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(FromFinalDmgPlus);
		}
		if (ToErAmend != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(ToErAmend);
		}
		if (ToDefAmend != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(ToDefAmend);
		}
		if (ToRcdSlotDmgRatio != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(ToRcdSlotDmgRatio);
		}
		if (ToEERCD != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(ToEERCD);
		}
		if (ToGenDmgRcdRatio != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(ToGenDmgRcdRatio);
		}
		if (ToDmgPlusRcd != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(ToDmgPlusRcd);
		}
		if (Dmg != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(Dmg);
		}
		if (CritRate != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(CritRate);
		}
		if (Hp != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(Hp);
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
		if (MissionId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MissionId);
		}
		if (Version != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Version);
		}
		if (FromSrcAtk != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FromSrcAtk);
		}
		if (FromPerkIntensityRatio != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FromPerkIntensityRatio);
		}
		if (FromSlotDmgRatio != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FromSlotDmgRatio);
		}
		if (FromEE != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FromEE);
		}
		if (FromGenDmgRatio != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FromGenDmgRatio);
		}
		if (FromDmgPlus != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FromDmgPlus);
		}
		if (FromCritRatio != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FromCritRatio);
		}
		if (FromFinalDmgRatio != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FromFinalDmgRatio);
		}
		if (FromFinalDmgPlus != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FromFinalDmgPlus);
		}
		if (ToErAmend != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ToErAmend);
		}
		if (ToDefAmend != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ToDefAmend);
		}
		if (ToRcdSlotDmgRatio != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ToRcdSlotDmgRatio);
		}
		if (ToEERCD != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ToEERCD);
		}
		if (ToGenDmgRcdRatio != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ToGenDmgRcdRatio);
		}
		if (ToDmgPlusRcd != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ToDmgPlusRcd);
		}
		if (Dmg != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Dmg);
		}
		if (CritRate != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(CritRate);
		}
		if (Hp != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Hp);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(VampireBattleThreshold other)
	{
		if (other != null)
		{
			if (other.MissionId != 0)
			{
				MissionId = other.MissionId;
			}
			if (other.Version != 0)
			{
				Version = other.Version;
			}
			if (other.FromSrcAtk != 0)
			{
				FromSrcAtk = other.FromSrcAtk;
			}
			if (other.FromPerkIntensityRatio != 0)
			{
				FromPerkIntensityRatio = other.FromPerkIntensityRatio;
			}
			if (other.FromSlotDmgRatio != 0)
			{
				FromSlotDmgRatio = other.FromSlotDmgRatio;
			}
			if (other.FromEE != 0)
			{
				FromEE = other.FromEE;
			}
			if (other.FromGenDmgRatio != 0)
			{
				FromGenDmgRatio = other.FromGenDmgRatio;
			}
			if (other.FromDmgPlus != 0)
			{
				FromDmgPlus = other.FromDmgPlus;
			}
			if (other.FromCritRatio != 0)
			{
				FromCritRatio = other.FromCritRatio;
			}
			if (other.FromFinalDmgRatio != 0)
			{
				FromFinalDmgRatio = other.FromFinalDmgRatio;
			}
			if (other.FromFinalDmgPlus != 0)
			{
				FromFinalDmgPlus = other.FromFinalDmgPlus;
			}
			if (other.ToErAmend != 0)
			{
				ToErAmend = other.ToErAmend;
			}
			if (other.ToDefAmend != 0)
			{
				ToDefAmend = other.ToDefAmend;
			}
			if (other.ToRcdSlotDmgRatio != 0)
			{
				ToRcdSlotDmgRatio = other.ToRcdSlotDmgRatio;
			}
			if (other.ToEERCD != 0)
			{
				ToEERCD = other.ToEERCD;
			}
			if (other.ToGenDmgRcdRatio != 0)
			{
				ToGenDmgRcdRatio = other.ToGenDmgRcdRatio;
			}
			if (other.ToDmgPlusRcd != 0)
			{
				ToDmgPlusRcd = other.ToDmgPlusRcd;
			}
			if (other.Dmg != 0)
			{
				Dmg = other.Dmg;
			}
			if (other.CritRate != 0)
			{
				CritRate = other.CritRate;
			}
			if (other.Hp != 0)
			{
				Hp = other.Hp;
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
				MissionId = input.ReadInt32();
				break;
			case 16u:
				Version = input.ReadInt32();
				break;
			case 24u:
				FromSrcAtk = input.ReadInt32();
				break;
			case 32u:
				FromPerkIntensityRatio = input.ReadInt32();
				break;
			case 40u:
				FromSlotDmgRatio = input.ReadInt32();
				break;
			case 48u:
				FromEE = input.ReadInt32();
				break;
			case 56u:
				FromGenDmgRatio = input.ReadInt32();
				break;
			case 64u:
				FromDmgPlus = input.ReadInt32();
				break;
			case 72u:
				FromCritRatio = input.ReadInt32();
				break;
			case 80u:
				FromFinalDmgRatio = input.ReadInt32();
				break;
			case 88u:
				FromFinalDmgPlus = input.ReadInt32();
				break;
			case 96u:
				ToErAmend = input.ReadInt32();
				break;
			case 104u:
				ToDefAmend = input.ReadInt32();
				break;
			case 112u:
				ToRcdSlotDmgRatio = input.ReadInt32();
				break;
			case 120u:
				ToEERCD = input.ReadInt32();
				break;
			case 128u:
				ToGenDmgRcdRatio = input.ReadInt32();
				break;
			case 136u:
				ToDmgPlusRcd = input.ReadInt32();
				break;
			case 144u:
				Dmg = input.ReadInt32();
				break;
			case 152u:
				CritRate = input.ReadInt32();
				break;
			case 160u:
				Hp = input.ReadInt32();
				break;
			}
		}
	}
}
