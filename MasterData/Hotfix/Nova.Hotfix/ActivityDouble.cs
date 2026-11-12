using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityDouble : IMessage<ActivityDouble>, IMessage, IEquatable<ActivityDouble>, IDeepCloneable<ActivityDouble>
{
	private static readonly MessageParser<ActivityDouble> _parser = new MessageParser<ActivityDouble>(() => new ActivityDouble());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int InstanceTypeFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_instanceType_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> instanceType_ = new RepeatedField<int>();

	public const int DailyTimesFieldNumber = 3;

	private int dailyTimes_;

	public const int RewardTypeFieldNumber = 4;

	private int rewardType_;

	public const int UIAssetsFieldNumber = 5;

	private string uIAssets_ = "";

	public const int CtrlNameFieldNumber = 6;

	private string ctrlName_ = "";

	public const int DesTextFieldNumber = 7;

	private string desText_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<ActivityDouble> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(8);

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
	public RepeatedField<int> InstanceType => instanceType_;

	[DebuggerNonUserCode]
	public int DailyTimes
	{
		get
		{
			return dailyTimes_;
		}
		set
		{
			dailyTimes_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardType
	{
		get
		{
			return rewardType_;
		}
		set
		{
			rewardType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string UIAssets
	{
		get
		{
			return uIAssets_;
		}
		set
		{
			uIAssets_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CtrlName
	{
		get
		{
			return ctrlName_;
		}
		set
		{
			ctrlName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string DesText
	{
		get
		{
			return desText_;
		}
		set
		{
			desText_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public ActivityDouble()
	{
	}

	[DebuggerNonUserCode]
	public ActivityDouble(ActivityDouble other)
		: this()
	{
		id_ = other.id_;
		instanceType_ = other.instanceType_.Clone();
		dailyTimes_ = other.dailyTimes_;
		rewardType_ = other.rewardType_;
		uIAssets_ = other.uIAssets_;
		ctrlName_ = other.ctrlName_;
		desText_ = other.desText_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityDouble Clone()
	{
		return new ActivityDouble(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityDouble);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityDouble other)
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
		if (!instanceType_.Equals(other.instanceType_))
		{
			return false;
		}
		if (DailyTimes != other.DailyTimes)
		{
			return false;
		}
		if (RewardType != other.RewardType)
		{
			return false;
		}
		if (UIAssets != other.UIAssets)
		{
			return false;
		}
		if (CtrlName != other.CtrlName)
		{
			return false;
		}
		if (DesText != other.DesText)
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
		num ^= instanceType_.GetHashCode();
		if (DailyTimes != 0)
		{
			num ^= DailyTimes.GetHashCode();
		}
		if (RewardType != 0)
		{
			num ^= RewardType.GetHashCode();
		}
		if (UIAssets.Length != 0)
		{
			num ^= UIAssets.GetHashCode();
		}
		if (CtrlName.Length != 0)
		{
			num ^= CtrlName.GetHashCode();
		}
		if (DesText.Length != 0)
		{
			num ^= DesText.GetHashCode();
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
		instanceType_.WriteTo(output, _repeated_instanceType_codec);
		if (DailyTimes != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(DailyTimes);
		}
		if (RewardType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(RewardType);
		}
		if (UIAssets.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(UIAssets);
		}
		if (CtrlName.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(CtrlName);
		}
		if (DesText.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(DesText);
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
		num += instanceType_.CalculateSize(_repeated_instanceType_codec);
		if (DailyTimes != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DailyTimes);
		}
		if (RewardType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardType);
		}
		if (UIAssets.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(UIAssets);
		}
		if (CtrlName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CtrlName);
		}
		if (DesText.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DesText);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityDouble other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			instanceType_.Add(other.instanceType_);
			if (other.DailyTimes != 0)
			{
				DailyTimes = other.DailyTimes;
			}
			if (other.RewardType != 0)
			{
				RewardType = other.RewardType;
			}
			if (other.UIAssets.Length != 0)
			{
				UIAssets = other.UIAssets;
			}
			if (other.CtrlName.Length != 0)
			{
				CtrlName = other.CtrlName;
			}
			if (other.DesText.Length != 0)
			{
				DesText = other.DesText;
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
				instanceType_.AddEntriesFrom(input, _repeated_instanceType_codec);
				break;
			case 24u:
				DailyTimes = input.ReadInt32();
				break;
			case 32u:
				RewardType = input.ReadInt32();
				break;
			case 42u:
				UIAssets = input.ReadString();
				break;
			case 50u:
				CtrlName = input.ReadString();
				break;
			case 58u:
				DesText = input.ReadString();
				break;
			}
		}
	}
}
