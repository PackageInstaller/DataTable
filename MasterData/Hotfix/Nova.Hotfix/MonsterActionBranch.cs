using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MonsterActionBranch : IMessage<MonsterActionBranch>, IMessage, IEquatable<MonsterActionBranch>, IDeepCloneable<MonsterActionBranch>
{
	private static readonly MessageParser<MonsterActionBranch> _parser = new MessageParser<MonsterActionBranch>(() => new MonsterActionBranch());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int SkillIdFieldNumber = 3;

	private int skillId_;

	public const int PriorityFieldNumber = 4;

	private int priority_;

	public const int WeightFieldNumber = 5;

	private int weight_;

	public const int RateFieldNumber = 6;

	private int rate_;

	public const int CDFieldNumber = 7;

	private int cD_;

	public const int InitialCDPoolFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_initialCDPool_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> initialCDPool_ = new RepeatedField<int>();

	public const int StartCDTimeFieldNumber = 9;

	private int startCDTime_;

	public const int FixedCDFieldNumber = 10;

	private bool fixedCD_;

	public const int ReleaseDistanceFieldNumber = 11;

	private int releaseDistance_;

	public const int ReleaseAngleFieldNumber = 12;

	private int releaseAngle_;

	public const int TraceDurationFieldNumber = 13;

	private int traceDuration_;

	public const int ActivateFieldNumber = 14;

	private bool activate_;

	public const int ActiveConditionType1FieldNumber = 15;

	private int activeConditionType1_;

	public const int ActiveParam1FieldNumber = 16;

	private string activeParam1_ = "";

	public const int ActiveParam2FieldNumber = 17;

	private string activeParam2_ = "";

	public const int DeActiveConditionType1FieldNumber = 18;

	private int deActiveConditionType1_;

	public const int DeActiveParam1FieldNumber = 19;

	private string deActiveParam1_ = "";

	public const int DeActiveParam2FieldNumber = 20;

	private string deActiveParam2_ = "";

	public const int FollowEventType1FieldNumber = 21;

	private int followEventType1_;

	public const int FollowEventParam1FieldNumber = 22;

	private string followEventParam1_ = "";

	public const int FollowEventType2FieldNumber = 23;

	private int followEventType2_;

	public const int FollowEventParam2FieldNumber = 24;

	private string followEventParam2_ = "";

	public const int FollowEventType3FieldNumber = 25;

	private int followEventType3_;

	public const int FollowEventParam3FieldNumber = 26;

	private string followEventParam3_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<MonsterActionBranch> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(568);

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
	public int GroupId
	{
		get
		{
			return groupId_;
		}
		set
		{
			groupId_ = value;
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
	public int Weight
	{
		get
		{
			return weight_;
		}
		set
		{
			weight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Rate
	{
		get
		{
			return rate_;
		}
		set
		{
			rate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CD
	{
		get
		{
			return cD_;
		}
		set
		{
			cD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> InitialCDPool => initialCDPool_;

	[DebuggerNonUserCode]
	public int StartCDTime
	{
		get
		{
			return startCDTime_;
		}
		set
		{
			startCDTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool FixedCD
	{
		get
		{
			return fixedCD_;
		}
		set
		{
			fixedCD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ReleaseDistance
	{
		get
		{
			return releaseDistance_;
		}
		set
		{
			releaseDistance_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ReleaseAngle
	{
		get
		{
			return releaseAngle_;
		}
		set
		{
			releaseAngle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TraceDuration
	{
		get
		{
			return traceDuration_;
		}
		set
		{
			traceDuration_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool Activate
	{
		get
		{
			return activate_;
		}
		set
		{
			activate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ActiveConditionType1
	{
		get
		{
			return activeConditionType1_;
		}
		set
		{
			activeConditionType1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ActiveParam1
	{
		get
		{
			return activeParam1_;
		}
		set
		{
			activeParam1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ActiveParam2
	{
		get
		{
			return activeParam2_;
		}
		set
		{
			activeParam2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int DeActiveConditionType1
	{
		get
		{
			return deActiveConditionType1_;
		}
		set
		{
			deActiveConditionType1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string DeActiveParam1
	{
		get
		{
			return deActiveParam1_;
		}
		set
		{
			deActiveParam1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string DeActiveParam2
	{
		get
		{
			return deActiveParam2_;
		}
		set
		{
			deActiveParam2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int FollowEventType1
	{
		get
		{
			return followEventType1_;
		}
		set
		{
			followEventType1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string FollowEventParam1
	{
		get
		{
			return followEventParam1_;
		}
		set
		{
			followEventParam1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int FollowEventType2
	{
		get
		{
			return followEventType2_;
		}
		set
		{
			followEventType2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string FollowEventParam2
	{
		get
		{
			return followEventParam2_;
		}
		set
		{
			followEventParam2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int FollowEventType3
	{
		get
		{
			return followEventType3_;
		}
		set
		{
			followEventType3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string FollowEventParam3
	{
		get
		{
			return followEventParam3_;
		}
		set
		{
			followEventParam3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public MonsterActionBranch()
	{
	}

	[DebuggerNonUserCode]
	public MonsterActionBranch(MonsterActionBranch other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		skillId_ = other.skillId_;
		priority_ = other.priority_;
		weight_ = other.weight_;
		rate_ = other.rate_;
		cD_ = other.cD_;
		initialCDPool_ = other.initialCDPool_.Clone();
		startCDTime_ = other.startCDTime_;
		fixedCD_ = other.fixedCD_;
		releaseDistance_ = other.releaseDistance_;
		releaseAngle_ = other.releaseAngle_;
		traceDuration_ = other.traceDuration_;
		activate_ = other.activate_;
		activeConditionType1_ = other.activeConditionType1_;
		activeParam1_ = other.activeParam1_;
		activeParam2_ = other.activeParam2_;
		deActiveConditionType1_ = other.deActiveConditionType1_;
		deActiveParam1_ = other.deActiveParam1_;
		deActiveParam2_ = other.deActiveParam2_;
		followEventType1_ = other.followEventType1_;
		followEventParam1_ = other.followEventParam1_;
		followEventType2_ = other.followEventType2_;
		followEventParam2_ = other.followEventParam2_;
		followEventType3_ = other.followEventType3_;
		followEventParam3_ = other.followEventParam3_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MonsterActionBranch Clone()
	{
		return new MonsterActionBranch(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MonsterActionBranch);
	}

	[DebuggerNonUserCode]
	public bool Equals(MonsterActionBranch other)
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
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (SkillId != other.SkillId)
		{
			return false;
		}
		if (Priority != other.Priority)
		{
			return false;
		}
		if (Weight != other.Weight)
		{
			return false;
		}
		if (Rate != other.Rate)
		{
			return false;
		}
		if (CD != other.CD)
		{
			return false;
		}
		if (!initialCDPool_.Equals(other.initialCDPool_))
		{
			return false;
		}
		if (StartCDTime != other.StartCDTime)
		{
			return false;
		}
		if (FixedCD != other.FixedCD)
		{
			return false;
		}
		if (ReleaseDistance != other.ReleaseDistance)
		{
			return false;
		}
		if (ReleaseAngle != other.ReleaseAngle)
		{
			return false;
		}
		if (TraceDuration != other.TraceDuration)
		{
			return false;
		}
		if (Activate != other.Activate)
		{
			return false;
		}
		if (ActiveConditionType1 != other.ActiveConditionType1)
		{
			return false;
		}
		if (ActiveParam1 != other.ActiveParam1)
		{
			return false;
		}
		if (ActiveParam2 != other.ActiveParam2)
		{
			return false;
		}
		if (DeActiveConditionType1 != other.DeActiveConditionType1)
		{
			return false;
		}
		if (DeActiveParam1 != other.DeActiveParam1)
		{
			return false;
		}
		if (DeActiveParam2 != other.DeActiveParam2)
		{
			return false;
		}
		if (FollowEventType1 != other.FollowEventType1)
		{
			return false;
		}
		if (FollowEventParam1 != other.FollowEventParam1)
		{
			return false;
		}
		if (FollowEventType2 != other.FollowEventType2)
		{
			return false;
		}
		if (FollowEventParam2 != other.FollowEventParam2)
		{
			return false;
		}
		if (FollowEventType3 != other.FollowEventType3)
		{
			return false;
		}
		if (FollowEventParam3 != other.FollowEventParam3)
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
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (SkillId != 0)
		{
			num ^= SkillId.GetHashCode();
		}
		if (Priority != 0)
		{
			num ^= Priority.GetHashCode();
		}
		if (Weight != 0)
		{
			num ^= Weight.GetHashCode();
		}
		if (Rate != 0)
		{
			num ^= Rate.GetHashCode();
		}
		if (CD != 0)
		{
			num ^= CD.GetHashCode();
		}
		num ^= initialCDPool_.GetHashCode();
		if (StartCDTime != 0)
		{
			num ^= StartCDTime.GetHashCode();
		}
		if (FixedCD)
		{
			num ^= FixedCD.GetHashCode();
		}
		if (ReleaseDistance != 0)
		{
			num ^= ReleaseDistance.GetHashCode();
		}
		if (ReleaseAngle != 0)
		{
			num ^= ReleaseAngle.GetHashCode();
		}
		if (TraceDuration != 0)
		{
			num ^= TraceDuration.GetHashCode();
		}
		if (Activate)
		{
			num ^= Activate.GetHashCode();
		}
		if (ActiveConditionType1 != 0)
		{
			num ^= ActiveConditionType1.GetHashCode();
		}
		if (ActiveParam1.Length != 0)
		{
			num ^= ActiveParam1.GetHashCode();
		}
		if (ActiveParam2.Length != 0)
		{
			num ^= ActiveParam2.GetHashCode();
		}
		if (DeActiveConditionType1 != 0)
		{
			num ^= DeActiveConditionType1.GetHashCode();
		}
		if (DeActiveParam1.Length != 0)
		{
			num ^= DeActiveParam1.GetHashCode();
		}
		if (DeActiveParam2.Length != 0)
		{
			num ^= DeActiveParam2.GetHashCode();
		}
		if (FollowEventType1 != 0)
		{
			num ^= FollowEventType1.GetHashCode();
		}
		if (FollowEventParam1.Length != 0)
		{
			num ^= FollowEventParam1.GetHashCode();
		}
		if (FollowEventType2 != 0)
		{
			num ^= FollowEventType2.GetHashCode();
		}
		if (FollowEventParam2.Length != 0)
		{
			num ^= FollowEventParam2.GetHashCode();
		}
		if (FollowEventType3 != 0)
		{
			num ^= FollowEventType3.GetHashCode();
		}
		if (FollowEventParam3.Length != 0)
		{
			num ^= FollowEventParam3.GetHashCode();
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
		if (GroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GroupId);
		}
		if (SkillId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(SkillId);
		}
		if (Priority != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Priority);
		}
		if (Weight != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Weight);
		}
		if (Rate != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Rate);
		}
		if (CD != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(CD);
		}
		initialCDPool_.WriteTo(output, _repeated_initialCDPool_codec);
		if (StartCDTime != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(StartCDTime);
		}
		if (FixedCD)
		{
			output.WriteRawTag(80);
			output.WriteBool(FixedCD);
		}
		if (ReleaseDistance != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(ReleaseDistance);
		}
		if (ReleaseAngle != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(ReleaseAngle);
		}
		if (TraceDuration != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(TraceDuration);
		}
		if (Activate)
		{
			output.WriteRawTag(112);
			output.WriteBool(Activate);
		}
		if (ActiveConditionType1 != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(ActiveConditionType1);
		}
		if (ActiveParam1.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(ActiveParam1);
		}
		if (ActiveParam2.Length != 0)
		{
			output.WriteRawTag(138, 1);
			output.WriteString(ActiveParam2);
		}
		if (DeActiveConditionType1 != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(DeActiveConditionType1);
		}
		if (DeActiveParam1.Length != 0)
		{
			output.WriteRawTag(154, 1);
			output.WriteString(DeActiveParam1);
		}
		if (DeActiveParam2.Length != 0)
		{
			output.WriteRawTag(162, 1);
			output.WriteString(DeActiveParam2);
		}
		if (FollowEventType1 != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(FollowEventType1);
		}
		if (FollowEventParam1.Length != 0)
		{
			output.WriteRawTag(178, 1);
			output.WriteString(FollowEventParam1);
		}
		if (FollowEventType2 != 0)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt32(FollowEventType2);
		}
		if (FollowEventParam2.Length != 0)
		{
			output.WriteRawTag(194, 1);
			output.WriteString(FollowEventParam2);
		}
		if (FollowEventType3 != 0)
		{
			output.WriteRawTag(200, 1);
			output.WriteInt32(FollowEventType3);
		}
		if (FollowEventParam3.Length != 0)
		{
			output.WriteRawTag(210, 1);
			output.WriteString(FollowEventParam3);
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
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (SkillId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkillId);
		}
		if (Priority != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Priority);
		}
		if (Weight != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Weight);
		}
		if (Rate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rate);
		}
		if (CD != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CD);
		}
		num += initialCDPool_.CalculateSize(_repeated_initialCDPool_codec);
		if (StartCDTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StartCDTime);
		}
		if (FixedCD)
		{
			num += 2;
		}
		if (ReleaseDistance != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ReleaseDistance);
		}
		if (ReleaseAngle != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ReleaseAngle);
		}
		if (TraceDuration != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TraceDuration);
		}
		if (Activate)
		{
			num += 2;
		}
		if (ActiveConditionType1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActiveConditionType1);
		}
		if (ActiveParam1.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(ActiveParam1);
		}
		if (ActiveParam2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(ActiveParam2);
		}
		if (DeActiveConditionType1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DeActiveConditionType1);
		}
		if (DeActiveParam1.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(DeActiveParam1);
		}
		if (DeActiveParam2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(DeActiveParam2);
		}
		if (FollowEventType1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FollowEventType1);
		}
		if (FollowEventParam1.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(FollowEventParam1);
		}
		if (FollowEventType2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FollowEventType2);
		}
		if (FollowEventParam2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(FollowEventParam2);
		}
		if (FollowEventType3 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FollowEventType3);
		}
		if (FollowEventParam3.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(FollowEventParam3);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MonsterActionBranch other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.SkillId != 0)
			{
				SkillId = other.SkillId;
			}
			if (other.Priority != 0)
			{
				Priority = other.Priority;
			}
			if (other.Weight != 0)
			{
				Weight = other.Weight;
			}
			if (other.Rate != 0)
			{
				Rate = other.Rate;
			}
			if (other.CD != 0)
			{
				CD = other.CD;
			}
			initialCDPool_.Add(other.initialCDPool_);
			if (other.StartCDTime != 0)
			{
				StartCDTime = other.StartCDTime;
			}
			if (other.FixedCD)
			{
				FixedCD = other.FixedCD;
			}
			if (other.ReleaseDistance != 0)
			{
				ReleaseDistance = other.ReleaseDistance;
			}
			if (other.ReleaseAngle != 0)
			{
				ReleaseAngle = other.ReleaseAngle;
			}
			if (other.TraceDuration != 0)
			{
				TraceDuration = other.TraceDuration;
			}
			if (other.Activate)
			{
				Activate = other.Activate;
			}
			if (other.ActiveConditionType1 != 0)
			{
				ActiveConditionType1 = other.ActiveConditionType1;
			}
			if (other.ActiveParam1.Length != 0)
			{
				ActiveParam1 = other.ActiveParam1;
			}
			if (other.ActiveParam2.Length != 0)
			{
				ActiveParam2 = other.ActiveParam2;
			}
			if (other.DeActiveConditionType1 != 0)
			{
				DeActiveConditionType1 = other.DeActiveConditionType1;
			}
			if (other.DeActiveParam1.Length != 0)
			{
				DeActiveParam1 = other.DeActiveParam1;
			}
			if (other.DeActiveParam2.Length != 0)
			{
				DeActiveParam2 = other.DeActiveParam2;
			}
			if (other.FollowEventType1 != 0)
			{
				FollowEventType1 = other.FollowEventType1;
			}
			if (other.FollowEventParam1.Length != 0)
			{
				FollowEventParam1 = other.FollowEventParam1;
			}
			if (other.FollowEventType2 != 0)
			{
				FollowEventType2 = other.FollowEventType2;
			}
			if (other.FollowEventParam2.Length != 0)
			{
				FollowEventParam2 = other.FollowEventParam2;
			}
			if (other.FollowEventType3 != 0)
			{
				FollowEventType3 = other.FollowEventType3;
			}
			if (other.FollowEventParam3.Length != 0)
			{
				FollowEventParam3 = other.FollowEventParam3;
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
				GroupId = input.ReadInt32();
				break;
			case 24u:
				SkillId = input.ReadInt32();
				break;
			case 32u:
				Priority = input.ReadInt32();
				break;
			case 40u:
				Weight = input.ReadInt32();
				break;
			case 48u:
				Rate = input.ReadInt32();
				break;
			case 56u:
				CD = input.ReadInt32();
				break;
			case 64u:
			case 66u:
				initialCDPool_.AddEntriesFrom(input, _repeated_initialCDPool_codec);
				break;
			case 72u:
				StartCDTime = input.ReadInt32();
				break;
			case 80u:
				FixedCD = input.ReadBool();
				break;
			case 88u:
				ReleaseDistance = input.ReadInt32();
				break;
			case 96u:
				ReleaseAngle = input.ReadInt32();
				break;
			case 104u:
				TraceDuration = input.ReadInt32();
				break;
			case 112u:
				Activate = input.ReadBool();
				break;
			case 120u:
				ActiveConditionType1 = input.ReadInt32();
				break;
			case 130u:
				ActiveParam1 = input.ReadString();
				break;
			case 138u:
				ActiveParam2 = input.ReadString();
				break;
			case 144u:
				DeActiveConditionType1 = input.ReadInt32();
				break;
			case 154u:
				DeActiveParam1 = input.ReadString();
				break;
			case 162u:
				DeActiveParam2 = input.ReadString();
				break;
			case 168u:
				FollowEventType1 = input.ReadInt32();
				break;
			case 178u:
				FollowEventParam1 = input.ReadString();
				break;
			case 184u:
				FollowEventType2 = input.ReadInt32();
				break;
			case 194u:
				FollowEventParam2 = input.ReadString();
				break;
			case 200u:
				FollowEventType3 = input.ReadInt32();
				break;
			case 210u:
				FollowEventParam3 = input.ReadString();
				break;
			}
		}
	}
}
