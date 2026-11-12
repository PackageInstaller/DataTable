using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class BdConvertContent : IMessage<BdConvertContent>, IMessage, IEquatable<BdConvertContent>, IDeepCloneable<BdConvertContent>
{
	private static readonly MessageParser<BdConvertContent> _parser = new MessageParser<BdConvertContent>(() => new BdConvertContent());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ConvertConditionListFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_convertConditionList_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> convertConditionList_ = new RepeatedField<int>();

	public const int MaxSubFieldNumber = 3;

	private int maxSub_;

	public const int IconFieldNumber = 4;

	private string icon_ = "";

	public const int BasicRewardFieldNumber = 5;

	private string basicReward_ = "";

	public const int BasicRewardPreviewFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_basicRewardPreview_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> basicRewardPreview_ = new RepeatedField<int>();

	public const int DoubleCheckMinLevelFieldNumber = 7;

	private int doubleCheckMinLevel_;

	public const int DesFieldNumber = 8;

	private string des_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<BdConvertContent> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(124);

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
	public RepeatedField<int> ConvertConditionList => convertConditionList_;

	[DebuggerNonUserCode]
	public int MaxSub
	{
		get
		{
			return maxSub_;
		}
		set
		{
			maxSub_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Icon
	{
		get
		{
			return icon_;
		}
		set
		{
			icon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BasicReward
	{
		get
		{
			return basicReward_;
		}
		set
		{
			basicReward_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> BasicRewardPreview => basicRewardPreview_;

	[DebuggerNonUserCode]
	public int DoubleCheckMinLevel
	{
		get
		{
			return doubleCheckMinLevel_;
		}
		set
		{
			doubleCheckMinLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Des
	{
		get
		{
			return des_;
		}
		set
		{
			des_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public BdConvertContent()
	{
	}

	[DebuggerNonUserCode]
	public BdConvertContent(BdConvertContent other)
		: this()
	{
		id_ = other.id_;
		convertConditionList_ = other.convertConditionList_.Clone();
		maxSub_ = other.maxSub_;
		icon_ = other.icon_;
		basicReward_ = other.basicReward_;
		basicRewardPreview_ = other.basicRewardPreview_.Clone();
		doubleCheckMinLevel_ = other.doubleCheckMinLevel_;
		des_ = other.des_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public BdConvertContent Clone()
	{
		return new BdConvertContent(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as BdConvertContent);
	}

	[DebuggerNonUserCode]
	public bool Equals(BdConvertContent other)
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
		if (!convertConditionList_.Equals(other.convertConditionList_))
		{
			return false;
		}
		if (MaxSub != other.MaxSub)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (BasicReward != other.BasicReward)
		{
			return false;
		}
		if (!basicRewardPreview_.Equals(other.basicRewardPreview_))
		{
			return false;
		}
		if (DoubleCheckMinLevel != other.DoubleCheckMinLevel)
		{
			return false;
		}
		if (Des != other.Des)
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
		num ^= convertConditionList_.GetHashCode();
		if (MaxSub != 0)
		{
			num ^= MaxSub.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (BasicReward.Length != 0)
		{
			num ^= BasicReward.GetHashCode();
		}
		num ^= basicRewardPreview_.GetHashCode();
		if (DoubleCheckMinLevel != 0)
		{
			num ^= DoubleCheckMinLevel.GetHashCode();
		}
		if (Des.Length != 0)
		{
			num ^= Des.GetHashCode();
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
		convertConditionList_.WriteTo(output, _repeated_convertConditionList_codec);
		if (MaxSub != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(MaxSub);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Icon);
		}
		if (BasicReward.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(BasicReward);
		}
		basicRewardPreview_.WriteTo(output, _repeated_basicRewardPreview_codec);
		if (DoubleCheckMinLevel != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(DoubleCheckMinLevel);
		}
		if (Des.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Des);
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
		num += convertConditionList_.CalculateSize(_repeated_convertConditionList_codec);
		if (MaxSub != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxSub);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (BasicReward.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BasicReward);
		}
		num += basicRewardPreview_.CalculateSize(_repeated_basicRewardPreview_codec);
		if (DoubleCheckMinLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DoubleCheckMinLevel);
		}
		if (Des.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Des);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(BdConvertContent other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			convertConditionList_.Add(other.convertConditionList_);
			if (other.MaxSub != 0)
			{
				MaxSub = other.MaxSub;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.BasicReward.Length != 0)
			{
				BasicReward = other.BasicReward;
			}
			basicRewardPreview_.Add(other.basicRewardPreview_);
			if (other.DoubleCheckMinLevel != 0)
			{
				DoubleCheckMinLevel = other.DoubleCheckMinLevel;
			}
			if (other.Des.Length != 0)
			{
				Des = other.Des;
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
				convertConditionList_.AddEntriesFrom(input, _repeated_convertConditionList_codec);
				break;
			case 24u:
				MaxSub = input.ReadInt32();
				break;
			case 34u:
				Icon = input.ReadString();
				break;
			case 42u:
				BasicReward = input.ReadString();
				break;
			case 48u:
			case 50u:
				basicRewardPreview_.AddEntriesFrom(input, _repeated_basicRewardPreview_codec);
				break;
			case 56u:
				DoubleCheckMinLevel = input.ReadInt32();
				break;
			case 66u:
				Des = input.ReadString();
				break;
			}
		}
	}
}
