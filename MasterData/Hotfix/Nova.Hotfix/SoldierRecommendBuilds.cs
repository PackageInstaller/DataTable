using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierRecommendBuilds : IMessage<SoldierRecommendBuilds>, IMessage, IEquatable<SoldierRecommendBuilds>, IDeepCloneable<SoldierRecommendBuilds>
{
	private static readonly MessageParser<SoldierRecommendBuilds> _parser = new MessageParser<SoldierRecommendBuilds>(() => new SoldierRecommendBuilds());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TitleFieldNumber = 2;

	private string title_ = "";

	public const int CharacterIdFieldNumber = 3;

	private int characterId_;

	public const int Front1FieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_front1_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> front1_ = new RepeatedField<int>();

	public const int Front2FieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_front2_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> front2_ = new RepeatedField<int>();

	public const int Front3FieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_front3_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> front3_ = new RepeatedField<int>();

	public const int BackFieldNumber = 7;

	private string back_ = "";

	public const int DescFieldNumber = 8;

	private string desc_ = "";

	public const int BossTemplateFieldNumber = 9;

	private int bossTemplate_;

	public const int StrategyCardFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_strategyCard_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> strategyCard_ = new RepeatedField<int>();

	public const int PartnerAddFieldNumber = 11;

	private string partnerAdd_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<SoldierRecommendBuilds> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(788);

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
	public string Title
	{
		get
		{
			return title_;
		}
		set
		{
			title_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int CharacterId
	{
		get
		{
			return characterId_;
		}
		set
		{
			characterId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Front1 => front1_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Front2 => front2_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Front3 => front3_;

	[DebuggerNonUserCode]
	public string Back
	{
		get
		{
			return back_;
		}
		set
		{
			back_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int BossTemplate
	{
		get
		{
			return bossTemplate_;
		}
		set
		{
			bossTemplate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> StrategyCard => strategyCard_;

	[DebuggerNonUserCode]
	public string PartnerAdd
	{
		get
		{
			return partnerAdd_;
		}
		set
		{
			partnerAdd_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public SoldierRecommendBuilds()
	{
	}

	[DebuggerNonUserCode]
	public SoldierRecommendBuilds(SoldierRecommendBuilds other)
		: this()
	{
		id_ = other.id_;
		title_ = other.title_;
		characterId_ = other.characterId_;
		front1_ = other.front1_.Clone();
		front2_ = other.front2_.Clone();
		front3_ = other.front3_.Clone();
		back_ = other.back_;
		desc_ = other.desc_;
		bossTemplate_ = other.bossTemplate_;
		strategyCard_ = other.strategyCard_.Clone();
		partnerAdd_ = other.partnerAdd_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierRecommendBuilds Clone()
	{
		return new SoldierRecommendBuilds(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierRecommendBuilds);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierRecommendBuilds other)
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
		if (Title != other.Title)
		{
			return false;
		}
		if (CharacterId != other.CharacterId)
		{
			return false;
		}
		if (!front1_.Equals(other.front1_))
		{
			return false;
		}
		if (!front2_.Equals(other.front2_))
		{
			return false;
		}
		if (!front3_.Equals(other.front3_))
		{
			return false;
		}
		if (Back != other.Back)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (BossTemplate != other.BossTemplate)
		{
			return false;
		}
		if (!strategyCard_.Equals(other.strategyCard_))
		{
			return false;
		}
		if (PartnerAdd != other.PartnerAdd)
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
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (CharacterId != 0)
		{
			num ^= CharacterId.GetHashCode();
		}
		num ^= front1_.GetHashCode();
		num ^= front2_.GetHashCode();
		num ^= front3_.GetHashCode();
		if (Back.Length != 0)
		{
			num ^= Back.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (BossTemplate != 0)
		{
			num ^= BossTemplate.GetHashCode();
		}
		num ^= strategyCard_.GetHashCode();
		if (PartnerAdd.Length != 0)
		{
			num ^= PartnerAdd.GetHashCode();
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
		if (Title.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Title);
		}
		if (CharacterId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CharacterId);
		}
		front1_.WriteTo(output, _repeated_front1_codec);
		front2_.WriteTo(output, _repeated_front2_codec);
		front3_.WriteTo(output, _repeated_front3_codec);
		if (Back.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Back);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Desc);
		}
		if (BossTemplate != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(BossTemplate);
		}
		strategyCard_.WriteTo(output, _repeated_strategyCard_codec);
		if (PartnerAdd.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(PartnerAdd);
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
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (CharacterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharacterId);
		}
		num += front1_.CalculateSize(_repeated_front1_codec);
		num += front2_.CalculateSize(_repeated_front2_codec);
		num += front3_.CalculateSize(_repeated_front3_codec);
		if (Back.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Back);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (BossTemplate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BossTemplate);
		}
		num += strategyCard_.CalculateSize(_repeated_strategyCard_codec);
		if (PartnerAdd.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PartnerAdd);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierRecommendBuilds other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.CharacterId != 0)
			{
				CharacterId = other.CharacterId;
			}
			front1_.Add(other.front1_);
			front2_.Add(other.front2_);
			front3_.Add(other.front3_);
			if (other.Back.Length != 0)
			{
				Back = other.Back;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.BossTemplate != 0)
			{
				BossTemplate = other.BossTemplate;
			}
			strategyCard_.Add(other.strategyCard_);
			if (other.PartnerAdd.Length != 0)
			{
				PartnerAdd = other.PartnerAdd;
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
				Title = input.ReadString();
				break;
			case 24u:
				CharacterId = input.ReadInt32();
				break;
			case 32u:
			case 34u:
				front1_.AddEntriesFrom(input, _repeated_front1_codec);
				break;
			case 40u:
			case 42u:
				front2_.AddEntriesFrom(input, _repeated_front2_codec);
				break;
			case 48u:
			case 50u:
				front3_.AddEntriesFrom(input, _repeated_front3_codec);
				break;
			case 58u:
				Back = input.ReadString();
				break;
			case 66u:
				Desc = input.ReadString();
				break;
			case 72u:
				BossTemplate = input.ReadInt32();
				break;
			case 80u:
			case 82u:
				strategyCard_.AddEntriesFrom(input, _repeated_strategyCard_codec);
				break;
			case 90u:
				PartnerAdd = input.ReadString();
				break;
			}
		}
	}
}
