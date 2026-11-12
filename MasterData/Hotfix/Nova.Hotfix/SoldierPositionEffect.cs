using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierPositionEffect : IMessage<SoldierPositionEffect>, IMessage, IEquatable<SoldierPositionEffect>, IDeepCloneable<SoldierPositionEffect>
{
	private static readonly MessageParser<SoldierPositionEffect> _parser = new MessageParser<SoldierPositionEffect>(() => new SoldierPositionEffect());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int PositionTypeFieldNumber = 2;

	private int positionType_;

	public const int IndexFieldNumber = 3;

	private int index_;

	public const int IconFieldNumber = 4;

	private string icon_ = "";

	public const int NameFieldNumber = 5;

	private string name_ = "";

	public const int KeyEffectIdFieldNumber = 6;

	private int keyEffectId_;

	public const int TechNodeIdFieldNumber = 7;

	private int techNodeId_;

	public const int KeyEffectDesFieldNumber = 8;

	private string keyEffectDes_ = "";

	public const int OppoEffectIdFieldNumber = 9;

	private int oppoEffectId_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierPositionEffect> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(780);

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
	public int PositionType
	{
		get
		{
			return positionType_;
		}
		set
		{
			positionType_ = value;
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
	public int KeyEffectId
	{
		get
		{
			return keyEffectId_;
		}
		set
		{
			keyEffectId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TechNodeId
	{
		get
		{
			return techNodeId_;
		}
		set
		{
			techNodeId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string KeyEffectDes
	{
		get
		{
			return keyEffectDes_;
		}
		set
		{
			keyEffectDes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int OppoEffectId
	{
		get
		{
			return oppoEffectId_;
		}
		set
		{
			oppoEffectId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierPositionEffect()
	{
	}

	[DebuggerNonUserCode]
	public SoldierPositionEffect(SoldierPositionEffect other)
		: this()
	{
		id_ = other.id_;
		positionType_ = other.positionType_;
		index_ = other.index_;
		icon_ = other.icon_;
		name_ = other.name_;
		keyEffectId_ = other.keyEffectId_;
		techNodeId_ = other.techNodeId_;
		keyEffectDes_ = other.keyEffectDes_;
		oppoEffectId_ = other.oppoEffectId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierPositionEffect Clone()
	{
		return new SoldierPositionEffect(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierPositionEffect);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierPositionEffect other)
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
		if (PositionType != other.PositionType)
		{
			return false;
		}
		if (Index != other.Index)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (KeyEffectId != other.KeyEffectId)
		{
			return false;
		}
		if (TechNodeId != other.TechNodeId)
		{
			return false;
		}
		if (KeyEffectDes != other.KeyEffectDes)
		{
			return false;
		}
		if (OppoEffectId != other.OppoEffectId)
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
		if (PositionType != 0)
		{
			num ^= PositionType.GetHashCode();
		}
		if (Index != 0)
		{
			num ^= Index.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (KeyEffectId != 0)
		{
			num ^= KeyEffectId.GetHashCode();
		}
		if (TechNodeId != 0)
		{
			num ^= TechNodeId.GetHashCode();
		}
		if (KeyEffectDes.Length != 0)
		{
			num ^= KeyEffectDes.GetHashCode();
		}
		if (OppoEffectId != 0)
		{
			num ^= OppoEffectId.GetHashCode();
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
		if (PositionType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(PositionType);
		}
		if (Index != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Index);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Icon);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Name);
		}
		if (KeyEffectId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(KeyEffectId);
		}
		if (TechNodeId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(TechNodeId);
		}
		if (KeyEffectDes.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(KeyEffectDes);
		}
		if (OppoEffectId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(OppoEffectId);
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
		if (PositionType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PositionType);
		}
		if (Index != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Index);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (KeyEffectId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(KeyEffectId);
		}
		if (TechNodeId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TechNodeId);
		}
		if (KeyEffectDes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(KeyEffectDes);
		}
		if (OppoEffectId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OppoEffectId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierPositionEffect other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.PositionType != 0)
			{
				PositionType = other.PositionType;
			}
			if (other.Index != 0)
			{
				Index = other.Index;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.KeyEffectId != 0)
			{
				KeyEffectId = other.KeyEffectId;
			}
			if (other.TechNodeId != 0)
			{
				TechNodeId = other.TechNodeId;
			}
			if (other.KeyEffectDes.Length != 0)
			{
				KeyEffectDes = other.KeyEffectDes;
			}
			if (other.OppoEffectId != 0)
			{
				OppoEffectId = other.OppoEffectId;
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
				PositionType = input.ReadInt32();
				break;
			case 24u:
				Index = input.ReadInt32();
				break;
			case 34u:
				Icon = input.ReadString();
				break;
			case 42u:
				Name = input.ReadString();
				break;
			case 48u:
				KeyEffectId = input.ReadInt32();
				break;
			case 56u:
				TechNodeId = input.ReadInt32();
				break;
			case 66u:
				KeyEffectDes = input.ReadString();
				break;
			case 72u:
				OppoEffectId = input.ReadInt32();
				break;
			}
		}
	}
}
