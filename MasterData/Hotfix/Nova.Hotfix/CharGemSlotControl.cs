using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CharGemSlotControl : IMessage<CharGemSlotControl>, IMessage, IEquatable<CharGemSlotControl>, IDeepCloneable<CharGemSlotControl>
{
	private static readonly MessageParser<CharGemSlotControl> _parser = new MessageParser<CharGemSlotControl>(() => new CharGemSlotControl());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int PositionFieldNumber = 2;

	private int position_;

	public const int GeneratenCostQtyFieldNumber = 3;

	private int generatenCostQty_;

	public const int RefreshCostQtyFieldNumber = 4;

	private int refreshCostQty_;

	public const int OverlockCostQtyFieldNumber = 5;

	private int overlockCostQty_;

	public const int OverlockDoraCostQtyFieldNumber = 6;

	private int overlockDoraCostQty_;

	public const int LockableNumFieldNumber = 7;

	private int lockableNum_;

	public const int MaxAlterNumFieldNumber = 8;

	private int maxAlterNum_;

	public const int UnlockLevelFieldNumber = 9;

	private int unlockLevel_;

	public const int LockItemTidFieldNumber = 10;

	private int lockItemTid_;

	public const int LockItemQtyFieldNumber = 11;

	private int lockItemQty_;

	[DebuggerNonUserCode]
	public static MessageParser<CharGemSlotControl> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(198);

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
	public int Position
	{
		get
		{
			return position_;
		}
		set
		{
			position_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GeneratenCostQty
	{
		get
		{
			return generatenCostQty_;
		}
		set
		{
			generatenCostQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RefreshCostQty
	{
		get
		{
			return refreshCostQty_;
		}
		set
		{
			refreshCostQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int OverlockCostQty
	{
		get
		{
			return overlockCostQty_;
		}
		set
		{
			overlockCostQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int OverlockDoraCostQty
	{
		get
		{
			return overlockDoraCostQty_;
		}
		set
		{
			overlockDoraCostQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LockableNum
	{
		get
		{
			return lockableNum_;
		}
		set
		{
			lockableNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MaxAlterNum
	{
		get
		{
			return maxAlterNum_;
		}
		set
		{
			maxAlterNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UnlockLevel
	{
		get
		{
			return unlockLevel_;
		}
		set
		{
			unlockLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LockItemTid
	{
		get
		{
			return lockItemTid_;
		}
		set
		{
			lockItemTid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LockItemQty
	{
		get
		{
			return lockItemQty_;
		}
		set
		{
			lockItemQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public CharGemSlotControl()
	{
	}

	[DebuggerNonUserCode]
	public CharGemSlotControl(CharGemSlotControl other)
		: this()
	{
		id_ = other.id_;
		position_ = other.position_;
		generatenCostQty_ = other.generatenCostQty_;
		refreshCostQty_ = other.refreshCostQty_;
		overlockCostQty_ = other.overlockCostQty_;
		overlockDoraCostQty_ = other.overlockDoraCostQty_;
		lockableNum_ = other.lockableNum_;
		maxAlterNum_ = other.maxAlterNum_;
		unlockLevel_ = other.unlockLevel_;
		lockItemTid_ = other.lockItemTid_;
		lockItemQty_ = other.lockItemQty_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CharGemSlotControl Clone()
	{
		return new CharGemSlotControl(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharGemSlotControl);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharGemSlotControl other)
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
		if (Position != other.Position)
		{
			return false;
		}
		if (GeneratenCostQty != other.GeneratenCostQty)
		{
			return false;
		}
		if (RefreshCostQty != other.RefreshCostQty)
		{
			return false;
		}
		if (OverlockCostQty != other.OverlockCostQty)
		{
			return false;
		}
		if (OverlockDoraCostQty != other.OverlockDoraCostQty)
		{
			return false;
		}
		if (LockableNum != other.LockableNum)
		{
			return false;
		}
		if (MaxAlterNum != other.MaxAlterNum)
		{
			return false;
		}
		if (UnlockLevel != other.UnlockLevel)
		{
			return false;
		}
		if (LockItemTid != other.LockItemTid)
		{
			return false;
		}
		if (LockItemQty != other.LockItemQty)
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
		if (Position != 0)
		{
			num ^= Position.GetHashCode();
		}
		if (GeneratenCostQty != 0)
		{
			num ^= GeneratenCostQty.GetHashCode();
		}
		if (RefreshCostQty != 0)
		{
			num ^= RefreshCostQty.GetHashCode();
		}
		if (OverlockCostQty != 0)
		{
			num ^= OverlockCostQty.GetHashCode();
		}
		if (OverlockDoraCostQty != 0)
		{
			num ^= OverlockDoraCostQty.GetHashCode();
		}
		if (LockableNum != 0)
		{
			num ^= LockableNum.GetHashCode();
		}
		if (MaxAlterNum != 0)
		{
			num ^= MaxAlterNum.GetHashCode();
		}
		if (UnlockLevel != 0)
		{
			num ^= UnlockLevel.GetHashCode();
		}
		if (LockItemTid != 0)
		{
			num ^= LockItemTid.GetHashCode();
		}
		if (LockItemQty != 0)
		{
			num ^= LockItemQty.GetHashCode();
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
		if (Position != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Position);
		}
		if (GeneratenCostQty != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(GeneratenCostQty);
		}
		if (RefreshCostQty != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(RefreshCostQty);
		}
		if (OverlockCostQty != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(OverlockCostQty);
		}
		if (OverlockDoraCostQty != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(OverlockDoraCostQty);
		}
		if (LockableNum != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(LockableNum);
		}
		if (MaxAlterNum != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(MaxAlterNum);
		}
		if (UnlockLevel != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(UnlockLevel);
		}
		if (LockItemTid != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(LockItemTid);
		}
		if (LockItemQty != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(LockItemQty);
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
		if (Position != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Position);
		}
		if (GeneratenCostQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GeneratenCostQty);
		}
		if (RefreshCostQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RefreshCostQty);
		}
		if (OverlockCostQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OverlockCostQty);
		}
		if (OverlockDoraCostQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OverlockDoraCostQty);
		}
		if (LockableNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LockableNum);
		}
		if (MaxAlterNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxAlterNum);
		}
		if (UnlockLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockLevel);
		}
		if (LockItemTid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LockItemTid);
		}
		if (LockItemQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LockItemQty);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CharGemSlotControl other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Position != 0)
			{
				Position = other.Position;
			}
			if (other.GeneratenCostQty != 0)
			{
				GeneratenCostQty = other.GeneratenCostQty;
			}
			if (other.RefreshCostQty != 0)
			{
				RefreshCostQty = other.RefreshCostQty;
			}
			if (other.OverlockCostQty != 0)
			{
				OverlockCostQty = other.OverlockCostQty;
			}
			if (other.OverlockDoraCostQty != 0)
			{
				OverlockDoraCostQty = other.OverlockDoraCostQty;
			}
			if (other.LockableNum != 0)
			{
				LockableNum = other.LockableNum;
			}
			if (other.MaxAlterNum != 0)
			{
				MaxAlterNum = other.MaxAlterNum;
			}
			if (other.UnlockLevel != 0)
			{
				UnlockLevel = other.UnlockLevel;
			}
			if (other.LockItemTid != 0)
			{
				LockItemTid = other.LockItemTid;
			}
			if (other.LockItemQty != 0)
			{
				LockItemQty = other.LockItemQty;
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
				Position = input.ReadInt32();
				break;
			case 24u:
				GeneratenCostQty = input.ReadInt32();
				break;
			case 32u:
				RefreshCostQty = input.ReadInt32();
				break;
			case 40u:
				OverlockCostQty = input.ReadInt32();
				break;
			case 48u:
				OverlockDoraCostQty = input.ReadInt32();
				break;
			case 56u:
				LockableNum = input.ReadInt32();
				break;
			case 64u:
				MaxAlterNum = input.ReadInt32();
				break;
			case 72u:
				UnlockLevel = input.ReadInt32();
				break;
			case 80u:
				LockItemTid = input.ReadInt32();
				break;
			case 88u:
				LockItemQty = input.ReadInt32();
				break;
			}
		}
	}
}
