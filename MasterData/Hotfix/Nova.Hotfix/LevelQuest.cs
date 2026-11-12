using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class LevelQuest : IMessage<LevelQuest>, IMessage, IEquatable<LevelQuest>, IDeepCloneable<LevelQuest>
{
	private static readonly MessageParser<LevelQuest> _parser = new MessageParser<LevelQuest>(() => new LevelQuest());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int QuestNameFieldNumber = 2;

	private string questName_ = "";

	public const int LevelQuestTargetIdsFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_levelQuestTargetIds_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> levelQuestTargetIds_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<LevelQuest> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(494);

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
	public string QuestName
	{
		get
		{
			return questName_;
		}
		set
		{
			questName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> LevelQuestTargetIds => levelQuestTargetIds_;

	[DebuggerNonUserCode]
	public LevelQuest()
	{
	}

	[DebuggerNonUserCode]
	public LevelQuest(LevelQuest other)
		: this()
	{
		id_ = other.id_;
		questName_ = other.questName_;
		levelQuestTargetIds_ = other.levelQuestTargetIds_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public LevelQuest Clone()
	{
		return new LevelQuest(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as LevelQuest);
	}

	[DebuggerNonUserCode]
	public bool Equals(LevelQuest other)
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
		if (QuestName != other.QuestName)
		{
			return false;
		}
		if (!levelQuestTargetIds_.Equals(other.levelQuestTargetIds_))
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
		if (QuestName.Length != 0)
		{
			num ^= QuestName.GetHashCode();
		}
		num ^= levelQuestTargetIds_.GetHashCode();
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
		if (QuestName.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(QuestName);
		}
		levelQuestTargetIds_.WriteTo(output, _repeated_levelQuestTargetIds_codec);
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
		if (QuestName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(QuestName);
		}
		num += levelQuestTargetIds_.CalculateSize(_repeated_levelQuestTargetIds_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(LevelQuest other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.QuestName.Length != 0)
			{
				QuestName = other.QuestName;
			}
			levelQuestTargetIds_.Add(other.levelQuestTargetIds_);
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
				QuestName = input.ReadString();
				break;
			case 24u:
			case 26u:
				levelQuestTargetIds_.AddEntriesFrom(input, _repeated_levelQuestTargetIds_codec);
				break;
			}
		}
	}
}
