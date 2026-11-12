using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PopUp : IMessage<PopUp>, IMessage, IEquatable<PopUp>, IDeepCloneable<PopUp>
{
	private static readonly MessageParser<PopUp> _parser = new MessageParser<PopUp>(() => new PopUp());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int SortIdFieldNumber = 2;

	private int sortId_;

	public const int PopUpTypeFieldNumber = 3;

	private int popUpType_;

	public const int ActivityIdFieldNumber = 4;

	private int activityId_;

	public const int PopUpResFieldNumber = 5;

	private string popUpRes_ = "";

	public const int ScriptNameFieldNumber = 6;

	private string scriptName_ = "";

	public const int ScriptParamsFieldNumber = 7;

	private string scriptParams_ = "";

	public const int PopRefreshTypeFieldNumber = 8;

	private int popRefreshType_;

	public const int PopJumpTypeFieldNumber = 9;

	private int popJumpType_;

	public const int JumpToParamsFieldNumber = 10;

	private int jumpToParams_;

	public const int StartCondTypeFieldNumber = 11;

	private int startCondType_;

	public const int StartCondParamsFieldNumber = 12;

	private static readonly FieldCodec<int> _repeated_startCondParams_codec = FieldCodec.ForInt32(98u);

	private readonly RepeatedField<int> startCondParams_ = new RepeatedField<int>();

	public const int StartTypeFieldNumber = 13;

	private int startType_;

	public const int StartTimeFieldNumber = 14;

	private string startTime_ = "";

	public const int EndTypeFieldNumber = 15;

	private int endType_;

	public const int EndTimeFieldNumber = 16;

	private string endTime_ = "";

	public const int EndDurationFieldNumber = 17;

	private int endDuration_;

	[DebuggerNonUserCode]
	public static MessageParser<PopUp> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(654);

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
	public int SortId
	{
		get
		{
			return sortId_;
		}
		set
		{
			sortId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PopUpType
	{
		get
		{
			return popUpType_;
		}
		set
		{
			popUpType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ActivityId
	{
		get
		{
			return activityId_;
		}
		set
		{
			activityId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string PopUpRes
	{
		get
		{
			return popUpRes_;
		}
		set
		{
			popUpRes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ScriptName
	{
		get
		{
			return scriptName_;
		}
		set
		{
			scriptName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ScriptParams
	{
		get
		{
			return scriptParams_;
		}
		set
		{
			scriptParams_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int PopRefreshType
	{
		get
		{
			return popRefreshType_;
		}
		set
		{
			popRefreshType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PopJumpType
	{
		get
		{
			return popJumpType_;
		}
		set
		{
			popJumpType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int JumpToParams
	{
		get
		{
			return jumpToParams_;
		}
		set
		{
			jumpToParams_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int StartCondType
	{
		get
		{
			return startCondType_;
		}
		set
		{
			startCondType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> StartCondParams => startCondParams_;

	[DebuggerNonUserCode]
	public int StartType
	{
		get
		{
			return startType_;
		}
		set
		{
			startType_ = value;
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
	public int EndType
	{
		get
		{
			return endType_;
		}
		set
		{
			endType_ = value;
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
	public int EndDuration
	{
		get
		{
			return endDuration_;
		}
		set
		{
			endDuration_ = value;
		}
	}

	[DebuggerNonUserCode]
	public PopUp()
	{
	}

	[DebuggerNonUserCode]
	public PopUp(PopUp other)
		: this()
	{
		id_ = other.id_;
		sortId_ = other.sortId_;
		popUpType_ = other.popUpType_;
		activityId_ = other.activityId_;
		popUpRes_ = other.popUpRes_;
		scriptName_ = other.scriptName_;
		scriptParams_ = other.scriptParams_;
		popRefreshType_ = other.popRefreshType_;
		popJumpType_ = other.popJumpType_;
		jumpToParams_ = other.jumpToParams_;
		startCondType_ = other.startCondType_;
		startCondParams_ = other.startCondParams_.Clone();
		startType_ = other.startType_;
		startTime_ = other.startTime_;
		endType_ = other.endType_;
		endTime_ = other.endTime_;
		endDuration_ = other.endDuration_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PopUp Clone()
	{
		return new PopUp(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PopUp);
	}

	[DebuggerNonUserCode]
	public bool Equals(PopUp other)
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
		if (SortId != other.SortId)
		{
			return false;
		}
		if (PopUpType != other.PopUpType)
		{
			return false;
		}
		if (ActivityId != other.ActivityId)
		{
			return false;
		}
		if (PopUpRes != other.PopUpRes)
		{
			return false;
		}
		if (ScriptName != other.ScriptName)
		{
			return false;
		}
		if (ScriptParams != other.ScriptParams)
		{
			return false;
		}
		if (PopRefreshType != other.PopRefreshType)
		{
			return false;
		}
		if (PopJumpType != other.PopJumpType)
		{
			return false;
		}
		if (JumpToParams != other.JumpToParams)
		{
			return false;
		}
		if (StartCondType != other.StartCondType)
		{
			return false;
		}
		if (!startCondParams_.Equals(other.startCondParams_))
		{
			return false;
		}
		if (StartType != other.StartType)
		{
			return false;
		}
		if (StartTime != other.StartTime)
		{
			return false;
		}
		if (EndType != other.EndType)
		{
			return false;
		}
		if (EndTime != other.EndTime)
		{
			return false;
		}
		if (EndDuration != other.EndDuration)
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
		if (SortId != 0)
		{
			num ^= SortId.GetHashCode();
		}
		if (PopUpType != 0)
		{
			num ^= PopUpType.GetHashCode();
		}
		if (ActivityId != 0)
		{
			num ^= ActivityId.GetHashCode();
		}
		if (PopUpRes.Length != 0)
		{
			num ^= PopUpRes.GetHashCode();
		}
		if (ScriptName.Length != 0)
		{
			num ^= ScriptName.GetHashCode();
		}
		if (ScriptParams.Length != 0)
		{
			num ^= ScriptParams.GetHashCode();
		}
		if (PopRefreshType != 0)
		{
			num ^= PopRefreshType.GetHashCode();
		}
		if (PopJumpType != 0)
		{
			num ^= PopJumpType.GetHashCode();
		}
		if (JumpToParams != 0)
		{
			num ^= JumpToParams.GetHashCode();
		}
		if (StartCondType != 0)
		{
			num ^= StartCondType.GetHashCode();
		}
		num ^= startCondParams_.GetHashCode();
		if (StartType != 0)
		{
			num ^= StartType.GetHashCode();
		}
		if (StartTime.Length != 0)
		{
			num ^= StartTime.GetHashCode();
		}
		if (EndType != 0)
		{
			num ^= EndType.GetHashCode();
		}
		if (EndTime.Length != 0)
		{
			num ^= EndTime.GetHashCode();
		}
		if (EndDuration != 0)
		{
			num ^= EndDuration.GetHashCode();
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
		if (SortId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(SortId);
		}
		if (PopUpType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(PopUpType);
		}
		if (ActivityId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ActivityId);
		}
		if (PopUpRes.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(PopUpRes);
		}
		if (ScriptName.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(ScriptName);
		}
		if (ScriptParams.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(ScriptParams);
		}
		if (PopRefreshType != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(PopRefreshType);
		}
		if (PopJumpType != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(PopJumpType);
		}
		if (JumpToParams != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(JumpToParams);
		}
		if (StartCondType != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(StartCondType);
		}
		startCondParams_.WriteTo(output, _repeated_startCondParams_codec);
		if (StartType != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(StartType);
		}
		if (StartTime.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(StartTime);
		}
		if (EndType != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(EndType);
		}
		if (EndTime.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(EndTime);
		}
		if (EndDuration != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(EndDuration);
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
		if (SortId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SortId);
		}
		if (PopUpType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PopUpType);
		}
		if (ActivityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityId);
		}
		if (PopUpRes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PopUpRes);
		}
		if (ScriptName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ScriptName);
		}
		if (ScriptParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ScriptParams);
		}
		if (PopRefreshType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PopRefreshType);
		}
		if (PopJumpType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PopJumpType);
		}
		if (JumpToParams != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(JumpToParams);
		}
		if (StartCondType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StartCondType);
		}
		num += startCondParams_.CalculateSize(_repeated_startCondParams_codec);
		if (StartType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StartType);
		}
		if (StartTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StartTime);
		}
		if (EndType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EndType);
		}
		if (EndTime.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(EndTime);
		}
		if (EndDuration != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EndDuration);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PopUp other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.SortId != 0)
			{
				SortId = other.SortId;
			}
			if (other.PopUpType != 0)
			{
				PopUpType = other.PopUpType;
			}
			if (other.ActivityId != 0)
			{
				ActivityId = other.ActivityId;
			}
			if (other.PopUpRes.Length != 0)
			{
				PopUpRes = other.PopUpRes;
			}
			if (other.ScriptName.Length != 0)
			{
				ScriptName = other.ScriptName;
			}
			if (other.ScriptParams.Length != 0)
			{
				ScriptParams = other.ScriptParams;
			}
			if (other.PopRefreshType != 0)
			{
				PopRefreshType = other.PopRefreshType;
			}
			if (other.PopJumpType != 0)
			{
				PopJumpType = other.PopJumpType;
			}
			if (other.JumpToParams != 0)
			{
				JumpToParams = other.JumpToParams;
			}
			if (other.StartCondType != 0)
			{
				StartCondType = other.StartCondType;
			}
			startCondParams_.Add(other.startCondParams_);
			if (other.StartType != 0)
			{
				StartType = other.StartType;
			}
			if (other.StartTime.Length != 0)
			{
				StartTime = other.StartTime;
			}
			if (other.EndType != 0)
			{
				EndType = other.EndType;
			}
			if (other.EndTime.Length != 0)
			{
				EndTime = other.EndTime;
			}
			if (other.EndDuration != 0)
			{
				EndDuration = other.EndDuration;
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
				SortId = input.ReadInt32();
				break;
			case 24u:
				PopUpType = input.ReadInt32();
				break;
			case 32u:
				ActivityId = input.ReadInt32();
				break;
			case 42u:
				PopUpRes = input.ReadString();
				break;
			case 50u:
				ScriptName = input.ReadString();
				break;
			case 58u:
				ScriptParams = input.ReadString();
				break;
			case 64u:
				PopRefreshType = input.ReadInt32();
				break;
			case 72u:
				PopJumpType = input.ReadInt32();
				break;
			case 80u:
				JumpToParams = input.ReadInt32();
				break;
			case 88u:
				StartCondType = input.ReadInt32();
				break;
			case 96u:
			case 98u:
				startCondParams_.AddEntriesFrom(input, _repeated_startCondParams_codec);
				break;
			case 104u:
				StartType = input.ReadInt32();
				break;
			case 114u:
				StartTime = input.ReadString();
				break;
			case 120u:
				EndType = input.ReadInt32();
				break;
			case 130u:
				EndTime = input.ReadString();
				break;
			case 136u:
				EndDuration = input.ReadInt32();
				break;
			}
		}
	}
}
