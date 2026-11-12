using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MonsterValueTempleteAdjust : IMessage<MonsterValueTempleteAdjust>, IMessage, IEquatable<MonsterValueTempleteAdjust>, IDeepCloneable<MonsterValueTempleteAdjust>
{
	private static readonly MessageParser<MonsterValueTempleteAdjust> _parser = new MessageParser<MonsterValueTempleteAdjust>(() => new MonsterValueTempleteAdjust());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private long id_;

	public const int TemplateIdFieldNumber = 2;

	private int templateId_;

	public const int EETFieldNumber = 3;

	private int eET_;

	public const int ResistEETFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_resistEET_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> resistEET_ = new RepeatedField<int>();

	public const int WeakEETFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_weakEET_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> weakEET_ = new RepeatedField<int>();

	public const int HpRatioFieldNumber = 6;

	private int hpRatio_;

	public const int HpFixFieldNumber = 7;

	private long hpFix_;

	public const int AtkRatioFieldNumber = 8;

	private int atkRatio_;

	public const int AtkFixFieldNumber = 9;

	private int atkFix_;

	public const int WERRatioFieldNumber = 10;

	private int wERRatio_;

	public const int WERFixFieldNumber = 11;

	private int wERFix_;

	public const int FERRatioFieldNumber = 12;

	private int fERRatio_;

	public const int FERFixFieldNumber = 13;

	private int fERFix_;

	public const int SERRatioFieldNumber = 14;

	private int sERRatio_;

	public const int SERFixFieldNumber = 15;

	private int sERFix_;

	public const int AERRatioFieldNumber = 16;

	private int aERRatio_;

	public const int AERFixFieldNumber = 17;

	private int aERFix_;

	public const int LERRatioFieldNumber = 18;

	private int lERRatio_;

	public const int LERFixFieldNumber = 19;

	private int lERFix_;

	public const int DERRatioFieldNumber = 20;

	private int dERRatio_;

	public const int DERFixFieldNumber = 21;

	private int dERFix_;

	public const int ToughnessRatioFieldNumber = 22;

	private int toughnessRatio_;

	public const int ToughnessFixFieldNumber = 23;

	private long toughnessFix_;

	public const int SuppressRatioFieldNumber = 24;

	private int suppressRatio_;

	public const int SuppressFixFieldNumber = 25;

	private int suppressFix_;

	[DebuggerNonUserCode]
	public static MessageParser<MonsterValueTempleteAdjust> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(588);

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
	public int TemplateId
	{
		get
		{
			return templateId_;
		}
		set
		{
			templateId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EET
	{
		get
		{
			return eET_;
		}
		set
		{
			eET_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> ResistEET => resistEET_;

	[DebuggerNonUserCode]
	public RepeatedField<int> WeakEET => weakEET_;

	[DebuggerNonUserCode]
	public int HpRatio
	{
		get
		{
			return hpRatio_;
		}
		set
		{
			hpRatio_ = value;
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
	public int AtkRatio
	{
		get
		{
			return atkRatio_;
		}
		set
		{
			atkRatio_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AtkFix
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
	public int WERRatio
	{
		get
		{
			return wERRatio_;
		}
		set
		{
			wERRatio_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WERFix
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
	public int FERRatio
	{
		get
		{
			return fERRatio_;
		}
		set
		{
			fERRatio_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FERFix
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
	public int SERRatio
	{
		get
		{
			return sERRatio_;
		}
		set
		{
			sERRatio_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SERFix
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
	public int AERRatio
	{
		get
		{
			return aERRatio_;
		}
		set
		{
			aERRatio_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AERFix
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
	public int LERRatio
	{
		get
		{
			return lERRatio_;
		}
		set
		{
			lERRatio_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LERFix
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
	public int DERRatio
	{
		get
		{
			return dERRatio_;
		}
		set
		{
			dERRatio_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DERFix
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
	public int ToughnessRatio
	{
		get
		{
			return toughnessRatio_;
		}
		set
		{
			toughnessRatio_ = value;
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
	public int SuppressRatio
	{
		get
		{
			return suppressRatio_;
		}
		set
		{
			suppressRatio_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SuppressFix
	{
		get
		{
			return suppressFix_;
		}
		set
		{
			suppressFix_ = value;
		}
	}

	[DebuggerNonUserCode]
	public MonsterValueTempleteAdjust()
	{
	}

	[DebuggerNonUserCode]
	public MonsterValueTempleteAdjust(MonsterValueTempleteAdjust other)
		: this()
	{
		id_ = other.id_;
		templateId_ = other.templateId_;
		eET_ = other.eET_;
		resistEET_ = other.resistEET_.Clone();
		weakEET_ = other.weakEET_.Clone();
		hpRatio_ = other.hpRatio_;
		hpFix_ = other.hpFix_;
		atkRatio_ = other.atkRatio_;
		atkFix_ = other.atkFix_;
		wERRatio_ = other.wERRatio_;
		wERFix_ = other.wERFix_;
		fERRatio_ = other.fERRatio_;
		fERFix_ = other.fERFix_;
		sERRatio_ = other.sERRatio_;
		sERFix_ = other.sERFix_;
		aERRatio_ = other.aERRatio_;
		aERFix_ = other.aERFix_;
		lERRatio_ = other.lERRatio_;
		lERFix_ = other.lERFix_;
		dERRatio_ = other.dERRatio_;
		dERFix_ = other.dERFix_;
		toughnessRatio_ = other.toughnessRatio_;
		toughnessFix_ = other.toughnessFix_;
		suppressRatio_ = other.suppressRatio_;
		suppressFix_ = other.suppressFix_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MonsterValueTempleteAdjust Clone()
	{
		return new MonsterValueTempleteAdjust(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MonsterValueTempleteAdjust);
	}

	[DebuggerNonUserCode]
	public bool Equals(MonsterValueTempleteAdjust other)
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
		if (TemplateId != other.TemplateId)
		{
			return false;
		}
		if (EET != other.EET)
		{
			return false;
		}
		if (!resistEET_.Equals(other.resistEET_))
		{
			return false;
		}
		if (!weakEET_.Equals(other.weakEET_))
		{
			return false;
		}
		if (HpRatio != other.HpRatio)
		{
			return false;
		}
		if (HpFix != other.HpFix)
		{
			return false;
		}
		if (AtkRatio != other.AtkRatio)
		{
			return false;
		}
		if (AtkFix != other.AtkFix)
		{
			return false;
		}
		if (WERRatio != other.WERRatio)
		{
			return false;
		}
		if (WERFix != other.WERFix)
		{
			return false;
		}
		if (FERRatio != other.FERRatio)
		{
			return false;
		}
		if (FERFix != other.FERFix)
		{
			return false;
		}
		if (SERRatio != other.SERRatio)
		{
			return false;
		}
		if (SERFix != other.SERFix)
		{
			return false;
		}
		if (AERRatio != other.AERRatio)
		{
			return false;
		}
		if (AERFix != other.AERFix)
		{
			return false;
		}
		if (LERRatio != other.LERRatio)
		{
			return false;
		}
		if (LERFix != other.LERFix)
		{
			return false;
		}
		if (DERRatio != other.DERRatio)
		{
			return false;
		}
		if (DERFix != other.DERFix)
		{
			return false;
		}
		if (ToughnessRatio != other.ToughnessRatio)
		{
			return false;
		}
		if (ToughnessFix != other.ToughnessFix)
		{
			return false;
		}
		if (SuppressRatio != other.SuppressRatio)
		{
			return false;
		}
		if (SuppressFix != other.SuppressFix)
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
		if (TemplateId != 0)
		{
			num ^= TemplateId.GetHashCode();
		}
		if (EET != 0)
		{
			num ^= EET.GetHashCode();
		}
		num ^= resistEET_.GetHashCode();
		num ^= weakEET_.GetHashCode();
		if (HpRatio != 0)
		{
			num ^= HpRatio.GetHashCode();
		}
		if (HpFix != 0L)
		{
			num ^= HpFix.GetHashCode();
		}
		if (AtkRatio != 0)
		{
			num ^= AtkRatio.GetHashCode();
		}
		if (AtkFix != 0)
		{
			num ^= AtkFix.GetHashCode();
		}
		if (WERRatio != 0)
		{
			num ^= WERRatio.GetHashCode();
		}
		if (WERFix != 0)
		{
			num ^= WERFix.GetHashCode();
		}
		if (FERRatio != 0)
		{
			num ^= FERRatio.GetHashCode();
		}
		if (FERFix != 0)
		{
			num ^= FERFix.GetHashCode();
		}
		if (SERRatio != 0)
		{
			num ^= SERRatio.GetHashCode();
		}
		if (SERFix != 0)
		{
			num ^= SERFix.GetHashCode();
		}
		if (AERRatio != 0)
		{
			num ^= AERRatio.GetHashCode();
		}
		if (AERFix != 0)
		{
			num ^= AERFix.GetHashCode();
		}
		if (LERRatio != 0)
		{
			num ^= LERRatio.GetHashCode();
		}
		if (LERFix != 0)
		{
			num ^= LERFix.GetHashCode();
		}
		if (DERRatio != 0)
		{
			num ^= DERRatio.GetHashCode();
		}
		if (DERFix != 0)
		{
			num ^= DERFix.GetHashCode();
		}
		if (ToughnessRatio != 0)
		{
			num ^= ToughnessRatio.GetHashCode();
		}
		if (ToughnessFix != 0L)
		{
			num ^= ToughnessFix.GetHashCode();
		}
		if (SuppressRatio != 0)
		{
			num ^= SuppressRatio.GetHashCode();
		}
		if (SuppressFix != 0)
		{
			num ^= SuppressFix.GetHashCode();
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
		if (TemplateId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(TemplateId);
		}
		if (EET != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(EET);
		}
		resistEET_.WriteTo(output, _repeated_resistEET_codec);
		weakEET_.WriteTo(output, _repeated_weakEET_codec);
		if (HpRatio != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(HpRatio);
		}
		if (HpFix != 0L)
		{
			output.WriteRawTag(56);
			output.WriteInt64(HpFix);
		}
		if (AtkRatio != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(AtkRatio);
		}
		if (AtkFix != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(AtkFix);
		}
		if (WERRatio != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(WERRatio);
		}
		if (WERFix != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(WERFix);
		}
		if (FERRatio != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(FERRatio);
		}
		if (FERFix != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(FERFix);
		}
		if (SERRatio != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(SERRatio);
		}
		if (SERFix != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(SERFix);
		}
		if (AERRatio != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(AERRatio);
		}
		if (AERFix != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(AERFix);
		}
		if (LERRatio != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(LERRatio);
		}
		if (LERFix != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(LERFix);
		}
		if (DERRatio != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(DERRatio);
		}
		if (DERFix != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(DERFix);
		}
		if (ToughnessRatio != 0)
		{
			output.WriteRawTag(176, 1);
			output.WriteInt32(ToughnessRatio);
		}
		if (ToughnessFix != 0L)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt64(ToughnessFix);
		}
		if (SuppressRatio != 0)
		{
			output.WriteRawTag(192, 1);
			output.WriteInt32(SuppressRatio);
		}
		if (SuppressFix != 0)
		{
			output.WriteRawTag(200, 1);
			output.WriteInt32(SuppressFix);
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
		if (TemplateId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TemplateId);
		}
		if (EET != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EET);
		}
		num += resistEET_.CalculateSize(_repeated_resistEET_codec);
		num += weakEET_.CalculateSize(_repeated_weakEET_codec);
		if (HpRatio != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(HpRatio);
		}
		if (HpFix != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(HpFix);
		}
		if (AtkRatio != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AtkRatio);
		}
		if (AtkFix != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AtkFix);
		}
		if (WERRatio != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WERRatio);
		}
		if (WERFix != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WERFix);
		}
		if (FERRatio != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FERRatio);
		}
		if (FERFix != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FERFix);
		}
		if (SERRatio != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SERRatio);
		}
		if (SERFix != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SERFix);
		}
		if (AERRatio != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AERRatio);
		}
		if (AERFix != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AERFix);
		}
		if (LERRatio != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(LERRatio);
		}
		if (LERFix != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(LERFix);
		}
		if (DERRatio != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DERRatio);
		}
		if (DERFix != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DERFix);
		}
		if (ToughnessRatio != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ToughnessRatio);
		}
		if (ToughnessFix != 0L)
		{
			num += 2 + CodedOutputStream.ComputeInt64Size(ToughnessFix);
		}
		if (SuppressRatio != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SuppressRatio);
		}
		if (SuppressFix != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SuppressFix);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MonsterValueTempleteAdjust other)
	{
		if (other != null)
		{
			if (other.Id != 0L)
			{
				Id = other.Id;
			}
			if (other.TemplateId != 0)
			{
				TemplateId = other.TemplateId;
			}
			if (other.EET != 0)
			{
				EET = other.EET;
			}
			resistEET_.Add(other.resistEET_);
			weakEET_.Add(other.weakEET_);
			if (other.HpRatio != 0)
			{
				HpRatio = other.HpRatio;
			}
			if (other.HpFix != 0L)
			{
				HpFix = other.HpFix;
			}
			if (other.AtkRatio != 0)
			{
				AtkRatio = other.AtkRatio;
			}
			if (other.AtkFix != 0)
			{
				AtkFix = other.AtkFix;
			}
			if (other.WERRatio != 0)
			{
				WERRatio = other.WERRatio;
			}
			if (other.WERFix != 0)
			{
				WERFix = other.WERFix;
			}
			if (other.FERRatio != 0)
			{
				FERRatio = other.FERRatio;
			}
			if (other.FERFix != 0)
			{
				FERFix = other.FERFix;
			}
			if (other.SERRatio != 0)
			{
				SERRatio = other.SERRatio;
			}
			if (other.SERFix != 0)
			{
				SERFix = other.SERFix;
			}
			if (other.AERRatio != 0)
			{
				AERRatio = other.AERRatio;
			}
			if (other.AERFix != 0)
			{
				AERFix = other.AERFix;
			}
			if (other.LERRatio != 0)
			{
				LERRatio = other.LERRatio;
			}
			if (other.LERFix != 0)
			{
				LERFix = other.LERFix;
			}
			if (other.DERRatio != 0)
			{
				DERRatio = other.DERRatio;
			}
			if (other.DERFix != 0)
			{
				DERFix = other.DERFix;
			}
			if (other.ToughnessRatio != 0)
			{
				ToughnessRatio = other.ToughnessRatio;
			}
			if (other.ToughnessFix != 0L)
			{
				ToughnessFix = other.ToughnessFix;
			}
			if (other.SuppressRatio != 0)
			{
				SuppressRatio = other.SuppressRatio;
			}
			if (other.SuppressFix != 0)
			{
				SuppressFix = other.SuppressFix;
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
				TemplateId = input.ReadInt32();
				break;
			case 24u:
				EET = input.ReadInt32();
				break;
			case 32u:
			case 34u:
				resistEET_.AddEntriesFrom(input, _repeated_resistEET_codec);
				break;
			case 40u:
			case 42u:
				weakEET_.AddEntriesFrom(input, _repeated_weakEET_codec);
				break;
			case 48u:
				HpRatio = input.ReadInt32();
				break;
			case 56u:
				HpFix = input.ReadInt64();
				break;
			case 64u:
				AtkRatio = input.ReadInt32();
				break;
			case 72u:
				AtkFix = input.ReadInt32();
				break;
			case 80u:
				WERRatio = input.ReadInt32();
				break;
			case 88u:
				WERFix = input.ReadInt32();
				break;
			case 96u:
				FERRatio = input.ReadInt32();
				break;
			case 104u:
				FERFix = input.ReadInt32();
				break;
			case 112u:
				SERRatio = input.ReadInt32();
				break;
			case 120u:
				SERFix = input.ReadInt32();
				break;
			case 128u:
				AERRatio = input.ReadInt32();
				break;
			case 136u:
				AERFix = input.ReadInt32();
				break;
			case 144u:
				LERRatio = input.ReadInt32();
				break;
			case 152u:
				LERFix = input.ReadInt32();
				break;
			case 160u:
				DERRatio = input.ReadInt32();
				break;
			case 168u:
				DERFix = input.ReadInt32();
				break;
			case 176u:
				ToughnessRatio = input.ReadInt32();
				break;
			case 184u:
				ToughnessFix = input.ReadInt64();
				break;
			case 192u:
				SuppressRatio = input.ReadInt32();
				break;
			case 200u:
				SuppressFix = input.ReadInt32();
				break;
			}
		}
	}
}
