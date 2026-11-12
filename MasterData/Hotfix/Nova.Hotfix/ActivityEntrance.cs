using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityEntrance : IMessage<ActivityEntrance>, IMessage, IEquatable<ActivityEntrance>, IDeepCloneable<ActivityEntrance>
{
	private static readonly MessageParser<ActivityEntrance> _parser = new MessageParser<ActivityEntrance>(() => new ActivityEntrance());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int StartTimeFieldNumber = 2;

	private string startTime_ = "";

	public const int EndTimeFieldNumber = 3;

	private string endTime_ = "";

	public const int EnterResFieldNumber = 4;

	private string enterRes_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<ActivityEntrance> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(12);

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
	public string EnterRes
	{
		get
		{
			return enterRes_;
		}
		set
		{
			enterRes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public ActivityEntrance()
	{
	}

	[DebuggerNonUserCode]
	public ActivityEntrance(ActivityEntrance other)
		: this()
	{
		id_ = other.id_;
		startTime_ = other.startTime_;
		endTime_ = other.endTime_;
		enterRes_ = other.enterRes_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityEntrance Clone()
	{
		return new ActivityEntrance(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityEntrance);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityEntrance other)
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
		if (EnterRes != other.EnterRes)
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
		if (EnterRes.Length != 0)
		{
			num ^= EnterRes.GetHashCode();
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
		if (EnterRes.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(EnterRes);
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
		if (StartTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StartTime);
		}
		if (EndTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EndTime);
		}
		if (EnterRes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EnterRes);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityEntrance other)
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
			if (other.EnterRes.Length != 0)
			{
				EnterRes = other.EnterRes;
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
				StartTime = input.ReadString();
				break;
			case 26u:
				EndTime = input.ReadString();
				break;
			case 34u:
				EnterRes = input.ReadString();
				break;
			}
		}
	}
}
