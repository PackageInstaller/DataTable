using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CookieRhythmlResult : IMessage<CookieRhythmlResult>, IMessage, IEquatable<CookieRhythmlResult>, IDeepCloneable<CookieRhythmlResult>
{
	private static readonly MessageParser<CookieRhythmlResult> _parser = new MessageParser<CookieRhythmlResult>(() => new CookieRhythmlResult());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ResultTypeFieldNumber = 2;

	private int resultType_;

	public const int ResultNameFieldNumber = 3;

	private string resultName_ = "";

	public const int ResultResourceNameFieldNumber = 4;

	private string resultResourceName_ = "";

	public const int RangeFieldNumber = 5;

	private float range_;

	public const int OtherConditionFieldNumber = 6;

	private string otherCondition_ = "";

	public const int AddTimeFieldNumber = 7;

	private int addTime_;

	public const int AddScoreTypeFieldNumber = 8;

	private int addScoreType_;

	public const int AddScoreFieldNumber = 9;

	private int addScore_;

	[DebuggerNonUserCode]
	public static MessageParser<CookieRhythmlResult> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(226);

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
	public int ResultType
	{
		get
		{
			return resultType_;
		}
		set
		{
			resultType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ResultName
	{
		get
		{
			return resultName_;
		}
		set
		{
			resultName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ResultResourceName
	{
		get
		{
			return resultResourceName_;
		}
		set
		{
			resultResourceName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public float Range
	{
		get
		{
			return range_;
		}
		set
		{
			range_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string OtherCondition
	{
		get
		{
			return otherCondition_;
		}
		set
		{
			otherCondition_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int AddTime
	{
		get
		{
			return addTime_;
		}
		set
		{
			addTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AddScoreType
	{
		get
		{
			return addScoreType_;
		}
		set
		{
			addScoreType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AddScore
	{
		get
		{
			return addScore_;
		}
		set
		{
			addScore_ = value;
		}
	}

	[DebuggerNonUserCode]
	public CookieRhythmlResult()
	{
	}

	[DebuggerNonUserCode]
	public CookieRhythmlResult(CookieRhythmlResult other)
		: this()
	{
		id_ = other.id_;
		resultType_ = other.resultType_;
		resultName_ = other.resultName_;
		resultResourceName_ = other.resultResourceName_;
		range_ = other.range_;
		otherCondition_ = other.otherCondition_;
		addTime_ = other.addTime_;
		addScoreType_ = other.addScoreType_;
		addScore_ = other.addScore_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CookieRhythmlResult Clone()
	{
		return new CookieRhythmlResult(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CookieRhythmlResult);
	}

	[DebuggerNonUserCode]
	public bool Equals(CookieRhythmlResult other)
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
		if (ResultType != other.ResultType)
		{
			return false;
		}
		if (ResultName != other.ResultName)
		{
			return false;
		}
		if (ResultResourceName != other.ResultResourceName)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(Range, other.Range))
		{
			return false;
		}
		if (OtherCondition != other.OtherCondition)
		{
			return false;
		}
		if (AddTime != other.AddTime)
		{
			return false;
		}
		if (AddScoreType != other.AddScoreType)
		{
			return false;
		}
		if (AddScore != other.AddScore)
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
		if (ResultType != 0)
		{
			num ^= ResultType.GetHashCode();
		}
		if (ResultName.Length != 0)
		{
			num ^= ResultName.GetHashCode();
		}
		if (ResultResourceName.Length != 0)
		{
			num ^= ResultResourceName.GetHashCode();
		}
		if (Range != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(Range);
		}
		if (OtherCondition.Length != 0)
		{
			num ^= OtherCondition.GetHashCode();
		}
		if (AddTime != 0)
		{
			num ^= AddTime.GetHashCode();
		}
		if (AddScoreType != 0)
		{
			num ^= AddScoreType.GetHashCode();
		}
		if (AddScore != 0)
		{
			num ^= AddScore.GetHashCode();
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
		if (ResultType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ResultType);
		}
		if (ResultName.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(ResultName);
		}
		if (ResultResourceName.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(ResultResourceName);
		}
		if (Range != 0f)
		{
			output.WriteRawTag(45);
			output.WriteFloat(Range);
		}
		if (OtherCondition.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(OtherCondition);
		}
		if (AddTime != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(AddTime);
		}
		if (AddScoreType != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(AddScoreType);
		}
		if (AddScore != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(AddScore);
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
		if (ResultType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ResultType);
		}
		if (ResultName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ResultName);
		}
		if (ResultResourceName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ResultResourceName);
		}
		if (Range != 0f)
		{
			num += 5;
		}
		if (OtherCondition.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OtherCondition);
		}
		if (AddTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AddTime);
		}
		if (AddScoreType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AddScoreType);
		}
		if (AddScore != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AddScore);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CookieRhythmlResult other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ResultType != 0)
			{
				ResultType = other.ResultType;
			}
			if (other.ResultName.Length != 0)
			{
				ResultName = other.ResultName;
			}
			if (other.ResultResourceName.Length != 0)
			{
				ResultResourceName = other.ResultResourceName;
			}
			if (other.Range != 0f)
			{
				Range = other.Range;
			}
			if (other.OtherCondition.Length != 0)
			{
				OtherCondition = other.OtherCondition;
			}
			if (other.AddTime != 0)
			{
				AddTime = other.AddTime;
			}
			if (other.AddScoreType != 0)
			{
				AddScoreType = other.AddScoreType;
			}
			if (other.AddScore != 0)
			{
				AddScore = other.AddScore;
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
				ResultType = input.ReadInt32();
				break;
			case 26u:
				ResultName = input.ReadString();
				break;
			case 34u:
				ResultResourceName = input.ReadString();
				break;
			case 45u:
				Range = input.ReadFloat();
				break;
			case 50u:
				OtherCondition = input.ReadString();
				break;
			case 56u:
				AddTime = input.ReadInt32();
				break;
			case 64u:
				AddScoreType = input.ReadInt32();
				break;
			case 72u:
				AddScore = input.ReadInt32();
				break;
			}
		}
	}
}
