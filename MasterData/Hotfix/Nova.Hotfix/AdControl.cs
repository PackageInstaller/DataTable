using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class AdControl : IMessage<AdControl>, IMessage, IEquatable<AdControl>, IDeepCloneable<AdControl>
{
	private static readonly MessageParser<AdControl> _parser = new MessageParser<AdControl>(() => new AdControl());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int DesTextFieldNumber = 2;

	private string desText_ = "";

	public const int UIAssetsFieldNumber = 3;

	private string uIAssets_ = "";

	public const int CtrlNameFieldNumber = 4;

	private string ctrlName_ = "";

	public const int StartTimeFieldNumber = 5;

	private string startTime_ = "";

	public const int JumpToFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_jumpTo_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> jumpTo_ = new RepeatedField<int>();

	public const int RewardsGroupFieldNumber = 7;

	private string rewardsGroup_ = "";

	public const int IsMoveFieldNumber = 8;

	private bool isMove_;

	public const int IncludeActFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_includeAct_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> includeAct_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<AdControl> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(74);

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
	public RepeatedField<int> JumpTo => jumpTo_;

	[DebuggerNonUserCode]
	public string RewardsGroup
	{
		get
		{
			return rewardsGroup_;
		}
		set
		{
			rewardsGroup_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool IsMove
	{
		get
		{
			return isMove_;
		}
		set
		{
			isMove_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> IncludeAct => includeAct_;

	[DebuggerNonUserCode]
	public AdControl()
	{
	}

	[DebuggerNonUserCode]
	public AdControl(AdControl other)
		: this()
	{
		id_ = other.id_;
		desText_ = other.desText_;
		uIAssets_ = other.uIAssets_;
		ctrlName_ = other.ctrlName_;
		startTime_ = other.startTime_;
		jumpTo_ = other.jumpTo_.Clone();
		rewardsGroup_ = other.rewardsGroup_;
		isMove_ = other.isMove_;
		includeAct_ = other.includeAct_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public AdControl Clone()
	{
		return new AdControl(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as AdControl);
	}

	[DebuggerNonUserCode]
	public bool Equals(AdControl other)
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
		if (DesText != other.DesText)
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
		if (StartTime != other.StartTime)
		{
			return false;
		}
		if (!jumpTo_.Equals(other.jumpTo_))
		{
			return false;
		}
		if (RewardsGroup != other.RewardsGroup)
		{
			return false;
		}
		if (IsMove != other.IsMove)
		{
			return false;
		}
		if (!includeAct_.Equals(other.includeAct_))
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
		if (DesText.Length != 0)
		{
			num ^= DesText.GetHashCode();
		}
		if (UIAssets.Length != 0)
		{
			num ^= UIAssets.GetHashCode();
		}
		if (CtrlName.Length != 0)
		{
			num ^= CtrlName.GetHashCode();
		}
		if (StartTime.Length != 0)
		{
			num ^= StartTime.GetHashCode();
		}
		num ^= jumpTo_.GetHashCode();
		if (RewardsGroup.Length != 0)
		{
			num ^= RewardsGroup.GetHashCode();
		}
		if (IsMove)
		{
			num ^= IsMove.GetHashCode();
		}
		num ^= includeAct_.GetHashCode();
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
		if (DesText.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(DesText);
		}
		if (UIAssets.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(UIAssets);
		}
		if (CtrlName.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(CtrlName);
		}
		if (StartTime.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(StartTime);
		}
		jumpTo_.WriteTo(output, _repeated_jumpTo_codec);
		if (RewardsGroup.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(RewardsGroup);
		}
		if (IsMove)
		{
			output.WriteRawTag(64);
			output.WriteBool(IsMove);
		}
		includeAct_.WriteTo(output, _repeated_includeAct_codec);
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
		if (DesText.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DesText);
		}
		if (UIAssets.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(UIAssets);
		}
		if (CtrlName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CtrlName);
		}
		if (StartTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StartTime);
		}
		num += jumpTo_.CalculateSize(_repeated_jumpTo_codec);
		if (RewardsGroup.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RewardsGroup);
		}
		if (IsMove)
		{
			num += 2;
		}
		num += includeAct_.CalculateSize(_repeated_includeAct_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(AdControl other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.DesText.Length != 0)
			{
				DesText = other.DesText;
			}
			if (other.UIAssets.Length != 0)
			{
				UIAssets = other.UIAssets;
			}
			if (other.CtrlName.Length != 0)
			{
				CtrlName = other.CtrlName;
			}
			if (other.StartTime.Length != 0)
			{
				StartTime = other.StartTime;
			}
			jumpTo_.Add(other.jumpTo_);
			if (other.RewardsGroup.Length != 0)
			{
				RewardsGroup = other.RewardsGroup;
			}
			if (other.IsMove)
			{
				IsMove = other.IsMove;
			}
			includeAct_.Add(other.includeAct_);
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
				DesText = input.ReadString();
				break;
			case 26u:
				UIAssets = input.ReadString();
				break;
			case 34u:
				CtrlName = input.ReadString();
				break;
			case 42u:
				StartTime = input.ReadString();
				break;
			case 48u:
			case 50u:
				jumpTo_.AddEntriesFrom(input, _repeated_jumpTo_codec);
				break;
			case 58u:
				RewardsGroup = input.ReadString();
				break;
			case 64u:
				IsMove = input.ReadBool();
				break;
			case 72u:
			case 74u:
				includeAct_.AddEntriesFrom(input, _repeated_includeAct_codec);
				break;
			}
		}
	}
}
