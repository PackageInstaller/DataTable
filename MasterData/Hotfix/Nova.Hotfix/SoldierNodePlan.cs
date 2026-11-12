using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierNodePlan : IMessage<SoldierNodePlan>, IMessage, IEquatable<SoldierNodePlan>, IDeepCloneable<SoldierNodePlan>
{
	private static readonly MessageParser<SoldierNodePlan> _parser = new MessageParser<SoldierNodePlan>(() => new SoldierNodePlan());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NodeGroupIdFieldNumber = 2;

	private int nodeGroupId_;

	public const int StageFieldNumber = 3;

	private int stage_;

	public const int IndexFieldNumber = 4;

	private int index_;

	public const int NodeTypeFieldNumber = 5;

	private int nodeType_;

	public const int EventGroupIdFieldNumber = 6;

	private int eventGroupId_;

	public const int NodeIconFieldNumber = 7;

	private string nodeIcon_ = "";

	public const int DifficultyLevelAddFieldNumber = 8;

	private int difficultyLevelAdd_;

	public const int CoinFieldNumber = 9;

	private int coin_;

	public const int ExperienceFieldNumber = 10;

	private int experience_;

	public const int AddHpFieldNumber = 11;

	private int addHp_;

	public const int LoseHpFieldNumber = 12;

	private int loseHp_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierNodePlan> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(772);

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
	public int NodeGroupId
	{
		get
		{
			return nodeGroupId_;
		}
		set
		{
			nodeGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Stage
	{
		get
		{
			return stage_;
		}
		set
		{
			stage_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Index
	{
		get
		{
			return index_;
		}
		set
		{
			index_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NodeType
	{
		get
		{
			return nodeType_;
		}
		set
		{
			nodeType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EventGroupId
	{
		get
		{
			return eventGroupId_;
		}
		set
		{
			eventGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string NodeIcon
	{
		get
		{
			return nodeIcon_;
		}
		set
		{
			nodeIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int DifficultyLevelAdd
	{
		get
		{
			return difficultyLevelAdd_;
		}
		set
		{
			difficultyLevelAdd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Coin
	{
		get
		{
			return coin_;
		}
		set
		{
			coin_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Experience
	{
		get
		{
			return experience_;
		}
		set
		{
			experience_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AddHp
	{
		get
		{
			return addHp_;
		}
		set
		{
			addHp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LoseHp
	{
		get
		{
			return loseHp_;
		}
		set
		{
			loseHp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierNodePlan()
	{
	}

	[DebuggerNonUserCode]
	public SoldierNodePlan(SoldierNodePlan other)
		: this()
	{
		id_ = other.id_;
		nodeGroupId_ = other.nodeGroupId_;
		stage_ = other.stage_;
		index_ = other.index_;
		nodeType_ = other.nodeType_;
		eventGroupId_ = other.eventGroupId_;
		nodeIcon_ = other.nodeIcon_;
		difficultyLevelAdd_ = other.difficultyLevelAdd_;
		coin_ = other.coin_;
		experience_ = other.experience_;
		addHp_ = other.addHp_;
		loseHp_ = other.loseHp_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierNodePlan Clone()
	{
		return new SoldierNodePlan(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierNodePlan);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierNodePlan other)
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
		if (NodeGroupId != other.NodeGroupId)
		{
			return false;
		}
		if (Stage != other.Stage)
		{
			return false;
		}
		if (Index != other.Index)
		{
			return false;
		}
		if (NodeType != other.NodeType)
		{
			return false;
		}
		if (EventGroupId != other.EventGroupId)
		{
			return false;
		}
		if (NodeIcon != other.NodeIcon)
		{
			return false;
		}
		if (DifficultyLevelAdd != other.DifficultyLevelAdd)
		{
			return false;
		}
		if (Coin != other.Coin)
		{
			return false;
		}
		if (Experience != other.Experience)
		{
			return false;
		}
		if (AddHp != other.AddHp)
		{
			return false;
		}
		if (LoseHp != other.LoseHp)
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
		if (NodeGroupId != 0)
		{
			num ^= NodeGroupId.GetHashCode();
		}
		if (Stage != 0)
		{
			num ^= Stage.GetHashCode();
		}
		if (Index != 0)
		{
			num ^= Index.GetHashCode();
		}
		if (NodeType != 0)
		{
			num ^= NodeType.GetHashCode();
		}
		if (EventGroupId != 0)
		{
			num ^= EventGroupId.GetHashCode();
		}
		if (NodeIcon.Length != 0)
		{
			num ^= NodeIcon.GetHashCode();
		}
		if (DifficultyLevelAdd != 0)
		{
			num ^= DifficultyLevelAdd.GetHashCode();
		}
		if (Coin != 0)
		{
			num ^= Coin.GetHashCode();
		}
		if (Experience != 0)
		{
			num ^= Experience.GetHashCode();
		}
		if (AddHp != 0)
		{
			num ^= AddHp.GetHashCode();
		}
		if (LoseHp != 0)
		{
			num ^= LoseHp.GetHashCode();
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
		if (NodeGroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(NodeGroupId);
		}
		if (Stage != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Stage);
		}
		if (Index != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Index);
		}
		if (NodeType != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(NodeType);
		}
		if (EventGroupId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(EventGroupId);
		}
		if (NodeIcon.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(NodeIcon);
		}
		if (DifficultyLevelAdd != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(DifficultyLevelAdd);
		}
		if (Coin != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Coin);
		}
		if (Experience != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Experience);
		}
		if (AddHp != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(AddHp);
		}
		if (LoseHp != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(LoseHp);
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
		if (NodeGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NodeGroupId);
		}
		if (Stage != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Stage);
		}
		if (Index != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Index);
		}
		if (NodeType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NodeType);
		}
		if (EventGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EventGroupId);
		}
		if (NodeIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(NodeIcon);
		}
		if (DifficultyLevelAdd != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DifficultyLevelAdd);
		}
		if (Coin != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Coin);
		}
		if (Experience != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Experience);
		}
		if (AddHp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AddHp);
		}
		if (LoseHp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LoseHp);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierNodePlan other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.NodeGroupId != 0)
			{
				NodeGroupId = other.NodeGroupId;
			}
			if (other.Stage != 0)
			{
				Stage = other.Stage;
			}
			if (other.Index != 0)
			{
				Index = other.Index;
			}
			if (other.NodeType != 0)
			{
				NodeType = other.NodeType;
			}
			if (other.EventGroupId != 0)
			{
				EventGroupId = other.EventGroupId;
			}
			if (other.NodeIcon.Length != 0)
			{
				NodeIcon = other.NodeIcon;
			}
			if (other.DifficultyLevelAdd != 0)
			{
				DifficultyLevelAdd = other.DifficultyLevelAdd;
			}
			if (other.Coin != 0)
			{
				Coin = other.Coin;
			}
			if (other.Experience != 0)
			{
				Experience = other.Experience;
			}
			if (other.AddHp != 0)
			{
				AddHp = other.AddHp;
			}
			if (other.LoseHp != 0)
			{
				LoseHp = other.LoseHp;
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
				NodeGroupId = input.ReadInt32();
				break;
			case 24u:
				Stage = input.ReadInt32();
				break;
			case 32u:
				Index = input.ReadInt32();
				break;
			case 40u:
				NodeType = input.ReadInt32();
				break;
			case 48u:
				EventGroupId = input.ReadInt32();
				break;
			case 58u:
				NodeIcon = input.ReadString();
				break;
			case 64u:
				DifficultyLevelAdd = input.ReadInt32();
				break;
			case 72u:
				Coin = input.ReadInt32();
				break;
			case 80u:
				Experience = input.ReadInt32();
				break;
			case 88u:
				AddHp = input.ReadInt32();
				break;
			case 96u:
				LoseHp = input.ReadInt32();
				break;
			}
		}
	}
}
