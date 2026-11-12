using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Gacha : IMessage<Gacha>, IMessage, IEquatable<Gacha>, IDeepCloneable<Gacha>
{
	private static readonly MessageParser<Gacha> _parser = new MessageParser<Gacha>(() => new Gacha());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int StorageIdFieldNumber = 3;

	private int storageId_;

	public const int GachaTypeFieldNumber = 4;

	private int gachaType_;

	public const int LimitTimesFieldNumber = 5;

	private int limitTimes_;

	public const int SpecificTidFieldNumber = 6;

	private int specificTid_;

	public const int SpecificQtyFieldNumber = 7;

	private int specificQty_;

	public const int ATypePkgFieldNumber = 8;

	private int aTypePkg_;

	public const int BTypePkgFieldNumber = 9;

	private int bTypePkg_;

	public const int CTypePkgFieldNumber = 10;

	private int cTypePkg_;

	public const int ATypeUpPkgFieldNumber = 11;

	private int aTypeUpPkg_;

	public const int BTypeUpPkgFieldNumber = 12;

	private int bTypeUpPkg_;

	public const int BGuaranteePkgFieldNumber = 13;

	private int bGuaranteePkg_;

	public const int ATypeGuaranteeTimesFieldNumber = 14;

	private int aTypeGuaranteeTimes_;

	public const int GuaranteeTimesFieldNumber = 15;

	private int guaranteeTimes_;

	public const int GuaranteeTidFieldNumber = 16;

	private int guaranteeTid_;

	public const int GuaranteeQtyFieldNumber = 17;

	private int guaranteeQty_;

	public const int FirstTenShowFieldNumber = 18;

	private int firstTenShow_;

	public const int StartTimeFieldNumber = 19;

	private string startTime_ = "";

	public const int EndTimeFieldNumber = 20;

	private string endTime_ = "";

	public const int SortFieldNumber = 21;

	private int sort_;

	public const int IconFieldNumber = 22;

	private string icon_ = "";

	public const int BannerResFieldNumber = 23;

	private string bannerRes_ = "";

	public const int ImageFieldNumber = 24;

	private string image_ = "";

	public const int TagFieldNumber = 25;

	private string tag_ = "";

	public const int VoiceFieldNumber = 26;

	private string voice_ = "";

	public const int TrailIdFieldNumber = 27;

	private int trailId_;

	[DebuggerNonUserCode]
	public static MessageParser<Gacha> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(362);

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
	public int StorageId
	{
		get
		{
			return storageId_;
		}
		set
		{
			storageId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GachaType
	{
		get
		{
			return gachaType_;
		}
		set
		{
			gachaType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LimitTimes
	{
		get
		{
			return limitTimes_;
		}
		set
		{
			limitTimes_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SpecificTid
	{
		get
		{
			return specificTid_;
		}
		set
		{
			specificTid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SpecificQty
	{
		get
		{
			return specificQty_;
		}
		set
		{
			specificQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ATypePkg
	{
		get
		{
			return aTypePkg_;
		}
		set
		{
			aTypePkg_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BTypePkg
	{
		get
		{
			return bTypePkg_;
		}
		set
		{
			bTypePkg_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CTypePkg
	{
		get
		{
			return cTypePkg_;
		}
		set
		{
			cTypePkg_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ATypeUpPkg
	{
		get
		{
			return aTypeUpPkg_;
		}
		set
		{
			aTypeUpPkg_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BTypeUpPkg
	{
		get
		{
			return bTypeUpPkg_;
		}
		set
		{
			bTypeUpPkg_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BGuaranteePkg
	{
		get
		{
			return bGuaranteePkg_;
		}
		set
		{
			bGuaranteePkg_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ATypeGuaranteeTimes
	{
		get
		{
			return aTypeGuaranteeTimes_;
		}
		set
		{
			aTypeGuaranteeTimes_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GuaranteeTimes
	{
		get
		{
			return guaranteeTimes_;
		}
		set
		{
			guaranteeTimes_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GuaranteeTid
	{
		get
		{
			return guaranteeTid_;
		}
		set
		{
			guaranteeTid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GuaranteeQty
	{
		get
		{
			return guaranteeQty_;
		}
		set
		{
			guaranteeQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FirstTenShow
	{
		get
		{
			return firstTenShow_;
		}
		set
		{
			firstTenShow_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string StartTime
	{
		get
		{
			return startTime_;
		}
		set
		{
			startTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string EndTime
	{
		get
		{
			return endTime_;
		}
		set
		{
			endTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Sort
	{
		get
		{
			return sort_;
		}
		set
		{
			sort_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Icon
	{
		get
		{
			return icon_;
		}
		set
		{
			icon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BannerRes
	{
		get
		{
			return bannerRes_;
		}
		set
		{
			bannerRes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Image
	{
		get
		{
			return image_;
		}
		set
		{
			image_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Tag
	{
		get
		{
			return tag_;
		}
		set
		{
			tag_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Voice
	{
		get
		{
			return voice_;
		}
		set
		{
			voice_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int TrailId
	{
		get
		{
			return trailId_;
		}
		set
		{
			trailId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Gacha()
	{
	}

	[DebuggerNonUserCode]
	public Gacha(Gacha other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		storageId_ = other.storageId_;
		gachaType_ = other.gachaType_;
		limitTimes_ = other.limitTimes_;
		specificTid_ = other.specificTid_;
		specificQty_ = other.specificQty_;
		aTypePkg_ = other.aTypePkg_;
		bTypePkg_ = other.bTypePkg_;
		cTypePkg_ = other.cTypePkg_;
		aTypeUpPkg_ = other.aTypeUpPkg_;
		bTypeUpPkg_ = other.bTypeUpPkg_;
		bGuaranteePkg_ = other.bGuaranteePkg_;
		aTypeGuaranteeTimes_ = other.aTypeGuaranteeTimes_;
		guaranteeTimes_ = other.guaranteeTimes_;
		guaranteeTid_ = other.guaranteeTid_;
		guaranteeQty_ = other.guaranteeQty_;
		firstTenShow_ = other.firstTenShow_;
		startTime_ = other.startTime_;
		endTime_ = other.endTime_;
		sort_ = other.sort_;
		icon_ = other.icon_;
		bannerRes_ = other.bannerRes_;
		image_ = other.image_;
		tag_ = other.tag_;
		voice_ = other.voice_;
		trailId_ = other.trailId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Gacha Clone()
	{
		return new Gacha(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Gacha);
	}

	[DebuggerNonUserCode]
	public bool Equals(Gacha other)
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
		if (Name != other.Name)
		{
			return false;
		}
		if (StorageId != other.StorageId)
		{
			return false;
		}
		if (GachaType != other.GachaType)
		{
			return false;
		}
		if (LimitTimes != other.LimitTimes)
		{
			return false;
		}
		if (SpecificTid != other.SpecificTid)
		{
			return false;
		}
		if (SpecificQty != other.SpecificQty)
		{
			return false;
		}
		if (ATypePkg != other.ATypePkg)
		{
			return false;
		}
		if (BTypePkg != other.BTypePkg)
		{
			return false;
		}
		if (CTypePkg != other.CTypePkg)
		{
			return false;
		}
		if (ATypeUpPkg != other.ATypeUpPkg)
		{
			return false;
		}
		if (BTypeUpPkg != other.BTypeUpPkg)
		{
			return false;
		}
		if (BGuaranteePkg != other.BGuaranteePkg)
		{
			return false;
		}
		if (ATypeGuaranteeTimes != other.ATypeGuaranteeTimes)
		{
			return false;
		}
		if (GuaranteeTimes != other.GuaranteeTimes)
		{
			return false;
		}
		if (GuaranteeTid != other.GuaranteeTid)
		{
			return false;
		}
		if (GuaranteeQty != other.GuaranteeQty)
		{
			return false;
		}
		if (FirstTenShow != other.FirstTenShow)
		{
			return false;
		}
		if (StartTime != other.StartTime)
		{
			return false;
		}
		if (EndTime != other.EndTime)
		{
			return false;
		}
		if (Sort != other.Sort)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (BannerRes != other.BannerRes)
		{
			return false;
		}
		if (Image != other.Image)
		{
			return false;
		}
		if (Tag != other.Tag)
		{
			return false;
		}
		if (Voice != other.Voice)
		{
			return false;
		}
		if (TrailId != other.TrailId)
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
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (StorageId != 0)
		{
			num ^= StorageId.GetHashCode();
		}
		if (GachaType != 0)
		{
			num ^= GachaType.GetHashCode();
		}
		if (LimitTimes != 0)
		{
			num ^= LimitTimes.GetHashCode();
		}
		if (SpecificTid != 0)
		{
			num ^= SpecificTid.GetHashCode();
		}
		if (SpecificQty != 0)
		{
			num ^= SpecificQty.GetHashCode();
		}
		if (ATypePkg != 0)
		{
			num ^= ATypePkg.GetHashCode();
		}
		if (BTypePkg != 0)
		{
			num ^= BTypePkg.GetHashCode();
		}
		if (CTypePkg != 0)
		{
			num ^= CTypePkg.GetHashCode();
		}
		if (ATypeUpPkg != 0)
		{
			num ^= ATypeUpPkg.GetHashCode();
		}
		if (BTypeUpPkg != 0)
		{
			num ^= BTypeUpPkg.GetHashCode();
		}
		if (BGuaranteePkg != 0)
		{
			num ^= BGuaranteePkg.GetHashCode();
		}
		if (ATypeGuaranteeTimes != 0)
		{
			num ^= ATypeGuaranteeTimes.GetHashCode();
		}
		if (GuaranteeTimes != 0)
		{
			num ^= GuaranteeTimes.GetHashCode();
		}
		if (GuaranteeTid != 0)
		{
			num ^= GuaranteeTid.GetHashCode();
		}
		if (GuaranteeQty != 0)
		{
			num ^= GuaranteeQty.GetHashCode();
		}
		if (FirstTenShow != 0)
		{
			num ^= FirstTenShow.GetHashCode();
		}
		if (StartTime.Length != 0)
		{
			num ^= StartTime.GetHashCode();
		}
		if (EndTime.Length != 0)
		{
			num ^= EndTime.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (BannerRes.Length != 0)
		{
			num ^= BannerRes.GetHashCode();
		}
		if (Image.Length != 0)
		{
			num ^= Image.GetHashCode();
		}
		if (Tag.Length != 0)
		{
			num ^= Tag.GetHashCode();
		}
		if (Voice.Length != 0)
		{
			num ^= Voice.GetHashCode();
		}
		if (TrailId != 0)
		{
			num ^= TrailId.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (StorageId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(StorageId);
		}
		if (GachaType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(GachaType);
		}
		if (LimitTimes != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(LimitTimes);
		}
		if (SpecificTid != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(SpecificTid);
		}
		if (SpecificQty != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(SpecificQty);
		}
		if (ATypePkg != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(ATypePkg);
		}
		if (BTypePkg != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(BTypePkg);
		}
		if (CTypePkg != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(CTypePkg);
		}
		if (ATypeUpPkg != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(ATypeUpPkg);
		}
		if (BTypeUpPkg != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(BTypeUpPkg);
		}
		if (BGuaranteePkg != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(BGuaranteePkg);
		}
		if (ATypeGuaranteeTimes != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(ATypeGuaranteeTimes);
		}
		if (GuaranteeTimes != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(GuaranteeTimes);
		}
		if (GuaranteeTid != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(GuaranteeTid);
		}
		if (GuaranteeQty != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(GuaranteeQty);
		}
		if (FirstTenShow != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(FirstTenShow);
		}
		if (StartTime.Length != 0)
		{
			output.WriteRawTag(154, 1);
			output.WriteString(StartTime);
		}
		if (EndTime.Length != 0)
		{
			output.WriteRawTag(162, 1);
			output.WriteString(EndTime);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(Sort);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(178, 1);
			output.WriteString(Icon);
		}
		if (BannerRes.Length != 0)
		{
			output.WriteRawTag(186, 1);
			output.WriteString(BannerRes);
		}
		if (Image.Length != 0)
		{
			output.WriteRawTag(194, 1);
			output.WriteString(Image);
		}
		if (Tag.Length != 0)
		{
			output.WriteRawTag(202, 1);
			output.WriteString(Tag);
		}
		if (Voice.Length != 0)
		{
			output.WriteRawTag(210, 1);
			output.WriteString(Voice);
		}
		if (TrailId != 0)
		{
			output.WriteRawTag(216, 1);
			output.WriteInt32(TrailId);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (StorageId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StorageId);
		}
		if (GachaType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GachaType);
		}
		if (LimitTimes != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LimitTimes);
		}
		if (SpecificTid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SpecificTid);
		}
		if (SpecificQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SpecificQty);
		}
		if (ATypePkg != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ATypePkg);
		}
		if (BTypePkg != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BTypePkg);
		}
		if (CTypePkg != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CTypePkg);
		}
		if (ATypeUpPkg != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ATypeUpPkg);
		}
		if (BTypeUpPkg != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BTypeUpPkg);
		}
		if (BGuaranteePkg != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BGuaranteePkg);
		}
		if (ATypeGuaranteeTimes != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ATypeGuaranteeTimes);
		}
		if (GuaranteeTimes != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GuaranteeTimes);
		}
		if (GuaranteeTid != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(GuaranteeTid);
		}
		if (GuaranteeQty != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(GuaranteeQty);
		}
		if (FirstTenShow != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FirstTenShow);
		}
		if (StartTime.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(StartTime);
		}
		if (EndTime.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(EndTime);
		}
		if (Sort != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		if (Icon.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (BannerRes.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(BannerRes);
		}
		if (Image.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Image);
		}
		if (Tag.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Tag);
		}
		if (Voice.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Voice);
		}
		if (TrailId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TrailId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Gacha other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.StorageId != 0)
			{
				StorageId = other.StorageId;
			}
			if (other.GachaType != 0)
			{
				GachaType = other.GachaType;
			}
			if (other.LimitTimes != 0)
			{
				LimitTimes = other.LimitTimes;
			}
			if (other.SpecificTid != 0)
			{
				SpecificTid = other.SpecificTid;
			}
			if (other.SpecificQty != 0)
			{
				SpecificQty = other.SpecificQty;
			}
			if (other.ATypePkg != 0)
			{
				ATypePkg = other.ATypePkg;
			}
			if (other.BTypePkg != 0)
			{
				BTypePkg = other.BTypePkg;
			}
			if (other.CTypePkg != 0)
			{
				CTypePkg = other.CTypePkg;
			}
			if (other.ATypeUpPkg != 0)
			{
				ATypeUpPkg = other.ATypeUpPkg;
			}
			if (other.BTypeUpPkg != 0)
			{
				BTypeUpPkg = other.BTypeUpPkg;
			}
			if (other.BGuaranteePkg != 0)
			{
				BGuaranteePkg = other.BGuaranteePkg;
			}
			if (other.ATypeGuaranteeTimes != 0)
			{
				ATypeGuaranteeTimes = other.ATypeGuaranteeTimes;
			}
			if (other.GuaranteeTimes != 0)
			{
				GuaranteeTimes = other.GuaranteeTimes;
			}
			if (other.GuaranteeTid != 0)
			{
				GuaranteeTid = other.GuaranteeTid;
			}
			if (other.GuaranteeQty != 0)
			{
				GuaranteeQty = other.GuaranteeQty;
			}
			if (other.FirstTenShow != 0)
			{
				FirstTenShow = other.FirstTenShow;
			}
			if (other.StartTime.Length != 0)
			{
				StartTime = other.StartTime;
			}
			if (other.EndTime.Length != 0)
			{
				EndTime = other.EndTime;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.BannerRes.Length != 0)
			{
				BannerRes = other.BannerRes;
			}
			if (other.Image.Length != 0)
			{
				Image = other.Image;
			}
			if (other.Tag.Length != 0)
			{
				Tag = other.Tag;
			}
			if (other.Voice.Length != 0)
			{
				Voice = other.Voice;
			}
			if (other.TrailId != 0)
			{
				TrailId = other.TrailId;
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
			case 18u:
				Name = input.ReadString();
				break;
			case 24u:
				StorageId = input.ReadInt32();
				break;
			case 32u:
				GachaType = input.ReadInt32();
				break;
			case 40u:
				LimitTimes = input.ReadInt32();
				break;
			case 48u:
				SpecificTid = input.ReadInt32();
				break;
			case 56u:
				SpecificQty = input.ReadInt32();
				break;
			case 64u:
				ATypePkg = input.ReadInt32();
				break;
			case 72u:
				BTypePkg = input.ReadInt32();
				break;
			case 80u:
				CTypePkg = input.ReadInt32();
				break;
			case 88u:
				ATypeUpPkg = input.ReadInt32();
				break;
			case 96u:
				BTypeUpPkg = input.ReadInt32();
				break;
			case 104u:
				BGuaranteePkg = input.ReadInt32();
				break;
			case 112u:
				ATypeGuaranteeTimes = input.ReadInt32();
				break;
			case 120u:
				GuaranteeTimes = input.ReadInt32();
				break;
			case 128u:
				GuaranteeTid = input.ReadInt32();
				break;
			case 136u:
				GuaranteeQty = input.ReadInt32();
				break;
			case 144u:
				FirstTenShow = input.ReadInt32();
				break;
			case 154u:
				StartTime = input.ReadString();
				break;
			case 162u:
				EndTime = input.ReadString();
				break;
			case 168u:
				Sort = input.ReadInt32();
				break;
			case 178u:
				Icon = input.ReadString();
				break;
			case 186u:
				BannerRes = input.ReadString();
				break;
			case 194u:
				Image = input.ReadString();
				break;
			case 202u:
				Tag = input.ReadString();
				break;
			case 210u:
				Voice = input.ReadString();
				break;
			case 216u:
				TrailId = input.ReadInt32();
				break;
			}
		}
	}
}
