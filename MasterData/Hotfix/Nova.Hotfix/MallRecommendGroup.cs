using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MallRecommendGroup : IMessage<MallRecommendGroup>, IMessage, IEquatable<MallRecommendGroup>, IDeepCloneable<MallRecommendGroup>
{
	private static readonly MessageParser<MallRecommendGroup> _parser = new MessageParser<MallRecommendGroup>(() => new MallRecommendGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private string id_ = "";

	public const int SortFieldNumber = 2;

	private int sort_;

	public const int PackageListFieldNumber = 3;

	private static readonly FieldCodec<string> _repeated_packageList_codec = FieldCodec.ForString(26u);

	private readonly RepeatedField<string> packageList_ = new RepeatedField<string>();

	public const int NameFieldNumber = 4;

	private string name_ = "";

	public const int StartTimeFieldNumber = 5;

	private string startTime_ = "";

	public const int EndTimeFieldNumber = 6;

	private string endTime_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<MallRecommendGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(524);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public string Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Sort
	{
		get
		{
			return sort_;
		}
		set
		{
			sort_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<string> PackageList => packageList_;

	[DebuggerNonUserCode]
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public MallRecommendGroup()
	{
	}

	[DebuggerNonUserCode]
	public MallRecommendGroup(MallRecommendGroup other)
		: this()
	{
		id_ = other.id_;
		sort_ = other.sort_;
		packageList_ = other.packageList_.Clone();
		name_ = other.name_;
		startTime_ = other.startTime_;
		endTime_ = other.endTime_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MallRecommendGroup Clone()
	{
		return new MallRecommendGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MallRecommendGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(MallRecommendGroup other)
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
		if (Sort != other.Sort)
		{
			return false;
		}
		if (!packageList_.Equals(other.packageList_))
		{
			return false;
		}
		if (Name != other.Name)
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
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id.Length != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
		}
		num ^= packageList_.GetHashCode();
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (StartTime.Length != 0)
		{
			num ^= StartTime.GetHashCode();
		}
		if (EndTime.Length != 0)
		{
			num ^= EndTime.GetHashCode();
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
		if (Id.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(Id);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Sort);
		}
		packageList_.WriteTo(output, _repeated_packageList_codec);
		if (Name.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Name);
		}
		if (StartTime.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(StartTime);
		}
		if (EndTime.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(EndTime);
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
		if (Id.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Id);
		}
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		num += packageList_.CalculateSize(_repeated_packageList_codec);
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (StartTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StartTime);
		}
		if (EndTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EndTime);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MallRecommendGroup other)
	{
		if (other != null)
		{
			if (other.Id.Length != 0)
			{
				Id = other.Id;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
			}
			packageList_.Add(other.packageList_);
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.StartTime.Length != 0)
			{
				StartTime = other.StartTime;
			}
			if (other.EndTime.Length != 0)
			{
				EndTime = other.EndTime;
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
			case 10u:
				Id = input.ReadString();
				break;
			case 16u:
				Sort = input.ReadInt32();
				break;
			case 26u:
				packageList_.AddEntriesFrom(input, _repeated_packageList_codec);
				break;
			case 34u:
				Name = input.ReadString();
				break;
			case 42u:
				StartTime = input.ReadString();
				break;
			case 50u:
				EndTime = input.ReadString();
				break;
			}
		}
	}
}
