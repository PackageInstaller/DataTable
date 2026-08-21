using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class UniqueSkill : IMessage<UniqueSkill>, IMessage, IEquatable<UniqueSkill>, IDeepCloneable<UniqueSkill>
{
	private static readonly MessageParser<UniqueSkill> _parser = new MessageParser<UniqueSkill>(() => new UniqueSkill());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int UpperLimitFieldNumber = 2;

	private int upperLimit_;

	public const int BaseAddValueFieldNumber = 3;

	private int baseAddValue_;

	public const int TickFieldNumber = 4;

	private int tick_;

	public const int AbilityIdFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_abilityId_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> abilityId_ = new RepeatedField<int>();

	public const int ProjectilesFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_projectiles_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> projectiles_ = new RepeatedField<int>();

	public const int AdditionalValueFieldNumber = 7;

	private int additionalValue_;

	public const int AiDistanceFieldNumber = 8;

	private int aiDistance_;

	public const int TeammateQTECameraDurationFieldNumber = 9;

	private int teammateQTECameraDuration_;

	[DebuggerNonUserCode]
	public static MessageParser<UniqueSkill> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[69];

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
	public int UpperLimit
	{
		get
		{
			return upperLimit_;
		}
		set
		{
			upperLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BaseAddValue
	{
		get
		{
			return baseAddValue_;
		}
		set
		{
			baseAddValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Tick
	{
		get
		{
			return tick_;
		}
		set
		{
			tick_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> AbilityId => abilityId_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Projectiles => projectiles_;

	[DebuggerNonUserCode]
	public int AdditionalValue
	{
		get
		{
			return additionalValue_;
		}
		set
		{
			additionalValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AiDistance
	{
		get
		{
			return aiDistance_;
		}
		set
		{
			aiDistance_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TeammateQTECameraDuration
	{
		get
		{
			return teammateQTECameraDuration_;
		}
		set
		{
			teammateQTECameraDuration_ = value;
		}
	}

	[DebuggerNonUserCode]
	public UniqueSkill()
	{
	}

	[DebuggerNonUserCode]
	public UniqueSkill(UniqueSkill other)
		: this()
	{
		iD_ = other.iD_;
		upperLimit_ = other.upperLimit_;
		baseAddValue_ = other.baseAddValue_;
		tick_ = other.tick_;
		abilityId_ = other.abilityId_.Clone();
		projectiles_ = other.projectiles_.Clone();
		additionalValue_ = other.additionalValue_;
		aiDistance_ = other.aiDistance_;
		teammateQTECameraDuration_ = other.teammateQTECameraDuration_;
	}

	[DebuggerNonUserCode]
	public UniqueSkill Clone()
	{
		return new UniqueSkill(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as UniqueSkill);
	}

	[DebuggerNonUserCode]
	public bool Equals(UniqueSkill other)
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
		if (UpperLimit != other.UpperLimit)
		{
			return false;
		}
		if (BaseAddValue != other.BaseAddValue)
		{
			return false;
		}
		if (Tick != other.Tick)
		{
			return false;
		}
		if (!abilityId_.Equals(other.abilityId_))
		{
			return false;
		}
		if (!projectiles_.Equals(other.projectiles_))
		{
			return false;
		}
		if (AdditionalValue != other.AdditionalValue)
		{
			return false;
		}
		if (AiDistance != other.AiDistance)
		{
			return false;
		}
		if (TeammateQTECameraDuration != other.TeammateQTECameraDuration)
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
		if (UpperLimit != 0)
		{
			num ^= UpperLimit.GetHashCode();
		}
		if (BaseAddValue != 0)
		{
			num ^= BaseAddValue.GetHashCode();
		}
		if (Tick != 0)
		{
			num ^= Tick.GetHashCode();
		}
		num ^= abilityId_.GetHashCode();
		num ^= projectiles_.GetHashCode();
		if (AdditionalValue != 0)
		{
			num ^= AdditionalValue.GetHashCode();
		}
		if (AiDistance != 0)
		{
			num ^= AiDistance.GetHashCode();
		}
		if (TeammateQTECameraDuration != 0)
		{
			num ^= TeammateQTECameraDuration.GetHashCode();
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
		if (UpperLimit != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(UpperLimit);
		}
		if (BaseAddValue != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(BaseAddValue);
		}
		if (Tick != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Tick);
		}
		abilityId_.WriteTo(output, _repeated_abilityId_codec);
		projectiles_.WriteTo(output, _repeated_projectiles_codec);
		if (AdditionalValue != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(AdditionalValue);
		}
		if (AiDistance != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(AiDistance);
		}
		if (TeammateQTECameraDuration != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(TeammateQTECameraDuration);
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
		if (UpperLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UpperLimit);
		}
		if (BaseAddValue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BaseAddValue);
		}
		if (Tick != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tick);
		}
		num += abilityId_.CalculateSize(_repeated_abilityId_codec);
		num += projectiles_.CalculateSize(_repeated_projectiles_codec);
		if (AdditionalValue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AdditionalValue);
		}
		if (AiDistance != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AiDistance);
		}
		if (TeammateQTECameraDuration != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TeammateQTECameraDuration);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(UniqueSkill other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.UpperLimit != 0)
			{
				UpperLimit = other.UpperLimit;
			}
			if (other.BaseAddValue != 0)
			{
				BaseAddValue = other.BaseAddValue;
			}
			if (other.Tick != 0)
			{
				Tick = other.Tick;
			}
			abilityId_.Add(other.abilityId_);
			projectiles_.Add(other.projectiles_);
			if (other.AdditionalValue != 0)
			{
				AdditionalValue = other.AdditionalValue;
			}
			if (other.AiDistance != 0)
			{
				AiDistance = other.AiDistance;
			}
			if (other.TeammateQTECameraDuration != 0)
			{
				TeammateQTECameraDuration = other.TeammateQTECameraDuration;
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
				UpperLimit = input.ReadInt32();
				break;
			case 24u:
				BaseAddValue = input.ReadInt32();
				break;
			case 32u:
				Tick = input.ReadInt32();
				break;
			case 40u:
			case 42u:
				abilityId_.AddEntriesFrom(input, _repeated_abilityId_codec);
				break;
			case 48u:
			case 50u:
				projectiles_.AddEntriesFrom(input, _repeated_projectiles_codec);
				break;
			case 56u:
				AdditionalValue = input.ReadInt32();
				break;
			case 64u:
				AiDistance = input.ReadInt32();
				break;
			case 72u:
				TeammateQTECameraDuration = input.ReadInt32();
				break;
			}
		}
	}
}
