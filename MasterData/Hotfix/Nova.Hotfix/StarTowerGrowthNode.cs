using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerGrowthNode : IMessage<StarTowerGrowthNode>, IMessage, IEquatable<StarTowerGrowthNode>, IDeepCloneable<StarTowerGrowthNode>
{
	private static readonly MessageParser<StarTowerGrowthNode> _parser = new MessageParser<StarTowerGrowthNode>(() => new StarTowerGrowthNode());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NodeIdFieldNumber = 2;

	private int nodeId_;

	public const int GroupFieldNumber = 3;

	private int group_;

	public const int NameFieldNumber = 4;

	private string name_ = "";

	public const int IsServerFieldNumber = 5;

	private bool isServer_;

	public const int IsClientFieldNumber = 6;

	private bool isClient_;

	public const int TypeFieldNumber = 7;

	private int type_;

	public const int ColorFieldNumber = 8;

	private int color_;

	public const int PreNodesFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_preNodes_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> preNodes_ = new RepeatedField<int>();

	public const int EffectClientFieldNumber = 10;

	private int effectClient_;

	public const int ClientParamsFieldNumber = 11;

	private string clientParams_ = "";

	public const int ClientlvlFieldNumber = 12;

	private int clientlvl_;

	public const int PriorityFieldNumber = 13;

	private int priority_;

	public const int IconFieldNumber = 14;

	private string icon_ = "";

	public const int PositionFieldNumber = 15;

	private static readonly FieldCodec<int> _repeated_position_codec = FieldCodec.ForInt32(122u);

	private readonly RepeatedField<int> position_ = new RepeatedField<int>();

	public const int DescFieldNumber = 16;

	private string desc_ = "";

	public const int ItemId1FieldNumber = 17;

	private int itemId1_;

	public const int ItemQty1FieldNumber = 18;

	private int itemQty1_;

	public const int ItemId2FieldNumber = 19;

	private int itemId2_;

	public const int ItemQty2FieldNumber = 20;

	private int itemQty2_;

	public const int ItemId3FieldNumber = 21;

	private int itemId3_;

	public const int ItemQty3FieldNumber = 22;

	private int itemQty3_;

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerGrowthNode> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(858);

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
	public int NodeId
	{
		get
		{
			return nodeId_;
		}
		set
		{
			nodeId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Group
	{
		get
		{
			return group_;
		}
		set
		{
			group_ = value;
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
	public bool IsServer
	{
		get
		{
			return isServer_;
		}
		set
		{
			isServer_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsClient
	{
		get
		{
			return isClient_;
		}
		set
		{
			isClient_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Color
	{
		get
		{
			return color_;
		}
		set
		{
			color_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> PreNodes => preNodes_;

	[DebuggerNonUserCode]
	public int EffectClient
	{
		get
		{
			return effectClient_;
		}
		set
		{
			effectClient_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ClientParams
	{
		get
		{
			return clientParams_;
		}
		set
		{
			clientParams_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Clientlvl
	{
		get
		{
			return clientlvl_;
		}
		set
		{
			clientlvl_ = value;
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
	public string Icon
	{
		get
		{
			return icon_;
		}
		set
		{
			icon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Position => position_;

	[DebuggerNonUserCode]
	public string Desc
	{
		get
		{
			return desc_;
		}
		set
		{
			desc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int ItemId1
	{
		get
		{
			return itemId1_;
		}
		set
		{
			itemId1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ItemQty1
	{
		get
		{
			return itemQty1_;
		}
		set
		{
			itemQty1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ItemId2
	{
		get
		{
			return itemId2_;
		}
		set
		{
			itemId2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ItemQty2
	{
		get
		{
			return itemQty2_;
		}
		set
		{
			itemQty2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ItemId3
	{
		get
		{
			return itemId3_;
		}
		set
		{
			itemId3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ItemQty3
	{
		get
		{
			return itemQty3_;
		}
		set
		{
			itemQty3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StarTowerGrowthNode()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerGrowthNode(StarTowerGrowthNode other)
		: this()
	{
		id_ = other.id_;
		nodeId_ = other.nodeId_;
		group_ = other.group_;
		name_ = other.name_;
		isServer_ = other.isServer_;
		isClient_ = other.isClient_;
		type_ = other.type_;
		color_ = other.color_;
		preNodes_ = other.preNodes_.Clone();
		effectClient_ = other.effectClient_;
		clientParams_ = other.clientParams_;
		clientlvl_ = other.clientlvl_;
		priority_ = other.priority_;
		icon_ = other.icon_;
		position_ = other.position_.Clone();
		desc_ = other.desc_;
		itemId1_ = other.itemId1_;
		itemQty1_ = other.itemQty1_;
		itemId2_ = other.itemId2_;
		itemQty2_ = other.itemQty2_;
		itemId3_ = other.itemId3_;
		itemQty3_ = other.itemQty3_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerGrowthNode Clone()
	{
		return new StarTowerGrowthNode(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerGrowthNode);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerGrowthNode other)
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
		if (NodeId != other.NodeId)
		{
			return false;
		}
		if (Group != other.Group)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (IsServer != other.IsServer)
		{
			return false;
		}
		if (IsClient != other.IsClient)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (Color != other.Color)
		{
			return false;
		}
		if (!preNodes_.Equals(other.preNodes_))
		{
			return false;
		}
		if (EffectClient != other.EffectClient)
		{
			return false;
		}
		if (ClientParams != other.ClientParams)
		{
			return false;
		}
		if (Clientlvl != other.Clientlvl)
		{
			return false;
		}
		if (Priority != other.Priority)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (!position_.Equals(other.position_))
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (ItemId1 != other.ItemId1)
		{
			return false;
		}
		if (ItemQty1 != other.ItemQty1)
		{
			return false;
		}
		if (ItemId2 != other.ItemId2)
		{
			return false;
		}
		if (ItemQty2 != other.ItemQty2)
		{
			return false;
		}
		if (ItemId3 != other.ItemId3)
		{
			return false;
		}
		if (ItemQty3 != other.ItemQty3)
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
		if (NodeId != 0)
		{
			num ^= NodeId.GetHashCode();
		}
		if (Group != 0)
		{
			num ^= Group.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (IsServer)
		{
			num ^= IsServer.GetHashCode();
		}
		if (IsClient)
		{
			num ^= IsClient.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (Color != 0)
		{
			num ^= Color.GetHashCode();
		}
		num ^= preNodes_.GetHashCode();
		if (EffectClient != 0)
		{
			num ^= EffectClient.GetHashCode();
		}
		if (ClientParams.Length != 0)
		{
			num ^= ClientParams.GetHashCode();
		}
		if (Clientlvl != 0)
		{
			num ^= Clientlvl.GetHashCode();
		}
		if (Priority != 0)
		{
			num ^= Priority.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		num ^= position_.GetHashCode();
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (ItemId1 != 0)
		{
			num ^= ItemId1.GetHashCode();
		}
		if (ItemQty1 != 0)
		{
			num ^= ItemQty1.GetHashCode();
		}
		if (ItemId2 != 0)
		{
			num ^= ItemId2.GetHashCode();
		}
		if (ItemQty2 != 0)
		{
			num ^= ItemQty2.GetHashCode();
		}
		if (ItemId3 != 0)
		{
			num ^= ItemId3.GetHashCode();
		}
		if (ItemQty3 != 0)
		{
			num ^= ItemQty3.GetHashCode();
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
		if (NodeId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(NodeId);
		}
		if (Group != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Group);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Name);
		}
		if (IsServer)
		{
			output.WriteRawTag(40);
			output.WriteBool(IsServer);
		}
		if (IsClient)
		{
			output.WriteRawTag(48);
			output.WriteBool(IsClient);
		}
		if (Type != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Type);
		}
		if (Color != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Color);
		}
		preNodes_.WriteTo(output, _repeated_preNodes_codec);
		if (EffectClient != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(EffectClient);
		}
		if (ClientParams.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(ClientParams);
		}
		if (Clientlvl != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(Clientlvl);
		}
		if (Priority != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(Priority);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(Icon);
		}
		position_.WriteTo(output, _repeated_position_codec);
		if (Desc.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(Desc);
		}
		if (ItemId1 != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(ItemId1);
		}
		if (ItemQty1 != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(ItemQty1);
		}
		if (ItemId2 != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(ItemId2);
		}
		if (ItemQty2 != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(ItemQty2);
		}
		if (ItemId3 != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(ItemId3);
		}
		if (ItemQty3 != 0)
		{
			output.WriteRawTag(176, 1);
			output.WriteInt32(ItemQty3);
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
		if (NodeId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NodeId);
		}
		if (Group != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Group);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (IsServer)
		{
			num += 2;
		}
		if (IsClient)
		{
			num += 2;
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (Color != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Color);
		}
		num += preNodes_.CalculateSize(_repeated_preNodes_codec);
		if (EffectClient != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EffectClient);
		}
		if (ClientParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ClientParams);
		}
		if (Clientlvl != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Clientlvl);
		}
		if (Priority != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Priority);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		num += position_.CalculateSize(_repeated_position_codec);
		if (Desc.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (ItemId1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ItemId1);
		}
		if (ItemQty1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ItemQty1);
		}
		if (ItemId2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ItemId2);
		}
		if (ItemQty2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ItemQty2);
		}
		if (ItemId3 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ItemId3);
		}
		if (ItemQty3 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ItemQty3);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerGrowthNode other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.NodeId != 0)
			{
				NodeId = other.NodeId;
			}
			if (other.Group != 0)
			{
				Group = other.Group;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.IsServer)
			{
				IsServer = other.IsServer;
			}
			if (other.IsClient)
			{
				IsClient = other.IsClient;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.Color != 0)
			{
				Color = other.Color;
			}
			preNodes_.Add(other.preNodes_);
			if (other.EffectClient != 0)
			{
				EffectClient = other.EffectClient;
			}
			if (other.ClientParams.Length != 0)
			{
				ClientParams = other.ClientParams;
			}
			if (other.Clientlvl != 0)
			{
				Clientlvl = other.Clientlvl;
			}
			if (other.Priority != 0)
			{
				Priority = other.Priority;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			position_.Add(other.position_);
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.ItemId1 != 0)
			{
				ItemId1 = other.ItemId1;
			}
			if (other.ItemQty1 != 0)
			{
				ItemQty1 = other.ItemQty1;
			}
			if (other.ItemId2 != 0)
			{
				ItemId2 = other.ItemId2;
			}
			if (other.ItemQty2 != 0)
			{
				ItemQty2 = other.ItemQty2;
			}
			if (other.ItemId3 != 0)
			{
				ItemId3 = other.ItemId3;
			}
			if (other.ItemQty3 != 0)
			{
				ItemQty3 = other.ItemQty3;
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
				NodeId = input.ReadInt32();
				break;
			case 24u:
				Group = input.ReadInt32();
				break;
			case 34u:
				Name = input.ReadString();
				break;
			case 40u:
				IsServer = input.ReadBool();
				break;
			case 48u:
				IsClient = input.ReadBool();
				break;
			case 56u:
				Type = input.ReadInt32();
				break;
			case 64u:
				Color = input.ReadInt32();
				break;
			case 72u:
			case 74u:
				preNodes_.AddEntriesFrom(input, _repeated_preNodes_codec);
				break;
			case 80u:
				EffectClient = input.ReadInt32();
				break;
			case 90u:
				ClientParams = input.ReadString();
				break;
			case 96u:
				Clientlvl = input.ReadInt32();
				break;
			case 104u:
				Priority = input.ReadInt32();
				break;
			case 114u:
				Icon = input.ReadString();
				break;
			case 120u:
			case 122u:
				position_.AddEntriesFrom(input, _repeated_position_codec);
				break;
			case 130u:
				Desc = input.ReadString();
				break;
			case 136u:
				ItemId1 = input.ReadInt32();
				break;
			case 144u:
				ItemQty1 = input.ReadInt32();
				break;
			case 152u:
				ItemId2 = input.ReadInt32();
				break;
			case 160u:
				ItemQty2 = input.ReadInt32();
				break;
			case 168u:
				ItemId3 = input.ReadInt32();
				break;
			case 176u:
				ItemQty3 = input.ReadInt32();
				break;
			}
		}
	}
}
