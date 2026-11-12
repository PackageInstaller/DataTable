using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierShopPool : IMessage<SoldierShopPool>, IMessage, IEquatable<SoldierShopPool>, IDeepCloneable<SoldierShopPool>
{
	private static readonly MessageParser<SoldierShopPool> _parser = new MessageParser<SoldierShopPool>(() => new SoldierShopPool());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int ChessCharacterIdFieldNumber = 3;

	private int chessCharacterId_;

	public const int RarityFieldNumber = 4;

	private int rarity_;

	public const int NameFieldNumber = 5;

	private string name_ = "";

	public const int WeightFieldNumber = 6;

	private int weight_;

	public const int CostFieldNumber = 7;

	private int cost_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierShopPool> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(794);

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
	public int ChessCharacterId
	{
		get
		{
			return chessCharacterId_;
		}
		set
		{
			chessCharacterId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Rarity
	{
		get
		{
			return rarity_;
		}
		set
		{
			rarity_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Weight
	{
		get
		{
			return weight_;
		}
		set
		{
			weight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Cost
	{
		get
		{
			return cost_;
		}
		set
		{
			cost_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierShopPool()
	{
	}

	[DebuggerNonUserCode]
	public SoldierShopPool(SoldierShopPool other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		chessCharacterId_ = other.chessCharacterId_;
		rarity_ = other.rarity_;
		name_ = other.name_;
		weight_ = other.weight_;
		cost_ = other.cost_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierShopPool Clone()
	{
		return new SoldierShopPool(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierShopPool);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierShopPool other)
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
		if (ChessCharacterId != other.ChessCharacterId)
		{
			return false;
		}
		if (Rarity != other.Rarity)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Weight != other.Weight)
		{
			return false;
		}
		if (Cost != other.Cost)
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
		if (ChessCharacterId != 0)
		{
			num ^= ChessCharacterId.GetHashCode();
		}
		if (Rarity != 0)
		{
			num ^= Rarity.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Weight != 0)
		{
			num ^= Weight.GetHashCode();
		}
		if (Cost != 0)
		{
			num ^= Cost.GetHashCode();
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
		if (ChessCharacterId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ChessCharacterId);
		}
		if (Rarity != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Rarity);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Name);
		}
		if (Weight != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Weight);
		}
		if (Cost != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Cost);
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
		if (ChessCharacterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChessCharacterId);
		}
		if (Rarity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rarity);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Weight != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Weight);
		}
		if (Cost != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Cost);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierShopPool other)
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
			if (other.ChessCharacterId != 0)
			{
				ChessCharacterId = other.ChessCharacterId;
			}
			if (other.Rarity != 0)
			{
				Rarity = other.Rarity;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Weight != 0)
			{
				Weight = other.Weight;
			}
			if (other.Cost != 0)
			{
				Cost = other.Cost;
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
				ChessCharacterId = input.ReadInt32();
				break;
			case 32u:
				Rarity = input.ReadInt32();
				break;
			case 42u:
				Name = input.ReadString();
				break;
			case 48u:
				Weight = input.ReadInt32();
				break;
			case 56u:
				Cost = input.ReadInt32();
				break;
			}
		}
	}
}
