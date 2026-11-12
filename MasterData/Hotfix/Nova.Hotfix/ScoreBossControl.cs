using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ScoreBossControl : IMessage<ScoreBossControl>, IMessage, IEquatable<ScoreBossControl>, IDeepCloneable<ScoreBossControl>
{
	private static readonly MessageParser<ScoreBossControl> _parser = new MessageParser<ScoreBossControl>(() => new ScoreBossControl());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int StartTimeFieldNumber = 2;

	private string startTime_ = "";

	public const int EndTimeFieldNumber = 3;

	private string endTime_ = "";

	public const int LevelGroupFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_levelGroup_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> levelGroup_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<ScoreBossControl> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(692);

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
	public string StartTime
	{
		get
		{
			return startTime_;
		}
		set
		{
			startTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string EndTime
	{
		get
		{
			return endTime_;
		}
		set
		{
			endTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> LevelGroup => levelGroup_;

	[DebuggerNonUserCode]
	public ScoreBossControl()
	{
	}

	[DebuggerNonUserCode]
	public ScoreBossControl(ScoreBossControl other)
		: this()
	{
		id_ = other.id_;
		startTime_ = other.startTime_;
		endTime_ = other.endTime_;
		levelGroup_ = other.levelGroup_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ScoreBossControl Clone()
	{
		return new ScoreBossControl(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ScoreBossControl);
	}

	[DebuggerNonUserCode]
	public bool Equals(ScoreBossControl other)
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
		if (StartTime != other.StartTime)
		{
			return false;
		}
		if (EndTime != other.EndTime)
		{
			return false;
		}
		if (!levelGroup_.Equals(other.levelGroup_))
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
		if (StartTime.Length != 0)
		{
			num ^= StartTime.GetHashCode();
		}
		if (EndTime.Length != 0)
		{
			num ^= EndTime.GetHashCode();
		}
		num ^= levelGroup_.GetHashCode();
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
		if (StartTime.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(StartTime);
		}
		if (EndTime.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(EndTime);
		}
		levelGroup_.WriteTo(output, _repeated_levelGroup_codec);
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
		if (StartTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StartTime);
		}
		if (EndTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EndTime);
		}
		num += levelGroup_.CalculateSize(_repeated_levelGroup_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ScoreBossControl other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.StartTime.Length != 0)
			{
				StartTime = other.StartTime;
			}
			if (other.EndTime.Length != 0)
			{
				EndTime = other.EndTime;
			}
			levelGroup_.Add(other.levelGroup_);
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
				StartTime = input.ReadString();
				break;
			case 26u:
				EndTime = input.ReadString();
				break;
			case 32u:
			case 34u:
				levelGroup_.AddEntriesFrom(input, _repeated_levelGroup_codec);
				break;
			}
		}
	}
}
