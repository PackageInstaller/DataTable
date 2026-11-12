using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class AgentSpecialPerformance : IMessage<AgentSpecialPerformance>, IMessage, IEquatable<AgentSpecialPerformance>, IDeepCloneable<AgentSpecialPerformance>
{
	private static readonly MessageParser<AgentSpecialPerformance> _parser = new MessageParser<AgentSpecialPerformance>(() => new AgentSpecialPerformance());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CharIdFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_charId_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> charId_ = new RepeatedField<int>();

	public const int WeightFieldNumber = 3;

	private int weight_;

	public const int AvgFieldNumber = 4;

	private string avg_ = "";

	public const int AVGGroupIdFieldNumber = 5;

	private string aVGGroupId_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<AgentSpecialPerformance> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(88);

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
	public RepeatedField<int> CharId => charId_;

	[DebuggerNonUserCode]
	public int Weight
	{
		get
		{
			return weight_;
		}
		set
		{
			weight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Avg
	{
		get
		{
			return avg_;
		}
		set
		{
			avg_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AVGGroupId
	{
		get
		{
			return aVGGroupId_;
		}
		set
		{
			aVGGroupId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public AgentSpecialPerformance()
	{
	}

	[DebuggerNonUserCode]
	public AgentSpecialPerformance(AgentSpecialPerformance other)
		: this()
	{
		id_ = other.id_;
		charId_ = other.charId_.Clone();
		weight_ = other.weight_;
		avg_ = other.avg_;
		aVGGroupId_ = other.aVGGroupId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public AgentSpecialPerformance Clone()
	{
		return new AgentSpecialPerformance(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as AgentSpecialPerformance);
	}

	[DebuggerNonUserCode]
	public bool Equals(AgentSpecialPerformance other)
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
		if (!charId_.Equals(other.charId_))
		{
			return false;
		}
		if (Weight != other.Weight)
		{
			return false;
		}
		if (Avg != other.Avg)
		{
			return false;
		}
		if (AVGGroupId != other.AVGGroupId)
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
		num ^= charId_.GetHashCode();
		if (Weight != 0)
		{
			num ^= Weight.GetHashCode();
		}
		if (Avg.Length != 0)
		{
			num ^= Avg.GetHashCode();
		}
		if (AVGGroupId.Length != 0)
		{
			num ^= AVGGroupId.GetHashCode();
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
		charId_.WriteTo(output, _repeated_charId_codec);
		if (Weight != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Weight);
		}
		if (Avg.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Avg);
		}
		if (AVGGroupId.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(AVGGroupId);
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
		num += charId_.CalculateSize(_repeated_charId_codec);
		if (Weight != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Weight);
		}
		if (Avg.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Avg);
		}
		if (AVGGroupId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AVGGroupId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(AgentSpecialPerformance other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			charId_.Add(other.charId_);
			if (other.Weight != 0)
			{
				Weight = other.Weight;
			}
			if (other.Avg.Length != 0)
			{
				Avg = other.Avg;
			}
			if (other.AVGGroupId.Length != 0)
			{
				AVGGroupId = other.AVGGroupId;
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
			case 18u:
				charId_.AddEntriesFrom(input, _repeated_charId_codec);
				break;
			case 24u:
				Weight = input.ReadInt32();
				break;
			case 34u:
				Avg = input.ReadString();
				break;
			case 42u:
				AVGGroupId = input.ReadString();
				break;
			}
		}
	}
}
