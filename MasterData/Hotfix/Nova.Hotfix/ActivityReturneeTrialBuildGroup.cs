using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityReturneeTrialBuildGroup : IMessage<ActivityReturneeTrialBuildGroup>, IMessage, IEquatable<ActivityReturneeTrialBuildGroup>, IDeepCloneable<ActivityReturneeTrialBuildGroup>
{
	private static readonly MessageParser<ActivityReturneeTrialBuildGroup> _parser = new MessageParser<ActivityReturneeTrialBuildGroup>(() => new ActivityReturneeTrialBuildGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int LevelMinFieldNumber = 2;

	private int levelMin_;

	public const int LevelMaxFieldNumber = 3;

	private int levelMax_;

	public const int ScoreFieldNumber = 4;

	private int score_;

	[DebuggerNonUserCode]
	public static MessageParser<ActivityReturneeTrialBuildGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(52);

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
	public int LevelMin
	{
		get
		{
			return levelMin_;
		}
		set
		{
			levelMin_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LevelMax
	{
		get
		{
			return levelMax_;
		}
		set
		{
			levelMax_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Score
	{
		get
		{
			return score_;
		}
		set
		{
			score_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ActivityReturneeTrialBuildGroup()
	{
	}

	[DebuggerNonUserCode]
	public ActivityReturneeTrialBuildGroup(ActivityReturneeTrialBuildGroup other)
		: this()
	{
		id_ = other.id_;
		levelMin_ = other.levelMin_;
		levelMax_ = other.levelMax_;
		score_ = other.score_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityReturneeTrialBuildGroup Clone()
	{
		return new ActivityReturneeTrialBuildGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityReturneeTrialBuildGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityReturneeTrialBuildGroup other)
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
		if (LevelMin != other.LevelMin)
		{
			return false;
		}
		if (LevelMax != other.LevelMax)
		{
			return false;
		}
		if (Score != other.Score)
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
		if (LevelMin != 0)
		{
			num ^= LevelMin.GetHashCode();
		}
		if (LevelMax != 0)
		{
			num ^= LevelMax.GetHashCode();
		}
		if (Score != 0)
		{
			num ^= Score.GetHashCode();
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
		if (LevelMin != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(LevelMin);
		}
		if (LevelMax != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(LevelMax);
		}
		if (Score != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Score);
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
		if (LevelMin != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelMin);
		}
		if (LevelMax != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelMax);
		}
		if (Score != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Score);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityReturneeTrialBuildGroup other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.LevelMin != 0)
			{
				LevelMin = other.LevelMin;
			}
			if (other.LevelMax != 0)
			{
				LevelMax = other.LevelMax;
			}
			if (other.Score != 0)
			{
				Score = other.Score;
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
				LevelMin = input.ReadInt32();
				break;
			case 24u:
				LevelMax = input.ReadInt32();
				break;
			case 32u:
				Score = input.ReadInt32();
				break;
			}
		}
	}
}
