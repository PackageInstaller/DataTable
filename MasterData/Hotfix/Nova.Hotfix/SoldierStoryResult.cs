using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierStoryResult : IMessage<SoldierStoryResult>, IMessage, IEquatable<SoldierStoryResult>, IDeepCloneable<SoldierStoryResult>
{
	private static readonly MessageParser<SoldierStoryResult> _parser = new MessageParser<SoldierStoryResult>(() => new SoldierStoryResult());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int RewardIdFieldNumber = 2;

	private int rewardId_;

	public const int ResultTextFieldNumber = 3;

	private string resultText_ = "";

	public const int SetFlagFieldNumber = 4;

	private int setFlag_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierStoryResult> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(802);

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
	public int RewardId
	{
		get
		{
			return rewardId_;
		}
		set
		{
			rewardId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ResultText
	{
		get
		{
			return resultText_;
		}
		set
		{
			resultText_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int SetFlag
	{
		get
		{
			return setFlag_;
		}
		set
		{
			setFlag_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierStoryResult()
	{
	}

	[DebuggerNonUserCode]
	public SoldierStoryResult(SoldierStoryResult other)
		: this()
	{
		id_ = other.id_;
		rewardId_ = other.rewardId_;
		resultText_ = other.resultText_;
		setFlag_ = other.setFlag_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierStoryResult Clone()
	{
		return new SoldierStoryResult(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierStoryResult);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierStoryResult other)
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
		if (RewardId != other.RewardId)
		{
			return false;
		}
		if (ResultText != other.ResultText)
		{
			return false;
		}
		if (SetFlag != other.SetFlag)
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
		if (RewardId != 0)
		{
			num ^= RewardId.GetHashCode();
		}
		if (ResultText.Length != 0)
		{
			num ^= ResultText.GetHashCode();
		}
		if (SetFlag != 0)
		{
			num ^= SetFlag.GetHashCode();
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
		if (RewardId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(RewardId);
		}
		if (ResultText.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(ResultText);
		}
		if (SetFlag != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(SetFlag);
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
		if (RewardId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardId);
		}
		if (ResultText.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ResultText);
		}
		if (SetFlag != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SetFlag);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierStoryResult other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.RewardId != 0)
			{
				RewardId = other.RewardId;
			}
			if (other.ResultText.Length != 0)
			{
				ResultText = other.ResultText;
			}
			if (other.SetFlag != 0)
			{
				SetFlag = other.SetFlag;
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
				RewardId = input.ReadInt32();
				break;
			case 26u:
				ResultText = input.ReadString();
				break;
			case 32u:
				SetFlag = input.ReadInt32();
				break;
			}
		}
	}
}
