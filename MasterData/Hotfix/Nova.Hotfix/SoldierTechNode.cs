using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierTechNode : IMessage<SoldierTechNode>, IMessage, IEquatable<SoldierTechNode>, IDeepCloneable<SoldierTechNode>
{
	private static readonly MessageParser<SoldierTechNode> _parser = new MessageParser<SoldierTechNode>(() => new SoldierTechNode());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NodeIdFieldNumber = 2;

	private int nodeId_;

	public const int SeasonFieldNumber = 3;

	private int season_;

	public const int NameFieldNumber = 4;

	private string name_ = "";

	public const int DescFieldNumber = 5;

	private string desc_ = "";

	public const int PositionFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_position_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> position_ = new RepeatedField<int>();

	public const int TypeFieldNumber = 7;

	private int type_;

	public const int ParamFieldNumber = 8;

	private int param_;

	public const int PreNodesFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_preNodes_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> preNodes_ = new RepeatedField<int>();

	public const int PreNodesLogicFieldNumber = 10;

	private bool preNodesLogic_;

	public const int EffectClientFieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_effectClient_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> effectClient_ = new RepeatedField<int>();

	public const int EffectBattleFieldNumber = 12;

	private int effectBattle_;

	public const int BattleTypeFieldNumber = 13;

	private int battleType_;

	public const int BattleTypeParamFieldNumber = 14;

	private int battleTypeParam_;

	public const int PriorityFieldNumber = 15;

	private int priority_;

	public const int IconFieldNumber = 16;

	private string icon_ = "";

	public const int ItemId1FieldNumber = 17;

	private int itemId1_;

	public const int ItemQty1FieldNumber = 18;

	private int itemQty1_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierTechNode> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(812);

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
	public int Season
	{
		get
		{
			return season_;
		}
		set
		{
			season_ = value;
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
	public RepeatedField<int> Position => position_;

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
	public int Param
	{
		get
		{
			return param_;
		}
		set
		{
			param_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> PreNodes => preNodes_;

	[DebuggerNonUserCode]
	public bool PreNodesLogic
	{
		get
		{
			return preNodesLogic_;
		}
		set
		{
			preNodesLogic_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> EffectClient => effectClient_;

	[DebuggerNonUserCode]
	public int EffectBattle
	{
		get
		{
			return effectBattle_;
		}
		set
		{
			effectBattle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BattleType
	{
		get
		{
			return battleType_;
		}
		set
		{
			battleType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BattleTypeParam
	{
		get
		{
			return battleTypeParam_;
		}
		set
		{
			battleTypeParam_ = value;
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
	public SoldierTechNode()
	{
	}

	[DebuggerNonUserCode]
	public SoldierTechNode(SoldierTechNode other)
		: this()
	{
		id_ = other.id_;
		nodeId_ = other.nodeId_;
		season_ = other.season_;
		name_ = other.name_;
		desc_ = other.desc_;
		position_ = other.position_.Clone();
		type_ = other.type_;
		param_ = other.param_;
		preNodes_ = other.preNodes_.Clone();
		preNodesLogic_ = other.preNodesLogic_;
		effectClient_ = other.effectClient_.Clone();
		effectBattle_ = other.effectBattle_;
		battleType_ = other.battleType_;
		battleTypeParam_ = other.battleTypeParam_;
		priority_ = other.priority_;
		icon_ = other.icon_;
		itemId1_ = other.itemId1_;
		itemQty1_ = other.itemQty1_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierTechNode Clone()
	{
		return new SoldierTechNode(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierTechNode);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierTechNode other)
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
		if (Season != other.Season)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (!position_.Equals(other.position_))
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (Param != other.Param)
		{
			return false;
		}
		if (!preNodes_.Equals(other.preNodes_))
		{
			return false;
		}
		if (PreNodesLogic != other.PreNodesLogic)
		{
			return false;
		}
		if (!effectClient_.Equals(other.effectClient_))
		{
			return false;
		}
		if (EffectBattle != other.EffectBattle)
		{
			return false;
		}
		if (BattleType != other.BattleType)
		{
			return false;
		}
		if (BattleTypeParam != other.BattleTypeParam)
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
		if (ItemId1 != other.ItemId1)
		{
			return false;
		}
		if (ItemQty1 != other.ItemQty1)
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
		if (Season != 0)
		{
			num ^= Season.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		num ^= position_.GetHashCode();
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (Param != 0)
		{
			num ^= Param.GetHashCode();
		}
		num ^= preNodes_.GetHashCode();
		if (PreNodesLogic)
		{
			num ^= PreNodesLogic.GetHashCode();
		}
		num ^= effectClient_.GetHashCode();
		if (EffectBattle != 0)
		{
			num ^= EffectBattle.GetHashCode();
		}
		if (BattleType != 0)
		{
			num ^= BattleType.GetHashCode();
		}
		if (BattleTypeParam != 0)
		{
			num ^= BattleTypeParam.GetHashCode();
		}
		if (Priority != 0)
		{
			num ^= Priority.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (ItemId1 != 0)
		{
			num ^= ItemId1.GetHashCode();
		}
		if (ItemQty1 != 0)
		{
			num ^= ItemQty1.GetHashCode();
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
		if (Season != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Season);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Name);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Desc);
		}
		position_.WriteTo(output, _repeated_position_codec);
		if (Type != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Type);
		}
		if (Param != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Param);
		}
		preNodes_.WriteTo(output, _repeated_preNodes_codec);
		if (PreNodesLogic)
		{
			output.WriteRawTag(80);
			output.WriteBool(PreNodesLogic);
		}
		effectClient_.WriteTo(output, _repeated_effectClient_codec);
		if (EffectBattle != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(EffectBattle);
		}
		if (BattleType != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(BattleType);
		}
		if (BattleTypeParam != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(BattleTypeParam);
		}
		if (Priority != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(Priority);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(Icon);
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
		if (Season != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Season);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		num += position_.CalculateSize(_repeated_position_codec);
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (Param != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Param);
		}
		num += preNodes_.CalculateSize(_repeated_preNodes_codec);
		if (PreNodesLogic)
		{
			num += 2;
		}
		num += effectClient_.CalculateSize(_repeated_effectClient_codec);
		if (EffectBattle != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EffectBattle);
		}
		if (BattleType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BattleType);
		}
		if (BattleTypeParam != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BattleTypeParam);
		}
		if (Priority != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Priority);
		}
		if (Icon.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (ItemId1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ItemId1);
		}
		if (ItemQty1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ItemQty1);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierTechNode other)
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
			if (other.Season != 0)
			{
				Season = other.Season;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			position_.Add(other.position_);
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.Param != 0)
			{
				Param = other.Param;
			}
			preNodes_.Add(other.preNodes_);
			if (other.PreNodesLogic)
			{
				PreNodesLogic = other.PreNodesLogic;
			}
			effectClient_.Add(other.effectClient_);
			if (other.EffectBattle != 0)
			{
				EffectBattle = other.EffectBattle;
			}
			if (other.BattleType != 0)
			{
				BattleType = other.BattleType;
			}
			if (other.BattleTypeParam != 0)
			{
				BattleTypeParam = other.BattleTypeParam;
			}
			if (other.Priority != 0)
			{
				Priority = other.Priority;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.ItemId1 != 0)
			{
				ItemId1 = other.ItemId1;
			}
			if (other.ItemQty1 != 0)
			{
				ItemQty1 = other.ItemQty1;
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
				Season = input.ReadInt32();
				break;
			case 34u:
				Name = input.ReadString();
				break;
			case 42u:
				Desc = input.ReadString();
				break;
			case 48u:
			case 50u:
				position_.AddEntriesFrom(input, _repeated_position_codec);
				break;
			case 56u:
				Type = input.ReadInt32();
				break;
			case 64u:
				Param = input.ReadInt32();
				break;
			case 72u:
			case 74u:
				preNodes_.AddEntriesFrom(input, _repeated_preNodes_codec);
				break;
			case 80u:
				PreNodesLogic = input.ReadBool();
				break;
			case 88u:
			case 90u:
				effectClient_.AddEntriesFrom(input, _repeated_effectClient_codec);
				break;
			case 96u:
				EffectBattle = input.ReadInt32();
				break;
			case 104u:
				BattleType = input.ReadInt32();
				break;
			case 112u:
				BattleTypeParam = input.ReadInt32();
				break;
			case 120u:
				Priority = input.ReadInt32();
				break;
			case 130u:
				Icon = input.ReadString();
				break;
			case 136u:
				ItemId1 = input.ReadInt32();
				break;
			case 144u:
				ItemQty1 = input.ReadInt32();
				break;
			}
		}
	}
}
