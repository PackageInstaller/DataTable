using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierPartner : IMessage<SoldierPartner>, IMessage, IEquatable<SoldierPartner>, IDeepCloneable<SoldierPartner>
{
	private static readonly MessageParser<SoldierPartner> _parser = new MessageParser<SoldierPartner>(() => new SoldierPartner());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int PartnerTypeFieldNumber = 2;

	private int partnerType_;

	public const int NameFieldNumber = 3;

	private string name_ = "";

	public const int PartnerLevelQualityFieldNumber = 4;

	private int partnerLevelQuality_;

	public const int DescFieldNumber = 5;

	private string desc_ = "";

	public const int LevelFieldNumber = 6;

	private int level_;

	public const int NumFieldNumber = 7;

	private int num_;

	public const int SoldierPartnerNumTypeFieldNumber = 8;

	private int soldierPartnerNumType_;

	public const int ServerEffectFieldNumber = 9;

	private int serverEffect_;

	public const int ClientEffectFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_clientEffect_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> clientEffect_ = new RepeatedField<int>();

	public const int Parameter1FieldNumber = 11;

	private float parameter1_;

	public const int Parameter2FieldNumber = 12;

	private float parameter2_;

	public const int Parameter3FieldNumber = 13;

	private float parameter3_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierPartner> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(776);

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
	public int PartnerType
	{
		get
		{
			return partnerType_;
		}
		set
		{
			partnerType_ = value;
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
	public int PartnerLevelQuality
	{
		get
		{
			return partnerLevelQuality_;
		}
		set
		{
			partnerLevelQuality_ = value;
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
	public int Level
	{
		get
		{
			return level_;
		}
		set
		{
			level_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Num
	{
		get
		{
			return num_;
		}
		set
		{
			num_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SoldierPartnerNumType
	{
		get
		{
			return soldierPartnerNumType_;
		}
		set
		{
			soldierPartnerNumType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ServerEffect
	{
		get
		{
			return serverEffect_;
		}
		set
		{
			serverEffect_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> ClientEffect => clientEffect_;

	[DebuggerNonUserCode]
	public float Parameter1
	{
		get
		{
			return parameter1_;
		}
		set
		{
			parameter1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float Parameter2
	{
		get
		{
			return parameter2_;
		}
		set
		{
			parameter2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float Parameter3
	{
		get
		{
			return parameter3_;
		}
		set
		{
			parameter3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierPartner()
	{
	}

	[DebuggerNonUserCode]
	public SoldierPartner(SoldierPartner other)
		: this()
	{
		id_ = other.id_;
		partnerType_ = other.partnerType_;
		name_ = other.name_;
		partnerLevelQuality_ = other.partnerLevelQuality_;
		desc_ = other.desc_;
		level_ = other.level_;
		num_ = other.num_;
		soldierPartnerNumType_ = other.soldierPartnerNumType_;
		serverEffect_ = other.serverEffect_;
		clientEffect_ = other.clientEffect_.Clone();
		parameter1_ = other.parameter1_;
		parameter2_ = other.parameter2_;
		parameter3_ = other.parameter3_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierPartner Clone()
	{
		return new SoldierPartner(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierPartner);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierPartner other)
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
		if (PartnerType != other.PartnerType)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (PartnerLevelQuality != other.PartnerLevelQuality)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Level != other.Level)
		{
			return false;
		}
		if (Num != other.Num)
		{
			return false;
		}
		if (SoldierPartnerNumType != other.SoldierPartnerNumType)
		{
			return false;
		}
		if (ServerEffect != other.ServerEffect)
		{
			return false;
		}
		if (!clientEffect_.Equals(other.clientEffect_))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(Parameter1, other.Parameter1))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(Parameter2, other.Parameter2))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(Parameter3, other.Parameter3))
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
		if (PartnerType != 0)
		{
			num ^= PartnerType.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (PartnerLevelQuality != 0)
		{
			num ^= PartnerLevelQuality.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (Num != 0)
		{
			num ^= Num.GetHashCode();
		}
		if (SoldierPartnerNumType != 0)
		{
			num ^= SoldierPartnerNumType.GetHashCode();
		}
		if (ServerEffect != 0)
		{
			num ^= ServerEffect.GetHashCode();
		}
		num ^= clientEffect_.GetHashCode();
		if (Parameter1 != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(Parameter1);
		}
		if (Parameter2 != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(Parameter2);
		}
		if (Parameter3 != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(Parameter3);
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
		if (PartnerType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(PartnerType);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Name);
		}
		if (PartnerLevelQuality != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(PartnerLevelQuality);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Desc);
		}
		if (Level != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Level);
		}
		if (Num != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Num);
		}
		if (SoldierPartnerNumType != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(SoldierPartnerNumType);
		}
		if (ServerEffect != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(ServerEffect);
		}
		clientEffect_.WriteTo(output, _repeated_clientEffect_codec);
		if (Parameter1 != 0f)
		{
			output.WriteRawTag(93);
			output.WriteFloat(Parameter1);
		}
		if (Parameter2 != 0f)
		{
			output.WriteRawTag(101);
			output.WriteFloat(Parameter2);
		}
		if (Parameter3 != 0f)
		{
			output.WriteRawTag(109);
			output.WriteFloat(Parameter3);
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
		if (PartnerType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PartnerType);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (PartnerLevelQuality != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PartnerLevelQuality);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (Num != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Num);
		}
		if (SoldierPartnerNumType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SoldierPartnerNumType);
		}
		if (ServerEffect != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ServerEffect);
		}
		num += clientEffect_.CalculateSize(_repeated_clientEffect_codec);
		if (Parameter1 != 0f)
		{
			num += 5;
		}
		if (Parameter2 != 0f)
		{
			num += 5;
		}
		if (Parameter3 != 0f)
		{
			num += 5;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierPartner other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.PartnerType != 0)
			{
				PartnerType = other.PartnerType;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.PartnerLevelQuality != 0)
			{
				PartnerLevelQuality = other.PartnerLevelQuality;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.Num != 0)
			{
				Num = other.Num;
			}
			if (other.SoldierPartnerNumType != 0)
			{
				SoldierPartnerNumType = other.SoldierPartnerNumType;
			}
			if (other.ServerEffect != 0)
			{
				ServerEffect = other.ServerEffect;
			}
			clientEffect_.Add(other.clientEffect_);
			if (other.Parameter1 != 0f)
			{
				Parameter1 = other.Parameter1;
			}
			if (other.Parameter2 != 0f)
			{
				Parameter2 = other.Parameter2;
			}
			if (other.Parameter3 != 0f)
			{
				Parameter3 = other.Parameter3;
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
				PartnerType = input.ReadInt32();
				break;
			case 26u:
				Name = input.ReadString();
				break;
			case 32u:
				PartnerLevelQuality = input.ReadInt32();
				break;
			case 42u:
				Desc = input.ReadString();
				break;
			case 48u:
				Level = input.ReadInt32();
				break;
			case 56u:
				Num = input.ReadInt32();
				break;
			case 64u:
				SoldierPartnerNumType = input.ReadInt32();
				break;
			case 72u:
				ServerEffect = input.ReadInt32();
				break;
			case 80u:
			case 82u:
				clientEffect_.AddEntriesFrom(input, _repeated_clientEffect_codec);
				break;
			case 93u:
				Parameter1 = input.ReadFloat();
				break;
			case 101u:
				Parameter2 = input.ReadFloat();
				break;
			case 109u:
				Parameter3 = input.ReadFloat();
				break;
			}
		}
	}
}
