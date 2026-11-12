using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityStoryCondition : IMessage<ActivityStoryCondition>, IMessage, IEquatable<ActivityStoryCondition>, IDeepCloneable<ActivityStoryCondition>
{
	private static readonly MessageParser<ActivityStoryCondition> _parser = new MessageParser<ActivityStoryCondition>(() => new ActivityStoryCondition());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ActivityIdFieldNumber = 2;

	private int activityId_;

	public const int CommentFieldNumber = 3;

	private string comment_ = "";

	public const int ActivityStoryIdAFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_activityStoryIdA_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> activityStoryIdA_ = new RepeatedField<int>();

	public const int ActivityStoryIdBFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_activityStoryIdB_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> activityStoryIdB_ = new RepeatedField<int>();

	public const int ActivityLevelFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_activityLevel_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> activityLevel_ = new RepeatedField<int>();

	public const int EvIdsAFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_evIdsA_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> evIdsA_ = new RepeatedField<int>();

	public const int EvIdsBFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_evIdsB_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> evIdsB_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<ActivityStoryCondition> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(62);

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
	public int ActivityId
	{
		get
		{
			return activityId_;
		}
		set
		{
			activityId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Comment
	{
		get
		{
			return comment_;
		}
		set
		{
			comment_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> ActivityStoryIdA => activityStoryIdA_;

	[DebuggerNonUserCode]
	public RepeatedField<int> ActivityStoryIdB => activityStoryIdB_;

	[DebuggerNonUserCode]
	public RepeatedField<int> ActivityLevel => activityLevel_;

	[DebuggerNonUserCode]
	public RepeatedField<int> EvIdsA => evIdsA_;

	[DebuggerNonUserCode]
	public RepeatedField<int> EvIdsB => evIdsB_;

	[DebuggerNonUserCode]
	public ActivityStoryCondition()
	{
	}

	[DebuggerNonUserCode]
	public ActivityStoryCondition(ActivityStoryCondition other)
		: this()
	{
		id_ = other.id_;
		activityId_ = other.activityId_;
		comment_ = other.comment_;
		activityStoryIdA_ = other.activityStoryIdA_.Clone();
		activityStoryIdB_ = other.activityStoryIdB_.Clone();
		activityLevel_ = other.activityLevel_.Clone();
		evIdsA_ = other.evIdsA_.Clone();
		evIdsB_ = other.evIdsB_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityStoryCondition Clone()
	{
		return new ActivityStoryCondition(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityStoryCondition);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityStoryCondition other)
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
		if (ActivityId != other.ActivityId)
		{
			return false;
		}
		if (Comment != other.Comment)
		{
			return false;
		}
		if (!activityStoryIdA_.Equals(other.activityStoryIdA_))
		{
			return false;
		}
		if (!activityStoryIdB_.Equals(other.activityStoryIdB_))
		{
			return false;
		}
		if (!activityLevel_.Equals(other.activityLevel_))
		{
			return false;
		}
		if (!evIdsA_.Equals(other.evIdsA_))
		{
			return false;
		}
		if (!evIdsB_.Equals(other.evIdsB_))
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
		if (ActivityId != 0)
		{
			num ^= ActivityId.GetHashCode();
		}
		if (Comment.Length != 0)
		{
			num ^= Comment.GetHashCode();
		}
		num ^= activityStoryIdA_.GetHashCode();
		num ^= activityStoryIdB_.GetHashCode();
		num ^= activityLevel_.GetHashCode();
		num ^= evIdsA_.GetHashCode();
		num ^= evIdsB_.GetHashCode();
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
		if (ActivityId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ActivityId);
		}
		if (Comment.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Comment);
		}
		activityStoryIdA_.WriteTo(output, _repeated_activityStoryIdA_codec);
		activityStoryIdB_.WriteTo(output, _repeated_activityStoryIdB_codec);
		activityLevel_.WriteTo(output, _repeated_activityLevel_codec);
		evIdsA_.WriteTo(output, _repeated_evIdsA_codec);
		evIdsB_.WriteTo(output, _repeated_evIdsB_codec);
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
		if (ActivityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityId);
		}
		if (Comment.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Comment);
		}
		num += activityStoryIdA_.CalculateSize(_repeated_activityStoryIdA_codec);
		num += activityStoryIdB_.CalculateSize(_repeated_activityStoryIdB_codec);
		num += activityLevel_.CalculateSize(_repeated_activityLevel_codec);
		num += evIdsA_.CalculateSize(_repeated_evIdsA_codec);
		num += evIdsB_.CalculateSize(_repeated_evIdsB_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityStoryCondition other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ActivityId != 0)
			{
				ActivityId = other.ActivityId;
			}
			if (other.Comment.Length != 0)
			{
				Comment = other.Comment;
			}
			activityStoryIdA_.Add(other.activityStoryIdA_);
			activityStoryIdB_.Add(other.activityStoryIdB_);
			activityLevel_.Add(other.activityLevel_);
			evIdsA_.Add(other.evIdsA_);
			evIdsB_.Add(other.evIdsB_);
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
				ActivityId = input.ReadInt32();
				break;
			case 26u:
				Comment = input.ReadString();
				break;
			case 32u:
			case 34u:
				activityStoryIdA_.AddEntriesFrom(input, _repeated_activityStoryIdA_codec);
				break;
			case 40u:
			case 42u:
				activityStoryIdB_.AddEntriesFrom(input, _repeated_activityStoryIdB_codec);
				break;
			case 48u:
			case 50u:
				activityLevel_.AddEntriesFrom(input, _repeated_activityLevel_codec);
				break;
			case 56u:
			case 58u:
				evIdsA_.AddEntriesFrom(input, _repeated_evIdsA_codec);
				break;
			case 64u:
			case 66u:
				evIdsB_.AddEntriesFrom(input, _repeated_evIdsB_codec);
				break;
			}
		}
	}
}
