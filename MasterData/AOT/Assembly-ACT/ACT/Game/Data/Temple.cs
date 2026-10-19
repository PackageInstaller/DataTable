using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Temple : IMessage<Temple>, IMessage, IEquatable<Temple>, IDeepCloneable<Temple>, IBufferMessage
{
	private static readonly MessageParser<Temple> _parser = new MessageParser<Temple>(() => new Temple());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CompletedFieldNumber = 2;

	private bool completed_;

	public const int GotStarsFieldNumber = 3;

	private static readonly FieldCodec<bool> _repeated_gotStars_codec = FieldCodec.ForBool(26u);

	private readonly RepeatedField<bool> gotStars_ = new RepeatedField<bool>();

	public const int LastTeamFieldNumber = 4;

	private TeamUsage lastTeam_;

	public const int CollectTreasureNumFieldNumber = 5;

	private int collectTreasureNum_;

	public const int StateFieldNumber = 6;

	private StageStateEnum state_;

	public const int EntryGameWIDFieldNumber = 7;

	private int entryGameWID_;

	public const int ObtainRobotsFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_obtainRobots_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> obtainRobots_ = new RepeatedField<int>();

	public const int ThisTimeCollectTreasureNumFieldNumber = 9;

	private int thisTimeCollectTreasureNum_;

	public const int SelectedBuffsFieldNumber = 10;

	private static readonly MapField<int, int>.Codec _map_selectedBuffs_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 82u);

	private readonly MapField<int, int> selectedBuffs_ = new MapField<int, int>();

	public const int TargetFieldNumber = 11;

	private StageChallengeTarget target_;

	public const int StageMinimumSecsFieldNumber = 12;

	private int stageMinimumSecs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Temple> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[138];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
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
	[GeneratedCode("protoc", null)]
	public bool Completed
	{
		get
		{
			return completed_;
		}
		set
		{
			completed_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<bool> GotStars => gotStars_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TeamUsage LastTeam
	{
		get
		{
			return lastTeam_;
		}
		set
		{
			lastTeam_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CollectTreasureNum
	{
		get
		{
			return collectTreasureNum_;
		}
		set
		{
			collectTreasureNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public StageStateEnum State
	{
		get
		{
			return state_;
		}
		set
		{
			state_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int EntryGameWID
	{
		get
		{
			return entryGameWID_;
		}
		set
		{
			entryGameWID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> ObtainRobots => obtainRobots_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ThisTimeCollectTreasureNum
	{
		get
		{
			return thisTimeCollectTreasureNum_;
		}
		set
		{
			thisTimeCollectTreasureNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> SelectedBuffs => selectedBuffs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public StageChallengeTarget Target
	{
		get
		{
			return target_;
		}
		set
		{
			target_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int StageMinimumSecs
	{
		get
		{
			return stageMinimumSecs_;
		}
		set
		{
			stageMinimumSecs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Temple()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Temple(Temple other)
		: this()
	{
		id_ = other.id_;
		completed_ = other.completed_;
		gotStars_ = other.gotStars_.Clone();
		lastTeam_ = ((other.lastTeam_ != null) ? other.lastTeam_.Clone() : null);
		collectTreasureNum_ = other.collectTreasureNum_;
		state_ = other.state_;
		entryGameWID_ = other.entryGameWID_;
		obtainRobots_ = other.obtainRobots_.Clone();
		thisTimeCollectTreasureNum_ = other.thisTimeCollectTreasureNum_;
		selectedBuffs_ = other.selectedBuffs_.Clone();
		target_ = ((other.target_ != null) ? other.target_.Clone() : null);
		stageMinimumSecs_ = other.stageMinimumSecs_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Temple Clone()
	{
		return new Temple(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Temple);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Temple other)
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
		if (Completed != other.Completed)
		{
			return false;
		}
		if (!gotStars_.Equals(other.gotStars_))
		{
			return false;
		}
		if (!object.Equals(LastTeam, other.LastTeam))
		{
			return false;
		}
		if (CollectTreasureNum != other.CollectTreasureNum)
		{
			return false;
		}
		if (State != other.State)
		{
			return false;
		}
		if (EntryGameWID != other.EntryGameWID)
		{
			return false;
		}
		if (!obtainRobots_.Equals(other.obtainRobots_))
		{
			return false;
		}
		if (ThisTimeCollectTreasureNum != other.ThisTimeCollectTreasureNum)
		{
			return false;
		}
		if (!SelectedBuffs.Equals(other.SelectedBuffs))
		{
			return false;
		}
		if (!object.Equals(Target, other.Target))
		{
			return false;
		}
		if (StageMinimumSecs != other.StageMinimumSecs)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (Completed)
		{
			num ^= Completed.GetHashCode();
		}
		num ^= gotStars_.GetHashCode();
		if (lastTeam_ != null)
		{
			num ^= LastTeam.GetHashCode();
		}
		if (CollectTreasureNum != 0)
		{
			num ^= CollectTreasureNum.GetHashCode();
		}
		if (State != StageStateEnum.StageStateOut)
		{
			num ^= State.GetHashCode();
		}
		if (EntryGameWID != 0)
		{
			num ^= EntryGameWID.GetHashCode();
		}
		num ^= obtainRobots_.GetHashCode();
		if (ThisTimeCollectTreasureNum != 0)
		{
			num ^= ThisTimeCollectTreasureNum.GetHashCode();
		}
		num ^= SelectedBuffs.GetHashCode();
		if (target_ != null)
		{
			num ^= Target.GetHashCode();
		}
		if (StageMinimumSecs != 0)
		{
			num ^= StageMinimumSecs.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (Completed)
		{
			output.WriteRawTag(16);
			output.WriteBool(Completed);
		}
		gotStars_.WriteTo(ref output, _repeated_gotStars_codec);
		if (lastTeam_ != null)
		{
			output.WriteRawTag(34);
			output.WriteMessage(LastTeam);
		}
		if (CollectTreasureNum != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(CollectTreasureNum);
		}
		if (State != StageStateEnum.StageStateOut)
		{
			output.WriteRawTag(48);
			output.WriteEnum((int)State);
		}
		if (EntryGameWID != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(EntryGameWID);
		}
		obtainRobots_.WriteTo(ref output, _repeated_obtainRobots_codec);
		if (ThisTimeCollectTreasureNum != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(ThisTimeCollectTreasureNum);
		}
		selectedBuffs_.WriteTo(ref output, _map_selectedBuffs_codec);
		if (target_ != null)
		{
			output.WriteRawTag(90);
			output.WriteMessage(Target);
		}
		if (StageMinimumSecs != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(StageMinimumSecs);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (Completed)
		{
			num += 2;
		}
		num += gotStars_.CalculateSize(_repeated_gotStars_codec);
		if (lastTeam_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(LastTeam);
		}
		if (CollectTreasureNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CollectTreasureNum);
		}
		if (State != StageStateEnum.StageStateOut)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)State);
		}
		if (EntryGameWID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EntryGameWID);
		}
		num += obtainRobots_.CalculateSize(_repeated_obtainRobots_codec);
		if (ThisTimeCollectTreasureNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ThisTimeCollectTreasureNum);
		}
		num += selectedBuffs_.CalculateSize(_map_selectedBuffs_codec);
		if (target_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Target);
		}
		if (StageMinimumSecs != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StageMinimumSecs);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Temple other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Id != 0)
		{
			Id = other.Id;
		}
		if (other.Completed)
		{
			Completed = other.Completed;
		}
		gotStars_.Add(other.gotStars_);
		if (other.lastTeam_ != null)
		{
			if (lastTeam_ == null)
			{
				LastTeam = new TeamUsage();
			}
			LastTeam.MergeFrom(other.LastTeam);
		}
		if (other.CollectTreasureNum != 0)
		{
			CollectTreasureNum = other.CollectTreasureNum;
		}
		if (other.State != StageStateEnum.StageStateOut)
		{
			State = other.State;
		}
		if (other.EntryGameWID != 0)
		{
			EntryGameWID = other.EntryGameWID;
		}
		obtainRobots_.Add(other.obtainRobots_);
		if (other.ThisTimeCollectTreasureNum != 0)
		{
			ThisTimeCollectTreasureNum = other.ThisTimeCollectTreasureNum;
		}
		selectedBuffs_.Add(other.selectedBuffs_);
		if (other.target_ != null)
		{
			if (target_ == null)
			{
				Target = new StageChallengeTarget();
			}
			Target.MergeFrom(other.Target);
		}
		if (other.StageMinimumSecs != 0)
		{
			StageMinimumSecs = other.StageMinimumSecs;
		}
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 16u:
				Completed = input.ReadBool();
				break;
			case 24u:
			case 26u:
				gotStars_.AddEntriesFrom(ref input, _repeated_gotStars_codec);
				break;
			case 34u:
				if (lastTeam_ == null)
				{
					LastTeam = new TeamUsage();
				}
				input.ReadMessage(LastTeam);
				break;
			case 40u:
				CollectTreasureNum = input.ReadInt32();
				break;
			case 48u:
				State = (StageStateEnum)input.ReadEnum();
				break;
			case 56u:
				EntryGameWID = input.ReadInt32();
				break;
			case 64u:
			case 66u:
				obtainRobots_.AddEntriesFrom(ref input, _repeated_obtainRobots_codec);
				break;
			case 72u:
				ThisTimeCollectTreasureNum = input.ReadInt32();
				break;
			case 82u:
				selectedBuffs_.AddEntriesFrom(ref input, _map_selectedBuffs_codec);
				break;
			case 90u:
				if (target_ == null)
				{
					Target = new StageChallengeTarget();
				}
				input.ReadMessage(Target);
				break;
			case 96u:
				StageMinimumSecs = input.ReadInt32();
				break;
			}
		}
	}
}
