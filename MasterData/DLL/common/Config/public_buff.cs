using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class public_buff : IMessage<public_buff>, IMessage, IEquatable<public_buff>, IDeepCloneable<public_buff>
{
	private static readonly MessageParser<public_buff> _parser = new MessageParser<public_buff>(() => new public_buff());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int TypeFieldNumber = 2;

	private string type_ = "";

	public const int SubTypeFieldNumber = 3;

	private string subType_ = "";

	public const int MaxLevelFieldNumber = 4;

	private int maxLevel_;

	public const int BuffClassIdFieldNumber = 5;

	private int buffClassId_;

	public const int EffectIdFieldNumber = 6;

	private int effectId_;

	public const int IconFieldNumber = 7;

	private string icon_ = "";

	public const int KeepTimeFieldNumber = 8;

	private int keepTime_;

	public const int KeepTimeGrowFieldNumber = 9;

	private int keepTimeGrow_;

	public const int BuffTicktimeFieldNumber = 10;

	private int buffTicktime_;

	public const int DelaytimeFieldNumber = 11;

	private int delaytime_;

	public const int BuffparamBaseFieldNumber = 12;

	private static readonly FieldCodec<int> _repeated_buffparamBase_codec = FieldCodec.ForInt32(98u);

	private readonly RepeatedField<int> buffparamBase_ = new RepeatedField<int>();

	public const int BuffparamFactorFieldNumber = 13;

	private static readonly FieldCodec<int> _repeated_buffparamFactor_codec = FieldCodec.ForInt32(106u);

	private readonly RepeatedField<int> buffparamFactor_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<public_buff> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[88];

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
	public string Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string SubType
	{
		get
		{
			return subType_;
		}
		set
		{
			subType_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int MaxLevel
	{
		get
		{
			return maxLevel_;
		}
		set
		{
			maxLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BuffClassId
	{
		get
		{
			return buffClassId_;
		}
		set
		{
			buffClassId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EffectId
	{
		get
		{
			return effectId_;
		}
		set
		{
			effectId_ = value;
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
	public int KeepTime
	{
		get
		{
			return keepTime_;
		}
		set
		{
			keepTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int KeepTimeGrow
	{
		get
		{
			return keepTimeGrow_;
		}
		set
		{
			keepTimeGrow_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BuffTicktime
	{
		get
		{
			return buffTicktime_;
		}
		set
		{
			buffTicktime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Delaytime
	{
		get
		{
			return delaytime_;
		}
		set
		{
			delaytime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> BuffparamBase => buffparamBase_;

	[DebuggerNonUserCode]
	public RepeatedField<int> BuffparamFactor => buffparamFactor_;

	[DebuggerNonUserCode]
	public public_buff()
	{
	}

	[DebuggerNonUserCode]
	public public_buff(public_buff other)
		: this()
	{
		iD_ = other.iD_;
		type_ = other.type_;
		subType_ = other.subType_;
		maxLevel_ = other.maxLevel_;
		buffClassId_ = other.buffClassId_;
		effectId_ = other.effectId_;
		icon_ = other.icon_;
		keepTime_ = other.keepTime_;
		keepTimeGrow_ = other.keepTimeGrow_;
		buffTicktime_ = other.buffTicktime_;
		delaytime_ = other.delaytime_;
		buffparamBase_ = other.buffparamBase_.Clone();
		buffparamFactor_ = other.buffparamFactor_.Clone();
	}

	[DebuggerNonUserCode]
	public public_buff Clone()
	{
		return new public_buff(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as public_buff);
	}

	[DebuggerNonUserCode]
	public bool Equals(public_buff other)
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
		if (Type != other.Type)
		{
			return false;
		}
		if (SubType != other.SubType)
		{
			return false;
		}
		if (MaxLevel != other.MaxLevel)
		{
			return false;
		}
		if (BuffClassId != other.BuffClassId)
		{
			return false;
		}
		if (EffectId != other.EffectId)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (KeepTime != other.KeepTime)
		{
			return false;
		}
		if (KeepTimeGrow != other.KeepTimeGrow)
		{
			return false;
		}
		if (BuffTicktime != other.BuffTicktime)
		{
			return false;
		}
		if (Delaytime != other.Delaytime)
		{
			return false;
		}
		if (!buffparamBase_.Equals(other.buffparamBase_))
		{
			return false;
		}
		if (!buffparamFactor_.Equals(other.buffparamFactor_))
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
		if (Type.Length != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (SubType.Length != 0)
		{
			num ^= SubType.GetHashCode();
		}
		if (MaxLevel != 0)
		{
			num ^= MaxLevel.GetHashCode();
		}
		if (BuffClassId != 0)
		{
			num ^= BuffClassId.GetHashCode();
		}
		if (EffectId != 0)
		{
			num ^= EffectId.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (KeepTime != 0)
		{
			num ^= KeepTime.GetHashCode();
		}
		if (KeepTimeGrow != 0)
		{
			num ^= KeepTimeGrow.GetHashCode();
		}
		if (BuffTicktime != 0)
		{
			num ^= BuffTicktime.GetHashCode();
		}
		if (Delaytime != 0)
		{
			num ^= Delaytime.GetHashCode();
		}
		num ^= buffparamBase_.GetHashCode();
		return num ^ buffparamFactor_.GetHashCode();
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
		if (Type.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Type);
		}
		if (SubType.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(SubType);
		}
		if (MaxLevel != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(MaxLevel);
		}
		if (BuffClassId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(BuffClassId);
		}
		if (EffectId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(EffectId);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Icon);
		}
		if (KeepTime != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(KeepTime);
		}
		if (KeepTimeGrow != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(KeepTimeGrow);
		}
		if (BuffTicktime != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(BuffTicktime);
		}
		if (Delaytime != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(Delaytime);
		}
		buffparamBase_.WriteTo(output, _repeated_buffparamBase_codec);
		buffparamFactor_.WriteTo(output, _repeated_buffparamFactor_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (Type.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Type);
		}
		if (SubType.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SubType);
		}
		if (MaxLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxLevel);
		}
		if (BuffClassId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BuffClassId);
		}
		if (EffectId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EffectId);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (KeepTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(KeepTime);
		}
		if (KeepTimeGrow != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(KeepTimeGrow);
		}
		if (BuffTicktime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BuffTicktime);
		}
		if (Delaytime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Delaytime);
		}
		num += buffparamBase_.CalculateSize(_repeated_buffparamBase_codec);
		return num + buffparamFactor_.CalculateSize(_repeated_buffparamFactor_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(public_buff other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Type.Length != 0)
			{
				Type = other.Type;
			}
			if (other.SubType.Length != 0)
			{
				SubType = other.SubType;
			}
			if (other.MaxLevel != 0)
			{
				MaxLevel = other.MaxLevel;
			}
			if (other.BuffClassId != 0)
			{
				BuffClassId = other.BuffClassId;
			}
			if (other.EffectId != 0)
			{
				EffectId = other.EffectId;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.KeepTime != 0)
			{
				KeepTime = other.KeepTime;
			}
			if (other.KeepTimeGrow != 0)
			{
				KeepTimeGrow = other.KeepTimeGrow;
			}
			if (other.BuffTicktime != 0)
			{
				BuffTicktime = other.BuffTicktime;
			}
			if (other.Delaytime != 0)
			{
				Delaytime = other.Delaytime;
			}
			buffparamBase_.Add(other.buffparamBase_);
			buffparamFactor_.Add(other.buffparamFactor_);
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
			case 18u:
				Type = input.ReadString();
				break;
			case 26u:
				SubType = input.ReadString();
				break;
			case 32u:
				MaxLevel = input.ReadInt32();
				break;
			case 40u:
				BuffClassId = input.ReadInt32();
				break;
			case 48u:
				EffectId = input.ReadInt32();
				break;
			case 58u:
				Icon = input.ReadString();
				break;
			case 64u:
				KeepTime = input.ReadInt32();
				break;
			case 72u:
				KeepTimeGrow = input.ReadInt32();
				break;
			case 80u:
				BuffTicktime = input.ReadInt32();
				break;
			case 88u:
				Delaytime = input.ReadInt32();
				break;
			case 96u:
			case 98u:
				buffparamBase_.AddEntriesFrom(input, _repeated_buffparamBase_codec);
				break;
			case 104u:
			case 106u:
				buffparamFactor_.AddEntriesFrom(input, _repeated_buffparamFactor_codec);
				break;
			}
		}
	}
}
