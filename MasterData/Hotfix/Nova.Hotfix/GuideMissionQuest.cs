using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class GuideMissionQuest : IMessage<GuideMissionQuest>, IMessage, IEquatable<GuideMissionQuest>, IDeepCloneable<GuideMissionQuest>
{
	private static readonly MessageParser<GuideMissionQuest> _parser = new MessageParser<GuideMissionQuest>(() => new GuideMissionQuest());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int CompleteCondFieldNumber = 3;

	private int completeCond_;

	public const int CompleteParamsFieldNumber = 4;

	private string completeParams_ = "";

	public const int Reward1TidFieldNumber = 5;

	private int reward1Tid_;

	public const int Reward1QtyFieldNumber = 6;

	private int reward1Qty_;

	public const int Reward2TidFieldNumber = 7;

	private int reward2Tid_;

	public const int Reward2QqtyFieldNumber = 8;

	private int reward2Qqty_;

	public const int TitleFieldNumber = 9;

	private string title_ = "";

	public const int JumpToFieldNumber = 10;

	private int jumpTo_;

	public const int ClientCompleteCountFieldNumber = 11;

	private int clientCompleteCount_;

	[DebuggerNonUserCode]
	public static MessageParser<GuideMissionQuest> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(416);

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
	public int Reward2Tid
	{
		get
		{
			return reward2Tid_;
		}
		set
		{
			reward2Tid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward2Qqty
	{
		get
		{
			return reward2Qqty_;
		}
		set
		{
			reward2Qqty_ = value;
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
	public int ClientCompleteCount
	{
		get
		{
			return clientCompleteCount_;
		}
		set
		{
			clientCompleteCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public GuideMissionQuest()
	{
	}

	[DebuggerNonUserCode]
	public GuideMissionQuest(GuideMissionQuest other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		completeCond_ = other.completeCond_;
		completeParams_ = other.completeParams_;
		reward1Tid_ = other.reward1Tid_;
		reward1Qty_ = other.reward1Qty_;
		reward2Tid_ = other.reward2Tid_;
		reward2Qqty_ = other.reward2Qqty_;
		title_ = other.title_;
		jumpTo_ = other.jumpTo_;
		clientCompleteCount_ = other.clientCompleteCount_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public GuideMissionQuest Clone()
	{
		return new GuideMissionQuest(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as GuideMissionQuest);
	}

	[DebuggerNonUserCode]
	public bool Equals(GuideMissionQuest other)
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
		if (CompleteCond != other.CompleteCond)
		{
			return false;
		}
		if (CompleteParams != other.CompleteParams)
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
		if (Reward2Tid != other.Reward2Tid)
		{
			return false;
		}
		if (Reward2Qqty != other.Reward2Qqty)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (JumpTo != other.JumpTo)
		{
			return false;
		}
		if (ClientCompleteCount != other.ClientCompleteCount)
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
		if (CompleteCond != 0)
		{
			num ^= CompleteCond.GetHashCode();
		}
		if (CompleteParams.Length != 0)
		{
			num ^= CompleteParams.GetHashCode();
		}
		if (Reward1Tid != 0)
		{
			num ^= Reward1Tid.GetHashCode();
		}
		if (Reward1Qty != 0)
		{
			num ^= Reward1Qty.GetHashCode();
		}
		if (Reward2Tid != 0)
		{
			num ^= Reward2Tid.GetHashCode();
		}
		if (Reward2Qqty != 0)
		{
			num ^= Reward2Qqty.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (JumpTo != 0)
		{
			num ^= JumpTo.GetHashCode();
		}
		if (ClientCompleteCount != 0)
		{
			num ^= ClientCompleteCount.GetHashCode();
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
		if (CompleteCond != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CompleteCond);
		}
		if (CompleteParams.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(CompleteParams);
		}
		if (Reward1Tid != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Reward1Tid);
		}
		if (Reward1Qty != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Reward1Qty);
		}
		if (Reward2Tid != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Reward2Tid);
		}
		if (Reward2Qqty != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Reward2Qqty);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Title);
		}
		if (JumpTo != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(JumpTo);
		}
		if (ClientCompleteCount != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(ClientCompleteCount);
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
		if (CompleteCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CompleteCond);
		}
		if (CompleteParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CompleteParams);
		}
		if (Reward1Tid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward1Tid);
		}
		if (Reward1Qty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward1Qty);
		}
		if (Reward2Tid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward2Tid);
		}
		if (Reward2Qqty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward2Qqty);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (JumpTo != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(JumpTo);
		}
		if (ClientCompleteCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ClientCompleteCount);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(GuideMissionQuest other)
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
			if (other.CompleteCond != 0)
			{
				CompleteCond = other.CompleteCond;
			}
			if (other.CompleteParams.Length != 0)
			{
				CompleteParams = other.CompleteParams;
			}
			if (other.Reward1Tid != 0)
			{
				Reward1Tid = other.Reward1Tid;
			}
			if (other.Reward1Qty != 0)
			{
				Reward1Qty = other.Reward1Qty;
			}
			if (other.Reward2Tid != 0)
			{
				Reward2Tid = other.Reward2Tid;
			}
			if (other.Reward2Qqty != 0)
			{
				Reward2Qqty = other.Reward2Qqty;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.JumpTo != 0)
			{
				JumpTo = other.JumpTo;
			}
			if (other.ClientCompleteCount != 0)
			{
				ClientCompleteCount = other.ClientCompleteCount;
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
			case 24u:
				CompleteCond = input.ReadInt32();
				break;
			case 34u:
				CompleteParams = input.ReadString();
				break;
			case 40u:
				Reward1Tid = input.ReadInt32();
				break;
			case 48u:
				Reward1Qty = input.ReadInt32();
				break;
			case 56u:
				Reward2Tid = input.ReadInt32();
				break;
			case 64u:
				Reward2Qqty = input.ReadInt32();
				break;
			case 74u:
				Title = input.ReadString();
				break;
			case 80u:
				JumpTo = input.ReadInt32();
				break;
			case 88u:
				ClientCompleteCount = input.ReadInt32();
				break;
			}
		}
	}
}
