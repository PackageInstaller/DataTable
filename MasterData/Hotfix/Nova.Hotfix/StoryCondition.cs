using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StoryCondition : IMessage<StoryCondition>, IMessage, IEquatable<StoryCondition>, IDeepCloneable<StoryCondition>
{
	private static readonly MessageParser<StoryCondition> _parser = new MessageParser<StoryCondition>(() => new StoryCondition());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ConditionIdFieldNumber = 2;

	private string conditionId_ = "";

	public const int CommentFieldNumber = 3;

	private string comment_ = "";

	public const int EvIdsAFieldNumber = 4;

	private static readonly FieldCodec<string> _repeated_evIdsA_codec = FieldCodec.ForString(34u);

	private readonly RepeatedField<string> evIdsA_ = new RepeatedField<string>();

	public const int EvIdsBFieldNumber = 5;

	private static readonly FieldCodec<string> _repeated_evIdsB_codec = FieldCodec.ForString(42u);

	private readonly RepeatedField<string> evIdsB_ = new RepeatedField<string>();

	public const int StoryIdAFieldNumber = 6;

	private static readonly FieldCodec<string> _repeated_storyIdA_codec = FieldCodec.ForString(50u);

	private readonly RepeatedField<string> storyIdA_ = new RepeatedField<string>();

	public const int StoryIdBFieldNumber = 7;

	private static readonly FieldCodec<string> _repeated_storyIdB_codec = FieldCodec.ForString(58u);

	private readonly RepeatedField<string> storyIdB_ = new RepeatedField<string>();

	public const int PlayerWorldLevelFieldNumber = 8;

	private int playerWorldLevel_;

	public const int AchieveIdsFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_achieveIds_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> achieveIds_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<StoryCondition> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(892);

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
	public string ConditionId
	{
		get
		{
			return conditionId_;
		}
		set
		{
			conditionId_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public RepeatedField<string> EvIdsA => evIdsA_;

	[DebuggerNonUserCode]
	public RepeatedField<string> EvIdsB => evIdsB_;

	[DebuggerNonUserCode]
	public RepeatedField<string> StoryIdA => storyIdA_;

	[DebuggerNonUserCode]
	public RepeatedField<string> StoryIdB => storyIdB_;

	[DebuggerNonUserCode]
	public int PlayerWorldLevel
	{
		get
		{
			return playerWorldLevel_;
		}
		set
		{
			playerWorldLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> AchieveIds => achieveIds_;

	[DebuggerNonUserCode]
	public StoryCondition()
	{
	}

	[DebuggerNonUserCode]
	public StoryCondition(StoryCondition other)
		: this()
	{
		id_ = other.id_;
		conditionId_ = other.conditionId_;
		comment_ = other.comment_;
		evIdsA_ = other.evIdsA_.Clone();
		evIdsB_ = other.evIdsB_.Clone();
		storyIdA_ = other.storyIdA_.Clone();
		storyIdB_ = other.storyIdB_.Clone();
		playerWorldLevel_ = other.playerWorldLevel_;
		achieveIds_ = other.achieveIds_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StoryCondition Clone()
	{
		return new StoryCondition(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StoryCondition);
	}

	[DebuggerNonUserCode]
	public bool Equals(StoryCondition other)
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
		if (ConditionId != other.ConditionId)
		{
			return false;
		}
		if (Comment != other.Comment)
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
		if (!storyIdA_.Equals(other.storyIdA_))
		{
			return false;
		}
		if (!storyIdB_.Equals(other.storyIdB_))
		{
			return false;
		}
		if (PlayerWorldLevel != other.PlayerWorldLevel)
		{
			return false;
		}
		if (!achieveIds_.Equals(other.achieveIds_))
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
		if (ConditionId.Length != 0)
		{
			num ^= ConditionId.GetHashCode();
		}
		if (Comment.Length != 0)
		{
			num ^= Comment.GetHashCode();
		}
		num ^= evIdsA_.GetHashCode();
		num ^= evIdsB_.GetHashCode();
		num ^= storyIdA_.GetHashCode();
		num ^= storyIdB_.GetHashCode();
		if (PlayerWorldLevel != 0)
		{
			num ^= PlayerWorldLevel.GetHashCode();
		}
		num ^= achieveIds_.GetHashCode();
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
		if (ConditionId.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(ConditionId);
		}
		if (Comment.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Comment);
		}
		evIdsA_.WriteTo(output, _repeated_evIdsA_codec);
		evIdsB_.WriteTo(output, _repeated_evIdsB_codec);
		storyIdA_.WriteTo(output, _repeated_storyIdA_codec);
		storyIdB_.WriteTo(output, _repeated_storyIdB_codec);
		if (PlayerWorldLevel != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(PlayerWorldLevel);
		}
		achieveIds_.WriteTo(output, _repeated_achieveIds_codec);
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
		if (ConditionId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ConditionId);
		}
		if (Comment.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Comment);
		}
		num += evIdsA_.CalculateSize(_repeated_evIdsA_codec);
		num += evIdsB_.CalculateSize(_repeated_evIdsB_codec);
		num += storyIdA_.CalculateSize(_repeated_storyIdA_codec);
		num += storyIdB_.CalculateSize(_repeated_storyIdB_codec);
		if (PlayerWorldLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PlayerWorldLevel);
		}
		num += achieveIds_.CalculateSize(_repeated_achieveIds_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StoryCondition other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ConditionId.Length != 0)
			{
				ConditionId = other.ConditionId;
			}
			if (other.Comment.Length != 0)
			{
				Comment = other.Comment;
			}
			evIdsA_.Add(other.evIdsA_);
			evIdsB_.Add(other.evIdsB_);
			storyIdA_.Add(other.storyIdA_);
			storyIdB_.Add(other.storyIdB_);
			if (other.PlayerWorldLevel != 0)
			{
				PlayerWorldLevel = other.PlayerWorldLevel;
			}
			achieveIds_.Add(other.achieveIds_);
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
				ConditionId = input.ReadString();
				break;
			case 26u:
				Comment = input.ReadString();
				break;
			case 34u:
				evIdsA_.AddEntriesFrom(input, _repeated_evIdsA_codec);
				break;
			case 42u:
				evIdsB_.AddEntriesFrom(input, _repeated_evIdsB_codec);
				break;
			case 50u:
				storyIdA_.AddEntriesFrom(input, _repeated_storyIdA_codec);
				break;
			case 58u:
				storyIdB_.AddEntriesFrom(input, _repeated_storyIdB_codec);
				break;
			case 64u:
				PlayerWorldLevel = input.ReadInt32();
				break;
			case 72u:
			case 74u:
				achieveIds_.AddEntriesFrom(input, _repeated_achieveIds_codec);
				break;
			}
		}
	}
}
