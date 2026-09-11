using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class MonsterSpawnerConfig : IMessage<MonsterSpawnerConfig>, IMessage, IEquatable<MonsterSpawnerConfig>, IDeepCloneable<MonsterSpawnerConfig>
{
	private static readonly MessageParser<MonsterSpawnerConfig> _parser = new MessageParser<MonsterSpawnerConfig>(() => new MonsterSpawnerConfig());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int ConfigIdFieldNumber = 2;

	private int configId_;

	public const int PositionFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_position_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> position_ = new RepeatedField<int>();

	public const int ForwardFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_forward_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> forward_ = new RepeatedField<int>();

	public const int TypeFieldNumber = 5;

	private int type_;

	public const int PlayIdFieldNumber = 6;

	private int playId_;

	public const int BaseAttributeFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_baseAttribute_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> baseAttribute_ = new RepeatedField<int>();

	public const int BreakPercentFieldNumber = 8;

	private int breakPercent_;

	public const int InitIdFieldNumber = 9;

	private int initId_;

	public const int AttributeIdFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_attributeId_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> attributeId_ = new RepeatedField<int>();

	public const int AttributeValueFieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_attributeValue_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> attributeValue_ = new RepeatedField<int>();

	public const int SkinIdFieldNumber = 12;

	private int skinId_;

	[DebuggerNonUserCode]
	public static MessageParser<MonsterSpawnerConfig> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[41];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int ID
	{
		get
		{
			return iD_;
		}
		set
		{
			iD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ConfigId
	{
		get
		{
			return configId_;
		}
		set
		{
			configId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Position => position_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Forward => forward_;

	[DebuggerNonUserCode]
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PlayId
	{
		get
		{
			return playId_;
		}
		set
		{
			playId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> BaseAttribute => baseAttribute_;

	[DebuggerNonUserCode]
	public int BreakPercent
	{
		get
		{
			return breakPercent_;
		}
		set
		{
			breakPercent_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int InitId
	{
		get
		{
			return initId_;
		}
		set
		{
			initId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> AttributeId => attributeId_;

	[DebuggerNonUserCode]
	public RepeatedField<int> AttributeValue => attributeValue_;

	[DebuggerNonUserCode]
	public int SkinId
	{
		get
		{
			return skinId_;
		}
		set
		{
			skinId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public MonsterSpawnerConfig()
	{
	}

	[DebuggerNonUserCode]
	public MonsterSpawnerConfig(MonsterSpawnerConfig other)
		: this()
	{
		iD_ = other.iD_;
		configId_ = other.configId_;
		position_ = other.position_.Clone();
		forward_ = other.forward_.Clone();
		type_ = other.type_;
		playId_ = other.playId_;
		baseAttribute_ = other.baseAttribute_.Clone();
		breakPercent_ = other.breakPercent_;
		initId_ = other.initId_;
		attributeId_ = other.attributeId_.Clone();
		attributeValue_ = other.attributeValue_.Clone();
		skinId_ = other.skinId_;
	}

	[DebuggerNonUserCode]
	public MonsterSpawnerConfig Clone()
	{
		return new MonsterSpawnerConfig(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MonsterSpawnerConfig);
	}

	[DebuggerNonUserCode]
	public bool Equals(MonsterSpawnerConfig other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ID != other.ID)
		{
			return false;
		}
		if (ConfigId != other.ConfigId)
		{
			return false;
		}
		if (!position_.Equals(other.position_))
		{
			return false;
		}
		if (!forward_.Equals(other.forward_))
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (PlayId != other.PlayId)
		{
			return false;
		}
		if (!baseAttribute_.Equals(other.baseAttribute_))
		{
			return false;
		}
		if (BreakPercent != other.BreakPercent)
		{
			return false;
		}
		if (InitId != other.InitId)
		{
			return false;
		}
		if (!attributeId_.Equals(other.attributeId_))
		{
			return false;
		}
		if (!attributeValue_.Equals(other.attributeValue_))
		{
			return false;
		}
		if (SkinId != other.SkinId)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ID != 0)
		{
			num ^= ID.GetHashCode();
		}
		if (ConfigId != 0)
		{
			num ^= ConfigId.GetHashCode();
		}
		num ^= position_.GetHashCode();
		num ^= forward_.GetHashCode();
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (PlayId != 0)
		{
			num ^= PlayId.GetHashCode();
		}
		num ^= baseAttribute_.GetHashCode();
		if (BreakPercent != 0)
		{
			num ^= BreakPercent.GetHashCode();
		}
		if (InitId != 0)
		{
			num ^= InitId.GetHashCode();
		}
		num ^= attributeId_.GetHashCode();
		num ^= attributeValue_.GetHashCode();
		if (SkinId != 0)
		{
			num ^= SkinId.GetHashCode();
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
		if (ID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ID);
		}
		if (ConfigId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ConfigId);
		}
		position_.WriteTo(output, _repeated_position_codec);
		forward_.WriteTo(output, _repeated_forward_codec);
		if (Type != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Type);
		}
		if (PlayId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(PlayId);
		}
		baseAttribute_.WriteTo(output, _repeated_baseAttribute_codec);
		if (BreakPercent != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(BreakPercent);
		}
		if (InitId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(InitId);
		}
		attributeId_.WriteTo(output, _repeated_attributeId_codec);
		attributeValue_.WriteTo(output, _repeated_attributeValue_codec);
		if (SkinId != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(SkinId);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (ConfigId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ConfigId);
		}
		num += position_.CalculateSize(_repeated_position_codec);
		num += forward_.CalculateSize(_repeated_forward_codec);
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (PlayId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PlayId);
		}
		num += baseAttribute_.CalculateSize(_repeated_baseAttribute_codec);
		if (BreakPercent != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BreakPercent);
		}
		if (InitId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(InitId);
		}
		num += attributeId_.CalculateSize(_repeated_attributeId_codec);
		num += attributeValue_.CalculateSize(_repeated_attributeValue_codec);
		if (SkinId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkinId);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MonsterSpawnerConfig other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.ConfigId != 0)
			{
				ConfigId = other.ConfigId;
			}
			position_.Add(other.position_);
			forward_.Add(other.forward_);
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.PlayId != 0)
			{
				PlayId = other.PlayId;
			}
			baseAttribute_.Add(other.baseAttribute_);
			if (other.BreakPercent != 0)
			{
				BreakPercent = other.BreakPercent;
			}
			if (other.InitId != 0)
			{
				InitId = other.InitId;
			}
			attributeId_.Add(other.attributeId_);
			attributeValue_.Add(other.attributeValue_);
			if (other.SkinId != 0)
			{
				SkinId = other.SkinId;
			}
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
				input.SkipLastField();
				break;
			case 8u:
				ID = input.ReadInt32();
				break;
			case 16u:
				ConfigId = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				position_.AddEntriesFrom(input, _repeated_position_codec);
				break;
			case 32u:
			case 34u:
				forward_.AddEntriesFrom(input, _repeated_forward_codec);
				break;
			case 40u:
				Type = input.ReadInt32();
				break;
			case 48u:
				PlayId = input.ReadInt32();
				break;
			case 56u:
			case 58u:
				baseAttribute_.AddEntriesFrom(input, _repeated_baseAttribute_codec);
				break;
			case 64u:
				BreakPercent = input.ReadInt32();
				break;
			case 72u:
				InitId = input.ReadInt32();
				break;
			case 80u:
			case 82u:
				attributeId_.AddEntriesFrom(input, _repeated_attributeId_codec);
				break;
			case 88u:
			case 90u:
				attributeValue_.AddEntriesFrom(input, _repeated_attributeValue_codec);
				break;
			case 96u:
				SkinId = input.ReadInt32();
				break;
			}
		}
	}
}
