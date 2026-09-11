using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class cooperate_unique_skill : IMessage<cooperate_unique_skill>, IMessage, IEquatable<cooperate_unique_skill>, IDeepCloneable<cooperate_unique_skill>
{
	private static readonly MessageParser<cooperate_unique_skill> _parser = new MessageParser<cooperate_unique_skill>(() => new cooperate_unique_skill());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int CooperateRoleIdsFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_cooperateRoleIds_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> cooperateRoleIds_ = new RepeatedField<int>();

	public const int CooperateThrownIdsFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_cooperateThrownIds_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> cooperateThrownIds_ = new RepeatedField<int>();

	public const int PrefabPathFieldNumber = 4;

	private string prefabPath_ = "";

	public const int EndPrefabPathFieldNumber = 5;

	private string endPrefabPath_ = "";

	public const int SkillIdFieldNumber = 6;

	private int skillId_;

	public const int IconPathFieldNumber = 7;

	private string iconPath_ = "";

	public const int HitDamagePercentGrpFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_hitDamagePercentGrp_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> hitDamagePercentGrp_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<cooperate_unique_skill> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[82];

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
	public RepeatedField<int> CooperateRoleIds => cooperateRoleIds_;

	[DebuggerNonUserCode]
	public RepeatedField<int> CooperateThrownIds => cooperateThrownIds_;

	[DebuggerNonUserCode]
	public string PrefabPath
	{
		get
		{
			return prefabPath_;
		}
		set
		{
			prefabPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string EndPrefabPath
	{
		get
		{
			return endPrefabPath_;
		}
		set
		{
			endPrefabPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int SkillId
	{
		get
		{
			return skillId_;
		}
		set
		{
			skillId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string IconPath
	{
		get
		{
			return iconPath_;
		}
		set
		{
			iconPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> HitDamagePercentGrp => hitDamagePercentGrp_;

	[DebuggerNonUserCode]
	public cooperate_unique_skill()
	{
	}

	[DebuggerNonUserCode]
	public cooperate_unique_skill(cooperate_unique_skill other)
		: this()
	{
		iD_ = other.iD_;
		cooperateRoleIds_ = other.cooperateRoleIds_.Clone();
		cooperateThrownIds_ = other.cooperateThrownIds_.Clone();
		prefabPath_ = other.prefabPath_;
		endPrefabPath_ = other.endPrefabPath_;
		skillId_ = other.skillId_;
		iconPath_ = other.iconPath_;
		hitDamagePercentGrp_ = other.hitDamagePercentGrp_.Clone();
	}

	[DebuggerNonUserCode]
	public cooperate_unique_skill Clone()
	{
		return new cooperate_unique_skill(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as cooperate_unique_skill);
	}

	[DebuggerNonUserCode]
	public bool Equals(cooperate_unique_skill other)
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
		if (!cooperateRoleIds_.Equals(other.cooperateRoleIds_))
		{
			return false;
		}
		if (!cooperateThrownIds_.Equals(other.cooperateThrownIds_))
		{
			return false;
		}
		if (PrefabPath != other.PrefabPath)
		{
			return false;
		}
		if (EndPrefabPath != other.EndPrefabPath)
		{
			return false;
		}
		if (SkillId != other.SkillId)
		{
			return false;
		}
		if (IconPath != other.IconPath)
		{
			return false;
		}
		if (!hitDamagePercentGrp_.Equals(other.hitDamagePercentGrp_))
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
		num ^= cooperateRoleIds_.GetHashCode();
		num ^= cooperateThrownIds_.GetHashCode();
		if (PrefabPath.Length != 0)
		{
			num ^= PrefabPath.GetHashCode();
		}
		if (EndPrefabPath.Length != 0)
		{
			num ^= EndPrefabPath.GetHashCode();
		}
		if (SkillId != 0)
		{
			num ^= SkillId.GetHashCode();
		}
		if (IconPath.Length != 0)
		{
			num ^= IconPath.GetHashCode();
		}
		return num ^ hitDamagePercentGrp_.GetHashCode();
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
		cooperateRoleIds_.WriteTo(output, _repeated_cooperateRoleIds_codec);
		cooperateThrownIds_.WriteTo(output, _repeated_cooperateThrownIds_codec);
		if (PrefabPath.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(PrefabPath);
		}
		if (EndPrefabPath.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(EndPrefabPath);
		}
		if (SkillId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(SkillId);
		}
		if (IconPath.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(IconPath);
		}
		hitDamagePercentGrp_.WriteTo(output, _repeated_hitDamagePercentGrp_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		num += cooperateRoleIds_.CalculateSize(_repeated_cooperateRoleIds_codec);
		num += cooperateThrownIds_.CalculateSize(_repeated_cooperateThrownIds_codec);
		if (PrefabPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PrefabPath);
		}
		if (EndPrefabPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EndPrefabPath);
		}
		if (SkillId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkillId);
		}
		if (IconPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IconPath);
		}
		return num + hitDamagePercentGrp_.CalculateSize(_repeated_hitDamagePercentGrp_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(cooperate_unique_skill other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			cooperateRoleIds_.Add(other.cooperateRoleIds_);
			cooperateThrownIds_.Add(other.cooperateThrownIds_);
			if (other.PrefabPath.Length != 0)
			{
				PrefabPath = other.PrefabPath;
			}
			if (other.EndPrefabPath.Length != 0)
			{
				EndPrefabPath = other.EndPrefabPath;
			}
			if (other.SkillId != 0)
			{
				SkillId = other.SkillId;
			}
			if (other.IconPath.Length != 0)
			{
				IconPath = other.IconPath;
			}
			hitDamagePercentGrp_.Add(other.hitDamagePercentGrp_);
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
			case 18u:
				cooperateRoleIds_.AddEntriesFrom(input, _repeated_cooperateRoleIds_codec);
				break;
			case 24u:
			case 26u:
				cooperateThrownIds_.AddEntriesFrom(input, _repeated_cooperateThrownIds_codec);
				break;
			case 34u:
				PrefabPath = input.ReadString();
				break;
			case 42u:
				EndPrefabPath = input.ReadString();
				break;
			case 48u:
				SkillId = input.ReadInt32();
				break;
			case 58u:
				IconPath = input.ReadString();
				break;
			case 64u:
			case 66u:
				hitDamagePercentGrp_.AddEntriesFrom(input, _repeated_hitDamagePercentGrp_codec);
				break;
			}
		}
	}
}
