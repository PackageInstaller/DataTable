using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MonsterValueTempleteModify : IMessage<MonsterValueTempleteModify>, IMessage, IEquatable<MonsterValueTempleteModify>, IDeepCloneable<MonsterValueTempleteModify>
{
	private static readonly MessageParser<MonsterValueTempleteModify> _parser = new MessageParser<MonsterValueTempleteModify>(() => new MonsterValueTempleteModify());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private long id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int LvFieldNumber = 3;

	private int lv_;

	public const int HpFixFieldNumber = 4;

	private long hpFix_;

	public const int AtkFixFieldNumber = 5;

	private float atkFix_;

	public const int ToughnessFixFieldNumber = 6;

	private long toughnessFix_;

	public const int DefFixFieldNumber = 7;

	private float defFix_;

	public const int ENVAMENDFixFieldNumber = 8;

	private float eNVAMENDFix_;

	public const int WERFixFieldNumber = 9;

	private float wERFix_;

	public const int FERFixFieldNumber = 10;

	private float fERFix_;

	public const int SERFixFieldNumber = 11;

	private float sERFix_;

	public const int AERFixFieldNumber = 12;

	private float aERFix_;

	public const int LERFixFieldNumber = 13;

	private float lERFix_;

	public const int DERFixFieldNumber = 14;

	private float dERFix_;

	public const int LvUpEffectFieldNumber = 15;

	private string lvUpEffect_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<MonsterValueTempleteModify> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(590);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public long Id
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
	public int GroupId
	{
		get
		{
			return groupId_;
		}
		set
		{
			groupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Lv
	{
		get
		{
			return lv_;
		}
		set
		{
			lv_ = value;
		}
	}

	[DebuggerNonUserCode]
	public long HpFix
	{
		get
		{
			return hpFix_;
		}
		set
		{
			hpFix_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float AtkFix
	{
		get
		{
			return atkFix_;
		}
		set
		{
			atkFix_ = value;
		}
	}

	[DebuggerNonUserCode]
	public long ToughnessFix
	{
		get
		{
			return toughnessFix_;
		}
		set
		{
			toughnessFix_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float DefFix
	{
		get
		{
			return defFix_;
		}
		set
		{
			defFix_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float ENVAMENDFix
	{
		get
		{
			return eNVAMENDFix_;
		}
		set
		{
			eNVAMENDFix_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float WERFix
	{
		get
		{
			return wERFix_;
		}
		set
		{
			wERFix_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float FERFix
	{
		get
		{
			return fERFix_;
		}
		set
		{
			fERFix_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float SERFix
	{
		get
		{
			return sERFix_;
		}
		set
		{
			sERFix_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float AERFix
	{
		get
		{
			return aERFix_;
		}
		set
		{
			aERFix_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float LERFix
	{
		get
		{
			return lERFix_;
		}
		set
		{
			lERFix_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float DERFix
	{
		get
		{
			return dERFix_;
		}
		set
		{
			dERFix_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string LvUpEffect
	{
		get
		{
			return lvUpEffect_;
		}
		set
		{
			lvUpEffect_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public MonsterValueTempleteModify()
	{
	}

	[DebuggerNonUserCode]
	public MonsterValueTempleteModify(MonsterValueTempleteModify other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		lv_ = other.lv_;
		hpFix_ = other.hpFix_;
		atkFix_ = other.atkFix_;
		toughnessFix_ = other.toughnessFix_;
		defFix_ = other.defFix_;
		eNVAMENDFix_ = other.eNVAMENDFix_;
		wERFix_ = other.wERFix_;
		fERFix_ = other.fERFix_;
		sERFix_ = other.sERFix_;
		aERFix_ = other.aERFix_;
		lERFix_ = other.lERFix_;
		dERFix_ = other.dERFix_;
		lvUpEffect_ = other.lvUpEffect_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MonsterValueTempleteModify Clone()
	{
		return new MonsterValueTempleteModify(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MonsterValueTempleteModify);
	}

	[DebuggerNonUserCode]
	public bool Equals(MonsterValueTempleteModify other)
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
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (Lv != other.Lv)
		{
			return false;
		}
		if (HpFix != other.HpFix)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(AtkFix, other.AtkFix))
		{
			return false;
		}
		if (ToughnessFix != other.ToughnessFix)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(DefFix, other.DefFix))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(ENVAMENDFix, other.ENVAMENDFix))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(WERFix, other.WERFix))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(FERFix, other.FERFix))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(SERFix, other.SERFix))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(AERFix, other.AERFix))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(LERFix, other.LERFix))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(DERFix, other.DERFix))
		{
			return false;
		}
		if (LvUpEffect != other.LvUpEffect)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0L)
		{
			num ^= Id.GetHashCode();
		}
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (Lv != 0)
		{
			num ^= Lv.GetHashCode();
		}
		if (HpFix != 0L)
		{
			num ^= HpFix.GetHashCode();
		}
		if (AtkFix != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(AtkFix);
		}
		if (ToughnessFix != 0L)
		{
			num ^= ToughnessFix.GetHashCode();
		}
		if (DefFix != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(DefFix);
		}
		if (ENVAMENDFix != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(ENVAMENDFix);
		}
		if (WERFix != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(WERFix);
		}
		if (FERFix != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(FERFix);
		}
		if (SERFix != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(SERFix);
		}
		if (AERFix != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(AERFix);
		}
		if (LERFix != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(LERFix);
		}
		if (DERFix != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(DERFix);
		}
		if (LvUpEffect.Length != 0)
		{
			num ^= LvUpEffect.GetHashCode();
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
		if (Id != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(Id);
		}
		if (GroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GroupId);
		}
		if (Lv != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Lv);
		}
		if (HpFix != 0L)
		{
			output.WriteRawTag(32);
			output.WriteInt64(HpFix);
		}
		if (AtkFix != 0f)
		{
			output.WriteRawTag(45);
			output.WriteFloat(AtkFix);
		}
		if (ToughnessFix != 0L)
		{
			output.WriteRawTag(48);
			output.WriteInt64(ToughnessFix);
		}
		if (DefFix != 0f)
		{
			output.WriteRawTag(61);
			output.WriteFloat(DefFix);
		}
		if (ENVAMENDFix != 0f)
		{
			output.WriteRawTag(69);
			output.WriteFloat(ENVAMENDFix);
		}
		if (WERFix != 0f)
		{
			output.WriteRawTag(77);
			output.WriteFloat(WERFix);
		}
		if (FERFix != 0f)
		{
			output.WriteRawTag(85);
			output.WriteFloat(FERFix);
		}
		if (SERFix != 0f)
		{
			output.WriteRawTag(93);
			output.WriteFloat(SERFix);
		}
		if (AERFix != 0f)
		{
			output.WriteRawTag(101);
			output.WriteFloat(AERFix);
		}
		if (LERFix != 0f)
		{
			output.WriteRawTag(109);
			output.WriteFloat(LERFix);
		}
		if (DERFix != 0f)
		{
			output.WriteRawTag(117);
			output.WriteFloat(DERFix);
		}
		if (LvUpEffect.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(LvUpEffect);
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
		if (Id != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Id);
		}
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (Lv != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Lv);
		}
		if (HpFix != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(HpFix);
		}
		if (AtkFix != 0f)
		{
			num += 5;
		}
		if (ToughnessFix != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(ToughnessFix);
		}
		if (DefFix != 0f)
		{
			num += 5;
		}
		if (ENVAMENDFix != 0f)
		{
			num += 5;
		}
		if (WERFix != 0f)
		{
			num += 5;
		}
		if (FERFix != 0f)
		{
			num += 5;
		}
		if (SERFix != 0f)
		{
			num += 5;
		}
		if (AERFix != 0f)
		{
			num += 5;
		}
		if (LERFix != 0f)
		{
			num += 5;
		}
		if (DERFix != 0f)
		{
			num += 5;
		}
		if (LvUpEffect.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LvUpEffect);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MonsterValueTempleteModify other)
	{
		if (other != null)
		{
			if (other.Id != 0L)
			{
				Id = other.Id;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.Lv != 0)
			{
				Lv = other.Lv;
			}
			if (other.HpFix != 0L)
			{
				HpFix = other.HpFix;
			}
			if (other.AtkFix != 0f)
			{
				AtkFix = other.AtkFix;
			}
			if (other.ToughnessFix != 0L)
			{
				ToughnessFix = other.ToughnessFix;
			}
			if (other.DefFix != 0f)
			{
				DefFix = other.DefFix;
			}
			if (other.ENVAMENDFix != 0f)
			{
				ENVAMENDFix = other.ENVAMENDFix;
			}
			if (other.WERFix != 0f)
			{
				WERFix = other.WERFix;
			}
			if (other.FERFix != 0f)
			{
				FERFix = other.FERFix;
			}
			if (other.SERFix != 0f)
			{
				SERFix = other.SERFix;
			}
			if (other.AERFix != 0f)
			{
				AERFix = other.AERFix;
			}
			if (other.LERFix != 0f)
			{
				LERFix = other.LERFix;
			}
			if (other.DERFix != 0f)
			{
				DERFix = other.DERFix;
			}
			if (other.LvUpEffect.Length != 0)
			{
				LvUpEffect = other.LvUpEffect;
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
				Id = input.ReadInt64();
				break;
			case 16u:
				GroupId = input.ReadInt32();
				break;
			case 24u:
				Lv = input.ReadInt32();
				break;
			case 32u:
				HpFix = input.ReadInt64();
				break;
			case 45u:
				AtkFix = input.ReadFloat();
				break;
			case 48u:
				ToughnessFix = input.ReadInt64();
				break;
			case 61u:
				DefFix = input.ReadFloat();
				break;
			case 69u:
				ENVAMENDFix = input.ReadFloat();
				break;
			case 77u:
				WERFix = input.ReadFloat();
				break;
			case 85u:
				FERFix = input.ReadFloat();
				break;
			case 93u:
				SERFix = input.ReadFloat();
				break;
			case 101u:
				AERFix = input.ReadFloat();
				break;
			case 109u:
				LERFix = input.ReadFloat();
				break;
			case 117u:
				DERFix = input.ReadFloat();
				break;
			case 122u:
				LvUpEffect = input.ReadString();
				break;
			}
		}
	}
}
