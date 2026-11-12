using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CharacterVoiceControl : IMessage<CharacterVoiceControl>, IMessage, IEquatable<CharacterVoiceControl>, IDeepCloneable<CharacterVoiceControl>
{
	private static readonly MessageParser<CharacterVoiceControl> _parser = new MessageParser<CharacterVoiceControl>(() => new CharacterVoiceControl());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private string id_ = "";

	public const int ProbabilityFieldNumber = 2;

	private int probability_;

	public const int ResTypeFieldNumber = 3;

	private int resType_;

	public const int CombatOnlyFieldNumber = 4;

	private bool combatOnly_;

	public const int WorldLevelTypesFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_worldLevelTypes_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> worldLevelTypes_ = new RepeatedField<int>();

	public const int BubbleFieldNumber = 6;

	private bool bubble_;

	public const int CdFieldNumber = 7;

	private float cd_;

	public const int VoPlayerFieldNumber = 8;

	private int voPlayer_;

	public const int PriorityFieldNumber = 9;

	private int priority_;

	public const int DateTriggerFieldNumber = 10;

	private bool dateTrigger_;

	public const int DateFieldNumber = 11;

	private string date_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<CharacterVoiceControl> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(182);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public string Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Probability
	{
		get
		{
			return probability_;
		}
		set
		{
			probability_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ResType
	{
		get
		{
			return resType_;
		}
		set
		{
			resType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool CombatOnly
	{
		get
		{
			return combatOnly_;
		}
		set
		{
			combatOnly_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> WorldLevelTypes => worldLevelTypes_;

	[DebuggerNonUserCode]
	public bool Bubble
	{
		get
		{
			return bubble_;
		}
		set
		{
			bubble_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float Cd
	{
		get
		{
			return cd_;
		}
		set
		{
			cd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int VoPlayer
	{
		get
		{
			return voPlayer_;
		}
		set
		{
			voPlayer_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Priority
	{
		get
		{
			return priority_;
		}
		set
		{
			priority_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool DateTrigger
	{
		get
		{
			return dateTrigger_;
		}
		set
		{
			dateTrigger_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Date
	{
		get
		{
			return date_;
		}
		set
		{
			date_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public CharacterVoiceControl()
	{
	}

	[DebuggerNonUserCode]
	public CharacterVoiceControl(CharacterVoiceControl other)
		: this()
	{
		id_ = other.id_;
		probability_ = other.probability_;
		resType_ = other.resType_;
		combatOnly_ = other.combatOnly_;
		worldLevelTypes_ = other.worldLevelTypes_.Clone();
		bubble_ = other.bubble_;
		cd_ = other.cd_;
		voPlayer_ = other.voPlayer_;
		priority_ = other.priority_;
		dateTrigger_ = other.dateTrigger_;
		date_ = other.date_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CharacterVoiceControl Clone()
	{
		return new CharacterVoiceControl(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterVoiceControl);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharacterVoiceControl other)
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
		if (Probability != other.Probability)
		{
			return false;
		}
		if (ResType != other.ResType)
		{
			return false;
		}
		if (CombatOnly != other.CombatOnly)
		{
			return false;
		}
		if (!worldLevelTypes_.Equals(other.worldLevelTypes_))
		{
			return false;
		}
		if (Bubble != other.Bubble)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(Cd, other.Cd))
		{
			return false;
		}
		if (VoPlayer != other.VoPlayer)
		{
			return false;
		}
		if (Priority != other.Priority)
		{
			return false;
		}
		if (DateTrigger != other.DateTrigger)
		{
			return false;
		}
		if (Date != other.Date)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id.Length != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (Probability != 0)
		{
			num ^= Probability.GetHashCode();
		}
		if (ResType != 0)
		{
			num ^= ResType.GetHashCode();
		}
		if (CombatOnly)
		{
			num ^= CombatOnly.GetHashCode();
		}
		num ^= worldLevelTypes_.GetHashCode();
		if (Bubble)
		{
			num ^= Bubble.GetHashCode();
		}
		if (Cd != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(Cd);
		}
		if (VoPlayer != 0)
		{
			num ^= VoPlayer.GetHashCode();
		}
		if (Priority != 0)
		{
			num ^= Priority.GetHashCode();
		}
		if (DateTrigger)
		{
			num ^= DateTrigger.GetHashCode();
		}
		if (Date.Length != 0)
		{
			num ^= Date.GetHashCode();
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
		if (Id.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(Id);
		}
		if (Probability != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Probability);
		}
		if (ResType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ResType);
		}
		if (CombatOnly)
		{
			output.WriteRawTag(32);
			output.WriteBool(CombatOnly);
		}
		worldLevelTypes_.WriteTo(output, _repeated_worldLevelTypes_codec);
		if (Bubble)
		{
			output.WriteRawTag(48);
			output.WriteBool(Bubble);
		}
		if (Cd != 0f)
		{
			output.WriteRawTag(61);
			output.WriteFloat(Cd);
		}
		if (VoPlayer != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(VoPlayer);
		}
		if (Priority != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Priority);
		}
		if (DateTrigger)
		{
			output.WriteRawTag(80);
			output.WriteBool(DateTrigger);
		}
		if (Date.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(Date);
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
		if (Id.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Id);
		}
		if (Probability != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Probability);
		}
		if (ResType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ResType);
		}
		if (CombatOnly)
		{
			num += 2;
		}
		num += worldLevelTypes_.CalculateSize(_repeated_worldLevelTypes_codec);
		if (Bubble)
		{
			num += 2;
		}
		if (Cd != 0f)
		{
			num += 5;
		}
		if (VoPlayer != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(VoPlayer);
		}
		if (Priority != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Priority);
		}
		if (DateTrigger)
		{
			num += 2;
		}
		if (Date.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Date);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CharacterVoiceControl other)
	{
		if (other != null)
		{
			if (other.Id.Length != 0)
			{
				Id = other.Id;
			}
			if (other.Probability != 0)
			{
				Probability = other.Probability;
			}
			if (other.ResType != 0)
			{
				ResType = other.ResType;
			}
			if (other.CombatOnly)
			{
				CombatOnly = other.CombatOnly;
			}
			worldLevelTypes_.Add(other.worldLevelTypes_);
			if (other.Bubble)
			{
				Bubble = other.Bubble;
			}
			if (other.Cd != 0f)
			{
				Cd = other.Cd;
			}
			if (other.VoPlayer != 0)
			{
				VoPlayer = other.VoPlayer;
			}
			if (other.Priority != 0)
			{
				Priority = other.Priority;
			}
			if (other.DateTrigger)
			{
				DateTrigger = other.DateTrigger;
			}
			if (other.Date.Length != 0)
			{
				Date = other.Date;
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
			case 10u:
				Id = input.ReadString();
				break;
			case 16u:
				Probability = input.ReadInt32();
				break;
			case 24u:
				ResType = input.ReadInt32();
				break;
			case 32u:
				CombatOnly = input.ReadBool();
				break;
			case 40u:
			case 42u:
				worldLevelTypes_.AddEntriesFrom(input, _repeated_worldLevelTypes_codec);
				break;
			case 48u:
				Bubble = input.ReadBool();
				break;
			case 61u:
				Cd = input.ReadFloat();
				break;
			case 64u:
				VoPlayer = input.ReadInt32();
				break;
			case 72u:
				Priority = input.ReadInt32();
				break;
			case 80u:
				DateTrigger = input.ReadBool();
				break;
			case 90u:
				Date = input.ReadString();
				break;
			}
		}
	}
}
