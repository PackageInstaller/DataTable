using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Chat : IMessage<Chat>, IMessage, IEquatable<Chat>, IDeepCloneable<Chat>
{
	private static readonly MessageParser<Chat> _parser = new MessageParser<Chat>(() => new Chat());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int AddressBookIdFieldNumber = 2;

	private int addressBookId_;

	public const int AVGIdFieldNumber = 3;

	private string aVGId_ = "";

	public const int AVGGroupIdFieldNumber = 4;

	private string aVGGroupId_ = "";

	public const int PreChatIdFieldNumber = 5;

	private int preChatId_;

	public const int PriorityFieldNumber = 6;

	private int priority_;

	public const int TriggerTypeFieldNumber = 7;

	private int triggerType_;

	public const int AutoPopUpFieldNumber = 8;

	private bool autoPopUp_;

	public const int TriggerCondFieldNumber = 9;

	private int triggerCond_;

	public const int TriggerCondParamFieldNumber = 10;

	private string triggerCondParam_ = "";

	public const int Reward1FieldNumber = 11;

	private int reward1_;

	public const int RewardQty1FieldNumber = 12;

	private int rewardQty1_;

	public const int Reward2FieldNumber = 13;

	private int reward2_;

	public const int RewardQty2FieldNumber = 14;

	private int rewardQty2_;

	public const int Reward3FieldNumber = 15;

	private int reward3_;

	public const int RewardQty3FieldNumber = 16;

	private int rewardQty3_;

	[DebuggerNonUserCode]
	public static MessageParser<Chat> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(210);

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
	public int AddressBookId
	{
		get
		{
			return addressBookId_;
		}
		set
		{
			addressBookId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string AVGId
	{
		get
		{
			return aVGId_;
		}
		set
		{
			aVGId_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int PreChatId
	{
		get
		{
			return preChatId_;
		}
		set
		{
			preChatId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Priority
	{
		get
		{
			return priority_;
		}
		set
		{
			priority_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TriggerType
	{
		get
		{
			return triggerType_;
		}
		set
		{
			triggerType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool AutoPopUp
	{
		get
		{
			return autoPopUp_;
		}
		set
		{
			autoPopUp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TriggerCond
	{
		get
		{
			return triggerCond_;
		}
		set
		{
			triggerCond_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string TriggerCondParam
	{
		get
		{
			return triggerCondParam_;
		}
		set
		{
			triggerCondParam_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Reward1
	{
		get
		{
			return reward1_;
		}
		set
		{
			reward1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardQty1
	{
		get
		{
			return rewardQty1_;
		}
		set
		{
			rewardQty1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward2
	{
		get
		{
			return reward2_;
		}
		set
		{
			reward2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardQty2
	{
		get
		{
			return rewardQty2_;
		}
		set
		{
			rewardQty2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward3
	{
		get
		{
			return reward3_;
		}
		set
		{
			reward3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardQty3
	{
		get
		{
			return rewardQty3_;
		}
		set
		{
			rewardQty3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Chat()
	{
	}

	[DebuggerNonUserCode]
	public Chat(Chat other)
		: this()
	{
		id_ = other.id_;
		addressBookId_ = other.addressBookId_;
		aVGId_ = other.aVGId_;
		aVGGroupId_ = other.aVGGroupId_;
		preChatId_ = other.preChatId_;
		priority_ = other.priority_;
		triggerType_ = other.triggerType_;
		autoPopUp_ = other.autoPopUp_;
		triggerCond_ = other.triggerCond_;
		triggerCondParam_ = other.triggerCondParam_;
		reward1_ = other.reward1_;
		rewardQty1_ = other.rewardQty1_;
		reward2_ = other.reward2_;
		rewardQty2_ = other.rewardQty2_;
		reward3_ = other.reward3_;
		rewardQty3_ = other.rewardQty3_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Chat Clone()
	{
		return new Chat(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Chat);
	}

	[DebuggerNonUserCode]
	public bool Equals(Chat other)
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
		if (AddressBookId != other.AddressBookId)
		{
			return false;
		}
		if (AVGId != other.AVGId)
		{
			return false;
		}
		if (AVGGroupId != other.AVGGroupId)
		{
			return false;
		}
		if (PreChatId != other.PreChatId)
		{
			return false;
		}
		if (Priority != other.Priority)
		{
			return false;
		}
		if (TriggerType != other.TriggerType)
		{
			return false;
		}
		if (AutoPopUp != other.AutoPopUp)
		{
			return false;
		}
		if (TriggerCond != other.TriggerCond)
		{
			return false;
		}
		if (TriggerCondParam != other.TriggerCondParam)
		{
			return false;
		}
		if (Reward1 != other.Reward1)
		{
			return false;
		}
		if (RewardQty1 != other.RewardQty1)
		{
			return false;
		}
		if (Reward2 != other.Reward2)
		{
			return false;
		}
		if (RewardQty2 != other.RewardQty2)
		{
			return false;
		}
		if (Reward3 != other.Reward3)
		{
			return false;
		}
		if (RewardQty3 != other.RewardQty3)
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
		if (AddressBookId != 0)
		{
			num ^= AddressBookId.GetHashCode();
		}
		if (AVGId.Length != 0)
		{
			num ^= AVGId.GetHashCode();
		}
		if (AVGGroupId.Length != 0)
		{
			num ^= AVGGroupId.GetHashCode();
		}
		if (PreChatId != 0)
		{
			num ^= PreChatId.GetHashCode();
		}
		if (Priority != 0)
		{
			num ^= Priority.GetHashCode();
		}
		if (TriggerType != 0)
		{
			num ^= TriggerType.GetHashCode();
		}
		if (AutoPopUp)
		{
			num ^= AutoPopUp.GetHashCode();
		}
		if (TriggerCond != 0)
		{
			num ^= TriggerCond.GetHashCode();
		}
		if (TriggerCondParam.Length != 0)
		{
			num ^= TriggerCondParam.GetHashCode();
		}
		if (Reward1 != 0)
		{
			num ^= Reward1.GetHashCode();
		}
		if (RewardQty1 != 0)
		{
			num ^= RewardQty1.GetHashCode();
		}
		if (Reward2 != 0)
		{
			num ^= Reward2.GetHashCode();
		}
		if (RewardQty2 != 0)
		{
			num ^= RewardQty2.GetHashCode();
		}
		if (Reward3 != 0)
		{
			num ^= Reward3.GetHashCode();
		}
		if (RewardQty3 != 0)
		{
			num ^= RewardQty3.GetHashCode();
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
		if (AddressBookId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(AddressBookId);
		}
		if (AVGId.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(AVGId);
		}
		if (AVGGroupId.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(AVGGroupId);
		}
		if (PreChatId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(PreChatId);
		}
		if (Priority != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Priority);
		}
		if (TriggerType != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(TriggerType);
		}
		if (AutoPopUp)
		{
			output.WriteRawTag(64);
			output.WriteBool(AutoPopUp);
		}
		if (TriggerCond != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(TriggerCond);
		}
		if (TriggerCondParam.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(TriggerCondParam);
		}
		if (Reward1 != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(Reward1);
		}
		if (RewardQty1 != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(RewardQty1);
		}
		if (Reward2 != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(Reward2);
		}
		if (RewardQty2 != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(RewardQty2);
		}
		if (Reward3 != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(Reward3);
		}
		if (RewardQty3 != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(RewardQty3);
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
		if (AddressBookId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AddressBookId);
		}
		if (AVGId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AVGId);
		}
		if (AVGGroupId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AVGGroupId);
		}
		if (PreChatId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreChatId);
		}
		if (Priority != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Priority);
		}
		if (TriggerType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TriggerType);
		}
		if (AutoPopUp)
		{
			num += 2;
		}
		if (TriggerCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TriggerCond);
		}
		if (TriggerCondParam.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TriggerCondParam);
		}
		if (Reward1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward1);
		}
		if (RewardQty1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardQty1);
		}
		if (Reward2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward2);
		}
		if (RewardQty2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardQty2);
		}
		if (Reward3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward3);
		}
		if (RewardQty3 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RewardQty3);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Chat other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.AddressBookId != 0)
			{
				AddressBookId = other.AddressBookId;
			}
			if (other.AVGId.Length != 0)
			{
				AVGId = other.AVGId;
			}
			if (other.AVGGroupId.Length != 0)
			{
				AVGGroupId = other.AVGGroupId;
			}
			if (other.PreChatId != 0)
			{
				PreChatId = other.PreChatId;
			}
			if (other.Priority != 0)
			{
				Priority = other.Priority;
			}
			if (other.TriggerType != 0)
			{
				TriggerType = other.TriggerType;
			}
			if (other.AutoPopUp)
			{
				AutoPopUp = other.AutoPopUp;
			}
			if (other.TriggerCond != 0)
			{
				TriggerCond = other.TriggerCond;
			}
			if (other.TriggerCondParam.Length != 0)
			{
				TriggerCondParam = other.TriggerCondParam;
			}
			if (other.Reward1 != 0)
			{
				Reward1 = other.Reward1;
			}
			if (other.RewardQty1 != 0)
			{
				RewardQty1 = other.RewardQty1;
			}
			if (other.Reward2 != 0)
			{
				Reward2 = other.Reward2;
			}
			if (other.RewardQty2 != 0)
			{
				RewardQty2 = other.RewardQty2;
			}
			if (other.Reward3 != 0)
			{
				Reward3 = other.Reward3;
			}
			if (other.RewardQty3 != 0)
			{
				RewardQty3 = other.RewardQty3;
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
				AddressBookId = input.ReadInt32();
				break;
			case 26u:
				AVGId = input.ReadString();
				break;
			case 34u:
				AVGGroupId = input.ReadString();
				break;
			case 40u:
				PreChatId = input.ReadInt32();
				break;
			case 48u:
				Priority = input.ReadInt32();
				break;
			case 56u:
				TriggerType = input.ReadInt32();
				break;
			case 64u:
				AutoPopUp = input.ReadBool();
				break;
			case 72u:
				TriggerCond = input.ReadInt32();
				break;
			case 82u:
				TriggerCondParam = input.ReadString();
				break;
			case 88u:
				Reward1 = input.ReadInt32();
				break;
			case 96u:
				RewardQty1 = input.ReadInt32();
				break;
			case 104u:
				Reward2 = input.ReadInt32();
				break;
			case 112u:
				RewardQty2 = input.ReadInt32();
				break;
			case 120u:
				Reward3 = input.ReadInt32();
				break;
			case 128u:
				RewardQty3 = input.ReadInt32();
				break;
			}
		}
	}
}
