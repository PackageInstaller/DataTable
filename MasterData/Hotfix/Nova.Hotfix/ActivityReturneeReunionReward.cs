using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityReturneeReunionReward : IMessage<ActivityReturneeReunionReward>, IMessage, IEquatable<ActivityReturneeReunionReward>, IDeepCloneable<ActivityReturneeReunionReward>
{
	private static readonly MessageParser<ActivityReturneeReunionReward> _parser = new MessageParser<ActivityReturneeReunionReward>(() => new ActivityReturneeReunionReward());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int Reward1TidFieldNumber = 2;

	private int reward1Tid_;

	public const int Reward1QtyFieldNumber = 3;

	private int reward1Qty_;

	public const int Reward2TidFieldNumber = 4;

	private int reward2Tid_;

	public const int Reward2QtyFieldNumber = 5;

	private int reward2Qty_;

	public const int Reward3TidFieldNumber = 6;

	private int reward3Tid_;

	public const int Reward3QtyFieldNumber = 7;

	private int reward3Qty_;

	public const int PopUpResFieldNumber = 8;

	private string popUpRes_ = "";

	public const int ScriptNameFieldNumber = 9;

	private string scriptName_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<ActivityReturneeReunionReward> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(48);

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
	public int Reward2Qty
	{
		get
		{
			return reward2Qty_;
		}
		set
		{
			reward2Qty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward3Tid
	{
		get
		{
			return reward3Tid_;
		}
		set
		{
			reward3Tid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward3Qty
	{
		get
		{
			return reward3Qty_;
		}
		set
		{
			reward3Qty_ = value;
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
	public ActivityReturneeReunionReward()
	{
	}

	[DebuggerNonUserCode]
	public ActivityReturneeReunionReward(ActivityReturneeReunionReward other)
		: this()
	{
		id_ = other.id_;
		reward1Tid_ = other.reward1Tid_;
		reward1Qty_ = other.reward1Qty_;
		reward2Tid_ = other.reward2Tid_;
		reward2Qty_ = other.reward2Qty_;
		reward3Tid_ = other.reward3Tid_;
		reward3Qty_ = other.reward3Qty_;
		popUpRes_ = other.popUpRes_;
		scriptName_ = other.scriptName_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityReturneeReunionReward Clone()
	{
		return new ActivityReturneeReunionReward(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityReturneeReunionReward);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityReturneeReunionReward other)
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
		if (Reward2Qty != other.Reward2Qty)
		{
			return false;
		}
		if (Reward3Tid != other.Reward3Tid)
		{
			return false;
		}
		if (Reward3Qty != other.Reward3Qty)
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
		if (Reward2Qty != 0)
		{
			num ^= Reward2Qty.GetHashCode();
		}
		if (Reward3Tid != 0)
		{
			num ^= Reward3Tid.GetHashCode();
		}
		if (Reward3Qty != 0)
		{
			num ^= Reward3Qty.GetHashCode();
		}
		if (PopUpRes.Length != 0)
		{
			num ^= PopUpRes.GetHashCode();
		}
		if (ScriptName.Length != 0)
		{
			num ^= ScriptName.GetHashCode();
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
		if (Reward1Tid != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Reward1Tid);
		}
		if (Reward1Qty != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Reward1Qty);
		}
		if (Reward2Tid != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Reward2Tid);
		}
		if (Reward2Qty != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Reward2Qty);
		}
		if (Reward3Tid != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Reward3Tid);
		}
		if (Reward3Qty != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Reward3Qty);
		}
		if (PopUpRes.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(PopUpRes);
		}
		if (ScriptName.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(ScriptName);
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
		if (Reward2Qty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward2Qty);
		}
		if (Reward3Tid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward3Tid);
		}
		if (Reward3Qty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward3Qty);
		}
		if (PopUpRes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PopUpRes);
		}
		if (ScriptName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ScriptName);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityReturneeReunionReward other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
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
			if (other.Reward2Qty != 0)
			{
				Reward2Qty = other.Reward2Qty;
			}
			if (other.Reward3Tid != 0)
			{
				Reward3Tid = other.Reward3Tid;
			}
			if (other.Reward3Qty != 0)
			{
				Reward3Qty = other.Reward3Qty;
			}
			if (other.PopUpRes.Length != 0)
			{
				PopUpRes = other.PopUpRes;
			}
			if (other.ScriptName.Length != 0)
			{
				ScriptName = other.ScriptName;
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
				Reward1Tid = input.ReadInt32();
				break;
			case 24u:
				Reward1Qty = input.ReadInt32();
				break;
			case 32u:
				Reward2Tid = input.ReadInt32();
				break;
			case 40u:
				Reward2Qty = input.ReadInt32();
				break;
			case 48u:
				Reward3Tid = input.ReadInt32();
				break;
			case 56u:
				Reward3Qty = input.ReadInt32();
				break;
			case 66u:
				PopUpRes = input.ReadString();
				break;
			case 74u:
				ScriptName = input.ReadString();
				break;
			}
		}
	}
}
