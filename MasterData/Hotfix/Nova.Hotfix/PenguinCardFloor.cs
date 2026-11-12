using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PenguinCardFloor : IMessage<PenguinCardFloor>, IMessage, IEquatable<PenguinCardFloor>, IDeepCloneable<PenguinCardFloor>
{
	private static readonly MessageParser<PenguinCardFloor> _parser = new MessageParser<PenguinCardFloor>(() => new PenguinCardFloor());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int MaxTurnFieldNumber = 2;

	private int maxTurn_;

	public const int InitialScoreFieldNumber = 3;

	private int initialScore_;

	public const int InitialSlotFieldNumber = 4;

	private int initialSlot_;

	public const int InitialRoundFieldNumber = 5;

	private int initialRound_;

	public const int InitialCheckRoundFieldNumber = 6;

	private int initialCheckRound_;

	public const int InitialBuyLimitFieldNumber = 7;

	private int initialBuyLimit_;

	public const int WeightGroupFieldNumber = 8;

	private int weightGroup_;

	public const int PoolIdFieldNumber = 9;

	private int poolId_;

	public const int QuestTurnFieldNumber = 10;

	private int questTurn_;

	public const int QuestGroupFieldNumber = 11;

	private int questGroup_;

	public const int FixedTurnFieldNumber = 12;

	private int fixedTurn_;

	public const int FloortipsFieldNumber = 13;

	private string floortips_ = "";

	public const int ShowWinFieldNumber = 14;

	private bool showWin_;

	public const int EndlessGroupFieldNumber = 15;

	private int endlessGroup_;

	public const int FloorDescFieldNumber = 16;

	private string floorDesc_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<PenguinCardFloor> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(632);

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
	public int MaxTurn
	{
		get
		{
			return maxTurn_;
		}
		set
		{
			maxTurn_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int InitialScore
	{
		get
		{
			return initialScore_;
		}
		set
		{
			initialScore_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int InitialSlot
	{
		get
		{
			return initialSlot_;
		}
		set
		{
			initialSlot_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int InitialRound
	{
		get
		{
			return initialRound_;
		}
		set
		{
			initialRound_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int InitialCheckRound
	{
		get
		{
			return initialCheckRound_;
		}
		set
		{
			initialCheckRound_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int InitialBuyLimit
	{
		get
		{
			return initialBuyLimit_;
		}
		set
		{
			initialBuyLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WeightGroup
	{
		get
		{
			return weightGroup_;
		}
		set
		{
			weightGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PoolId
	{
		get
		{
			return poolId_;
		}
		set
		{
			poolId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int QuestTurn
	{
		get
		{
			return questTurn_;
		}
		set
		{
			questTurn_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int QuestGroup
	{
		get
		{
			return questGroup_;
		}
		set
		{
			questGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FixedTurn
	{
		get
		{
			return fixedTurn_;
		}
		set
		{
			fixedTurn_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Floortips
	{
		get
		{
			return floortips_;
		}
		set
		{
			floortips_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool ShowWin
	{
		get
		{
			return showWin_;
		}
		set
		{
			showWin_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EndlessGroup
	{
		get
		{
			return endlessGroup_;
		}
		set
		{
			endlessGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string FloorDesc
	{
		get
		{
			return floorDesc_;
		}
		set
		{
			floorDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public PenguinCardFloor()
	{
	}

	[DebuggerNonUserCode]
	public PenguinCardFloor(PenguinCardFloor other)
		: this()
	{
		id_ = other.id_;
		maxTurn_ = other.maxTurn_;
		initialScore_ = other.initialScore_;
		initialSlot_ = other.initialSlot_;
		initialRound_ = other.initialRound_;
		initialCheckRound_ = other.initialCheckRound_;
		initialBuyLimit_ = other.initialBuyLimit_;
		weightGroup_ = other.weightGroup_;
		poolId_ = other.poolId_;
		questTurn_ = other.questTurn_;
		questGroup_ = other.questGroup_;
		fixedTurn_ = other.fixedTurn_;
		floortips_ = other.floortips_;
		showWin_ = other.showWin_;
		endlessGroup_ = other.endlessGroup_;
		floorDesc_ = other.floorDesc_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PenguinCardFloor Clone()
	{
		return new PenguinCardFloor(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PenguinCardFloor);
	}

	[DebuggerNonUserCode]
	public bool Equals(PenguinCardFloor other)
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
		if (MaxTurn != other.MaxTurn)
		{
			return false;
		}
		if (InitialScore != other.InitialScore)
		{
			return false;
		}
		if (InitialSlot != other.InitialSlot)
		{
			return false;
		}
		if (InitialRound != other.InitialRound)
		{
			return false;
		}
		if (InitialCheckRound != other.InitialCheckRound)
		{
			return false;
		}
		if (InitialBuyLimit != other.InitialBuyLimit)
		{
			return false;
		}
		if (WeightGroup != other.WeightGroup)
		{
			return false;
		}
		if (PoolId != other.PoolId)
		{
			return false;
		}
		if (QuestTurn != other.QuestTurn)
		{
			return false;
		}
		if (QuestGroup != other.QuestGroup)
		{
			return false;
		}
		if (FixedTurn != other.FixedTurn)
		{
			return false;
		}
		if (Floortips != other.Floortips)
		{
			return false;
		}
		if (ShowWin != other.ShowWin)
		{
			return false;
		}
		if (EndlessGroup != other.EndlessGroup)
		{
			return false;
		}
		if (FloorDesc != other.FloorDesc)
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
		if (MaxTurn != 0)
		{
			num ^= MaxTurn.GetHashCode();
		}
		if (InitialScore != 0)
		{
			num ^= InitialScore.GetHashCode();
		}
		if (InitialSlot != 0)
		{
			num ^= InitialSlot.GetHashCode();
		}
		if (InitialRound != 0)
		{
			num ^= InitialRound.GetHashCode();
		}
		if (InitialCheckRound != 0)
		{
			num ^= InitialCheckRound.GetHashCode();
		}
		if (InitialBuyLimit != 0)
		{
			num ^= InitialBuyLimit.GetHashCode();
		}
		if (WeightGroup != 0)
		{
			num ^= WeightGroup.GetHashCode();
		}
		if (PoolId != 0)
		{
			num ^= PoolId.GetHashCode();
		}
		if (QuestTurn != 0)
		{
			num ^= QuestTurn.GetHashCode();
		}
		if (QuestGroup != 0)
		{
			num ^= QuestGroup.GetHashCode();
		}
		if (FixedTurn != 0)
		{
			num ^= FixedTurn.GetHashCode();
		}
		if (Floortips.Length != 0)
		{
			num ^= Floortips.GetHashCode();
		}
		if (ShowWin)
		{
			num ^= ShowWin.GetHashCode();
		}
		if (EndlessGroup != 0)
		{
			num ^= EndlessGroup.GetHashCode();
		}
		if (FloorDesc.Length != 0)
		{
			num ^= FloorDesc.GetHashCode();
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
		if (MaxTurn != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(MaxTurn);
		}
		if (InitialScore != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(InitialScore);
		}
		if (InitialSlot != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(InitialSlot);
		}
		if (InitialRound != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(InitialRound);
		}
		if (InitialCheckRound != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(InitialCheckRound);
		}
		if (InitialBuyLimit != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(InitialBuyLimit);
		}
		if (WeightGroup != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(WeightGroup);
		}
		if (PoolId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(PoolId);
		}
		if (QuestTurn != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(QuestTurn);
		}
		if (QuestGroup != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(QuestGroup);
		}
		if (FixedTurn != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(FixedTurn);
		}
		if (Floortips.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(Floortips);
		}
		if (ShowWin)
		{
			output.WriteRawTag(112);
			output.WriteBool(ShowWin);
		}
		if (EndlessGroup != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(EndlessGroup);
		}
		if (FloorDesc.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(FloorDesc);
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
		if (MaxTurn != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxTurn);
		}
		if (InitialScore != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(InitialScore);
		}
		if (InitialSlot != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(InitialSlot);
		}
		if (InitialRound != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(InitialRound);
		}
		if (InitialCheckRound != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(InitialCheckRound);
		}
		if (InitialBuyLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(InitialBuyLimit);
		}
		if (WeightGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WeightGroup);
		}
		if (PoolId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PoolId);
		}
		if (QuestTurn != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(QuestTurn);
		}
		if (QuestGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(QuestGroup);
		}
		if (FixedTurn != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FixedTurn);
		}
		if (Floortips.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Floortips);
		}
		if (ShowWin)
		{
			num += 2;
		}
		if (EndlessGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EndlessGroup);
		}
		if (FloorDesc.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(FloorDesc);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PenguinCardFloor other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.MaxTurn != 0)
			{
				MaxTurn = other.MaxTurn;
			}
			if (other.InitialScore != 0)
			{
				InitialScore = other.InitialScore;
			}
			if (other.InitialSlot != 0)
			{
				InitialSlot = other.InitialSlot;
			}
			if (other.InitialRound != 0)
			{
				InitialRound = other.InitialRound;
			}
			if (other.InitialCheckRound != 0)
			{
				InitialCheckRound = other.InitialCheckRound;
			}
			if (other.InitialBuyLimit != 0)
			{
				InitialBuyLimit = other.InitialBuyLimit;
			}
			if (other.WeightGroup != 0)
			{
				WeightGroup = other.WeightGroup;
			}
			if (other.PoolId != 0)
			{
				PoolId = other.PoolId;
			}
			if (other.QuestTurn != 0)
			{
				QuestTurn = other.QuestTurn;
			}
			if (other.QuestGroup != 0)
			{
				QuestGroup = other.QuestGroup;
			}
			if (other.FixedTurn != 0)
			{
				FixedTurn = other.FixedTurn;
			}
			if (other.Floortips.Length != 0)
			{
				Floortips = other.Floortips;
			}
			if (other.ShowWin)
			{
				ShowWin = other.ShowWin;
			}
			if (other.EndlessGroup != 0)
			{
				EndlessGroup = other.EndlessGroup;
			}
			if (other.FloorDesc.Length != 0)
			{
				FloorDesc = other.FloorDesc;
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
				MaxTurn = input.ReadInt32();
				break;
			case 24u:
				InitialScore = input.ReadInt32();
				break;
			case 32u:
				InitialSlot = input.ReadInt32();
				break;
			case 40u:
				InitialRound = input.ReadInt32();
				break;
			case 48u:
				InitialCheckRound = input.ReadInt32();
				break;
			case 56u:
				InitialBuyLimit = input.ReadInt32();
				break;
			case 64u:
				WeightGroup = input.ReadInt32();
				break;
			case 72u:
				PoolId = input.ReadInt32();
				break;
			case 80u:
				QuestTurn = input.ReadInt32();
				break;
			case 88u:
				QuestGroup = input.ReadInt32();
				break;
			case 96u:
				FixedTurn = input.ReadInt32();
				break;
			case 106u:
				Floortips = input.ReadString();
				break;
			case 112u:
				ShowWin = input.ReadBool();
				break;
			case 120u:
				EndlessGroup = input.ReadInt32();
				break;
			case 130u:
				FloorDesc = input.ReadString();
				break;
			}
		}
	}
}
