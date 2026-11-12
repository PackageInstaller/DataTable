using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityReturneeQuest : IMessage<ActivityReturneeQuest>, IMessage, IEquatable<ActivityReturneeQuest>, IDeepCloneable<ActivityReturneeQuest>
{
	private static readonly MessageParser<ActivityReturneeQuest> _parser = new MessageParser<ActivityReturneeQuest>(() => new ActivityReturneeQuest());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int TitleFieldNumber = 3;

	private string title_ = "";

	public const int CompleteCondFieldNumber = 4;

	private int completeCond_;

	public const int CompleteParamsFieldNumber = 5;

	private string completeParams_ = "";

	public const int JumpToFieldNumber = 6;

	private int jumpTo_;

	public const int Reward1TidFieldNumber = 7;

	private int reward1Tid_;

	public const int Reward1QtyFieldNumber = 8;

	private int reward1Qty_;

	[DebuggerNonUserCode]
	public static MessageParser<ActivityReturneeQuest> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(42);

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
	public int GroupId
	{
		get
		{
			return groupId_;
		}
		set
		{
			groupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Title
	{
		get
		{
			return title_;
		}
		set
		{
			title_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int CompleteCond
	{
		get
		{
			return completeCond_;
		}
		set
		{
			completeCond_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string CompleteParams
	{
		get
		{
			return completeParams_;
		}
		set
		{
			completeParams_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int JumpTo
	{
		get
		{
			return jumpTo_;
		}
		set
		{
			jumpTo_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward1Tid
	{
		get
		{
			return reward1Tid_;
		}
		set
		{
			reward1Tid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward1Qty
	{
		get
		{
			return reward1Qty_;
		}
		set
		{
			reward1Qty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ActivityReturneeQuest()
	{
	}

	[DebuggerNonUserCode]
	public ActivityReturneeQuest(ActivityReturneeQuest other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		title_ = other.title_;
		completeCond_ = other.completeCond_;
		completeParams_ = other.completeParams_;
		jumpTo_ = other.jumpTo_;
		reward1Tid_ = other.reward1Tid_;
		reward1Qty_ = other.reward1Qty_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityReturneeQuest Clone()
	{
		return new ActivityReturneeQuest(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityReturneeQuest);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityReturneeQuest other)
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
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (CompleteCond != other.CompleteCond)
		{
			return false;
		}
		if (CompleteParams != other.CompleteParams)
		{
			return false;
		}
		if (JumpTo != other.JumpTo)
		{
			return false;
		}
		if (Reward1Tid != other.Reward1Tid)
		{
			return false;
		}
		if (Reward1Qty != other.Reward1Qty)
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
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (CompleteCond != 0)
		{
			num ^= CompleteCond.GetHashCode();
		}
		if (CompleteParams.Length != 0)
		{
			num ^= CompleteParams.GetHashCode();
		}
		if (JumpTo != 0)
		{
			num ^= JumpTo.GetHashCode();
		}
		if (Reward1Tid != 0)
		{
			num ^= Reward1Tid.GetHashCode();
		}
		if (Reward1Qty != 0)
		{
			num ^= Reward1Qty.GetHashCode();
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
		if (GroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GroupId);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Title);
		}
		if (CompleteCond != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(CompleteCond);
		}
		if (CompleteParams.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(CompleteParams);
		}
		if (JumpTo != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(JumpTo);
		}
		if (Reward1Tid != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Reward1Tid);
		}
		if (Reward1Qty != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Reward1Qty);
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
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (CompleteCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CompleteCond);
		}
		if (CompleteParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CompleteParams);
		}
		if (JumpTo != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(JumpTo);
		}
		if (Reward1Tid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward1Tid);
		}
		if (Reward1Qty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward1Qty);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityReturneeQuest other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.CompleteCond != 0)
			{
				CompleteCond = other.CompleteCond;
			}
			if (other.CompleteParams.Length != 0)
			{
				CompleteParams = other.CompleteParams;
			}
			if (other.JumpTo != 0)
			{
				JumpTo = other.JumpTo;
			}
			if (other.Reward1Tid != 0)
			{
				Reward1Tid = other.Reward1Tid;
			}
			if (other.Reward1Qty != 0)
			{
				Reward1Qty = other.Reward1Qty;
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
				GroupId = input.ReadInt32();
				break;
			case 26u:
				Title = input.ReadString();
				break;
			case 32u:
				CompleteCond = input.ReadInt32();
				break;
			case 42u:
				CompleteParams = input.ReadString();
				break;
			case 48u:
				JumpTo = input.ReadInt32();
				break;
			case 56u:
				Reward1Tid = input.ReadInt32();
				break;
			case 64u:
				Reward1Qty = input.ReadInt32();
				break;
			}
		}
	}
}
