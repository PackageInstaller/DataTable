using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityReturnee : IMessage<ActivityReturnee>, IMessage, IEquatable<ActivityReturnee>, IDeepCloneable<ActivityReturnee>
{
	private static readonly MessageParser<ActivityReturnee> _parser = new MessageParser<ActivityReturnee>(() => new ActivityReturnee());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int DoubleCountFieldNumber = 2;

	private int doubleCount_;

	public const int AVGFieldNumber = 3;

	private string aVG_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<ActivityReturnee> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(32);

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
	public int DoubleCount
	{
		get
		{
			return doubleCount_;
		}
		set
		{
			doubleCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string AVG
	{
		get
		{
			return aVG_;
		}
		set
		{
			aVG_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public ActivityReturnee()
	{
	}

	[DebuggerNonUserCode]
	public ActivityReturnee(ActivityReturnee other)
		: this()
	{
		id_ = other.id_;
		doubleCount_ = other.doubleCount_;
		aVG_ = other.aVG_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityReturnee Clone()
	{
		return new ActivityReturnee(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityReturnee);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityReturnee other)
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
		if (DoubleCount != other.DoubleCount)
		{
			return false;
		}
		if (AVG != other.AVG)
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
		if (DoubleCount != 0)
		{
			num ^= DoubleCount.GetHashCode();
		}
		if (AVG.Length != 0)
		{
			num ^= AVG.GetHashCode();
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
		if (DoubleCount != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(DoubleCount);
		}
		if (AVG.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(AVG);
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
		if (DoubleCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DoubleCount);
		}
		if (AVG.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AVG);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityReturnee other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.DoubleCount != 0)
			{
				DoubleCount = other.DoubleCount;
			}
			if (other.AVG.Length != 0)
			{
				AVG = other.AVG;
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
				DoubleCount = input.ReadInt32();
				break;
			case 26u:
				AVG = input.ReadString();
				break;
			}
		}
	}
}
