using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StoryChapterTimeStamp : IMessage<StoryChapterTimeStamp>, IMessage, IEquatable<StoryChapterTimeStamp>, IDeepCloneable<StoryChapterTimeStamp>
{
	private static readonly MessageParser<StoryChapterTimeStamp> _parser = new MessageParser<StoryChapterTimeStamp>(() => new StoryChapterTimeStamp());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TimeStampFieldNumber = 2;

	private string timeStamp_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<StoryChapterTimeStamp> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(890);

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
	public string TimeStamp
	{
		get
		{
			return timeStamp_;
		}
		set
		{
			timeStamp_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public StoryChapterTimeStamp()
	{
	}

	[DebuggerNonUserCode]
	public StoryChapterTimeStamp(StoryChapterTimeStamp other)
		: this()
	{
		id_ = other.id_;
		timeStamp_ = other.timeStamp_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StoryChapterTimeStamp Clone()
	{
		return new StoryChapterTimeStamp(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StoryChapterTimeStamp);
	}

	[DebuggerNonUserCode]
	public bool Equals(StoryChapterTimeStamp other)
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
		if (TimeStamp != other.TimeStamp)
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
		if (TimeStamp.Length != 0)
		{
			num ^= TimeStamp.GetHashCode();
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
		if (TimeStamp.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(TimeStamp);
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
		if (TimeStamp.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TimeStamp);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StoryChapterTimeStamp other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.TimeStamp.Length != 0)
			{
				TimeStamp = other.TimeStamp;
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
			case 18u:
				TimeStamp = input.ReadString();
				break;
			}
		}
	}
}
