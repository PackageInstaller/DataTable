using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class AbilityConfig : IMessage<AbilityConfig>, IMessage, IEquatable<AbilityConfig>, IDeepCloneable<AbilityConfig>
{
	private static readonly MessageParser<AbilityConfig> _parser = new MessageParser<AbilityConfig>(() => new AbilityConfig());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int AbilityClassFieldNumber = 2;

	private int abilityClass_;

	public const int OriginAbilityFieldNumber = 3;

	private int originAbility_;

	public const int SyncCDSkillIDFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_syncCDSkillID_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> syncCDSkillID_ = new RepeatedField<int>();

	public const int IsExtensionalSkillFieldNumber = 5;

	private bool isExtensionalSkill_;

	public const int CanBeParryFieldNumber = 6;

	private bool canBeParry_;

	[DebuggerNonUserCode]
	public static MessageParser<AbilityConfig> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[5];

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
	public int AbilityClass
	{
		get
		{
			return abilityClass_;
		}
		set
		{
			abilityClass_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int OriginAbility
	{
		get
		{
			return originAbility_;
		}
		set
		{
			originAbility_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> SyncCDSkillID => syncCDSkillID_;

	[DebuggerNonUserCode]
	public bool IsExtensionalSkill
	{
		get
		{
			return isExtensionalSkill_;
		}
		set
		{
			isExtensionalSkill_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool CanBeParry
	{
		get
		{
			return canBeParry_;
		}
		set
		{
			canBeParry_ = value;
		}
	}

	[DebuggerNonUserCode]
	public AbilityConfig()
	{
	}

	[DebuggerNonUserCode]
	public AbilityConfig(AbilityConfig other)
		: this()
	{
		iD_ = other.iD_;
		abilityClass_ = other.abilityClass_;
		originAbility_ = other.originAbility_;
		syncCDSkillID_ = other.syncCDSkillID_.Clone();
		isExtensionalSkill_ = other.isExtensionalSkill_;
		canBeParry_ = other.canBeParry_;
	}

	[DebuggerNonUserCode]
	public AbilityConfig Clone()
	{
		return new AbilityConfig(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as AbilityConfig);
	}

	[DebuggerNonUserCode]
	public bool Equals(AbilityConfig other)
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
		if (AbilityClass != other.AbilityClass)
		{
			return false;
		}
		if (OriginAbility != other.OriginAbility)
		{
			return false;
		}
		if (!syncCDSkillID_.Equals(other.syncCDSkillID_))
		{
			return false;
		}
		if (IsExtensionalSkill != other.IsExtensionalSkill)
		{
			return false;
		}
		if (CanBeParry != other.CanBeParry)
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
		if (AbilityClass != 0)
		{
			num ^= AbilityClass.GetHashCode();
		}
		if (OriginAbility != 0)
		{
			num ^= OriginAbility.GetHashCode();
		}
		num ^= syncCDSkillID_.GetHashCode();
		if (IsExtensionalSkill)
		{
			num ^= IsExtensionalSkill.GetHashCode();
		}
		if (CanBeParry)
		{
			num ^= CanBeParry.GetHashCode();
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
		if (AbilityClass != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(AbilityClass);
		}
		if (OriginAbility != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(OriginAbility);
		}
		syncCDSkillID_.WriteTo(output, _repeated_syncCDSkillID_codec);
		if (IsExtensionalSkill)
		{
			output.WriteRawTag(40);
			output.WriteBool(IsExtensionalSkill);
		}
		if (CanBeParry)
		{
			output.WriteRawTag(48);
			output.WriteBool(CanBeParry);
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
		if (AbilityClass != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AbilityClass);
		}
		if (OriginAbility != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OriginAbility);
		}
		num += syncCDSkillID_.CalculateSize(_repeated_syncCDSkillID_codec);
		if (IsExtensionalSkill)
		{
			num += 2;
		}
		if (CanBeParry)
		{
			num += 2;
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(AbilityConfig other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.AbilityClass != 0)
			{
				AbilityClass = other.AbilityClass;
			}
			if (other.OriginAbility != 0)
			{
				OriginAbility = other.OriginAbility;
			}
			syncCDSkillID_.Add(other.syncCDSkillID_);
			if (other.IsExtensionalSkill)
			{
				IsExtensionalSkill = other.IsExtensionalSkill;
			}
			if (other.CanBeParry)
			{
				CanBeParry = other.CanBeParry;
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
				AbilityClass = input.ReadInt32();
				break;
			case 24u:
				OriginAbility = input.ReadInt32();
				break;
			case 32u:
			case 34u:
				syncCDSkillID_.AddEntriesFrom(input, _repeated_syncCDSkillID_codec);
				break;
			case 40u:
				IsExtensionalSkill = input.ReadBool();
				break;
			case 48u:
				CanBeParry = input.ReadBool();
				break;
			}
		}
	}
}
